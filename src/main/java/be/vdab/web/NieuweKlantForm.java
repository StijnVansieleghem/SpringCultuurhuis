package be.vdab.web;

import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import javax.validation.constraints.Size;

import be.vdab.entities.Klant;

public class NieuweKlantForm extends Klant {
	private static final long serialVersionUID = 1L;
	@Size(min = 1, max = 50)
	private String straat;
	@Size(min = 1, max = 6)
	private String huisNr;
	@Min(1000)
	@Max(9999)
	private String postcode;
	@Size(min = 1, max = 50)
	private String gemeente;
	private String paswoord;
	private String herhaalPaswoord;

	NieuweKlantForm() {
	}

	public String getStraat() {
		return straat;
	}

	public String getHuisNr() {
		return huisNr;
	}

	public String getPostcode() {
		return postcode;
	}

	public String getGemeente() {
		return gemeente;
	}

	@Override
	public String getPaswoord() {
		return paswoord;
	}

	public String getHerhaalPaswoord() {
		return herhaalPaswoord;
	}

	public void setStraat(String straat) {
		this.straat = straat;
	}

	public void setHuisNr(String huisNr) {
		this.huisNr = huisNr;
	}

	public void setPostcode(String postcode) {
		this.postcode = postcode;
	}

	public void setGemeente(String gemeente) {
		this.gemeente = gemeente;
	}

	@Override
	public void setPaswoord(String paswoord) {
		this.paswoord = paswoord;
	}

	public void setHerhaalPaswoord(String herhaalPaswoord) {
		this.herhaalPaswoord = herhaalPaswoord;
	}

	@Override
	public boolean equals(Object obj) {
		if (!(obj instanceof Klant)) {
			return false;
		}
		return ((Klant) obj).getGebruikersnaam().equalsIgnoreCase(
				getGebruikersnaam());
	}

	@Override
	public int hashCode() {
		return getGebruikersnaam().toLowerCase().hashCode();
	}
}