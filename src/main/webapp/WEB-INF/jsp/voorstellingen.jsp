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
<style>
.ui-datepicker-next {
	display: none;
}

.ui-datepicker-prev {
	display: none;
}
</style>
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
						<table>
							<thead>
								<tr>
									<th class="padded_right">Datum</th>
									<th class="padded_right">Titel</th>
									<th class="padded_right">Uitvoerders</th>
									<th class="padded_right">Prijs</th>
									<th class="padded_right">Vrije Plaatsen</th>
									<th>Reserveren</th>
								</tr>
							</thead>
							<tbody>
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
							</tbody>
						</table>
					</c:when>
					<c:otherwise>
						<p>Er zijn helaas geen voorstellingen van dit genre.</p>
					</c:otherwise>
				</c:choose>
			</c:if>
			<form>
				<input id="datum" maxlength="10" size="10" type="text" /> <input
					id="submit" type="button" value="Sorteer" />
			</form>
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
		src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.4/jquery-ui.min.js"></script>
	<script 
		src="http://momentjs.com/downloads/moment-with-langs.min.js"></script>
	<script>
		//TODO: autocomplete toevoegen
		$('.row').hide();
		$(document).ready(function() {
			$('.row').slideDown(750);
			$('#datum').datepicker({
				inline: true,
				dateFormat : 'yy-mm-dd',
				yearRange : '-1:+1',
				changeMonth : true,
				changeYear: true,
				showAnim: 'slideDown', 
				duration: '750',
				beforeShow: function(){
					$('#voorstellingen').css({
						'height' : $('#voorstellingen').height() + 200
					});
				},
				onClose: function(){
					$('#voorstellingen').css({
						'height' : $('#voorstellingen').height() - 170
					});	
				},
			});
			$('#submit').click(function() {
				if(moment($('#datum').val()).isValid()){
					$.getJSON('rest/' + $('#datum').val(), function(data) {
						$('#voorstellingen').html(
								"<tr>"
								+ "<td class='padded_right'>"
								+ moment(data.datum).format('YYYY-M-D h:mm')
								+ "</td>"
								+ "<td class='padded_right'>"
								+ data.titel
								+ "</td>"
								+ "<td class='padded_right'>"
								+ data.uitvoerders
								+ "</td>"
								+ "<td class='padded_right'>&euro; "
								+ data.prijs
								+ "</td>"
								+ "<td class='align_right padded_right'>"
								+ data.vrijePlaatsen
								+ "</td>"
								+ "<td>"
								+ "<a href='/reserveren/"+ data.voorstellingsNr + "'>Reserveren</a>"
								+ "</td>"
								+ "</tr>"
						);
					});
				}
			});
		});
			//			$('#datum').change(function(){});
	</script>

	<!-- Bootstrap core JavaScript
    ================================================== -->
	<!-- Placed at the end of the document so the pages load faster -->
</body>
</html>