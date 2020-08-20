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
<h1>Get Page</h1>
  bno : <input type="text" name="bno" value="${board.bno}" readonly><br>
  Title : <input type="text" name='title' value='<c:out value="${board.title}" />' readonly><br><br>
  Content : <textarea rows="3" name='content' readonly><c:out value="${board.content}" /></textarea><br>
  Writer : <input type="text" name='writer' value='<c:out value="${board.writer}" />' readonly><br>
<%-- 
  <button type="button" onclick="location.href='/board/modify?bno=<c:out value="${board.bno}"/>'">Modify</button>
 --%>
  <button type="button" data-oper="modify">Modify</button>
  <button type="button" data-oper="list">List</button>
<form id="operForm" action="/board/modify" method="get">
  <input type="hidden" id="bno" name="bno" value='<c:out value="${board.bno}"/>'>
  <input type="hidden" name="pageNum" value='<c:out value="${cri.pageNum}"/>'>
  <input type="hidden" name="amount" value='<c:out value="${cri.amount}"/>'>
  <input type="hidden" name="type" value='<c:out value="${cri.type}" />'>
  <input type="hidden" name="keyword" value='<c:out value="${cri.keyword}" />'>
</form>
<script>
// p 265
$(document).ready(function(){
	var operForm = $("#operForm");
	$("button[data-oper='modify']").on("click", function(e){
		// modify 할 때는 submit 해서 hidden 태그인 bno를 매개변수로 전달해줌
		operForm.attr("action", "/board/modify").submit();
	});
	$("button[data-oper='list']").on("click", function(e){
		// list로 이동할 때는 아무런 파라미터도 필요 없으므로 remove
		operForm.find("#bno").remove();
		operForm.attr("action", "/board/list");
		operForm.submit();
	});
});
</script>
</body>
</html>