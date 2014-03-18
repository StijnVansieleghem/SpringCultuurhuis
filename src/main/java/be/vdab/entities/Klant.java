package be.vdab.entities;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.List;
import java.util.Set;

import javax.persistence.Embedded;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.validation.Valid;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.authentication.encoding.ShaPasswordEncoder;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.GrantedAuthorityImpl;
import org.springframework.security.core.context.SecurityContextHolder;

import be.vdab.valueobjects.Adres;
import be.vdab.valueobjects.Email;
import be.vdab.web.NieuweKlantForm;

@SuppressWarnings("deprecation")
@Entity
@Table(name = "klanten")
@XmlRootElement
public class Klant extends Adres implements Serializable {
	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue
	@XmlTransient
	private long klantNr;
	@Size(min = 2, max = 50)
	private String voornaam;
	@Size(min = 2, max = 50)
	private String familienaam;
	@Embedded
	@Valid
	private Adres adres;
	@Size(min = 1, max = 50)
	private String gebruikersnaam;
	private String paswoord;
	@Embedded
	@Valid
	private Email email;
	@Transient
	@XmlTransient
	private String authorities;
	@OneToMany(mappedBy = "klant")
	@XmlTransient
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

	protected Klant() {
	}

	public Klant(String voornaam, String familienaam, String straat,
			String huisNr, String postcode, String gemeente,
			String gebruikersnaam, String paswoord, String email)
			throws IllegalArgumentException {
		setVoornaam(voornaam);
		setFamilienaam(familienaam);
		this.adres = new Adres(straat, huisNr, postcode, gemeente);
		setGebruikersnaam(gebruikersnaam);
		setPaswoord(paswoord);
		this.email = new Email(email);
	}

	public Klant(NieuweKlantForm nieuweKlantForm) {
		setVoornaam(nieuweKlantForm.getVoornaam());
		setFamilienaam(nieuweKlantForm.getFamilienaam());
		this.adres = new Adres(nieuweKlantForm.getStraat(),
				nieuweKlantForm.getHuisNr(), nieuweKlantForm.getPostcode(),
				nieuweKlantForm.getGemeente());
		setGebruikersnaam(nieuweKlantForm.getGebruikersnaam());
		setPaswoord(nieuweKlantForm.getPaswoord());
		this.email = new Email(nieuweKlantForm.getEmail().toString());
	}

	public long getKlantNr() {
		return klantNr;
	}

	public void setKlantNr(long klantNr) {
		this.klantNr = klantNr;
	}

	public String getVoornaam() {
		return voornaam;
	}

	public void setVoornaam(String voornaam) {
		this.voornaam = voornaam;
	}

	public String getFamilienaam() {
		return familienaam;
	}

	public String getNaam() {
		return voornaam + " " + familienaam;
	}

	public void setFamilienaam(String familienaam) {
		this.familienaam = familienaam;
	}

	public String getGebruikersnaam() {
		return gebruikersnaam;
	}

	public void setGebruikersnaam(String gebruikersnaam) {
		this.gebruikersnaam = gebruikersnaam;
	}

	public String getPaswoord() {
		return paswoord;
	}

	public void setPaswoord(String paswoord) {
		this.paswoord = hashPaswoord(paswoord);
	}
	
	public String hashPaswoord(String paswoord){
		ShaPasswordEncoder encoder = new ShaPasswordEncoder();
		return encoder.encodePassword(paswoord, gebruikersnaam);
	}

	public Adres getAdres() {
		return adres;
	}

	public Email getEmail() {
		return email;
	}

	public Email getEmailValueObject() {
		return email;
	}

	public void loginKlant() {
		UsernamePasswordAuthenticationToken auth = new UsernamePasswordAuthenticationToken(
				getGebruikersnaam(), getPaswoord(), getAuthorities());
		SecurityContextHolder.getContext().setAuthentication(auth);
	}

	public Collection<? extends GrantedAuthority> getAuthorities() {
		List<GrantedAuthority> grantedAuthorities = new ArrayList<GrantedAuthority>();
		grantedAuthorities.add(new GrantedAuthorityImpl("user"));
		return grantedAuthorities;

	}

	@Override
	public String toString() {
		return getVoornaam() + ' ' + getFamilienaam() + ' '
				+ getAdres().toString();
	}

	@Override
	public boolean equals(Object obj) {
		if (!(obj instanceof Klant)) {
			return false;
		}
		return ((Klant) obj).gebruikersnaam
				.equalsIgnoreCase(this.gebruikersnaam);
	}

	@Override
	public int hashCode() {
		return gebruikersnaam.toLowerCase().hashCode();
	}
}
