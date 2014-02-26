package be.vdab.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import be.vdab.dao.GenreDAO;
import be.vdab.entities.Genre;

@Service
class GenreServiceImpl implements GenreService{
	private final GenreDAO genreDAO;
	
	@Autowired
	public GenreServiceImpl(GenreDAO genreDAO){
		this.genreDAO = genreDAO;
	}

	@Override
	public Iterable<Genre> findAll() {
		return genreDAO.findAll();
	}

	@Override
	public Genre read(long id) {
		return genreDAO.findOne(id);
	}
}