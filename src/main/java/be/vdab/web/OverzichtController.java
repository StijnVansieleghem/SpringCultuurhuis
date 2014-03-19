//package be.vdab.web;
//
//import java.security.Principal;
//import java.util.HashMap;
//import java.util.Map;
//
////productiecode:
////import org.slf4j.Logger;
////import org.slf4j.LoggerFactory;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.dao.DataIntegrityViolationException;
//import org.springframework.stereotype.Controller;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.RequestMethod;
//import org.springframework.web.servlet.ModelAndView;
//
//import be.vdab.entities.Klant;
//import be.vdab.entities.Voorstelling;
//import be.vdab.services.KlantService;
//import be.vdab.services.VoorstellingService;
//
//@Controller
//@RequestMapping("/overzicht")
//class OverzichtController {
//	private final VoorstellingService voorstellingService;
//	private final GelukteReservering gelukteReservering;
//	private final MislukteReservering mislukteReservering;
//	private final KlantService klantService;
//	// productiecode:
//	// private final Logger logger = LoggerFactory
//	// .getLogger(BevestigReservatieController.class);
//	private final MailService mailService;
//
//	@Autowired
//	public OverzichtController(VoorstellingService voorstellingService,
//			GelukteReservering gelukteReservering,
//			MislukteReservering mislukteReservering, KlantService klantService,
//			MailService mailService) {
//		this.voorstellingService = voorstellingService;
//		this.gelukteReservering = gelukteReservering;
//		this.mislukteReservering = mislukteReservering;
//		this.mailService = mailService;
//		this.klantService = klantService;
//	}
//
//	@RequestMapping(method = RequestMethod.GET)
//	public ModelAndView toonOverzicht(Principal principal) {
//		ModelAndView modelAndView = new ModelAndView("overzicht");
//		try {
//			StringBuilder builder = new StringBuilder();
//			builder.append("<h1>Cultuurhuis Reservaties</h1>"
//					+ "Hieronder vind u een overzicht van uw geplaatste reservaties bij het Cultuurhuis:");
//			if (gelukteReservering.getReservatiemandje() != null) {
//				builder.append("<h2>Gelukte reservaties:</h2>"
//						+ "<table border='1'><tr><th>Datum</th><th>Titel</th><th>Uitvoerders</th><th>Prijs</th><th>Plaatsen</th></tr>");
//				for (Map.Entry<Long, Integer> entry : gelukteReservering
//						.getReservatiemandje().entrySet()) {
//					builder.append("<tr><td>"
//							+ voorstellingService.read(entry.getKey())
//									.getDatum()
//							+ "</td>"
//							+ "<td>"
//							+ voorstellingService.read(entry.getKey())
//									.getTitel()
//							+ "</td>"
//							+ "<td>"
//							+ voorstellingService.read(entry.getKey())
//									.getUitvoerders()
//							+ "</td>"
//							+ "<td>"
//							+ voorstellingService.read(entry.getKey())
//									.getPrijs() + "</td>" + "<td>"
//							+ entry.getValue() + "</td></tr>");
//				}
//				builder.append("</table><br/><br/>");
//			}
//			if (mislukteReservering.getReservatiemandje() != null) {
//				builder.append("<h2>Mislukte reservaties:</h2>"
//						+ "<table border='1'><tr><th>Datum</th><th>Titel</th><th>Uitvoerders</th><th>Prijs</th><th>Plaatsen</th></tr>");
//				for (Map.Entry<Long, Integer> entry : mislukteReservering
//						.getReservatiemandje().entrySet()) {
//					builder.append("<tr><td>"
//							+ voorstellingService.read(entry.getKey())
//									.getDatum()
//							+ "</td>"
//							+ "<td>"
//							+ voorstellingService.read(entry.getKey())
//									.getTitel()
//							+ "</td>"
//							+ "<td>"
//							+ voorstellingService.read(entry.getKey())
//									.getUitvoerders()
//							+ "</td>"
//							+ "<td>"
//							+ voorstellingService.read(entry.getKey())
//									.getPrijs() + "</td>" + "<td>"
//							+ entry.getValue() + "</td></tr>");
//				}
//				builder.append("</table><br/><br/>");
//			}
//			Klant klant = klantService
//					.findByGebruikersnaam(principal.getName());
//			mailService.zendMail(klant.getEmail().toString(),
//					"Reservaties Cultuurhuis", builder.toString());
//		} catch (DataIntegrityViolationException ex) {
//			// productiecode:
//			// logger.error("kan mail niet versturen ", ex);
//		}
//		if (gelukteReservering.getReservatiemandje() != null) {
//			Map<Voorstelling, Integer> gelukteReserveringen = new HashMap<Voorstelling, Integer>();
//			for (Map.Entry<Long, Integer> entry : gelukteReservering
//					.getReservatiemandje().entrySet()) {
//				Voorstelling voorstelling = voorstellingService.read(entry
//						.getKey());
//				gelukteReserveringen.put(voorstelling, entry.getValue());
//			}
//			gelukteReservering.setReservatiemandje(null);
//			modelAndView
//					.addObject("gelukteReserveringen", gelukteReserveringen);
//		}
//		if (mislukteReservering.getReservatiemandje() != null) {
//			Map<Voorstelling, Integer> mislukteReserveringen = new HashMap<Voorstelling, Integer>();
//			for (Map.Entry<Long, Integer> entry : mislukteReservering
//					.getReservatiemandje().entrySet()) {
//				Voorstelling voorstelling = voorstellingService.read(entry
//						.getKey());
//				mislukteReserveringen.put(voorstelling, entry.getValue());
//			}
//			mislukteReservering.setReservatiemandje(null);
//			modelAndView.addObject("mislukteReserveringen",
//					mislukteReserveringen);
//		}
//		return modelAndView;
//	}
//}