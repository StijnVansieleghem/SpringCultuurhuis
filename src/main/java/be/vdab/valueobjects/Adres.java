package be.vdab.valueobjects;

import java.io.Serializable;

import javax.persistence.Embeddable;
import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import javax.validation.constraints.Size;

@Embeddable
public class Adres implements Serializable {
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

	public Adres(String straat, String huisNr, String postcode, String gemeente) {
		this.straat = straat;
		this.huisNr = huisNr;
		this.postcode = postcode;
		this.gemeente = gemeente;
	}

	protected Adres() {
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
	public String toString() {
		return getStraat() + ' ' + getHuisNr() + ' ' + getPostcode() + ' '
				+ getGemeente();
	}
}