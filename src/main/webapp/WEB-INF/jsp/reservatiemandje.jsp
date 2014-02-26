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
			<c:if test="${not empty mandje}">
				<form action="${reservatiemandjeURL}" id="verwijderReservatie"
					method="post">
					<table class="zebra">
						<tr>
							<th class="padded_right">Datum</th>
							<th class="padded_right">Titel</th>
							<th class="padded_right">Uitvoerders</th>
							<th class="padded_right">Prijs</th>
							<th class="padded_right">Plaatsen</th>
							<th><input id="verwijderen" name="verwijderen" type="submit"
								value="verwijderen" /></th>
						</tr>
						<c:forEach var="mandjeItem" items="${mandje}" varStatus="status">
							<tr>
								<td class="padded_right"><spring:eval
										expression='mandjeItem.key.datum' /></td>
								<td class="padded_right">${mandjeItem.key.titel}</td>
								<td class="padded_right">${mandjeItem.key.uitvoerders}</td>
								<td class="padded_right">&euro; <spring:eval
										expression='mandjeItem.key.prijs' /></td>
								<td class="align_right padded_right">${mandjeItem.value}</td>
								<td><input name="voorstellingsNr" id="voorstellingsNr"
									type="checkbox" value="${mandjeItem.key.voorstellingsNr}" /></td>
							</tr>
						</c:forEach>
					</table>
				</form>
				<p>
					Te betalen: &euro; <span class="totaalPrijs"><spring:eval
							expression='totaalPrijs' /></span>
				</p>
			</c:if>
			<c:if test="${not empty fouten}">
				<c:forEach var="fout" items="${fouten}">
					<ul class="fouten">
						<li>${fout}</li>
					</ul>
				</c:forEach>
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
		src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
	<script>
		$('document').ready(function() {
			$('#verwijderen').click(function(event) {
				event.preventDefault();
				verwijderVoorstellingen(getValues());
				updateTotaalPrijs();
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
					arrValues.forEach(function(entry) {
						$('tr:has(#voorstellingsNr:checked)').fadeOut(1000);
						
						$.ajax({
							type : "DELETE",
							url : "reservatiemandje/" + entry
						});
					});
				};
			}
			
			function updateTotaalPrijs(){
				$.get('reservatiemandje/getTotaalPrijs', function(data) {
					if (data == 0) {
						window.location = 'voorstellingen';
					}
						
					//fix internationalization van totaalprijs
					var getal = '<fmt:formatNumber value='3.14'/>';
					if (getal.indexOf('.') === -1) {
						data = data.replace('.', ',');
					}
						
					$('.totaalPrijs').html(data);
				});
			}
		});
	</script>

	<!-- Bootstrap core JavaScript
    ================================================== -->
	<!-- Placed at the end of the document so the pages load faster -->
</body>
</html>