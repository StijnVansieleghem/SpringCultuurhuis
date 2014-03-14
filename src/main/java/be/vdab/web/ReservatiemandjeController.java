package be.vdab.web;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import be.vdab.entities.Voorstelling;
import be.vdab.services.VoorstellingService;

@Controller
@RequestMapping("/reservatiemandje")
class ReservatiemandjeController {
	private final VoorstellingService voorstellingService;

	@Autowired
	public ReservatiemandjeController(VoorstellingService voorstellingService) {
		this.voorstellingService = voorstellingService;
	}

	@RequestMapping(method = RequestMethod.GET)
	public ModelAndView toonReservatiemandje() {
		ModelAndView modelAndView = new ModelAndView("reservatiemandje");
		return modelAndView;
	}
	
	@RequestMapping(value = "{voorstellingsNummer}", method = RequestMethod.GET)
	public @ResponseBody Voorstelling getVoorstelling(@PathVariable String voorstellingsNummer){
		return voorstellingService.read(Long.parseLong(voorstellingsNummer));
	}

	@RequestMapping(value = "{combinatieVoorstellingsNummersAantalPlaatsen}", method = RequestMethod.POST)
	@ResponseBody
	String toonReservatiemandje(
			@PathVariable String combinatieVoorstellingsNummersAantalPlaatsen) {
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
		return "";
	}

	// @RequestMapping(value = "getTotaalPrijs", method = RequestMethod.GET)
	// @ResponseBody
	// String getTotaalPrijs() {
	// if (reservatiemandje.getReservatiemandje() != null
	// && !reservatiemandje.getReservatiemandje().isEmpty()) {
	// Map<Long, Integer> mandje = reservatiemandje.getReservatiemandje();
	// Map<Voorstelling, Integer> mandjeMetVoorstellingen = new
	// HashMap<Voorstelling, Integer>();
	// for (Map.Entry<Long, Integer> entry : mandje.entrySet()) {
	// mandjeMetVoorstellingen.put(
	// voorstellingService.read(entry.getKey()),
	// entry.getValue());
	// }
	// return Reservatie.getTotalValue(mandjeMetVoorstellingen).toString();
	// } else {
	// return BigDecimal.ZERO.toString();
	// }
	// }
}