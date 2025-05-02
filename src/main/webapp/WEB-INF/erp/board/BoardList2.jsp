<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<%--


 --%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${path}/a00_com/bootstrap.min.css">
<link rel="stylesheet" href="${path}/a00_com/jquery-ui.css">
<style>
td {
	text-align: center;
}
</style>
<script src="${path}/a00_com/jquery.min.js"></script>
<script src="${path}/a00_com/popper.min.js"></script>
<script src="${path}/a00_com/bootstrap.min.js"></script>
<script src="${path}/a00_com/jquery-ui.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script
	src="https://developers.google.com/web/ilt/pwa/working-with-the-fetch-api"
	type="text/javascript"></script>


<script type="text/javascript">
	$(document).ready(function() {
		$("#regBtn").click(function() {
			location.href = "boardInsert"
		})
		$("#pageSize").val("${sch.pageSize}")
		$("#schBtn").click(function() {
			$("[name=curPage]").val(1)
			$("form").submit();
		})
		$("[name=subject] , [name=writer]").keyup(function(){
			if(event.keyCode===13){
				$("#schBtn").click();
			}
		})

	});
	function goDetail(no) {
		location.href = "boardDetail?no=" + no
	}
	function goPage(pcnt) {
		$("[name=curPage]").val(pcnt) // 클릭한 번호를 현재 페이지로 설정하고..
		$("form").submit() // 요청값으로 전송 처리..
	}
	function uptPageSize() {
		$("[name=pageSize]").val($("#pageSize").val())
		$("[name=curPage]").val(1)
		$("form").submit();
	}
	if (msg.indexOf("수정") >= 0) {
		location.href = "boardList"
	}
</script>
</head>

<body>
	<div class="jumbotron text-center">
		<h2>게시판 리스트</h2>
	</div>
	<div class="container">

		<form id="frm01" class="form" method="post">
			<input type="hidden" name="curPage" value="${sch.curPage}" /> <input
				type="hidden" name="pageSize" value="${sch.pageSize}" />
			<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
				<input placeholder="제목" name="subject" value="${param.subject}"
					class="form-control mr-sm-2" /> <input placeholder="작성자"
					name="writer" value="${param.writer}" class="form-control mr-sm-2" />
				<button class="btn btn-info" type="button" id="schBtn">Search</button>
				<button class="btn btn-success" id="regBtn" type="button">등록</button>
			</nav>
		</form>
		<div class="container-fluid">
			<div class="row">
				<div class="col-sm-1" style="padding-left: 0;">

					<select class="form-control" id="pageSize" onchange="uptPageSize()"
						style="padding-right: 0;">
						<option value="3">[ 3 ]</option>
						<option value="5">[ 5 ]</option>
						<option value="10">[ 10 ]</option>
						<option value="15">[ 15 ]</option>
						<option value="20">[ 20 ]</option>
					</select>
				</div>
				<div class="col-sm-11"></div>
			</div>
		</div>
		<table class="table table-hover table-striped">
			<col width="10%">
			<col width="50%">
			<col width="15%">
			<col width="15%">
			<col width="10%">
			<thead>

				<tr class="table-success text-center">
					<th>번호</th>
					<th>상위번호</th>
					<th>제목</th>
					<th>작성자</th>
					<th>내용</th>
					<th>조회수</th>
					<th>등록일</th>
					<th>수정일</th>
				</tr>
			</thead>
			<tbody>
				<!-- no refno subject writer content readcnt regdte uptdte -->
				<c:forEach var="board" items="${boardList}">
					<tr ondblclick="goDetail(${board.no})">
						<td>${board.no}</td>
						<td>${board.refno}</td>
						<td>${board.subject}</td>
						<td>${board.writer}</td>
						<td>${board.content}</td>
						<td>${board.readcnt}</td>
						<td><fmt:formatDate value="${board.regdte}" /></td>
						<td><fmt:formatDate value="${board.uptdte}" /></td>
					</tr>
				</c:forEach>

			</tbody>
		</table>

		<div class="container-fluid">
			<div class="row">
				<div class="col-sm-3" style="padding-left: 0;">
					<button type="button" class="btn btn-primary">
						총 <span class="badge badge-light">${sch.count}</span> 건
					</button>
				</div>
				<div class="col-sm-9">
					<ul class="pagination justify-content-end">
						<li class="page-item"><a class="page-link"
							href="javascript:goPage(${sch.startBlock-1})">Previous</a></li>
						<c:forEach var="pcnt" begin="${sch.startBlock}"
							end="${sch.endBlock}">
							<li class="page-item ${sch.curPage==pcnt?'active':''}"><a
								class="page-link" href="javascript:goPage(${pcnt})">${pcnt}</a></li>
						</c:forEach>
						<!-- 
		  	클릭한 현재페이지 번호와 페이지번호가 같을 때, 배경색상이 있게(active) 처리함..
		   -->
						<li class="page-item"><a class="page-link"
							href="javascript:goPage(${sch.endBlock+1})">Next</a></li>
					</ul>
				</div>
			</div>
		</div>
	</div>
	<div>

		<h3>댓글 목록:</h3>
		<table class="table table-hover table-striped">
			<col width="10%">
			<col width="10%">
			<col width="15%">
			<col width="10%">
			<col width="10%">
			<thead>

				<tr class="table-success text-center">
					<th>댓글번호</th>
					<th>작성자</th>
					<th>내용</th>
					<th>원글번호</th>
					<th>등록일</th>
				</tr>
			</thead>
			<tbody>
				<!--  num writer content no trgdate -->
				<c:forEach var="content" items="${contentList}">
					<tr>
						<td>${content.num}</td>
						<td>${content.writer}</td>
						<td>${content.content}</td>
						<td>${content.no}</td>
						<td><fmt:formatDate value="${content.trgdate}" /></td>
					</tr>
				</c:forEach>


			</tbody>
		</table>
		<div>
			<textarea id="commentInput" rows="5" cols="110"
				placeholder="댓글을 입력하세요..."></textarea>
			<button onclick="addComment()">댓글 추가</button>
		</div>
	</div>

</body>
</html>