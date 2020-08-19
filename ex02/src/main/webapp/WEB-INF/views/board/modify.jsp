<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>
<h1>Modify Page</h1>
<form role="form" action="/board/modify" method="post">
<!-- p 319 페이징 처리 위해 추가 -->
<input type="hidden" name="pageNum" value='<c:out value="${cri.pageNum}"/>'>
<input type="hidden" name="amount" value='<c:out value="${cri.amount}"/>'>
  bno : <input type="text" name="bno" value="${board.bno}" readonly><br>
  Title : <input type="text" name='title' value='<c:out value="${board.title}" />' ><br><br>
  Content : <textarea rows="3" name='content' ><c:out value="${board.content}" /></textarea><br>
  Writer : <input type="text" name='writer' value='<c:out value="${board.writer}" />' readonly><br>
  regdate : <input type="text" name="regDate" value='<fmt:formatDate pattern="yyyy/MM/dd" value="${board.regdate}"/>' readonly><br>
  updatedate : <input type="text" name="updateDate" value='<fmt:formatDate pattern="yyyy/MM/dd" value="${board.updateDate}"/>' readonly><br>
  <button type="submit" data-oper="modify">Modify</button>
  <button type="submit" data-oper="remove">Remove</button>
  <button type="submit" data-oper="list">List</button>
</form>
<script>
// p 266
$(document).ready(function(){
	var formObj = $("form");
	
	$('button').on("click", function(e){
		e.preventDefault();
		var operation = $(this).data("oper");
		console.log(operation);
		if(operation === 'remove'){
			formObj.attr("action", "/board/remove");
		}else if(operation === 'list'){
			//move to list
			//self.location = "/board/list";
			formObj.attr("action", "/board/list").attr("method", "get");
			// p 321 페이징 처리 위해 추가. 수정/삭제를 취소하고 다시 목록으로 이동하기
			var pageNumTag = $("input[name='pageNum']").clone();
			var amountTag = $("input[name='amountTag']").clone();
			
			formObj.empty();
			// 필요한 거만 따로 저장해놓고 empty 한 후에 저장해둔 것 다시 추가.
			formObj.append(pageNumTag);
			formObj.append(amountTag);
		}
		formObj.submit();
	});
});
</script>
</body>
</html>