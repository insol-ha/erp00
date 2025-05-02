<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<fmt:requestEncoding value="utf-8" />
<!DOCTYPE html>
<html lang="en">

<head>

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
		<div id="content-wrapper" class="d-flex flex-column">
			<div id="content">
				<nav
					class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">
					<c:import url="/WEB-INF/views/header.jsp" />
				</nav>
				<div class="content-fluid" id="vueCon">

					<h1 class="h3 mb-2 text-gray-800">게시판</h1>
					<form id="frm01" class="form" method="post">
						<input type="hidden" name="curPage" value="${sch.curPage}" /> <input
							type="hidden" name="pageSize" value="${sch.pageSize}" />
						<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
							<input placeholder="제목" name="subject" value="${param.subject}"
								class="form-control mr-sm-2" /> <input placeholder="작성자"
								name="writer" value="${param.writer}"
								class="form-control mr-sm-2" />
							<button class="btn btn-info" type="button" id="schBtn">Search</button>
							<button class="btn btn-success" id="regBtn" type="button">등록</button>
						</nav>
					</form>
					<br>
					<!-- DataTales Example -->
					<div class="card shadow mb-4">

						<div class="card-header py-3">
							<h6 class="m-0 font-weight-bold text-primary">게시판 리스트</h6>
						</div>
						<div class="container-fluid">
							<div class="row">
								<div class="col-sm-1" style="padding-left: 0;">

									<select class="form-control" id="pageSize"
										onchange="uptPageSize()" style="padding-right: 0;">
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
						<div class="card-body">

							<div class="table-responsive">
								<table class="table table-bordered" id="dataTable" width="100%"
									cellspacing="0">
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
												<c:forEach var="pcnt" begin="${sch.startBlock} "
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
									});
									function goDetail(no) {
										location.href = "boardDetail?no=" + no
									}
									function goPage(pcnt) {
										$("[name=curPage]").val(pcnt) // 클릭한 번호를 현재 페이지로 설정하고..
										$("form").submit() // 요청값으로 전송 처리..
									}
									function uptPageSize() {
										$("[name=pageSize]").val(
												$("#pageSize").val())
										$("[name=curPage]").val(1)
										$("form").submit();
									}
								</script>

								<canvas id="myChart" width="400" height="200"></canvas>
								<canvas id="myChart" width="800" height="10"></canvas>




							</div>
						</div>
					</div>

					<!-- 내용물 -->




				</div>
			</div>
			<footer class="sticky-footer bg-white">
				<div class="container my-auto">
					<div class="copyright text-center my-auto">
						<span>Copyright &copy; Your Website 2025</span>
					</div>
				</div>
			</footer>
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
