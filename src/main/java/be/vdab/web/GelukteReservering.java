package be.vdab.web;

import java.util.Map;

public interface GelukteReservering {
	void setReservatiemandje(Map<Long, Integer> reservatiemandje);

	Map<Long, Integer> getReservatiemandje();
}