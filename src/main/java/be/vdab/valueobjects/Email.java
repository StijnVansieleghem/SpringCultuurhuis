package be.vdab.valueobjects;

import java.io.Serializable;

import javax.persistence.Embeddable;
import javax.validation.constraints.Pattern;

@Embeddable
public class Email implements Serializable {
	private static final long serialVersionUID = 1L;
	private static final String REG_EXPR = "^.+@.+\\.[a-z]+$";
	@Pattern(regexp = REG_EXPR, message = "{Pattern.email}")
	private final String email;

	public Email(String email) {
		this.email = email;
	}

	protected Email() {
		this.email = null;
	}

	public String getEmail() {
		return email;
	}

	@Override
	public boolean equals(Object obj) {
		if (!(obj instanceof Email)) {
			return false;
		}
		return ((Email) obj).email.equalsIgnoreCase(this.email);
	}

	@Override
	public int hashCode() {
		return email.toLowerCase().hashCode();
	}

	@Override
	public String toString() {
		return email;
	}
}