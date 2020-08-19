<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
$(document).ready(function (){
	var result = '<c:out value="${result}"/>';
	if(!(result === '' || history.state)){
	alert("게시글 " + result + "번이 등록되었습니다."); 
	}
	
	history.replaceState({}, null, null);
	
	$("#regBtn").on("click", function(){
		self.location = "/board/register";
	});
});
</script>
</head>
<body>
<h1>List Page</h1>
<button id="regBtn">Register</button><br>
	<table width="100%"
		class="table table-striped table-bordered table-hover"
		id="dataTables-example"
		border="1">
		<thead>
			<tr>
				<th>#번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>작성일</th>
				<th>수정일</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${list}" var="board">
				<tr>
					<td><c:out value="${board.bno}" /></td>
					<td><a href="/board/get?bno=${board.bno}"><c:out value="${board.title}" /></a></td>
					<td><c:out value="${board.writer}" /></td>
					<td><fmt:formatDate pattern="yyyy-MM-dd"
							value="${board.regdate}" /></td>
					<td><fmt:formatDate pattern="yyyy-MM-dd"
							value="${board.updateDate}" /></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</body>
</html>