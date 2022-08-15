<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><tiles:getAsString name="title" /></title>
<style>
@import url('https://fonts.googleapis.com/css2?family=Do+Hyeon&family=Dongle:wght@700&family=Hammersmith+One&family=Koulen&family=Nanum+Gothic+Coding&family=Open+Sans:wght@300&family=Paytone+One&display=swap');
.container { width: 1200px; margin: 0 auto;}
a { text-decoration: none; color: black;}
</style>

</head>
<body>
<div class="container">
	<tiles:insertAttribute name="header"/>
	<tiles:insertAttribute name="body"/>
	<tiles:insertAttribute name="footer"/>
</div>
</body>
</html>