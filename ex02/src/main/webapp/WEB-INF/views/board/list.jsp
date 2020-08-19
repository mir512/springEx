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
	
	// p 311 페이지 번호 클릭하면 처리하는 부분
	var actionForm = $("#actionForm");
	$(".paginate_button a").on("click", function(e){
		e.preventDefault();
		console.log('click');
		actionForm.find("input[name='pageNum']").val($(this).attr("href"));
		actionForm.submit();
	});
	
	// p 315 게시물 조회를 위한 이벤트 처리 추가
	$(".move").on("click", function(e){
		e.preventDefault();
		actionForm.append("<input type='hidden' name='bno' value='" + $(this).attr("href")+"'>");
		actionForm.attr("action", "/board/get");
		actionForm.submit();
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
					<td><a class='move' href='<c:out value="${board.bno}" />'><c:out value="${board.title}" /></a></td>
					<td><c:out value="${board.writer}" /></td>
					<td><fmt:formatDate pattern="yyyy-MM-dd"
							value="${board.regdate}" /></td>
					<td><fmt:formatDate pattern="yyyy-MM-dd"
							value="${board.updateDate}" /></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<div>
	  <ul>
	    <c:if test="${pageMaker.prev}">
	      <li class="paginate_button"><a href="${pageMaker.startPage-1}">Previous</a></li>
	    </c:if>
	    <c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
	      <li class="paginate_button" style="${pageMaker.cri.pageNum == num? 'color:lightblue':''}"><a href="${num}">${num}</a></li>
	    </c:forEach>
	    <c:if test="${pageMaker.next}">
	      <li class="paginate_button"><a href="${pageMaker.endPage+1}">Next</a></li>
	    </c:if>
	  </ul>
	</div>
	<form id="actionForm" action="/board/list" method="get">
	  <input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
	  <input type="hidden" name="amount" value="${pageMaker.cri.amount}">
	</form>
</body>
</html>