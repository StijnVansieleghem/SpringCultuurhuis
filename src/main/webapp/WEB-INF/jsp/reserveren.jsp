<%@page language="java" contentType="text/html" pageEncoding="UTF-8"
	trimDirectiveWhitespaces="true"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix='spring' uri='http://www.springframework.org/tags'%>
<%@taglib prefix='form' uri='http://www.springframework.org/tags/form'%>
<%@taglib prefix='fmt' uri='http://java.sun.com/jsp/jstl/fmt'%>
<c:set var='contextPath'
	value='${pageContext.servletContext.contextPath}' />
<!doctype html">
<html lang="nl">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="">
<meta name="author" content="Stijn Vansieleghem">

<title>CultuurHuis - Reserveren</title>

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
	<c:url value="/reserveren" var="reserverenURL" />
	<c:url value="/voorstellingen" var="voorstellingenURL" />
	<c:url value="/reservatiemandje" var="reservatiemandjeURL" />
	<c:url value="/bevestig_reservatie" var="bevestig_reservatieURL" />

	<div class="container">
		<div class="masthead">
			<h3 class="text-muted">
				<a href="" title="Reserveren">Het CultuurHuis - Reserveren</a>
			</h3>

			<ul class="nav nav-justified">
				<li><a href="${voorstellingenURL}" title="Voorstellingen">Voorstellingen</a></li>
				<li class="reservatiemandjeSet"><a
					href="${reservatiemandjeURL}" title="Reservatiemandje">Reservatiemandje</a></li>
				<li class="reservatiemandjeSet"><a
					href="${bevestig_reservatieURL}" title="Bevestiging reservatie">Bevestiging
						reservatie</a></li>
			</ul>
		</div>

		<div class="row">
			<c:if test="${not empty voorstelling}">
				<p>
					Voorstelling: <br /> <span class="bold">${voorstelling.titel}</span>
				</p>
				<p>
					Uitvoerders: <br /> <span class="bold">${voorstelling.uitvoerders}</span>
				</p>
				<p>
					Datum: <br /> <span class="bold"><spring:eval
							expression='voorstelling.datum' /></span>
				</p>
				<p>
					Prijs: <br /> <span class="bold">&euro; <spring:eval
							expression='voorstelling.prijs' /></span>
				</p>
				<p>
					Vrije plaatsen: <br /> <span class="bold" id="vrijePlaatsen">${voorstelling.vrijePlaatsen}</span>
				</p>
				<form action="post">
					<!-- fix labels -->
					<label for="aantalPlaatsen">Plaatsen: </label> <br /> <input
						id="aantalPlaatsen" type="number" min="1"
						max="${voorstelling.vrijePlaatsen}" maxlength="4" size="4"
						autofocus="autofocus"
						title="Hoeveel plaatsen wenst u te reserveren?"
						required="required" /> <br /> <input id="voorstellingsNr"
						type="hidden" value="${voorstelling.voorstellingsNr}" /> <br /> <input
						id="submit" name="submit" type="submit" value="Reserveren" />
				</form>
			</c:if>
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
	<script
		src="http://cdnjs.cloudflare.com/ajax/libs/json2/20110223/json2.js"></script>
	<script src="${contextPath}/js/jstorage.js"></script>

	<script>
		$('document').ready(
				function() {
					$('.reservatiemandjeSet').hide();
					var voorstellingsNummers = $.jStorage
							.get('voorstellingsNummers');
					var aantalPlaatsen = $.jStorage.get('aantalPlaatsen');

					if (voorstellingsNummers != null) {
						$('.reservatiemandjeSet').show();
						var arrVoorstellingsNummers = [];
						arrVoorstellingsNummers = voorstellingsNummers
								.split(',');
						var arrAantalPlaatsen = [];
						arrAantalPlaatsen = aantalPlaatsen.split(',');

						var positie = arrVoorstellingsNummers.indexOf($(
								'#voorstellingsNr').val());
						$('#aantalPlaatsen').val(arrAantalPlaatsen[positie]);
					}

					$('#submit').click(
							function(event) {
								event.preventDefault();
								if ($.trim($('#aantalPlaatsen').val()) !== '' && $('#aantalPlaatsen').val() > 0 && $('#aantalPlaatsen').val() <= $('#vrijePlaatsen').html()) {
									setReservatiemandje(voorstellingsNummers,
											aantalPlaatsen);
									window.location = '../reservatiemandje';
								}
							});

					function setReservatiemandje(voorstellingsNummers,
							aantalPlaatsen) {
						if (voorstellingsNummers != null
								&& aantalPlaatsen != null) {
							var arrVoorstellingsNummers = [];
							arrVoorstellingsNummers = voorstellingsNummers
									.split(',');
							var arrAantalPlaatsen = [];
							arrAantalPlaatsen = aantalPlaatsen.split(',');

							var positie = arrVoorstellingsNummers.indexOf($(
									'#voorstellingsNr').val());

							if (positie === -1) {
								voorstellingsNummers += ','
										+ $('#voorstellingsNr').val();
								$.jStorage.set('voorstellingsNummers',
										voorstellingsNummers);
								aantalPlaatsen += ','
										+ $('#aantalPlaatsen').val();
								$.jStorage
										.set('aantalPlaatsen', aantalPlaatsen);
								i++;
							} else {
								arrAantalPlaatsen[positie] = $(
										'#aantalPlaatsen').val();
								$.jStorage.set('aantalPlaatsen',
										arrAantalPlaatsen.join());
							}
						} else {
							$.jStorage.set('voorstellingsNummers', $(
									'#voorstellingsNr').val());
							$.jStorage.set('aantalPlaatsen', $(
									'#aantalPlaatsen').val());
						}
					}
					;
				});
	</script>

	<!-- Bootstrap core JavaScript
================================================== -->
	<!-- Placed at the end of the document so the pages load faster -->
</body>
</html>