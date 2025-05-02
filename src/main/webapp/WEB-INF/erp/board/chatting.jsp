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

#chatArea {
	width: 80%;
	height: 500px;
	overflow-y: scroll;
	text-align: left;
	border: 1px solid green;
	padding-right: 15px;
}
</style>
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

					<h1 class="h3 mb-2 text-gray-800">커뮤니케이션</h1>

					<br>
					<!-- DataTales Example -->
					<div class="card shadow mb-4">
						<div class="card-header py-3">
							<h6 class="m-0 font-weight-bold text-primary">실시간 채팅</h6>
						</div>

						<div class="card-body">

							<div class="input-group mb-3">
								<div class="input-group-prepend ">
									<span class="input-group-text  justify-content-center">입장할이름</span>
								</div>
								<input id="id" class="form-control" placeholder="접속할 아이디 입력" />
								<input type="button" class="btn btn-primary" value="채팅방입장"
									id="enterBtn" /> <input type="button" class="btn btn-danger"
									value="채팅방나가기" id="exitBtn" />
							</div>
							<div class="input-group mb-3">
								<div class="input-group-prepend ">
									<span class="input-group-text  justify-content-center">메시지</span>
								</div>
								<div id="chatArea" style="overflow-x: hidden"
									class="input-group-append">
									<div id="chatMessageArea"></div>
								</div>
							</div>
							<div class="input-group mb-3">
								<div class="input-group-prepend ">
									<span class="input-group-text  justify-content-center">메시지</span>
								</div>
								<input id="msg" class="form-control" placeholder="전송할 메시지 입력" />
								<input type="button" class="btn btn-success" value="메시지전송"
									id="sendBtn" /> <input type="button" class="btn btn-warning"
									value="메시지 삭제" id="delBtn" />
							</div>
						</div>
					</div>

					<!-- 내용물 -->




				</div>
			</div>
			<footer class="sticky-footer bg-white">
				<div class="container my-auto">
					<div class="copyright text-center my-auto">
						<span>Copyright &copy; Your Website 2021</span>
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
	<script type="text/javascript">
		var socketServer = "${socketServer}"
		//alert(socketServer+":접속")
		var wsocket = null
		$(document).ready(function() {

			$("#enterBtn").click(function() {
				//alert(wsocket)

				wsocket = new WebSocket(socketServer)
				wsocket.onopen = function(evt) {
					console.log(evt)
					//alert($("#id").val()+"님:입장합니다.");
					wsocket.send($("#id").val() + "님:입장합니다.");
				}
				wsocket.onmessage = function(evt) {
					//alert(evt.data)
					$("#chatMessageArea").append(evt.data + "<br>")
				}
			})
			$("#exitBtn").click(function() {
				alert($("#id").val() + "님:접속 종료합니다.")
				wsocket.send($("#id").val() + "님:접속 종료합니다.");
				wsocket.close();
				$("#chatMessageArea").text("")
				$("#id").val("").focus()
			})
			$("#sendBtn").click(function() {
				sendMsg()
			})
			$("#msg").keyup(function() {
				if (event.keyCode == 13) {
					sendMsg()
				}
			})
		});
		function sendMsg() {
			wsocket.send($("#id").val() + ":" + $("#msg").val());
			$("#msg").val("")
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
