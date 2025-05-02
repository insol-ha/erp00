<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<fmt:requestEncoding value="utf-8" />
<!DOCTYPE html>
<html lang="en">

<head>
<style type="text/css">
.input-group-text {
	width: 100%;
	background-color: linen;
	color: black;
	font-weight: bolder;
}

.input-group-prepend {
	width: 20%;
}

#comment{
	rows:3 !important;
}
</style>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>SB Admin 2 - Dashboard</title>

<!-- Custom fonts for this template-->
<link href="a00_com/vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">

<!-- Custom styles for this template-->
<link href="a00_com/css/sb-admin-2.min.css" rel="stylesheet">

<script src="a00_com/vendor/jquery/jquery.min.js"></script>
</head>

<body id="page-top">
	<div id="wrapper">

		<!-- Sidebar -->
		<ul
			class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion"
			id="accordionSidebar">

			<c:import url="/WEB-INF/views/sidebar.jsp" />

		</ul>
		<!-- End of Sidebar -->

		<!-- Content Wrapper -->
		<div id="content-wrapper" class="d-flex flex-column">

			<!-- Main Content -->
			<div id="content">

				<!-- Topbar -->
				<nav
					class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">

					<!-- Sidebar Toggle (Topbar) -->
					<c:import url="/WEB-INF/views/header.jsp" />
					<!-- Topbar Search -->

				</nav>
				<!-- End of Topbar -->

				<!-- Begin Page Content -->
				<div class="container-fluid" id="vueCon">

					<div class="jumbotron text-center">
						<h2>공지 상세</h2>
					</div>
					<div class="container">
						<form method="post" enctype="multipart/form-data" id="board">

							<div class="input-group mb-3">
								<div class="input-group-prepend ">
									<span class="input-group-text  justify-content-center">번호</span>
								</div>
								<input name="no" class="form-control" value="${board.no}"
									readonly />
								<div class="input-group-prepend ">
									<span class="input-group-text  justify-content-center">상위번호</span>
								</div>
								<input name="refno" class="form-control" value="${board.refno}"
									readonly />
							</div>
							<div class="input-group mb-3">
								<div class="input-group-prepend ">
									<span class="input-group-text  justify-content-center">제목</span>
								</div>
								<input name="subject" class="form-control"
									value="${board.subject}" />
							</div>
							<div class="input-group mb-3">
								<div class="input-group-prepend ">
									<span class="input-group-text  justify-content-center">작성자</span>
								</div>
								<input name="writer" class="form-control"
									value="${board.writer}" />
								<div class="input-group-prepend ">
									<span class="input-group-text  justify-content-center">조회수</span>
								</div>
								<input class="form-control" value="${board.readcnt}" />
							</div>
							<div class="input-group mb-3">
								<div class="input-group-prepend ">
									<span class="input-group-text  justify-content-center">등록일</span>
								</div>
								<input class="form-control" name="regdteS"
									value="<fmt:formatDate value='${board.regdte}'/>" />
								<div class="input-group-prepend ">
									<span class="input-group-text  justify-content-center">수정일</span>
								</div>
								<input class="form-control"
									value="<fmt:formatDate value='${board.uptdte}'/>" />
							</div>
							<div class="input-group mb-3">
								<div class="input-group-prepend ">
									<span class="input-group-text  justify-content-center">내용</span>
								</div>
								<textarea name="content" class="form-control" rows="10" 
									cols="20" style="resize: none;">${board.content}</textarea>
							</div>
							<div class="input-group mb-3">
								<div class="input-group-prepend ">
									<span class="input-group-text  justify-content-center">첨부파일</span>
								</div>
								<c:forEach var="fname" items="${board.flist}">
									<span ondblclick="download('${fname}')">${fname}</span>,&nbsp;&nbsp;&nbsp;
								</c:forEach>
							</div>

							<div style="text-align: right;">
								<input type="button" class="btn btn-warning" value="답글"
									id="repBtn" /> <input type="button" class="btn btn-primary"
									value="수정" id="uptBtn" /> <input type="button"
									class="btn btn-danger" value="삭제" id="delBtn" /> <input
									type="button" class="btn btn-info"
									onclick="location.href='boardList'" value="조회리스트" id="mainBtn" />
							</div>
							<br> <br> <br> ## ${board.relist.size()} 개
							<div>
								<div class="container">
									<table class="table table-hover table-striped">
										<col width="25%">
										<col width="50%">
										<col width="25%">
										<thead>
											<tr class="table-success text-center">
												<th>번호</th>
												<th>내용</th>
												<th>등록일</th>
											</tr>
										</thead>
										<tbody>
											<c:forEach var="content" items="${board.relist}">
												<tr class=" text-center">
													<td>${content.no}</td>
													<td>${content.content}</td>
													<td><fmt:formatDate value="${content.regdte}" /></td>
												</tr>
											</c:forEach>
										</tbody>
									</table>
									<!-- 댓글 작성 폼 -->
								</div>
							</div>
						</form>
						<form method="post" id="frm02">
							<div class="input-group mb-3">
								<input type="hidden" name="no" id="no" value="0"/>
								<div class="input-group-prepend">
									<span class="input-group-text">댓글 작성</span>
								</div>
								<input id="comment" type="text" rows="3" name="contentComment" class="form-control"/>
							</div>
							<div class="text-right">
								<input type="submit" class="btn btn-primary" value="댓글 달기"
									id="commentBtn" />
							</div>
							
						</form>
					</div>
				</div>
			</div>
		</div>

		<script type="text/javascript">
			$(document).ready(function() {
				// 댓글 버튼 클릭 시 처리
				var no = "${param.no}"
				$("#no").val(no);
				console.log(no);
				$("#commentBtn").click(function(event) {
					event.preventDefault(); // 폼 제출 방지 (페이지 리로드 방지)

					if (confirm("댓글을 추가 하시겠습니까?")) {
						// 폼 데이터 직렬화 (폼 데이터를 key-value 쌍으로 변환)
						var formData = $("#frm02").serialize();
						
						// AJAX로 데이터 전송
						$.ajax({
							url : "/insContent", // 댓글을 서버로 전송할 URL
							type : "POST", // 요청 방식
							data : $("#frm02").serialize(), // 전송할 데이터
							dataType : "text", // 서버의 응답 형식 (여기서는 텍스트 응답)
							success : function(data) {
								// 댓글 등록 성공 시 처리
								console.log(data);
								alert(data);
								// 댓글 목록을 갱신하거나 페이지를 새로 고침 할 수도 있습니다.
								location.reload(); // 예시로 페이지를 새로 고침			
							},
							error : function(err) {
								// 오류 발생 시 처리
								console.log("댓글 등록 오류:", err);
								alert("댓글 등록에 실패했습니다.");
								console.log(formData);
							}
						});
					}
				});
			});
		</script>

		<!-- 					<footer class="sticky-footer bg-white">
						<div class="container my-auto">
							<div class="copyright text-center my-auto">
								<span>Copyright &copy; Your Website 2021</span>
							</div>
						</div>
					</footer> -->
		<!-- End of Footer -->

	</div>

	<!-- End of Content Wrapper -->

	</div>
	<!-- End of Page Wrapper -->
	<!-- Scroll to Top Button-->
	<a class="scroll-to-top rounded" href="#page-top"> <i
		class="fas fa-angle-up"></i>
	</a>


	<!-- Bootstrap core JavaScript-->
	<script type="text/javascript">
		$(document).ready(function() {

			$("#mainBtn").click(function() {
				location.href = "boardList"
			})
			var msg = "${msg}"
			if (msg != "") {
				alert(msg)
				// indexOf("검색문자") : 해당 문자열의 포함된 위치를 index번호로 리턴한다.
				// 삭제라는 글자가 있으면 검색으로 바로 이동하게 처리한다.
				if (msg.indexOf("삭제") >= 0) {
					location.href = "boardList"
				}
				if (msg.indexOf("수정") >= 0) {
					location.href = "boardList"
				}
			}

			$("#uptBtn").click(function() {
				if (confirm("수정하시겠습니까?")) {
					$("#board").attr("action", "boardUpdate")
					$("#board").submit();
					//location.href="boardDetail?no="+no
				}
			})
			$("#delBtn").click(function() {
				if (confirm("삭제하시겠습니까?")) {
					$("#board").attr("action", "boardDelete")
					$("#board").submit();
				}
			})
			$("#repBtn").click(function() {
				if (confirm("답글을 처리하시겠습니까?")) {
					$("#board").attr("action", "boardReply")
					$("#board").submit();
				}
			})

		});
		function download(fname) {
			if (confirm(fname + " 파일을 다운로드 하시겠습니까?"))
				location.href = "/download?filename=" + fname
		}
	</script>
	<!-- Bootstrap core JavaScript-->
	<script src="a00_com/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

	<!-- Core plugin JavaScript-->
	<script src="a00_com/vendor/jquery-easing/jquery.easing.min.js"></script>

	<!-- Custom scripts for all pages-->
	<script src="a00_com/js/sb-admin-2.min.js"></script>

	<!-- Page level plugins -->
	<script src="a00_com/vendor/datatables/jquery.dataTables.min.js"></script>
	<script src="a00_com/vendor/datatables/dataTables.bootstrap4.min.js"></script>

	<!-- Page level custom scripts -->
	<script src="a00_com/js/demo/datatables-demo.js"></script>
	<script src="https://unpkg.com/vue" type="text/javascript"></script>
	<script src="http://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
</body>
</html>
