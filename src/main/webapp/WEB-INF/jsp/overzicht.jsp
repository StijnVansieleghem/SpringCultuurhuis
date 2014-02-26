<%@page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix='spring' uri='http://www.springframework.org/tags'%>
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

<title>CultuurHuis - Overzicht</title>

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
	<div class="container">

		<div class="masthead">
			<h3 class="text-muted">
				<a href="" title="Overzicht">Het CultuurHuis - Overzicht</a>
			</h3>

			<ul class="nav nav-justified">
				<li><a href="${voorstellingenURL}" title="Voorstellingen">Voorstellingen</a></li>
			</ul>
		</div>

		<div class="row">
			<c:if test="${not empty gelukteReserveringen}">
				<h3>Gelukte reserveringen</h3>
				<table class="zebra">
					<tr>
						<th class="padded_right">Datum</th>
						<th class="padded_right">Titel</th>
						<th class="padded_right">Uitvoerders</th>
						<th class="padded_right">Prijs</th>
						<th>Plaatsen</th>
					</tr>
					<c:forEach var="gelukteReservering" items="${gelukteReserveringen}"
						varStatus="status">
						<tr>
							<td class="padded_right"><spring:eval
									expression='gelukteReservering.key.datum' /></td>
							<td class="padded_right">${gelukteReservering.key.titel}</td>
							<td class="padded_right">${gelukteReservering.key.uitvoerders}</td>
							<td class="align_right padded_right">&euro;<spring:eval
									expression='gelukteReservering.key.prijs' /></td>
							<td class="align_right">${gelukteReservering.value}</td>
						</tr>
					</c:forEach>
				</table>
				<br />${btcAdres}
			</c:if>
			<c:if test="${not empty mislukteReserveringen}">
				<h3>Mislukte reserveringen</h3>
				<table class="zebra">
					<tr>
						<th class="padded_right">Datum</th>
						<th class="padded_right">Titel</th>
						<th class="padded_right">Uitvoerders</th>
						<th class="padded_right">Prijs</th>
						<th class="padded_right">Plaatsen</th>
						<th>Vrije plaatsen</th>
					</tr>
					<c:forEach var="mislukteReservering"
						items="${mislukteReserveringen}" varStatus="status">
						<tr>
							<td class="padded_right"><spring:eval
									expression='mislukteReservering.key.datum' /></td>
							<td class="padded_right">${mislukteReservering.key.titel}</td>
							<td class="padded_right">${mislukteReservering.key.uitvoerders}</td>
							<td class="align_right padded_right">&euro;<spring:eval
									expression='mislukteReservering.key.prijs' /></td>
							<td class="align_right padded_right">${mislukteReservering.value}</td>
							<td class="align_right">${mislukteReservering.key.vrijePlaatsen}</td>
						</tr>
					</c:forEach>
				</table>
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


	<!-- Bootstrap core JavaScript
    ================================================== -->
	<!-- Placed at the end of the document so the pages load faster -->
</body>
</html>