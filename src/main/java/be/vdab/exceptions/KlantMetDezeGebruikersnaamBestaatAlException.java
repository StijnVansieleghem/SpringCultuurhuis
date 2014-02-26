package be.vdab.exceptions;

public class KlantMetDezeGebruikersnaamBestaatAlException extends
		RuntimeException {
	private static final long serialVersionUID = 1L;

	@Override
	public String getMessage() {
		return "Deze gebruikersnaam bestaat reeds";
	}
}