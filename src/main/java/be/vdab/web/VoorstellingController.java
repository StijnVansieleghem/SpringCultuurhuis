package be.vdab.web;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.DateTimeFormat.ISO;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import be.vdab.entities.Genre;
import be.vdab.entities.Voorstelling;
import be.vdab.services.GenreService;
import be.vdab.services.VoorstellingService;

import com.ibm.icu.util.Calendar;

@Controller
@RequestMapping({ "/", "/voorstellingen" })
class VoorstellingController {
	private final GenreService genreService;
	private final VoorstellingService voorstellingService;

	@Autowired
	public VoorstellingController(GenreService genreService,
			VoorstellingService voorstellingService) {
		this.genreService = genreService;
		this.voorstellingService = voorstellingService;
	}

	@RequestMapping(method = RequestMethod.GET, value = "{parameter}")
	public ModelAndView toonVoorstellingen(@PathVariable String parameter) {
		try {
			ModelAndView modelAndView = new ModelAndView("voorstellingen");
			modelAndView.addObject("genres", genreService.findAll());
			long id = Long.parseLong(parameter);
			Genre genre = genreService.read(id);
			modelAndView.addObject("huidigGenre", genre);
			modelAndView.addObject("voorstellingen", voorstellingService
					.findByGenreAndDatumGreaterThan(genre, new Date()));
			return modelAndView;
		} catch (NumberFormatException ex) {
			return toonGenres();
		}
	}

	@RequestMapping(method = RequestMethod.GET)
	public ModelAndView toonGenres() {
		ModelAndView modelAndView = new ModelAndView("voorstellingen",
				"genres", genreService.findAll());
		return modelAndView;
	}

	@RequestMapping(method = RequestMethod.GET, value = "/rest/{datum}")
	public @ResponseBody
	Iterable<Voorstelling> getVoorstellingByDatum(@PathVariable @DateTimeFormat(iso=ISO.DATE) Date datum) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(datum);
		cal.add(Calendar.HOUR, +24);
		return voorstellingService.findByDatumBetween(datum, cal.getTime());
	}
}