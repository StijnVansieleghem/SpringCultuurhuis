package be.vdab.dao;

import org.springframework.data.jpa.repository.JpaRepository;

import be.vdab.entities.Reservatie;

public interface ReservatieDAO extends JpaRepository<Reservatie, Long> {
}