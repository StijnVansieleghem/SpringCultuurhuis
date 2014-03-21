package be.vdab.services;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import be.vdab.dao.VoorstellingDAO;
import be.vdab.entities.Genre;
import be.vdab.entities.Voorstelling;

@Service
class VoorstellingServiceImpl implements VoorstellingService {
	private final VoorstellingDAO voorstellingDAO;

	@Autowired
	public VoorstellingServiceImpl(VoorstellingDAO voorstellingDAO) {
		this.voorstellingDAO = voorstellingDAO;
	}

	@Override
	public Voorstelling read(long id) {
		return voorstellingDAO.findOne(id);
	}

	@Override
	public Iterable<Voorstelling> findByGenreAndDatumGreaterThan(Genre genre,
			Date currDate) {
		return voorstellingDAO.findByGenreAndDatumGreaterThan(genre, currDate);
	}
	
	@Override
	public Iterable<Voorstelling> findAll(Iterable<Long> voorstellingsNrs){
		return voorstellingDAO.findAll(voorstellingsNrs);
	}
	
	@Override
	public Iterable<Voorstelling> findByDatumBetween(Date datum, Date datumEindeDag){
		return voorstellingDAO.findByDatumBetween(datum, datumEindeDag);
	}
}