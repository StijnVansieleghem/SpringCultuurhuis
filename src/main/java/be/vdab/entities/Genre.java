package be.vdab.entities;

import java.io.Serializable;
import java.util.Collections;
import java.util.Set;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.Size;

@Entity
@Table(name = "genres")
public class Genre implements Serializable {
	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue
	private long genreNr;
	@Size(min = 1, max = 50)
	private String naam;
	@OneToMany(mappedBy = "genre")
	private Set<Voorstelling> voorstellingen;

	public Set<Voorstelling> getVoorstellingen() {
		return Collections.unmodifiableSet(voorstellingen);
	}

	public void addVoorstelling(Voorstelling voorstelling) {
		voorstellingen.add(voorstelling);
	}

	public void removeVoorstelling(Voorstelling voorstelling) {
		voorstellingen.remove(voorstelling);
	}

	protected Genre() {
	}

	public Genre(long genreNr, String naam) {
		setGenreNr(genreNr);
		setNaam(naam);
	}

	public long getGenreNr() {
		return genreNr;
	}

	public void setGenreNr(long genreNr) {
		this.genreNr = genreNr;
	}

	public String getNaam() {
		return naam;
	}

	public void setNaam(String naam) {
		this.naam = naam;
	}

	@Override
	public boolean equals(Object obj) {
		if (!(obj instanceof Genre)) {
			return false;
		}
		return ((Genre) obj).naam.equalsIgnoreCase(this.naam);
	}

	@Override
	public int hashCode() {
		return naam.toLowerCase().hashCode();
	}
}
