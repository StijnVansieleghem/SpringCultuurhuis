package be.vdab.web.endpoints;

import org.jdom2.Element;
import org.jdom2.JDOMException;
import org.jdom2.Namespace;
import org.jdom2.filter.Filters;
import org.jdom2.xpath.XPathExpression;
import org.jdom2.xpath.XPathFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ws.server.endpoint.annotation.Endpoint;
import org.springframework.ws.server.endpoint.annotation.PayloadRoot;
import org.springframework.ws.server.endpoint.annotation.RequestPayload;

import be.vdab.entities.Klant;
import be.vdab.services.KlantService;

@Endpoint
public class NieuweKlantEndpoint {
	private static final String NAMESPACE_URI = "http://springcultuurhuis.stijnvansieleghem.cloudbees.net/schemas";
	private XPathExpression<Element> voornaam;
	private XPathExpression<Element> familienaam;
	private XPathExpression<Element> straat;
	private XPathExpression<Element> huisnr;
	private XPathExpression<Element> postcode;
	private XPathExpression<Element> gemeente;
	private XPathExpression<Element> gebruikersnaam;
	private XPathExpression<Element> paswoord;
	private XPathExpression<Element> email;
	private KlantService klantService;

	@Autowired
	public NieuweKlantEndpoint(KlantService klantService) throws JDOMException {
		this.klantService = klantService;
		Namespace namespace = Namespace.getNamespace("sch", NAMESPACE_URI);
		XPathFactory xpathFactory = XPathFactory.instance();

		voornaam = xpathFactory.compile("//sch:Voornaam", Filters.element(),
				null, namespace);
		familienaam = xpathFactory.compile("//sch:Familienaam",
				Filters.element(), null, namespace);
		straat = xpathFactory.compile("//sch:Straat", Filters.element(), null,
				namespace);
		huisnr = xpathFactory.compile("//sch:Huisnr", Filters.element(), null,
				namespace);
		postcode = xpathFactory.compile("//sch:Postcode", Filters.element(),
				null, namespace);
		gemeente = xpathFactory.compile("//sch:Gemeente", Filters.element(),
				null, namespace);
		gebruikersnaam = xpathFactory.compile("//sch:Gebruikersnaam",
				Filters.element(), null, namespace);
		paswoord = xpathFactory.compile("//sch:Paswoord", Filters.element(),
				null, namespace);
		email = xpathFactory.compile("//sch:Email", Filters.element(), null,
				namespace);
	}

	@PayloadRoot(namespace = NAMESPACE_URI, localPart = "NieuweKlantRequest")
	public void handleNieuweKlantRequest(
			@RequestPayload Element nieuweKlantRequest) throws Exception {
		Klant klant = new Klant(voornaam.evaluate(nieuweKlantRequest).get(0)
				.getValue(), familienaam.evaluate(nieuweKlantRequest).get(0)
				.getValue(), straat.evaluate(nieuweKlantRequest).get(0)
				.getValue(), huisnr.evaluate(nieuweKlantRequest).get(0)
				.getValue(), postcode.evaluate(nieuweKlantRequest).get(0)
				.getValue(), gemeente.evaluate(nieuweKlantRequest).get(0)
				.getValue(), gebruikersnaam.evaluate(nieuweKlantRequest).get(0)
				.getValue(), paswoord.evaluate(nieuweKlantRequest).get(0)
				.getValue(), email.evaluate(nieuweKlantRequest).get(0)
				.getValue());
		klantService.create(klant);
	}
}
