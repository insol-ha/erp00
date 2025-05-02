<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<fmt:requestEncoding value="utf-8" />
<!DOCTYPE html>
<html lang="en">
<script src="a00_com/vendor/jquery/jquery.min.js"></script>
<script src="http://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>SB Admin 2</title>

<!-- Custom fonts for this template-->
<link href="a00_com/vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">

<!-- Custom styles for this template-->
<link href="a00_com/css/sb-admin-2.min.css" rel="stylesheet">


<script src="a00_com/vendor/bootstrap/js/bootstrap.bundle.min.js" defer></script>
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

<!-- Custom styles for this page -->
<link href="a00_com/vendor/datatables/dataTables.bootstrap4.min.css"
	rel="stylesheet">
<style>
#wrapper {
	width: 100%;
	overflow-x: hidden;
}
</style>
<script src="https://unpkg.com/vue" type="text/javascript"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>



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

				<!-- Begin Page Content -->
				<div class="container-fluid">

					<!-- Page Heading -->
					<h1 class="h3 mb-2 text-gray-800">지점별 판매 실적</h1>
					<h6>*프로모션: 커피,라떼 / 딸기 초코 케이크 합산 금액*</h6>
					<br>
					<!-- chart -->
					<div class="card shadow mb-4">
						<div class="card-header py-3">
							<h6 class="m-0 font-weight-bold text-primary">STORE CHART</h6>
							<div>
								<canvas id="myChart" style="width: 100%; height: 600px;"></canvas>
							</div>
							<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

							<script>
						    // 차트 요소 가져오기
						    const ctx = document.getElementById('myChart');
						
						    // Ajax 요청을 통해 데이터를 가져오기
						    fetch('/ajaxPerformList')
						        .then(response => response.json())  // JSON 데이터 변환
						        .then(data => {
						            // 데이터를 지점별로 그룹화하여 합산
						            const storeSales = {};
						
						            data.forEach(item => {
						                const dname = item.dname;  // 
						                const tot = item.tot;  // 판매금액
						
						                if (!storeSales[dname]) {
						                    storeSales[dname] = 0;
						                }
						                storeSales[dname] += tot;
						            });
						
						            // 차트에 반영할 데이터 정리
						            const labels = Object.keys(storeSales);  // 지점명 리스트
						            const salesData = labels.map(dname => storeSales[dname]); // 각 지점의 총 판매금액
						
						            // 차트 생성
						            new Chart(ctx, {
						                type: 'bar',
						                data: {
						                    labels: labels,
						                    datasets: [{
						                        label: '# 프로모션 판매 실적 #',
						                        data: salesData,
						                        backgroundColor: 'rgba(54, 162, 235, 0.5)',
						                        borderColor: 'rgba(54, 162, 235, 1)',
						                        borderWidth: 1
						                    }]
						                },
						                options: {
						                    responsive: true,
						                    scales: {
						                        y: {
						                            beginAtZero: true,
						                            title: { 
						                                display: true, 
						                                text: '판매금액' 
						                            },
						                            ticks:{
						                            	 callback: function(value) {
						                                     return value ;
														}
						                            }
						                        }
						                    }
						                }
						            });
						        })
						        .catch(error => console.error('데이터 로딩 실패:', error));
						</script>

						</div>
					</div>
					<!-- DataTales Example -->
					<div class="card shadow mb-4">
						<script>
						$(document).ready(function(){						
			        		//const URL = "/ajaxPerformList"
			        		search();
			        	});
						function search(){
							$.ajax({
								url:"/ajaxPerformList",
								type:"get",
								data:"store=",
								dataType:"json",
								success:function(data){
									console.log(data)
									var addHTML = ''
									$(data).each(function(idx, st){
										//console.log(idx)
										//console.log(st)
										addHTML += `<tr><td>\${st.dname}</td>
														<td>\${st.tot.toLocaleString()}</td>
														<td>\${st.month}</td></tr>`
										

									})
									$("#storeList").html(addHTML)
									
								},
								error:function(err){
									console.log(err)
								}
							})
						
						
						}
						
						
						
						
						</script>
						
						<div class="card-header py-3">
							<h6 class="m-0 font-weight-bold text-primary">판매실적</h6>
						</div>

						<div class="card-body">
							<div class="table-responsive">
								<table class="table table-bordered" id="dataTable" width="100%"
									cellspacing="0" >
									<thead>
										<tr align="center">
											<th>지점명</th>
											<th>판매금액</th>
											<th>판매일자</th>
										</tr>
									</thead>
									<tfoot>
										<tr align="center">
											<th>지점명</th>
											<th>판매금액</th>
											<th>판매일자</th>

										</tr>
									</tfoot>
									<tbody id="storeList" align="center">

									</tbody>
								</table>

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
	<div class="modal fade" id="logoutModal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">Ready to Leave?</h5>
					<button class="close" type="button" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">×</span>
					</button>
				</div>
				<div class="modal-body">Select "Logout" below if you are ready
					to end your current session.</div>
				<div class="modal-footer">
					<button class="btn btn-secondary" type="button"
						data-dismiss="modal">Cancel</button>
					<a class="btn btn-primary" href="login.html">Logout</a>
				</div>
			</div>
		</div>
	</div>

	<!-- Bootstrap core JavaScript-->



</body>


</html>