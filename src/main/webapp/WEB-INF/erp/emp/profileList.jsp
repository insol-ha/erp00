<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<fmt:requestEncoding value="utf-8" />
<!DOCTYPE html>
<html lang="en">

<head>
<style>
tbody tr:hover {
	background-color: lightgray;
}

.profile-img {
	display: flex;
	flex-wrap: wrap; /* 필요한 경우 자동 줄바꿈 */
	justify-content: start; /* 가로 정렬 */
	gap: 1rem;
}

.profile-img img {
	width: 120px !important;
	height: 150px !important;
	object-fit: cover !important;
}

.span {
	font-size: 30px;
}

.emp {
	border: 2px solid lightgray;
}

.emp:hover {
	border: 1px solid black;
	background-color: lightgray;
	filter: brightness(0.75);
}
</style>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>SB Admin 2 - 사원정보</title>

<!-- Custom fonts for this template -->
<link href="a00_com/vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">

<!-- Custom styles for this template -->
<link href="a00_com/css/sb-admin-2.min.css" rel="stylesheet">

<!-- Custom styles for this page -->
<link href="a00_com/vendor/datatables/dataTables.bootstrap4.min.css"
	rel="stylesheet">
<script src="a00_com/vendor/jquery/jquery.min.js"></script>
</head>

<body id="page-top">

	<!-- Page Wrapper -->
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

					<!-- Page Heading -->
					<h1 class="h3 mb-2 text-gray-800">부서별 사원 배치</h1>
					<!-- DataTales Example -->
					<div class="card shadow mb-4">
						<div class="card-header py-3">
							<h6 class="m-0 font-weight-bold text-primary">더블클릭으로 프로필 이동</h6>
						</div>
						<div class="card-body">
							<div v-for="dp in depart" :key="dp.deptno">
								<span class="span">{{ dp.deptno }}번 부서 {{ dp.dname }}<br></span>
								<div class="profile-img">
									<div v-for="emp in filteredEmpList(dp.deptno)" :key="emp.empno"
										@dblclick="goProfile(emp.empno)" class="emp">
										<img
											:src="'http://192.168.0.106:2222/upload/empno_' + emp.empno + '.png'"
											alt="" />
										<p>{{emp.ename}} {{emp.jname}}</p>
									</div>
									<div v-if="filteredEmpList(dp.deptno).length === 0">
										<p>사원정보 없음</p>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<!-- /.container-fluid -->

			</div>
			<!-- End of Main Content -->

			<!-- Footer -->
			<footer class="sticky-footer bg-white">
				<div class="container my-auto">
					<div class="copyright text-center my-auto">
						<span>Copyright &copy; Your Website 2020</span>
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

	<!-- Logout Modal-->
	<script type="text/javascript">
		$(document).ready(function() {
			var auth = "${sesEmp.auth}"
				if (auth < 5) {
					$("#regBtn").hide().attr("disabled", true)
				} else {
					$("#regBtn").show().attr("disabled", false)
				}
			var model = {
				    msg: "사원정보리스트(vue-axios)",
				    empList: [],
				    depart: [],
				    isLoading: false
				};

				var vm = Vue.createApp({
				    data() {
				        return model;
				    },
				    mounted() {
				        this.fetchEmpList();
				        this.fetchDepartList();
				    },
				    methods: {
				        fetchEmpList() {
				            axios.get("/ajaxErpEmpList")
				                .then((response) => {
				                    console.log("# 직원 데이터 #", response.data);
				                    this.empList = response.data;
				                })
				                .catch((err) => {
				                    console.log(err);
				                });
				        },
				        fetchDepartList() {
				            axios.get("/ajaxDepart")  // 새로운 엔드포인트 필요
				                .then((response) => {
				                    console.log("# 부서 데이터 #", response.data);
				                    this.depart = response.data;
				                })
				                .catch((err) => {
				                    console.log(err);
				                });
				        },
				        filteredEmpList(deptno) {
				            return this.empList.filter(emp => emp.deptno === deptno);
				        },
				        goProfile(empno){
							location.href="erpProfile?empno="+empno
				        }
				    }
				}).mount("#vueCon")
		});
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