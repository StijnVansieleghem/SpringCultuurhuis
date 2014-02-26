package be.vdab.dao;

import org.springframework.data.jpa.repository.JpaRepository;

import be.vdab.entities.Klant;

public interface KlantDAO extends JpaRepository<Klant, Long> {
	Klant findByGebruikersnaam(String gebruikersnaam);
	Klant findByGebruikersnaamAndPaswoord(String gebruikersnaam, String paswoord);
}