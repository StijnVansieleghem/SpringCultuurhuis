package be.vdab.dao;

import java.util.Date;

import org.springframework.data.jpa.repository.JpaRepository;

import be.vdab.entities.Genre;
import be.vdab.entities.Voorstelling;

public interface VoorstellingDAO extends JpaRepository<Voorstelling, Long> {
	public Iterable<Voorstelling> findByGenreAndDatumGreaterThan(Genre genre,Date currDate);
	public Iterable<Voorstelling> findByDatumBetween(Date datum, Date datumEindeDag);
}