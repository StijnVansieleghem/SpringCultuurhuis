package be.vdab.services;

import java.util.Date;

import be.vdab.entities.Genre;
import be.vdab.entities.Voorstelling;

public interface VoorstellingService {
	Voorstelling read(long id);
	Iterable<Voorstelling> findByGenreAndDatumGreaterThan(Genre genre, Date currDate);
	Iterable<Voorstelling> findAll(Iterable<Long> voorstellingsNrs);
}