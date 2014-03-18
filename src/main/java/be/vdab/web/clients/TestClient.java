package be.vdab.web.clients;

import org.slf4j.Logger;
import org.springframework.oxm.jaxb.Jaxb2Marshaller;
import org.springframework.ws.client.core.WebServiceTemplate;
import org.springframework.ws.soap.client.SoapFaultClientException;

import be.vdab.JAXBClasses.KlantType;
import be.vdab.JAXBClasses.NieuweKlantRequest;

public class TestClient {

	private final WebServiceTemplate webServiceTemplate = new WebServiceTemplate();
	protected static Logger logger;

	public void setDefaultUri(String defaultUri) {
		webServiceTemplate.setDefaultUri(defaultUri);
	}

	public void nieuweKlantAanmaken() throws Exception {
		
		try {
			Jaxb2Marshaller marshaller = new org.springframework.oxm.jaxb.Jaxb2Marshaller();
			marshaller.setClassesToBeBound(new Class[] { KlantType.class,
					NieuweKlantRequest.class });
			marshaller.afterPropertiesSet();

			webServiceTemplate.setMarshaller(marshaller);
			webServiceTemplate.afterPropertiesSet();

			NieuweKlantRequest nieuweKlantRequest = new NieuweKlantRequest(
					new KlantType("voornaam", "familienaam", "straat", "1", "1000",
							"gemeente", "gebruikersnaam", "paswoord",
							"email@email.com"));
			webServiceTemplate
					.marshalSendAndReceive(
							"http://localhost:8080/Cultuurhuis_Spring/ws/NieuweKlantRequest",
							nieuweKlantRequest);
		} catch (SoapFaultClientException ex) {
			logger.error("invalid message");
		}
		catch (RuntimeException ex2) {
			logger.error("RuntimeException");
		}
	}
}