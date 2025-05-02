<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<fmt:requestEncoding value="utf-8" />
<!DOCTYPE html>
<html lang="en">
<style type="text/css">
.bg-gradient-primary {
	background-color: #a85c00 !important;
	background-image: linear-gradient(0deg, #F0E68C, #7B3F00) !important;
	background-size: cover !important;
}
</style>
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

</head>

<body id="page-top">

	<!-- Page Wrapper -->
	<!-- Sidebar - Brand -->
	<a
		class="sidebar-brand d-flex align-items-center justify-content-center"
		href="/main">
		<div class="sidebar-brand-icon rotate-n-15">
			<img src="http://192.168.0.106:2222/upload/coffeehouse.png"
				style="max-width: 150%; height: auto;" alt="" />
		</div>
		<div class="sidebar-brand-text mx-3">CoffeeHouse</div>
	</a>

	<!-- Divider -->
	<hr class="sidebar-divider my-0">

	<!-- Nav Item - Dashboard -->
	<li class="nav-item"><a class="nav-link" href="/main"> <i
			class="fas fa-fw fa-tachometer-alt"></i> <span>Dashboard</span></a></li>

	<!-- Divider -->
	<hr class="sidebar-divider">

	<!-- Heading -->

	<!-- Divider -->

	<!-- Heading -->
	<div class="sidebar-heading">메뉴</div>

	<!-- Nav Item - Pages Collapse Menu -->


	<!-- Nav Item - Tables -->
	<li class="nav-item"><a class="nav-link collapsed" href="#"
		data-toggle="collapse" data-target="#empPages" aria-expanded="true"
		aria-controls="collapsePages"> <i class="fas fa-fw fa-folder"></i>
			<span>인사관리</span>
	</a>
		<div id="empPages" class="collapse" aria-labelledby="headingPages"
			data-parent="#accordionSidebar">
			<div class="bg-white py-2 collapse-inner rounded">
				<h6 class="collapse-header">사원정보:</h6>
				<a class="collapse-item" href="/erpEmpList">사원정보리스트</a> <a
					class="collapse-item" id="empHis" href="/empHistory">인사이동</a><a
					class="collapse-item auth3" href="/erpDepartList">부서정보리스트</a> <a
					class="collapse-item" href="/erpProfileList">직원배치도</a> <a
					class="collapse-item" href="/jobList">권한체계도</a> <a
					class="collapse-item" href="/calcul2">급여 계산기</a>
			</div>
		</div></li>

	<!-- 근태관리 -->
	<li class="nav-item"><a class="nav-link collapsed" href="#"
		data-toggle="collapse" data-target="#gewntaegwanli"
		aria-expanded="true" aria-controls="collapsePages"> <i
			class="fas fa-fw fa-folder"></i> <span>근태관리</span>
	</a>
		<div id="gewntaegwanli" class="collapse"
			aria-labelledby="headingPages" data-parent="#accordionSidebar">
			<div class="bg-white py-2 collapse-inner rounded">
				<div class="bg-white py-2 collapse-inner rounded">
					<h6 class="collapse-header">근태관리:</h6>
					<a class="collapse-item" href="/Cal5">출결 관리</a> <a
						class="collapse-item" href="/CalList">직원 출결 내역</a> <a
						class="collapse-item" href="/LeaveMngt" id="jobidauth">직원 연차
						사용 현황</a>


				</div>
			</div>
		</div></li>



	<!-- 판매관리 -->
	<li class="nav-item"><a class="nav-link collapsed" href="#"
		data-toggle="collapse" data-target="#jepumgwanli" aria-expanded="true"
		aria-controls="collapsePages"> <i class="fas fa-fw fa-folder"></i>
			<span>제품관리</span>
	</a>
		<div id="jepumgwanli" class="collapse" aria-labelledby="headingPages"
			data-parent="#accordionSidebar">
			<div class="bg-white py-2 collapse-inner rounded">
				<div class="bg-white py-2 collapse-inner rounded">
					<h6 class="collapse-header">재고관리:</h6>
					<a class="collapse-item" href="/getOrderList">구매관리</a> <a
						class="collapse-item" href="/getSellList">입출고관리</a> <a
						class="collapse-item" href="/inventoryList">재고리스트</a>
				</div>
			</div>
		</div></li>

	<!-- 판매관리 -->
	<li class="nav-item"><a class="nav-link collapsed" href="#"
		data-toggle="collapse" data-target="#panmaegwanli"
		aria-expanded="true" aria-controls="collapsePages"> <i
			class="fas fa-fw fa-folder"></i> <span>판매관리</span>
	</a>
		<div id="panmaegwanli" class="collapse" aria-labelledby="headingPages"
			data-parent="#accordionSidebar">
			<div class="bg-white py-2 collapse-inner rounded">
				<div class="bg-white py-2 collapse-inner rounded">
					<h6 class="collapse-header">실적관리:</h6>
					<a class="collapse-item" href="/getSalesList">판매 내역</a> <a
						class="collapse-item" href="/PerformList">지점별 실적</a> <a
						class="collapse-item" href="/EachPerfor">직원별 실적</a>
				</div>
			</div>
		</div></li>



	<!-- 커뮤니케이션(부가기능) -->
	<li class="nav-item"><a class="nav-link collapsed" href="#"
		data-toggle="collapse" data-target="#communicare" aria-expanded="true"
		aria-controls="collapsePages"> <i class="fas fa-fw fa-folder"></i>
			<span>커뮤니케이션</span>
	</a>
		<div id="communicare" class="collapse" aria-labelledby="headingPages"
			data-parent="#accordionSidebar">
			<div class="bg-white py-2 collapse-inner rounded">
				<div class="bg-white py-2 collapse-inner rounded">
					<h6 class="collapse-header">커뮤니케이션:</h6>
					<a class="collapse-item" href="/boardList">일정공지사항</a> <a
						class="collapse-item" href="/chatting">채팅</a> <a
						class="collapse-item" href="/sendMail">메일</a>
				</div>
			</div>
		</div></li>

	<!-- Divider -->
	<hr class="sidebar-divider d-none d-md-block">

	<!-- Sidebar Toggler (Sidebar) -->
	<div class="text-center d-none d-md-inline">
		<button class="rounded-circle border-0" id="sidebarToggle"></button>
	</div>

	<!-- Bootstrap core JavaScript-->

	<!-- Core plugin JavaScript-->

	<!-- Custom scripts for all pages-->

	<script type="text/javascript">
		var auth = "${sesEmp.auth}"
		if (auth < 4) {
			$("#empHis").hide();
		}

		var jobid = "${sesEmp.jobid}"
		if (jobid < 103) {
			$("#jobidauth").hide();
		}
	</script>
</body>
</html>
