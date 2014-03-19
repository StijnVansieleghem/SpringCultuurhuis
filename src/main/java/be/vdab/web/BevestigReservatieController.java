package be.vdab.web;

import java.security.Principal;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.encoding.ShaPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import be.vdab.entities.Klant;
import be.vdab.entities.Reservatie;
import be.vdab.entities.Voorstelling;
import be.vdab.services.KlantService;
import be.vdab.services.ReservatieService;
import be.vdab.services.VoorstellingService;

@Controller
@RequestMapping("/bevestig_reservatie")
class BevestigReservatieController {
	private final KlantService klantService;
	private final ReservatieService reservatieService;
	private final VoorstellingService voorstellingService;
	
	@Autowired
	public BevestigReservatieController(KlantService klantService,
			ReservatieService reservatieService,
			VoorstellingService voorstellingService) {
		this.klantService = klantService;
		this.reservatieService = reservatieService;
		this.voorstellingService = voorstellingService;
	}

	@RequestMapping(value = "{combinatieGebruikersnaamWachtwoord}", method = RequestMethod.GET)
	@ResponseBody
	String postLogin(@PathVariable String combinatieGebruikersnaamWachtwoord) {
		List<String> credentials = Arrays
				.asList(combinatieGebruikersnaamWachtwoord.split("&"));
		String gebruikersnaam = credentials.get(0);
		String paswoord = credentials.get(1);
		ShaPasswordEncoder encoder = new ShaPasswordEncoder();
		String hashedPaswoord = encoder
				.encodePassword(paswoord, gebruikersnaam);

		Klant klant = klantService.findByGebruikersnaamAndPaswoord(
				gebruikersnaam, hashedPaswoord);
		if (klant != null) {
			klant.loginKlant();
			return klant.toString();
		} else {
			return "mislukt";
		}
	}

	@RequestMapping(method = RequestMethod.GET)
	public ModelAndView bevestig_reservatie(Principal principal) {
		return new ModelAndView("bevestig_reservatie");
	}
	
	@RequestMapping(value = "{combinatieVoorstellingsNummersAantalPlaatsen}", method = RequestMethod.POST)
	@ResponseBody
	String bevestigReservatie(
			@PathVariable String combinatieVoorstellingsNummersAantalPlaatsen, Principal principal) {
		//TODO: json
		return maakOnderscheidGelukteMislukteReserveringen(principal, maakReservatiemandje(combinatieVoorstellingsNummersAantalPlaatsen));
	}
	
	private Map<Voorstelling, Integer> maakReservatiemandje(String combinatieVoorstellingsNummersAantalPlaatsen){
		int index = combinatieVoorstellingsNummersAantalPlaatsen.indexOf('&');

		String voorstellingsNummersGescheidenDoorKomma = combinatieVoorstellingsNummersAantalPlaatsen
				.substring(0, index);
		String aantalPlaatsenGescheidenDoorKomma = combinatieVoorstellingsNummersAantalPlaatsen
				.substring(index + 1);

		List<String> voorstellingsNummers = Arrays
				.asList(voorstellingsNummersGescheidenDoorKomma.split(","));
		List<String> aantalPlaatsen = Arrays
				.asList(aantalPlaatsenGescheidenDoorKomma.split(","));

		List<Long> voorstellingsNrs = new ArrayList<Long>();
		List<Integer> aantalPlaatsenNrs = new ArrayList<Integer>();
		for (int i = 0; i <= voorstellingsNummers.size() - 1; i++) {
			voorstellingsNrs.add(Long.parseLong(voorstellingsNummers.get(i)));
			aantalPlaatsenNrs
					.add(Integer.parseInt(aantalPlaatsen.get(i)));
		}

		List<Voorstelling> voorstellingen = (ArrayList<Voorstelling>) voorstellingService
				.findAll(voorstellingsNrs);
		Map<Voorstelling, Integer> reservatiemandje = new HashMap<Voorstelling, Integer>();
		
		for (int i = 0; i <= voorstellingen.size() - 1; i++) {	
			reservatiemandje.put(voorstellingen.get(i),
					aantalPlaatsenNrs.get(i));
		}
		
		return reservatiemandje;
	}
	
	private String maakOnderscheidGelukteMislukteReserveringen(Principal principal, Map<Voorstelling, Integer> reservatiemandje){
		StringBuilder mislukteReserveringenVoorstellingsNummers = new StringBuilder();
		StringBuilder mislukteReserveringenAantalPlaatsen = new StringBuilder();
		StringBuilder gelukteReserveringenVoorstellingsNummers = new StringBuilder();
		StringBuilder gelukteReserveringenAantalPlaatsen = new StringBuilder();
		Klant klant = klantService.findByGebruikersnaam(principal.getName());
		
		int i=0;
		for (Map.Entry<Voorstelling, Integer> entry : reservatiemandje.entrySet()) {
			i++;
			Reservatie reservatie = new Reservatie(entry.getValue(),
					entry.getKey(), klant);
			if (reservatieService.create(reservatie)) {
				gelukteReserveringenVoorstellingsNummers.append(entry.getKey().getVoorstellingsNr());
				gelukteReserveringenAantalPlaatsen.append(entry.getValue());
				if(i != reservatiemandje.entrySet().size()){
					gelukteReserveringenVoorstellingsNummers.append(',');
					gelukteReserveringenAantalPlaatsen.append(',');
				}
			} else {
				mislukteReserveringenVoorstellingsNummers.append(entry.getKey().getVoorstellingsNr());
				mislukteReserveringenAantalPlaatsen.append(entry.getValue());			
				if(i != reservatiemandje.entrySet().size()){
					mislukteReserveringenVoorstellingsNummers.append(',');
					mislukteReserveringenAantalPlaatsen.append(',');
				}
			}
		}
		String gelukteReserveringen = gelukteReserveringenVoorstellingsNummers.toString() + '&' + gelukteReserveringenAantalPlaatsen.toString();
		String mislukteReserveringen = mislukteReserveringenVoorstellingsNummers.toString() + '&' + mislukteReserveringenAantalPlaatsen.toString();
		return gelukteReserveringen + '/' + mislukteReserveringen;
	}
}