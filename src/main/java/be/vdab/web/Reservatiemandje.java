package be.vdab.web;

import java.util.Map;

public interface Reservatiemandje {
	void setReservatiemandje(Map<Long,Integer> reservatiemandje);
	Map<Long, Integer> getReservatiemandje();
}
