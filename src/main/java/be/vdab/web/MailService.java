package be.vdab.web;

public interface MailService {
	void zendMail(String to, String subject, String text);
}