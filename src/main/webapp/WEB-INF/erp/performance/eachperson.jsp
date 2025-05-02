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

nav {
	display: flex;
	align-items: center; /* 세로 중앙 정렬 */
	gap: 10px; /* 아이콘과 텍스트 간격 */
}

h7 {
	font-size: 16px; /* 글씨 크기 */
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
				<!-- End of Topbar -->

				<!-- Begin Page Content -->
				<div class="container-fluid">

					<!-- Page Heading -->
					<h1 id="h1" class="h3 mb-2 text-gray-800">명동점 직원 실적</h1>
					<h6>*프로모션: 커피,라떼 / 딸기 초코 케이크 합산 금액*</h6>
					<nav>
						<svg width="50" height="50">
		               	 <circle cx="25" cy="25" r="20" fill="#FFA7A7" />
		          	  	</svg>
						<h7>판매 목표</h7>
					</nav>

					<nav>
						<svg width="50" height="45">   
	                	<rect x="5" y="5" width="40" height="40"
								fill="skyblue" />
	            		</svg>
						<h7>실제 판매량</h7>
					</nav>
					<br>
					<h7></h7>
					<br>

					<!-- chart -->
					<div class="card shadow mb-4">
						<div class="card-header py-3">
							<h6 class="m-0 font-weight-bold text-primary">SALES CHART</h6>
							<div>
								<canvas id="myChart" style="width: 100%; height: 500px;"></canvas>
							</div>
							<script>
							var deptno = "${sesEmp.deptno}"
							var dname = "${sesEmp.dname}"
							$("#h1").text(dname+" 직원 실적");
							console.log(deptno)
						    // 차트 요소 가져오기
						    const ctx = document.getElementById('myChart');
						
						    // Ajax 요청을 통해 데이터를 가져오기
						    fetch('/ajaxEachPerfor?deptno='+deptno)
						    .then(response => response.json())  
						    .then(data => {
						        // 데이터를 지점별로 그룹화하여 판매량(sellcnt)과 목표(target) 저장
						        const eachSales = {};  
						        const eachTarget = {}; 
						
						        data.forEach(item => {
						            const name = item.name;
						            const sellcnt = item.sellcnt;
						            const target = item.target; 
						
						           // if (!eachSales[name]) {
						                //eachSales[name] = 0;
						                eachSales[name] = sellcnt;
						           // }
						            //if (!eachTarget[name]) {
						                eachTarget[name] = target;  // 목표는 한 번만 저장
						           // }
						
						            //eachSales[name] += sellcnt;
						        });
						
						        // 차트에 반영할 데이터 정리
						        const labels = Object.keys(eachSales);  // 직원명 리스트
						        const salesData = labels.map(name => eachSales[name]); 
						        const targetData = labels.map(name => eachTarget[name]); 
						
						        // 차트 생성
						        new Chart(ctx, {
						            data: {
						                labels: labels,
						                datasets: [
						                    {
						                        label: '# 프로모션 판매갯수',
						                        type: 'bar',
						                        data: salesData,
						                        backgroundColor: 'rgba(54, 162, 235, 0.5)',
						                        borderColor: 'rgba(54, 162, 235, 1)',
						                        borderWidth: 1
						                    },
						                    {
						                        label: '# 목표갯수',
						                        type: 'line',
						                        data: targetData,
						                        borderColor: 'rgba(255, 99, 132, 1)',  
						                        backgroundColor: 'rgba(255, 99, 132, 0.5)', 
						                        borderWidth: 2,
						                        fill: false
						                    }
						                ]
						            },
						            options: {
						                responsive: true,
						                scales: {
						                    y: {
						                        beginAtZero: true,
						                        title: { 
						                            display: true, 
						                            text: '판매 수량 (개 단위)' 
						                        },
						                        ticks: {
						                            callback: function(value) {
						                                return value;
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
							ajaxList()
			        		
							$("#schBtn").click(function(){
			        			search()			        			
			        		})			        		
			        	});
						function ajaxList(){
							var deptno = "${sesEmp.deptno}"
							$.ajax({
								url:"/ajaxEachPerfor?deptno="+deptno,
								type:"get",
								dataType:"json",
								success:function(data){
									//console.log(data)
									var addHTML = ''
									$(data).each(function(idx, st){
										//console.log(idx)
										//console.log(st) 
										addHTML += `<tr><td>\${st.deptno}</td>
														<td>\${st.name}</td>
														<td>\${st.job}</td>
														<td>\${st.target}</td>
														<td>\${st.sellcnt}</td>
														<td>\${st.emonth}</td></tr>`
										

									})
									$("#eachList").html(addHTML)
									
								},
								error:function(err){
									console.log(err)
								}
							})												
						}
						function search(){
							var deptno = "${sesEmp.deptno}"
							
							console.log(deptno)
							$.ajax({
								url:"/ajaxEachPerfor?deptno="+deptno,
								type:"get",												
								dataType:"json",
								success:function(data){								
									var addHTML=""
									var filteredData = data.filter(function (eachperfor) {
							               return search === "" || eachperfor.name === search;
							            });
									
									$(filteredData).each(function(idx, eachperfor){
										addHTML+=`<tr><td>\${eachperfor.deptno}</td>
														<td>\${eachperfor.name}</td>
														<td>\${eachperfor.job}</td>
														<td>\${eachperfor.target}</td>
														<td>\${eachperfor.sellcnt}</td>
														<td>\${eachperfor.emonth}</td></tr>`
										
									})
									console.log(filteredData)
									console.log(addHTML)
									
									$("tbody").html(addHTML)
								},
								error:function(err){
									console.log(err)
								}
							})	
						}
						</script>
						<div class="card-header py-3">
							<h6 class="m-0 font-weight-bold text-primary">직원별 판매실적</h6>
						</div>
						<br>

						<div class="card-body">
							<div class="table-responsive">
								<table class="table table-bordered" id="dataTable" width="100%"
									cellspacing="0">
									<thead>
										<tr align="center">
											<th>부서번호</th>
											<th>직원명</th>
											<th>직책</th>
											<th>목표실적</th>
											<th>판매 합산 수량</th>
											<th>판매한 월</th>
										</tr>
									</thead>
									<tfoot>
										<tr align="center">
											<th>부서번호</th>
											<th>직원명</th>
											<th>직책</th>
											<th>목표실적</th>
											<th>판매 합산 수량</th>
											<th>판매한 월</th>
										</tr>
									</tfoot>
									<tbody id="eachList" align="center">

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