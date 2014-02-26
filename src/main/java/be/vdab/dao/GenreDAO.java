package be.vdab.dao;

import org.springframework.data.jpa.repository.JpaRepository;

import be.vdab.entities.Genre;

public interface GenreDAO extends JpaRepository<Genre, Long> {
}