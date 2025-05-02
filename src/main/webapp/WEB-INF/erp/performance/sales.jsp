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

h4 {
	border-width: medium;
	border-style: double;
	align: left;
	padding: 5px;
	background-color: #fffff0;
}

th {
	background-color: #997000;
	color: white;
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
					<h1 class="h3 mb-2 text-gray-800">(주) 커피하우스 판매 내역</h1>
					<!-- DataTales Example -->
					<div class="card shadow mb-4">
						<script>
						$(document).ready(function(){
							
							const URL = "/getSales"
							var model = {msg:"판매내역(vue-axios)", 
										 sch:{dname:"",salesdate:""}, salesList:[], 
										 sales:{no:'',pname:'',cnt:'',price:'',tot:'',salesdate:'',store:''},
										 no:'',
										  isLoading:false};
							
							var vm = Vue.createApp({
								name:"App",
								data(){
									return model;
								},
								created(){								
									this.callSales()
									this.callDept()
								},
								computed: {

									 isNoReadonly() {
									        return true; // 항상 읽기 전용 유지
									    },
									 uniqueProducts() {
									        const uniqueSet = new Set();
									        return this.salesList.filter(sales => {
									            if (!uniqueSet.has(sales.pname)) {
									                uniqueSet.add(sales.pname);
									                return true;
									            } 
									            return false;
									        });
									    },
									    uniqueStores() {
									        const storeSet = new Set();
									        return this.salesList.filter(sales => {
									            if (!storeSet.has(sales.store)) {
									            	storeSet.add(sales.store);
									                return true;
									            } 
									            return false;
									        });
									    },    
								    totalSalesAmount() {
								        return this.salesList.reduce((sum, sales) => sum + sales.tot, 0);
								    }
								},
								methods:{
									callDept(){ // 부서 선택지 불러오기
									    axios.get("/ajaxDepart").then((response) => {
									        console.log(response.data);
									        this.deptList = response.data;
									     
									    }).catch((err) => {
									        console.log(err);
									    });
									},
									callSales(){
										//ajaxgetSalesList
										axios.get("/getSales").then((response)=>{
											console.log(response.data)
											this.salesList = response.data
										}).catch((err)=>{
											console.log(err)
										})					
										
									},
									search(){
										this.isLoading=true;									
										axios.get(URL,{params:this.sch}).then((response)=>{
											console.log(response.data)
											this.salesList = response.data
											this.isLoading=false;
											console.log("#로딩#")
											console.log(this.isLoading)
										}).catch((err)=>{
											console.log(err)
										})
									},
									registerFrm(){
										 this.sales={no:'자동순서 입력x'}										
										 // 타이틀 변경
										 $("#exampleModalLongTitle").text("판매 등록");
										 // 등록 버튼을 보이게 하고, 수정/삭제버튼을 보이지 않게..
										 $("#empRegBtn").show()
										 $("#empUptBtn").hide()
										 $("#empDelBtn").hide()
										 // 사원번호가 입력이 가능하게/상세화면에서는 입력불가능하게 해야되기에..
										// $("#frm02 [name=no]").prop("readonly",false)
									},
									insertSales(){
										$("#empRegBtn").show()
										$("#empUptBtn").hide()
										$("#empDelBtn").hide()
										console.log("# 판매 등록 #")
										console.log(this.sales)			
										if (!this.sales.cnt || isNaN(this.sales.cnt) || this.sales.cnt <= 0) {
      										 alert("수량을 올바르게 입력하세요.");
     										  return;
										    }
										this.sales.no = this.salesList.length+3;
										$("#exampleModalCenter [name=no]").prop("readonly",false)				
										axios.post("/insertSales",this.sales).then((response)=>{
											console.log(response.data)	
											alert(response.data)
											this.sales={}											
											this.search()
										}).catch((err)=>{
											console.log(err)
										})						
									},																										
									getSales1(no){
										//alert(no)
										// 상세 화면 처리
											 $("#regBtnFrm").click()
											 $("#exampleModalLongTitle").text("판매 상세");
											  //등록 버튼을 보이게 하고, 수정/삭제버튼을 보이지 않게..
											 $("#empRegBtn").hide()
											 $("#empUptBtn").show()
											 $("#empDelBtn").show()
											  //사원번호가 입력이 가능하게/상세화면에서는 입력불가능하게 해야되기에..
											 $("#frm02 [name=no]").prop("readonly",true)
										 //상세 데이터 가져오기..
											axios.get("/salesVue",{params:{no:no}}).then((response)=>{
												console.log("# 상세 데이터 #")
												console.log(response.data)
												this.sales = response.data
												//var date = new Date(this.sales.salesdate)
												//this.sales.salesdate = formatDate(date) 
												console.log(response.data)
												//alert("상세 데이터 가져옴")
											}).catch((err)=>{
												console.log(err)
											})
										},
										updateSales(){
											console.log("# 판매내역 수정 #")
											console.log(this.sales)
											//updateSales
											axios.put("/updateSales",this.sales).then((response)=>{
												console.log(response.data)
												alert(response.data)
												//this.emp={}
												this.search()
											}).catch((err)=>{
												console.log(err)
											})						
										},
										deleteSale(){
											console.log("# 판매내역 삭제 #")
											console.log(this.sales.no)
											axios.delete("/deleteSale",{params: {no:this.sales.no}})
											.then((response)=>{
												console.log(response.data)
												alert(response.data)
												this.sales={}
												this.search()
												$(".clsBtn").click()
											}).catch((err)=>{
												console.log(err)
											})						
										}
										
								}								
						}).mount("#container")
							console.log(vm)
						});
						
						function formatDate(date) {
						    let year = date.getFullYear();
						    let month = String(date.getMonth() + 1).padStart(2, '0'); // 월은 0부터 시작하므로 +1
						    let day = String(date.getDate()).padStart(2, '0');       // 일자를 2자리로 보장

						    return `${year}-${month}-${day}`;
						}	
						
						</script>
						<!-- @keyup.키이름="함수" @keyup.enter="search"  @click="search" -->
						<div id="container">
							<div class="card-header py-3">
								<h6 class="m-0 font-weight-bold text-primary">판매관리</h6>
								<nav class="navbar navbar-expand-sm bg-white-dark">
									<input @keyup.enter="search" class="form-control mr-sm-2"
										placeholder="매장명" v-model="sch.dname" /> <input type="date"
										v-model="sch.start" class="form-control mr-2"
										placeholder="시작 날짜 선택 (YYYY-MM-DD)" name="startDate">
									<input type="date" v-model="sch.end" class="form-control mr-2"
										placeholder="종료 날짜 선택 (YYYY-MM-DD)" name="endDate">
									<button @click="search" class="btn btn-info" type="button">Search</button>
								</nav>
							</div>

							<div class="card-body" id="container">
								<div class="table-responsive">
									<table class="table table-bordered" id="dataTable" width="100%"
										cellspacing="0">
										<col width="5%">
										<col width="13%">
										<col width="20%">
										<col width="10%">
										<col width="10%">
										<col width="15%">
										<col width="15%">
										<thead>
											<tr align="center">
												<th>NO.</th>
												<th>지점명</th>
												<th>상품명</th>
												<th>수량</th>
												<th>가격</th>
												<th>총합</th>
												<th>날짜</th>
											</tr>
										</thead>
										<tbody>
											<tr v-for="sales in salesList"
												@dblclick="getSales1(sales.no)" align="center">
												<td>{{sales.no}}</td>
												<td>{{sales.dname}}</td>
												<td>{{sales.pname}}</td>
												<td>{{sales.cnt.toLocaleString()}}</td>
												<td>{{sales.price.toLocaleString()}}</td>
												<td>{{sales.tot.toLocaleString()}}</td>
												<td>{{sales.salesdate ? sales.salesdate.replace(/-/g,
													".") : "-"}}</td>
											</tr>
										</tbody>

									</table>
									<br>
									<div>
										<nav>
											<h4>총 판매 금액 : {{ totalSalesAmount.toLocaleString()}} 원</h4>
										</nav>
										<div align="right">
											<button class="btn btn-success" id="regBtnFrm"
												@click="registerFrm" data-toggle="modal"
												data-target="#exampleModalCenter" type="button">판매
												등록</button>
										</div>
									</div>
								</div>
							</div>


							<!-- /.container-fluid -->
							<div class="modal fade" id="exampleModalCenter" tabindex="-1"
								role="dialog" aria-labelledby="exampleModalCenterTitle"
								aria-hidden="true">
								<div class="modal-dialog modal-dialog-centered" role="document">
									<div class="modal-content">
										<!-- $("#exampleModalLongTitle").text("등록/상세"); -->
										<div class="modal-header">
											<h5 class="modal-title" id="exampleModalLongTitle">판매 등록</h5>
											<button type="button" class="clsBtn close"
												data-dismiss="modal" aria-label="Close">
												<span aria-hidden="true">&times;</span>
											</button>
										</div>
										<div class="modal-body">
											<form id="frm02" class="form" method="post">

												<div class="row">
													<div class="col">
														<input type="text" v-model="sales.no" class="form-control"
															placeholder="순서" name="no" :readonly="true">
													</div>
												</div>
												<div class="row">
													<div class="col">
														<select v-model="sales.store" name="store"
															class="form-control">
															<option value="0">부서선택</option>
															<option v-for="dept in deptList" class="deptno"
																:value="dept.deptno" :id="'depart' + dept.deptno">{{dept.dname
																}} [{{ dept.deptno }}]</option>
															<!-- class=deptno, id는 deptno+실제부서번호 -->

														</select>
													</div>
												</div>
												<div class="row">
													<div class="col">
														<select v-model="sales.pname" name="pname"
															class="form-control">
															<option value="0">제품명</option>
															<option v-for="sales in uniqueProducts"
																:value="sales.pname">{{ sales.pname }} [{{
																sales.price }}]</option>
														</select>
													</div>
												</div>
												<div class="row">
													<div class="col">
														<input type="text" v-model="sales.cnt"
															class="form-control" placeholder="수량 입력" name="cnt">
													</div>

												</div>
												<div class="row">
													<div class="col">
														<input type="date" v-model="sales.salesdate"
															class="form-control" placeholder="입사일 입력(YYYY-MM-DD)"
															name="salesdate">
													</div>
											</form>
										</div>
										<div class="modal-footer">
											<button type="button" @click="insertSales" id="empRegBtn"
												class="btn btn-success">등 록</button>
											<button type="button" @click="updateSales" id="empUptBtn"
												class="btn btn-primary">수 정</button>
											<button type="button" @click="deleteSale" id="empDelBtn"
												class="btn btn-warning">삭 제</button>
											<button type="button" class="clsBtn btn btn-secondary"
												data-dismiss="modal">Close</button>
										</div>
									</div>
								</div>
							</div>
						</div>
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
							<h5 class="modal-title" id="exampleModalLabel">Ready to
								Leave?</h5>
							<button class="close" type="button" data-dismiss="modal"
								aria-label="Close">
								<span aria-hidden="true">×</span>
							</button>
						</div>
						<div class="modal-body">Select "Logout" below if you are
							ready to end your current session.</div>
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