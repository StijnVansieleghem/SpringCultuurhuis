package be.vdab.web;

import java.io.Serializable;
import java.util.Map;

import org.springframework.context.annotation.Scope;
import org.springframework.context.annotation.ScopedProxyMode;
import org.springframework.stereotype.Component;

@Component
@Scope(value = "session", proxyMode = ScopedProxyMode.INTERFACES)
public class ReservatiemandjeImpl implements Reservatiemandje, Serializable {
	public static final long serialVersionUID = 1L;
	private Map<Long, Integer> reservatiemandje;

	@Override
	public Map<Long, Integer> getReservatiemandje() {
		return reservatiemandje;
	}

	@Override
	public void setReservatiemandje(Map<Long, Integer> reservatiemandje) {
		this.reservatiemandje = reservatiemandje;
	}
}
