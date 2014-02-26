package be.vdab.services;

import be.vdab.entities.Reservatie;

public interface ReservatieService {
	Reservatie read(long id);

	boolean create(Reservatie reservatie);
}