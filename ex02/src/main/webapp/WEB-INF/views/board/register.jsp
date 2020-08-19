<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>
<h1>Register Page</h1>
<form action="/board/register" method="post">
  Title : <input type="text" name='title'><br><br>
  Content : <textarea rows="3" name='content'></textarea><br>
  Writer : <input type="text" name='writer'><br>
  <button type="submit">Submit Button</button>
  <button type="reset">Reset Button</button>
</form>
</body>
</html>