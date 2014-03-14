package be.vdab.entities;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Collections;
import java.util.Date;
import java.util.Set;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.NumberFormat;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name = "voorstellingen")
@XmlRootElement
public class Voorstelling implements Serializable {
	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue
	@JsonIgnore
	private long voorstellingsNr;
	@Size(min = 1, max = 50)
	private String titel;
	@Size(min = 1, max = 50)
	private String uitvoerders;
	@Temporal(TemporalType.TIMESTAMP)
	@DateTimeFormat(style = "SS")
	private Date datum;
	@NumberFormat(pattern = "#,##0.00")
	private BigDecimal prijs;
	private int vrijePlaatsen;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "GenreNr")
	@JsonIgnore
	private Genre genre;

	public Genre getGenre() {
		return genre;
	}

	public void setGenre(Genre genre) {
		this.genre = genre;
	}

	@OneToMany(mappedBy = "voorstelling")
	@JsonIgnore
	private Set<Reservatie> reservaties;

	public Set<Reservatie> getReservaties() {
		return Collections.unmodifiableSet(reservaties);
	}

	public void addReservatie(Reservatie reservatie) {
		reservaties.add(reservatie);
	}

	public void removeReservatie(Reservatie reservatie) {
		reservaties.remove(reservatie);
	}

	protected Voorstelling() {
	}

	public Voorstelling(Date datum, String titel, String uitvoerders,
			BigDecimal prijs, int vrijePlaatsen, long voorstellingsNr) {
		setDatum(datum);
		setTitel(titel);
		setUitvoerders(uitvoerders);
		setPrijs(prijs);
		setVrijePlaatsen(vrijePlaatsen);
		setVoorstellingsNr(voorstellingsNr);
	}

	public Date getDatum() {
		Date datumClone = datum;
		return datumClone;
	}

	public void setDatum(Date datum) {
		this.datum = (Date) datum.clone();
	}

	public String getTitel() {
		return titel;
	}

	public void setTitel(String titel) {
		this.titel = titel;
	}

	public String getUitvoerders() {
		return uitvoerders;
	}

	public void setUitvoerders(String uitvoerders) {
		this.uitvoerders = uitvoerders;
	}

	public BigDecimal getPrijs() {
		return prijs;
	}

	public void setPrijs(BigDecimal prijs) {
		this.prijs = prijs;
	}

	public int getVrijePlaatsen() {
		return vrijePlaatsen;
	}

	public void setVrijePlaatsen(int vrijePlaatsen) {
		this.vrijePlaatsen = vrijePlaatsen;
	}

	public long getVoorstellingsNr() {
		return voorstellingsNr;
	}

	public void setVoorstellingsNr(long voorstellingsNr) {
		this.voorstellingsNr = voorstellingsNr;
	}

	public void verminderVrijePlaatsen(Reservatie reservatie) {
		setVrijePlaatsen(getVrijePlaatsen() - reservatie.getPlaatsen());
	}

	@Override
	public boolean equals(Object obj) {
		if (!(obj instanceof Voorstelling)) {
			return false;
		}
		return ((Voorstelling) obj).titel.equalsIgnoreCase(this.titel);
	}

	@Override
	public int hashCode() {
		return titel.toLowerCase().hashCode();
	}
}