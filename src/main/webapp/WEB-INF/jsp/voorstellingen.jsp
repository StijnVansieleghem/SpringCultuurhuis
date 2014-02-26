<%@page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix='spring' uri='http://www.springframework.org/tags'%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
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

<title>CultuurHuis - Voorstellingen</title>

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
	<c:url value="voorstellingen" var="voorstellingURL" />
	<c:url value="reservatiemandje" var="reservatiemandjeURL" />
	<c:url value="bevestig_reservatie" var="bevestig_reservatieURL" />
	<div class="container">
		<div class="masthead">
			<h3 class="text-muted">
				<a href="" title="Voorstellingen">Het CultuurHuis -
					Voorstellingen</a>
			</h3>

			<ul class="nav nav-justified" id="genres">
				<c:forEach var="genre" items="${genres}">
					<c:url value='/voorstellingen/${genre.genreNr}' var='genreURL' />
					<li><a href='${genreURL}' title='${genre.naam}'>${genre.naam}</a></li>
				</c:forEach>
			</ul>
		</div>

		<div class="row" id="voorstellingen">
			<c:if test="${not empty huidigGenre}">
				<h2>${huidigGenre.naam}&nbsp;voorstellingen</h2>
				<c:choose>
					<c:when test="${not empty voorstellingen}">
						<table class="zebra">
							<tr>
								<th class="padded_right">Datum</th>
								<th class="padded_right">Titel</th>
								<th class="padded_right">Uitvoerders</th>
								<th class="padded_right">Prijs</th>
								<th class="padded_right">Vrije Plaatsen</th>
								<th>Reserveren</th>
							</tr>
							<c:forEach var="voorstelling" items="${voorstellingen}">
								<tr>
									<td class="padded_right"><spring:eval
											expression='voorstelling.datum' /></td>
									<td class="padded_right">${voorstelling.titel}</td>
									<td class="padded_right">${voorstelling.uitvoerders}</td>
									<td class="padded_right">&euro; <spring:eval
											expression='voorstelling.prijs' /></td>
									<td class="align_right padded_right">${voorstelling.vrijePlaatsen}</td>
									<td><c:if test="${voorstelling.vrijePlaatsen != 0}">
											<c:url value='/reserveren/${voorstelling.voorstellingsNr}'
												var='reservatieURL' />
											<a href='${reservatieURL}'>reserveren</a>
										</c:if></td>
								</tr>
							</c:forEach>
						</table>
					</c:when>
					<c:otherwise>
						<p>Er zijn helaas geen voorstellingen van dit genre.</p>
					</c:otherwise>
				</c:choose>
			</c:if>

			<c:if test="${not empty fouten}">
				<p class="fouten">${fouten}</p>
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

	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
	<script>
		$('.row').hide();
		$(document).ready(function() {
			$('.row').slideDown(750);
		});
	</script>

	<!-- Bootstrap core JavaScript
    ================================================== -->
	<!-- Placed at the end of the document so the pages load faster -->
</body>
</html>