package be.vdab.services;

import be.vdab.entities.Klant;

public interface KlantService {
	Klant read(long id);

	void create(Klant klant);
	
	Klant findByGebruikersnaam(String gebruikersnaam);
	
	Klant findByGebruikersnaamAndPaswoord(String gebruikersnaam,
			String paswoord);
}
