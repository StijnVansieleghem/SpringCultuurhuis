package be.vdab.web;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

//productiecode: 
//import org.slf4j.Logger;
//import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

@Service
class MailServiceImpl implements MailService {
	private final JavaMailSender mailSender;
	//productiecode: 
	// private final Logger logger = LoggerFactory
	// .getLogger(MailServiceImpl.class);

	@Autowired
	public MailServiceImpl(JavaMailSender mailSender) {
		this.mailSender = mailSender;
	}

	@Override
	@Async
	public void zendMail(String to, String subject, String text) {
		try {
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper helper = new MimeMessageHelper(message, true);
			helper.setTo(to);
			helper.setSubject(subject);
			helper.setText(text, true);
			mailSender.send(message);
			//productiecode: 
			// logger.info("mail is verstuurd");
		} catch (MessagingException ex) {
		}
	}
}