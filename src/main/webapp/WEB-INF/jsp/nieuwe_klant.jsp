<%@page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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

<title>CultuurHuis - Nieuwe klant</title>

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
	<c:url value="nieuwe_klant" var="nieuwe_klantURL" />
	<div class="container">
		<div class="masthead">
			<h3 class="text-muted">
				<a href="" title="Nieuwe klant">Het CultuurHuis - Nieuwe Klant</a>
			</h3>

			<ul class="nav nav-justified">
				<li><a href="${voorstellingenURL}" title="Voorstellingen">Voorstellingen</a></li>
				<li><a href="${reservatiemandjeURL}" title="Reservatiemandje">Reservatiemandje</a></li>
				<li><a href="${bevestig_reservatieURL}"
					title="Bevestiging reservaties">Bevestiging reservaties</a></li>
			</ul>
		</div>

		<div class="row">
			<c:if test="${not empty nieuweKlantForm}">
				<form:form action="${nieuwe_klantURL}" method="post"
					commandName="nieuweKlantForm">
					<form:label path="voornaam">Voornaam:</form:label>
					<br />
					<form:input path="voornaam" size="50" type="text"
						value="${voornaam}" autofocus="autofocus" pattern=".{2,50}" title="Moet tussen 2 en 50 tekens bevatten"
						maxlength="50" required="required" />
					<br />
					<form:errors path='voornaam' cssClass='fouten' />
					<br />
					<form:label path="familienaam">Familienaam:</form:label>
					<br />
					<form:input path="familienaam" size="50" type="text"
						value="${familienaam}" pattern=".{2,50}" title="Moet tussen 2 en 50 tekens bevatten" maxlength="50"
						required="required" />
					<br />
					<form:errors path='familienaam' cssClass='fouten' />
					<br />
					<form:label path="straat">Straat:</form:label>
					<br />
					<form:input path="straat" size="50" type="text" value="${straat}"
						maxlength="50" required="required" />
					<br />
					<form:errors path='straat' cssClass='fouten' />
					<br />
					<form:label path="huisNr">Huisnr:</form:label>
					<br />
					<form:input path="huisNr" size="50" maxlength="6"
						type="text" value="${huisNr}" required="required" />
					<br />
					<form:errors path='huisNr' cssClass='fouten' />
					<br />
					<form:label path="postcode">Postcode:</form:label>
					<br />
					<form:input path="postcode" size="50" maxlength="6" min="1000"
						max="9000" type="number" value="${postcode}" pattern="^([1-8]{1}[0-9]{3}|9000)$" title="Moet tussen 1000 en 9000 liggen" required="required" />
					<br />
					<form:errors path='postcode' cssClass='fouten' />
					<br />
					<form:label path="gemeente">Gemeente:</form:label>
					<br />
					<form:input path="gemeente" size="50" type="text"
						value="${gemeente}" maxlength="50"
						required="required" />
					<br />
					<form:errors path='gemeente' cssClass='fouten' />
					<br />
					<form:label path="email">Email:</form:label>
					<br />
					<form:input path="email" size="50" type="email" value="${email}"
						maxlength="50" required="required" />
					<br />
					<form:errors path='email' cssClass='fouten' />
					<br />
					<form:label path="gebruikersnaam">Gebruikersnaam:</form:label>
					<br />
					<form:input path="gebruikersnaam" size="50" type="text"
						value="${gebruikersnaam}" maxlength="50"
						required="required" />
					<c:if test="${not empty gebruikersnaamFout}">
						<br />
						<span class="fouten">${gebruikersnaamFout}</span>
					</c:if>
					<br />
					<form:errors path='gebruikersnaam' cssClass='fouten' />
					<br />
					<form:label path="paswoord">Paswoord:</form:label>
					<br />
					<form:input path="paswoord" size="50" maxlength="50"
						type="password" required="required" />
					<br />
					<form:errors path='paswoord' cssClass='fouten' />
					<br />
					<form:label path="herhaalPaswoord">Herhaal paswoord:</form:label>
					<c:if test="${not empty paswoordFout}">
						<br />
						<span class="fouten">${paswoordFout}</span>
					</c:if>
					<br />
					<form:input path="herhaalPaswoord" size="50" maxlength="50"
						type="password" required="required" />
					<br />
					<form:errors path='herhaalPaswoord' cssClass='fouten' />
					<br />
					<input class="submit" name="submit" type="submit" value="OK" />
				</form:form>
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


	<!-- Bootstrap core JavaScript
    ================================================== -->
	<!-- Placed at the end of the document so the pages load faster -->
</body>
</html>