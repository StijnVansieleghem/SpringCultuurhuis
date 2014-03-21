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

.ui-datepicker table {  
    width: 100%;
    margin-bottom:0;
} 

.ui-datepicker {  
	width: 220px;  
	height: auto;  
	margin: 5px auto 0;  
 	-webkit-box-shadow: 0px 0px 10px 0px rgba(0, 0, 0, .5);  
	-moz-box-shadow: 0px 0px 10px 0px rgba(0, 0, 0, .5);  
	box-shadow: 0px 0px 10px 0px rgba(0, 0, 0, .5);
	background-color:#FFF;
}

.ui-datepicker thead, .ui-datepicker-header {  
	background-color: #f7f7f7;  
	background-image: -moz-linear-gradient(top,  #f7f7f7 0%, #f1f1f1 100%);  
	background-image: -webkit-gradient(linear, left top, left bottombottom, color-stop(0%,#f7f7f7), color-stop(100%,#f1f1f1));  
	background-image: -webkit-linear-gradient(top,  #f7f7f7 0%,#f1f1f1 100%);  
	background-image: -o-linear-gradient(top,  #f7f7f7 0%,#f1f1f1 100%);  
	background-image: -ms-linear-gradient(top,  #f7f7f7 0%,#f1f1f1 100%);  
	background-image: linear-gradient(top,  #f7f7f7 0%,#f1f1f1 100%);  
	filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#f7f7f7', endColorstr='#f1f1f1',GradientType=0 );  
	border-bottom: 1px solid #bbb;
	padding:2px;
	text-align:center;
}  

    .ui-datepicker th {  
        text-transform: uppercase;  
        font-size: 7pt;  
        padding: 5px 0;  
        color: #666666;  
        text-shadow: 1px 0px 0px #fff;  
        filter: dropshadow(color=#fff, offx=1, offy=0);
        text-align:center;  
    }
    .ui-datepicker tbody td {  
    padding: 0;  
    border-right: 1px solid #bbb;
    text-align:center;
}
    .ui-datepicker tbody td:last-child {  
        border-right: 0px;  
    }
    .ui-datepicker tbody tr {  
    border-bottom: 1px solid #bbb;  
}  
.ui-datepicker tbody tr:last-child {  
    border-bottom: 0px;  
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
						<table id="voorstellingenGesorteerdOpGenre">
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
			<c:if test="${empty huidigGenre}">
				<form>
					<input id="zoekDatum" maxlength="10" size="10" type="date" placeholder="Zoek datum" />
				</form>
			</c:if>
			<div id="voorstellingenGesorteerdOpDatum" style="display:none;">
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
							</tbody>
							</table>
							<div id="geenVoorstellingen"></div>
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
	<script
		src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.4/jquery-ui.min.js"></script>
	<script 
		src="http://momentjs.com/downloads/moment-with-langs.min.js"></script>
	<script src="${contextPath}/js/modernizr.js"></script>
	<script src="http://ajax.aspnetcdn.com/ajax/jquery.dataTables/1.9.4/jquery.dataTables.min.js
	"></script>
	<script>
		$('.row').hide();
		$('#voorstellingenGesorteerdOpDatum').hide();
		<c:if test="${not empty voorstellingen}">
			$('#voorstellingenGesorteerdOpGenre').dataTable({
				'bPaginate' : false,
				'bProcessing' : true,
				'bInfo' : false,
				'aoColumnDefs' : [
				                  { 'bSortable' : false, 'aTargets' : [5] },
				                  { 'bSearchable' : false, 'aTargets' : [5]}
				                 ],
				'oLanguage' : {
					'sSearch' : 'Filter: ',
					'sZeroRecords' : '<fmt:message key="dataTableZeroRecords"/>',
					},
			});
		</c:if>
		$(document).ready(function() {
			$('.row').slideDown(750);
			if(!Modernizr.inputtypes.date){
				$('#zoekDatum').datepicker({
					'inline' : false,
					'dateFormat' : 'yy-mm-dd',
					'yearRange' : '-1:+1',
					'changeMonth' : true,
					'changeYear' : true,
					'showAnim' : 'slideDown', 
					'duration' : '750',
					'dayNamesMin' : ['<fmt:message key="zondag"/>'
					              , '<fmt:message key="maandag"/>'
					              , '<fmt:message key="dinsdag"/>'
					              , '<fmt:message key="woensdag"/>'
					              , '<fmt:message key="donderdag"/>'
					              , '<fmt:message key="vrijdag"/>'
					              , '<fmt:message key="zaterdag"/>'],
					'showOn' : "button",
					'buttonImage' : '${contextPath}/images/calendar-blue.png',
					'buttonImageOnly': true,
					'buttonText' : '<fmt:message key="calendarButtonText"/>', 
					'onSelect' : function(){
						datumHandler();
					}
				});
			}
			
			$('#zoekDatum').on('input', function() {
				datumHandler();
			});
			
				function datumHandler(){
					if(moment($('#zoekDatum').val(), 'YYYY-MM-DD', true).isValid()){
						var aantalRecords = 0;
						$('#voorstellingenGesorteerdOpDatum tbody').html('');
						aantalRecords = $.getJSON('rest/' + $('#zoekDatum').val(), function(data) {
							if(data.length != 0){
							$.each(data, function(i){
								//TODO: toon kolom met genre & pas dan ook aTargets aan!
								$('#voorstellingenGesorteerdOpDatum tbody').append("<tr>"
										+ "<td class='padded_right'>"
										+ moment(data[i].datum).format('YYYY-M-D h:mm')
										+ "</td>"
										+ "<td class='padded_right'>"
										+ data[i].titel
										+ "</td>"
										+ "<td class='padded_right'>"
										+ data[i].uitvoerders
										+ "</td>"
										+ "<td class='padded_right'>&euro; "
										+ data[i].prijs
										+ "</td>"
										+ "<td class='align_right padded_right'>"
										+ data[i].vrijePlaatsen
										+ "</td>"
										+ "<td>"
										+ "<a href='${contextPath}/reserveren/"+ data[i].voorstellingsNr + "'>Reserveren</a>"
										+ "</td>"
										+ "</tr>");
							return data.length;
							});
							$('#voorstellingenGesorteerdOpDatum>#geenVoorstellingen').hide();
							$('#voorstellingenGesorteerdOpDatum table').dataTable({
								'bPaginate' : false,
								'bProcessing' : true,
								'bInfo' : false,
								'aoColumnDefs' : [
								                  { 'bSortable' : false, 'aTargets' : [0] },
								                  { 'bSortable' : false, 'aTargets' : [5] },
								                  { 'bSearchable' : false, 'aTargets' : [0]},
								                  { 'bSearchable' : false, 'aTargets' : [5]}
								                 ],
								'oLanguage' : {
									'sSearch' : 'Filter: ',
									'sZeroRecords' : '<fmt:message key="dataTableZeroRecords"/>',
									},
							});
							$('#voorstellingenGesorteerdOpDatum table').show();
							$('#voorstellingen').css({
								'height' : $('#voorstellingen').height() + aantalRecords * 10
							});
							}else{
								$('#voorstellingenGesorteerdOpDatum table').hide();
								$('#voorstellingenGesorteerdOpDatum>#geenVoorstellingen').show();
								$('#voorstellingenGesorteerdOpDatum>#geenVoorstellingen').html('<p>Er zijn helaas geen voorstellingen op deze datum.</p>');
							}
							$('#voorstellingenGesorteerdOpDatum').css({
								'display' : 'block'
							});
							$('#voorstellingenGesorteerdOpDatum').slideDown(750);
						});
					}
				}
		});
	</script>

	<!-- Bootstrap core JavaScript
    ================================================== -->
	<!-- Placed at the end of the document so the pages load faster -->
</body>
</html>