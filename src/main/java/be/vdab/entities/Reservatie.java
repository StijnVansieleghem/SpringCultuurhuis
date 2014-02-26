package be.vdab.entities;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Map;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.validation.constraints.Min;

import org.springframework.format.annotation.NumberFormat;

@Entity
@Table(name = "reservaties")
public class Reservatie implements Serializable {
	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue
	private long reservatieNr;
	@Min(1)
	private int plaatsen;
	@ManyToOne
	@JoinColumn(name = "VoorstellingsNr")
	private Voorstelling voorstelling;

	@ManyToOne
	@JoinColumn(name = "KlantNr")
	private Klant klant;

	protected Reservatie() {
	}

	public Reservatie(int plaatsen, Voorstelling voorstelling, Klant klant) {
		setPlaatsen(plaatsen);
		setVoorstelling(voorstelling);
		setKlant(klant);
	}

	public long getReservatieNr() {
		return this.reservatieNr;
	}

	public void setReservatieNr(long reservatieNr) {
		this.reservatieNr = reservatieNr;
	}

	public int getPlaatsen() {
		return plaatsen;
	}

	public void setPlaatsen(int plaatsen) {
		this.plaatsen = plaatsen;
	}

	public Voorstelling getVoorstelling() {
		return voorstelling;
	}

	public void setVoorstelling(Voorstelling voorstelling) {
		this.voorstelling = voorstelling;
	}

	public Klant getKlant() {
		return klant;
	}

	public void setKlant(Klant klant) {
		this.klant = klant;
	}

	@NumberFormat(pattern = "#,##0.00")
	public static BigDecimal getTotalValue(Map<Voorstelling, Integer> mandje) {
		BigDecimal total = BigDecimal.ZERO;
		for (Map.Entry<Voorstelling, Integer> entry : mandje.entrySet()) {
			total = total.add(new BigDecimal(entry.getValue()).multiply(entry
					.getKey().getPrijs()));
		}
		return total;
	}
}
