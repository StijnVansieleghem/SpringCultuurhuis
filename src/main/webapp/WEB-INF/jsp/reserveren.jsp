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
				<c:if test="${not empty toonLinkReservatiemandje}">
					<li><a href="${reservatiemandjeURL}" title="Reservatiemandje">Reservatiemandje</a></li>
					<li><a href="${bevestig_reservatieURL}"
						title="Bevestiging reservatie">Bevestiging reservatie</a></li>
				</c:if>
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
					Vrije plaatsen: <br /> <span class="bold">${voorstelling.vrijePlaatsen}</span>
				</p>
				<form:form action="${reserverenURL}" method="post"
					commandName="reservatieForm">
					<form:label path="aantalPlaatsen">Plaatsen: </form:label>
					<br />
					<form:input path="aantalPlaatsen" type="number" min="1"
						max="${voorstelling.vrijePlaatsen}" maxlength="4" size="4"
						autofocus="autofocus" required="required" />
					<br />
					<input id="voorstellingsNr" name="voorstellingsNr" type="hidden"
						value="${voorstelling.voorstellingsNr}" />
					<br />
					<input class="submit" name="submit" type="submit"
						value="Reserveren" />
				</form:form>
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