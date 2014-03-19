<%@page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix='spring' uri='http://www.springframework.org/tags'%>
<%@taglib prefix='form' uri='http://www.springframework.org/tags/form'%>
<%@taglib prefix='fmt' uri='http://java.sun.com/jsp/jstl/fmt'%>
<c:set var='contextPath'
	value='${pageContext.servletContext.contextPath}' />
<!doctype html>
<html lang="nl">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="">
<meta name="author" content="Stijn Vansieleghem">

<title>CultuurHuis - Reservatiemandje</title>

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
				<a href="" title="Reservatiemandje">Het CultuurHuis -
					Reservatiemandje</a>
			</h3>

			<ul class="nav nav-justified">
				<li><a href="${voorstellingenURL}" title="Voorstellingen">Voorstellingen</a></li>
				<li><a href="${bevestig_reservatieURL}"
					title="Bevestiging reservatie">Bevestiging reservatie</a></li>
			</ul>
		</div>
		<div class="row">
			<div id="reservatiemandje">
				<form action="${reservatiemandjeURL}" id="verwijderReservatie"
					method="post">
					<table>
						<tr>
							<th class="padded_right">Datum</th>
							<th class="padded_right">Titel</th>
							<th class="padded_right">Uitvoerders</th>
							<th class="padded_right">Prijs</th>
							<th class="padded_right">Plaatsen</th>
							<th><input id="verwijderen" name="verwijderen" type="button"
								value="verwijderen" /></th>
						</tr>
					</table>
				</form>
				<p>
					Te betalen: &euro; <span id="totaalPrijs"></span>
				</p>
			</div>
			<ul class="fouten">
			</ul>
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

							var voorstellingsNummers = $.jStorage.get('voorstellingsNummers');
							var aantalPlaatsen = $.jStorage.get('aantalPlaatsen');

							var totaalPrijs = 0;
							if ((voorstellingsNummers !== null && aantalPlaatsen !== null)
									&& (voorstellingsNummers !== '' && aantalPlaatsen !== '')) {
								var arrVoorstellingsNummers = [];
								arrVoorstellingsNummers = voorstellingsNummers.split(',');
								var arrAantalPlaatsen = [];
								arrAantalPlaatsen = aantalPlaatsen.split(',');
								var i = 0;
								arrVoorstellingsNummers.forEach(function(entry){
									$.getJSON('reservatiemandje/' + arrVoorstellingsNummers[i], 
										function(data) {
										$('table').append(
										"<tr>"
										+"<td class='padded_right'>"+ data.datum +"</td>"
										+"<td class='padded_right'>"+ data.titel +"</td>"
										+"<td class='padded_right'>"+ data.uitvoerders +"</td>"
										+"<td class='padded_right'>&euro; "+ data.prijs +"</td>"
										//TODO: fix arrAantalPlaatsen[i] 
										+"<td class='align_right padded_right'>x</td>"
										+"<td><input id='voorstellingsNr' type='checkbox' value='' /></td>"
										+"</tr>");
										//evt. totaalprijs via rest service
										totaalPrijs += data.prijs;
									}).done(function(){$('#totaalPrijs').val(totaalPrijs);
									});
									i++;
								});
							} else {
								$('#reservatiemandje').hide();
								$('.fouten').append(
										'<li>Uw winkelmandje is leeg</li>');
								$('.fouten').fadeIn(1000);
							}
							alert(totaalPrijs);
							$('#totaalPrijs').append(totaalPrijs);

							$('#verwijderen').click(function(event) {
								verwijderVoorstellingen(getValues());
							});
							
							$('tr').click(function(){
								//TODO: enkel tr's van tbody
								$(this).parents('table').find('tr').each(function(index,element){
									$(element).css({"background-color" : "#FFF"});
								});
								$(this).css({"background-color" : "#F0F0F0"});
							});
							
							function getValues() {
								var arrValues = [];
								$('#voorstellingsNr:checked').each(function() {
									arrValues.push($(this).val().split(","));
								});
								return arrValues;
							}

							function verwijderVoorstellingen(arrValues) {
								if (arrValues.length != 0) {
									var i = 0;
									arrValues
											.forEach(function(entry) {
												//bgcolor aanpassen
												$('tr:has(#voorstellingsNr:checked)').css({'background-color' : '#fb6c6c'});
												$('tr:has(#voorstellingsNr:checked)')
														.fadeOut(1000);
												var voorstellingsNummers = $.jStorage.get('voorstellingsNummers');
												var aantalPlaatsen = $.jStorage.get('aantalPlaatsen');

												var arrVoorstellingsNummers = [];
												arrVoorstellingsNummers = voorstellingsNummers
														.split(',');

												var arrAantalPlaatsen = [];
												arrAantalPlaatsen = aantalPlaatsen
														.split(',');

												var arrVoorstellingsNummersKopie = arrVoorstellingsNummers;
												var positie = $.inArray(arrValues[i],
																arrVoorstellingsNummers);

												if (positie === -1) {
													arrVoorstellingsNummersKopie
															.splice(positie, 1);
													arrAantalPlaatsen.splice(
															positie, 1);
												}

												$.jStorage.set(
														'voorstellingsNummers',
														arrVoorstellingsNummersKopie
																.join());
												$.jStorage.set(
														'aantalPlaatsen',
														arrAantalPlaatsen
																.join());
												i++;
											});
								};
								if ($.jStorage.get('voorstellingsNummers') === '') {
									$.jStorage.deleteKey('voorstellingsNummers');
									$.jStorage.deleteKey('aantalPlaatsen');
								}
							}
						});
	</script>

	<!-- Bootstrap core JavaScript
    ================================================== -->
	<!-- Placed at the end of the document so the pages load faster -->
</body>
</html>