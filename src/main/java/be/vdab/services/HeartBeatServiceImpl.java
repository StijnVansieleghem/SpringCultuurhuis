package be.vdab.services;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

//Deze klasse zorgt ervoor dat de CloudBees applicaties niet in slaap vallen

@Service
class HeartBeatServiceImpl implements HeartBeatService {
	private final RestTemplate restTemplate = new RestTemplate();

	@Override
	@Scheduled(fixedRate = 60000)
	public void sendHeartBeat() {
		restTemplate.getForObject("http://springcultuurhuis.stijnvansieleghem.cloudbees.net/", String.class);
		restTemplate.getForObject("http://toysforboys.stijnvansieleghem.cloudbees.net/", String.class);
		restTemplate.getForObject("http://personeel.stijnvansieleghem.cloudbees.net/", String.class);
	}
}