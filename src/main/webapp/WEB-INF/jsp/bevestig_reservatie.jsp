<%@page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix='fmt' uri='http://java.sun.com/jsp/jstl/fmt'%>
<c:set var='contextPath'
	value='${pageContext.servletContext.contextPath}' />
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="">
<meta name="author" content="Stijn Vansieleghem">

<title>CultuurHuis - Bevestig reservatie</title>

<!-- Bootstrap core CSS -->
<link href="${contextPath}/stylesheets/bootstrap.css" rel="stylesheet">

<!-- Custom styles for this template -->
<link href="${contextPath}/stylesheets/justified-nav.css"
	rel="stylesheet">

<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
      <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
    <![endif]-->
</head>
<body>
	<c:url value="voorstellingen" var="voorstellingenURL" />
	<c:url value="reservatiemandje" var="reservatiemandjeURL" />
	<c:url value="bevestig_reservatie" var="bevestig_reservatieURL" />
	<div class="container">


		<div class="masthead">
			<h3 class="text-muted">
				<a href="" title="Bevestiging reservaties">Het CultuurHuis -
					Bevestiging reservaties</a>
			</h3>

			<ul class="nav nav-justified">
				<li><a href="${voorstellingenURL}" title="Voorstellingen">Voorstellingen</a></li>
				<li><a href="${reservatiemandjeURL}" title="Reservatiemandje">Reservatiemandje</a></li>
				<li id="afmeldKnop"><a href="<c:url value='/j_spring_security_logout'/>"
					id="afmelden" title="Afmelden">Afmelden</a></li>
			</ul>
		</div>

		<div class="row">
			<h2>Stap 1: wie ben je?</h2>
			<div id="gebruiker">
				<form action="<c:url value="/j_spring_security_check"/>"
					id="frmZoekGebruiker" method="post" name="frmZoekGebruiker">
					<label>Gebruikersnaam:<br /> <input maxlength="50"
						id="gebruikersnaamVeld" name="j_username" type="text" autofocus
						required /></label><br /> <label>Paswoord<br /> <input
						maxlength="50" id="paswoordVeld" name="j_password" type="password"
						required /></label><br /> <input class="btn btn-sm btn-primary" id="zoekGebruiker" name="zoekGebruiker"
						type="button" value="Zoek me op" />
				</form>
				<br />
				<button class="btn btn-sm btn-primary"  id="nieuweGebruiker">Ik ben nieuw</button>
			</div>
			<br />
			<p>
				<span class="bold" id="gebruikerGegevens"></span>
			</p>
			<ul class="fouten">
			</ul>
			<div id="bevestigKnop">
				<h2>Stap 2: Bevestigen</h2>
				<button class="btn btn-sm btn-primary" id="bevestigKnop">Bevestigen</button>
			</div>
		</div>

		<!-- Site footer -->
		<div class="footer">
			<p>
				&copy; Stijn Vansieleghem
				<jsp:useBean id="date" class="java.util.Date" />
				<fmt:formatDate value="${date}" pattern="yyyy" />
			</p>
		</div>

	</div>
	<!-- /container -->

	<script
		src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.0/jquery.min.js"></script>
	<script src="http://cdnjs.cloudflare.com/ajax/libs/json2/20110223/json2.js"></script>
	<script src="${contextPath}/js/jstorage.js"></script>

	<script>
		$('document')
				.ready(
						function() {
							$('.fouten').hide();
							$('#bevestigKnop').hide();
							$('#gebruikerGegevens').hide();
							$('#afmeldKnop').hide();

							if (getSessionStorage() !== null) {
								$('#gebruikerGegevens').html(
										getSessionStorage());
								veranderKnoppenIngelogd();
							}

							if ($.jStorage.get('voorstellingsNummers') === null
									|| $.jStorage.get('voorstellingsNummers') === '') {
								$('.fouten')
										.append(
												'<li>U kan geen reservaties bevestigen want uw winkelmandje is leeg</li>');
								$('.fouten').fadeIn(1000);
							}

							$('#zoekGebruiker').click(function(event) {
								loginGebruiker();
							});

							$('#nieuweGebruiker').click(function(event) {
								window.location = 'nieuwe_klant';
							});

							$('#bevestigKnop').click(function(event) {
								bevestigReservaties();
							});

							$('#afmelden').click(function(event) {
								$.jStorage.flush();
							});

							function loginGebruiker() {
								if ($('#gebruikersnaamVeld').val() !== ''
										&& $('#paswoordVeld').val() !== '') {
									$.get('bevestig_reservatie/' + $('#gebruikersnaamVeld').val() + '&' + $('#paswoordVeld').val(),
										function(data) {
											if (data !== 'mislukt') {
												$('#gebruikerGegevens').html(<c:out value="data"/>);
												//login session expires na 20 minuten
												$.jStorage.set('user',data,{TTL: 1200000});
												veranderKnoppenIngelogd();
											} else {
												$('.fouten').append('<li>Foutieve aanmeldgegevens</li>');
												$('.fouten').fadeIn(10000);
											}
										});
								}
							}

							function bevestigReservaties() {
								var combinatieVoorstellingsNummersAantalPlaatsen = $.jStorage.get('voorstellingsNummers') + '&' + $.jStorage.get('aantalPlaatsen');
								
								//data bevat gelukte & mislukte reservaties
								$.post('bevestig_reservatie/' + combinatieVoorstellingsNummersAantalPlaatsen,
										function(data){
											console.log(data);
								});
								//window.location = 'overzicht';
							}

							function veranderKnoppenIngelogd() {
								$('#gebruikerGegevens').fadeIn(1000);
								if ($.jStorage.get('voorstellingsNummers') !== null
										&& $.jStorage.get('voorstellingsNummers') !== '') {
									$('#bevestigKnop').fadeIn(1000);
								}
								$('#gebruiker').hide();
								$('.fouten').hide();
								$('#afmeldKnop').show();
							}

							function getSessionStorage() {
								return $.jStorage.get('user');
							}
						});
	</script>

	<!-- Bootstrap core JavaScript
    ================================================== -->
	<!-- Placed at the end of the document so the pages load faster -->
</body>
</html>