package be.vdab.web;

import javax.validation.constraints.Max;
import javax.validation.constraints.Min;

class ReservatieForm {
	@Min(1)
	@Max(250)
	private int aantalPlaatsen;

	ReservatieForm() {
	}

	ReservatieForm(int aantalPlaatsen) {
		setAantalPlaatsen(aantalPlaatsen);
	}

	public int getAantalPlaatsen() {
		return aantalPlaatsen;
	}

	public void setAantalPlaatsen(int aantalPlaatsen) {
		this.aantalPlaatsen = aantalPlaatsen;
	}
}
