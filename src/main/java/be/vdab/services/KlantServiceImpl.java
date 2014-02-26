package be.vdab.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import be.vdab.dao.KlantDAO;
import be.vdab.entities.Klant;
import be.vdab.exceptions.KlantMetDezeGebruikersnaamBestaatAlException;

@Service
class KlantServiceImpl implements KlantService {
	private final KlantDAO klantDAO;

	@Autowired
	public KlantServiceImpl(KlantDAO klantDAO) {
		this.klantDAO = klantDAO;
	}

	@Override
	public Klant read(long id) {
		return klantDAO.findOne(id);
	}

	@Override
	@Transactional(readOnly = false)
	public void create(Klant klant) {
		if (klantDAO.findByGebruikersnaam(klant.getGebruikersnaam()) != null) {
			throw new KlantMetDezeGebruikersnaamBestaatAlException();
		}
		klantDAO.save(klant);
	}

	@Override
	public Klant findByGebruikersnaam(String gebruikersnaam) {
		return klantDAO.findByGebruikersnaam(gebruikersnaam);
	}

	@Override
	public Klant findByGebruikersnaamAndPaswoord(String gebruikersnaam,
			String paswoord) {
		return klantDAO.findByGebruikersnaamAndPaswoord(gebruikersnaam,
				paswoord);
	}
}