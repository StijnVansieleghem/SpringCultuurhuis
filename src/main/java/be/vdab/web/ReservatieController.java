package be.vdab.web;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import be.vdab.services.VoorstellingService;

@Controller
class ReservatieController {
	private final VoorstellingService voorstellingService;
	private final Reservatiemandje reservatiemandje;

	@Autowired
	public ReservatieController(VoorstellingService voorstellingService,
			Reservatiemandje reservatiemandje) {
		this.voorstellingService = voorstellingService;
		this.reservatiemandje = reservatiemandje;
	}

	@RequestMapping(method = RequestMethod.GET, value = "/reserveren")
	public String reservatieZonderID() {
		return "redirect:/voorstellingen";
	}

	@RequestMapping(method = RequestMethod.GET, value = "/reserveren/{parameter}")
	public ModelAndView toonVoorstelling(@PathVariable String parameter) {
		try {
			long id = Long.parseLong(parameter);
			int aantalPlaatsen = 1;
			if (reservatiemandje.getReservatiemandje() != null) {
				if (reservatiemandje.getReservatiemandje().containsKey(id)) {
					aantalPlaatsen = reservatiemandje.getReservatiemandje()
							.get(id);
				}
			}
			ModelAndView modelAndView = new ModelAndView("reserveren",
					"voorstelling", voorstellingService.read(id));
			modelAndView.addObject("reservatieForm", new ReservatieForm(
					aantalPlaatsen));
			return modelAndView;
		} catch (NumberFormatException ex) {
			return new ModelAndView("reserveren");
		}
	}

	@RequestMapping(method = RequestMethod.POST, params = { "voorstellingsNr",
			"aantalPlaatsen" }, value = "/reserveren")
	public String reserveerPlaatsen(@RequestParam long voorstellingsNr,
			@ModelAttribute ReservatieForm reservatieForm,
			BindingResult bindingResult) {
		if (!bindingResult.hasErrors()) {
			Map<Long, Integer> reservatiemand = new HashMap<Long, Integer>();
			if (reservatiemandje.getReservatiemandje() != null) {
				reservatiemand = reservatiemandje.getReservatiemandje();
			}
			reservatiemand.put(voorstellingsNr,
					reservatieForm.getAantalPlaatsen());
			reservatiemandje.setReservatiemandje(reservatiemand);
			return "redirect:/reservatiemandje";
		} else {
			return "redirect:/reserveren/" + voorstellingsNr;
		}
	}
}