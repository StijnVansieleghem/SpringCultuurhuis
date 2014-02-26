package be.vdab.services;

import javax.persistence.EntityManager;
import javax.persistence.LockModeType;
import javax.persistence.PersistenceContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import be.vdab.dao.ReservatieDAO;
import be.vdab.entities.Reservatie;
import be.vdab.entities.Voorstelling;

@Service
class ReservatieServiceImpl implements ReservatieService {
	private final ReservatieDAO reservatieDAO;
	@PersistenceContext
	private EntityManager entityManager;

	@Autowired
	public ReservatieServiceImpl(ReservatieDAO reservatieDAO) {
		this.reservatieDAO = reservatieDAO;
	}

	@Override
	public Reservatie read(long id) {
		return reservatieDAO.findOne(id);
	}

	@Override
	@Transactional(readOnly = false)
	public boolean create(Reservatie reservatie) {
		Voorstelling voorstelling = reservatie.getVoorstelling();
		entityManager.lock(voorstelling, LockModeType.PESSIMISTIC_READ);
		if (voorstelling.getVrijePlaatsen() >= reservatie.getPlaatsen()) {
			voorstelling.verminderVrijePlaatsen(reservatie);
			reservatieDAO.save(reservatie);
			return true;
		}
		return false;
	}
}