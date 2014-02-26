package be.vdab.web;

import java.security.Principal;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.DataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import be.vdab.entities.Klant;
import be.vdab.exceptions.KlantMetDezeGebruikersnaamBestaatAlException;
import be.vdab.services.KlantService;

@Controller
@RequestMapping("/nieuwe_klant")
class NieuweKlantController {
	private final KlantService klantService;

	@Autowired
	public NieuweKlantController(KlantService klantservice) {
		this.klantService = klantservice;
	}

	@RequestMapping(method = RequestMethod.GET)
	public ModelAndView nieuwe_klant(Principal principal) {
		ModelAndView modelAndView = new ModelAndView("nieuwe_klant");
		try {
			principal.getName();
			modelAndView.addObject("fouten",
					"U bent reeds ingelogd als een bestaande klant!");
		} catch (NullPointerException ex) {
			modelAndView.addObject("nieuweKlantForm", new NieuweKlantForm());
		}
		return modelAndView;
	}

	@RequestMapping(method = RequestMethod.POST, params = "submit")
	public ModelAndView createNieuweKlant(
			@Valid NieuweKlantForm nieuweKlantForm, BindingResult bindingResult) {
		if (!bindingResult.hasErrors()) {
			ModelAndView modelAndView = new ModelAndView("nieuwe_klant");
			try {
				if (!nieuweKlantForm.getHerhaalPaswoord().equals(
						nieuweKlantForm.getPaswoord())) {
					String paswoordFout = "De twee wachtwoorden komen niet overeen";
					modelAndView.addObject("paswoordFout", paswoordFout);
					return modelAndView;
				}
				Klant klant = new Klant(nieuweKlantForm);
				klantService.create(klant);
				klant.loginKlant();
			} catch (KlantMetDezeGebruikersnaamBestaatAlException ex) {
				modelAndView.addObject("gebruikersnaamFout", ex.getMessage());
				return modelAndView;
			}
			modelAndView = new ModelAndView("bevestig_reservatie");
			modelAndView.addObject("gebruikerGegevens", klantService
					.findByGebruikersnaam(nieuweKlantForm.getGebruikersnaam()));
			return modelAndView;
		}
		return new ModelAndView("nieuwe_klant");
	}

	@InitBinder("nieuweKlantForm")
	public void initBinderNieuweKlantForm(DataBinder dataBinder) {
		dataBinder.initDirectFieldAccess();
	}
}
