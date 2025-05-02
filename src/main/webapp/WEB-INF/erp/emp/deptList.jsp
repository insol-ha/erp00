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

.form-control1 {
	display: block;
	width: 15%;
	height: calc(1.5em + .75rem + 2px);
	padding: .275rem .55rem;
	font-size: 1rem;
	font-weight: 400;
	line-height: 1.5;
	color: #6e707e;
	background-color: #fff;
	background-clip: padding-box;
	border: 1px solid #d1d3e2;
	border-radius: .35rem;
	transition: border-color .15s ease-in-out, box-shadow .15s ease-in-out;
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
					<h1 class="h3 mb-2 text-gray-800">부서정보</h1>
					<!-- DataTales Example -->
					<div class="card shadow mb-4">
						<div class="card-header py-3">
							<h6 class="m-0 font-weight-bold text-primary">부서정보 리스트</h6>
						</div>
						<div class="card-body">
							<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
								<input class="form-control mr-sm-2" placeholder="부서명"
									v-model="sch.dname" @keyup="search" /> <input
									class="form-control mr-sm-2" placeholder="부서주소"
									v-model="sch.loc" @keyup="search" /> <input type="hidden"
									v-model="schEmpno.ename" /> <input type="hidden"
									v-model="schEmpno.dname" />
								<button style="float: right;"
									class="form-control1 btn btn-success" type="button" id="regBtn"
									@click="register" data-toggle="modal"
									data-target="#exampleModalCenter">등록</button>
							</nav>
							<div class="table-responsive">
								<table class="table table-bordered" width="100%" cellspacing="0">
									<thead>
										<tr>
											<th>부서번호</th>
											<th>부서명</th>
											<th>부서주소</th>
											<th>담당자</th>
										</tr>
									</thead>
									<tfoot>
										<tr>
											<th>부서번호</th>
											<th>부서명</th>
											<th>부서주소</th>
											<th>담당자</th>
										</tr>
									</tfoot>
									<tbody>
										<tr v-for="dp in deptList" @dblclick="getDetail(dp.deptno)">
											<td>{{dp.deptno}}</td>
											<td>{{dp.dname}}</td>
											<td>{{dp.loc}}</td>
											<td>{{dp.managerid}}</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>
					<div class="modal fade" id="exampleModalCenter" tabindex="-1"
						role="dialog" aria-labelledby="exampleModalCenterTitle"
						aria-hidden="true">
						<div class="modal-dialog modal-dialog-centered" role="document">
							<div class="modal-content">
								<!-- $("#exampleModalLongTitle").text("등록/상세"); -->
								<div class="modal-header">
									<h5 class="modal-title" id="exampleModalLongTitle">타이틀</h5>
									<button type="button" class="clsBtn close" data-dismiss="modal"
										aria-label="Close">
										<span aria-hidden="true">&times;</span>
									</button>
								</div>
								<div class="modal-body">
									<form id="frm02" class="form" method="post">
										<div class="row">
											<div class="col">
												<input type="text" class="form-control" readonly
													placeholder="부서번호 자동등록" name="deptno" v-model="dept.deptno">
											</div>
											<div class="col">
												<input type="text" v-model="dept.dname" class="form-control"
													placeholder="부서명 입력" name="dname">
											</div>
										</div>
										<div class="row">
											<div class="col">
												<input type="text" v-model="dept.loc" class="form-control"
													placeholder="부서주소 입력" name="loc">
											</div>
											<div class="col">
												<select name="managerid" v-model="dept.managerid"
													class="form-control">
													<option value="0">담당자 선택</option>
													<option v-for="emp in eList" :value="emp.empno">{{emp.dname}}
														{{emp.jname}} {{emp.ename }} [{{ emp.empno }}]</option>
												</select>
											</div>
										</div>
									</form>
								</div>

								<div class="modal-footer">
									<button type="button" @click="insertDept" id="deptRegBtn"
										class="btn btn-success">등 록</button>
									<button type="button" @click="updateDept" id="deptUptBtn"
										class="btn btn-primary">수 정</button>
									<button type="button" @click="deleteDept" id="deptDelBtn"
										class="btn btn-warning">삭 제</button>
									<button type="button" class="clsBtn btn btn-secondary"
										data-dismiss="modal">Close</button>
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
$(document).ready(function(){
	var auth = "${sesEmp.auth}";
	if (auth < 4) {
	    $("#regBtn").hide().attr("disabled", true);
	}else{
		$("#regBtn").show().attr("disabled", false);
	}
	const URL = "/ajaxDepartList";
	var model = {msg:"사원정보리스트(vue-axios)",
				sch:{dname:"",loc:""}, deptList:[], dept:{},schEmpno:{ename:"",dname:""},eList:[],
				isLoading:false}
	var vm = Vue.createApp({
		name:"App",
		data(){
			return model;
		},
		created(){
			this.search()
			this.searchEmpno()
		},
		methods:{
			searchEmpno(){
				this.isLoading = true;
				// cors 에러는 가끔 나는데, 서버단에서 처리할 내용..f5로 다시 수행
				console.log("검색수행:"+this.schEmpno)
				axios.get("/ajaxErpEmpList",{params:this.schEmpno}).then((response)=>{
					console.log("사원검색"+response.data)
					this.eList = response.data
					this.isLoading = false; 
					console.log("#로딩#")
					console.log(this.isLoading)
					// 서버에서 데이터를 받아서 완료됐을때, 사라지게 처리
				}).catch((err)=>{
					console.log(err)
				})
			},
			search(){
				console.log("검색수행:"+this.sch)
				axios.get(URL,{params:this.sch}).then((response)=>{
					console.log("부서검색"+response.data)
					this.deptList = response.data
				}).catch((err)=>{
					console.log(err)
				})
			},
			register(){
			    $("#frm02")[0].reset();
			    $("#exampleModalLongTitle").text("부서 등록");
			    $("#deptRegBtn").show();
			    $("#deptUptBtn").hide();
			    $("#deptDelBtn").hide();
			    $("[name=deptno]").val("부서번호 자동 삽입")
			    // 기존 데이터 유지 (초기화 시 emp.ename 값을 비우지 않음)
			    this.dept =  {
			        managerid: '0'
			    };
			},
			insertDept(){
			    let deptData = {...this.dept};
			    // ❗ 빈 문자열을 null로 변환하여 Spring에서 처리 가능하도록 변경
			    Object.keys(deptData).forEach(key => {
			        if (deptData[key] === "" || deptData[key] === "0") {
			            deptData[key] = null;
			        }
			    });
			    axios.post("/ajaxinsertDepart", deptData, {
			        headers: { "Content-Type": "application/json" }  // ✅ JSON 형식으로 전송
			    })
			    .then((response) => {
			    	alert(response.data);
			        this.dept = {};  
			        this.search();
			    })
			    .catch((err) => {
			        console.error("에러 발생:", err);
			    });
			},
			updateDept(){
				console.log("# 사원정보 수정 #")
				console.log(this.dept)
				axios.put("/ajaxupdateDepart",this.dept).then((response)=>{
					console.log(response.data)
					alert(response.data)
					//this.dept={}
					this.search()
				}).catch((err)=>{
					console.log(err)
				})						
			},
			deleteDept(){
				if(confirm("삭제하시겠습니까?")){
					console.log("# 사원정보 삭제 #")
					console.log(this.dept.deptno)
					axios.delete("/ajaxdeleteDepart",
							{params: {deptno:this.dept.deptno} }).then((response)=>{
						console.log(response.data)
						alert(response.data)
						this.dept={}
						this.search()
						$(".clsBtn").click()
					}).catch((err)=>{
						console.log(err)
					})	
				}
			},	
			getDetail(deptno){
				$("#regBtn").click();
                $("#frm02")[0].reset();
                $("#exampleModalLongTitle").text("부서 상세정보");
                $("#deptRegBtn").hide();
                $("#deptUptBtn").show();
                $("#deptDelBtn").show();
				console.log("더블클릭")
				axios.get("ajaxGetDepart?deptno="+deptno).then((response)=>{
					console.log("# 상세 데이터 #")
					console.log(response.data)
					this.dept = response.data
			    }).catch((err) => {
			        console.log("에러 발생:", err);
			    });
			}
		}
	}).mount("#vueCon")
});
function formatDate(value) {
    if (!value) return '';
    let date = new Date(value);
    return date.toISOString().split('T')[0]; // 'YYYY-MM-DD' 형식으로 변환
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