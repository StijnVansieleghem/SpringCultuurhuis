package be.vdab.dao;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import be.vdab.entities.Genre;
import be.vdab.entities.Klant;
import be.vdab.entities.Reservatie;
import be.vdab.entities.Voorstelling;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:/spring/dao.xml")
public class JPATest {
	private EntityManager entityManager;

	@PersistenceContext
	public void setEntityManager(EntityManager entityManager) {
		this.entityManager = entityManager;
	}

	@Test
	public void testGenre() {
		entityManager.find(Genre.class, 1L);
	}
	
	@Test
	public void testKlant() {
		entityManager.find(Klant.class, 1L);
	}
	
	@Test
	public void testReservatie() {
		entityManager.find(Reservatie.class, 1L);
	}
	
	@Test
	public void testVoorstelling() {
		entityManager.find(Voorstelling.class, 1L);
	}
}