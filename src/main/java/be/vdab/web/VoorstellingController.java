package be.vdab.web;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import be.vdab.entities.Genre;
import be.vdab.services.GenreService;
import be.vdab.services.VoorstellingService;
import be.vdab.web.clients.TestClient;

@Controller
class VoorstellingController {
	private final GenreService genreService;
	private final VoorstellingService voorstellingService;

	@Autowired
	public VoorstellingController(GenreService genreService,
			VoorstellingService voorstellingService) {
		this.genreService = genreService;
		this.voorstellingService = voorstellingService;
	}

	@RequestMapping(method = RequestMethod.GET, value = "/voorstellingen/{parameter}")
	public ModelAndView toonVoorstellingen(@PathVariable String parameter) {
		try {
			ModelAndView modelAndView = new ModelAndView("voorstellingen");
			modelAndView.addObject("genres", genreService.findAll());
			long id = Long.parseLong(parameter);
			Genre genre = genreService.read(id);
			modelAndView.addObject("huidigGenre", genre);
			modelAndView.addObject("voorstellingen", voorstellingService
					.findByGenreAndDatumGreaterThan(genre, new Date()));
			// if (reservatiemandje.getReservatiemandje() != null) {
			// modelAndView.addObject("toonLinkReservatiemandje", "true");
			// }
			return modelAndView;
		} catch (NumberFormatException ex) {
			return toonGenres();
		}
	}

	@RequestMapping(method = RequestMethod.GET, value = { "/voorstellingen",
			"/" })
	public ModelAndView toonGenres() {
		ModelAndView modelAndView = new ModelAndView("voorstellingen",
				"genres", genreService.findAll());
		// if (reservatiemandje.getReservatiemandje() != null) {
		// modelAndView.addObject("toonLinkReservatiemandje", "true");
		// }
		return modelAndView;
	}
}