package be.vdab.services;

import be.vdab.entities.Genre;

public interface GenreService {
	Iterable<Genre> findAll();
	Genre read(long id);
}