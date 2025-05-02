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
	width: 20%;
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

td>b {
	color: black !important;
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
					<h1 class="h3 mb-2 text-gray-800">직원역사 정보</h1>
					<!-- DataTales Example -->
					<div class="card shadow mb-4">
						<div class="card-header py-3">
							<h6 class="m-0 font-weight-bold text-primary">직원역사 리스트</h6>
						</div>
						<div class="card-body">
							<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
								<input class="form-control mr-sm-2" placeholder="사원명"
									v-model="sch.ename" @keyup="search" /> <input
									class="form-control mr-sm-2" placeholder="부서명"
									v-model="sch.dname" @keyup="search" /> <input type="hidden"
									v-model="schEmpno.ename" /> <input type="hidden"
									v-model="schEmpno.dname" />
								<button style="float: right;"
									class="form-control1 btn btn-success" type="button" id="regBtn"
									@click="register" data-toggle="modal"
									data-target="#exampleModalCenter">인사이동</button>
							</nav>
							<div class="table-responsive">
								<table class="table table-bordered" width="100%" cellspacing="0">
									<thead>
										<tr>
											<th>사원번호</th>
											<th>사원명</th>
											<th>부서명</th>
											<th>직급명</th>
											<th>업무시작일</th>
											<th>업무종료일</th>
										</tr>
									</thead>
									<tfoot>
										<tr>
											<th>사원번호</th>
											<th>사원명</th>
											<th>부서명</th>
											<th>직급명</th>
											<th>업무시작일</th>
											<th>업무종료일</th>
										</tr>
									</tfoot>
									<tbody>
										<tr v-for="eh in ehList"
											@dblclick="getDetail(eh.empno,formatDate(eh.startdate))">
											<td>{{eh.empno}}</td>
											<td>{{eh.ename}}</td>
											<td>{{eh.dname}}</td>
											<td>{{eh.jname}}</td>
											<td>{{formatDate(eh.startdate)}}</td>
											<td v-if="eh.enddate!=null">{{formatDate(eh.enddate)}}</td>
											<td v-if="eh.enddate==null">&ensp;<b>현재 근무중</b></td>
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
											<select v-model="eh.empno" name="empno" class="form-control">
												<option value="0">사원선택</option>
												<option v-for="emp in eList" :value="emp.empno">{{emp.dname}}
													{{emp.jname}} {{emp.ename }} [{{ emp.empno }}]</option>
											</select>
										</div>
										<div class="row dates">
											<div class="col">
												<input type="date" v-model="formattedStartDate" readonly
													class="form-control" name="startdateStr">
											</div>
											<div class="col">
												<input type="date" v-model="formattedEndDate"
													class="form-control" name="enddateStr">
											</div>
										</div>
										<div class="row">
											<div class="col">
												<select v-model="eh.jobid" name="jobid" class="form-control">
													<option value="0">직급선택</option>
													<option v-for="job in jobList" :value="job.jobid">{{
														job.jname }} [{{ job.jobid }}]</option>
												</select>
											</div>
											<div class="col">
												<select v-model="eh.deptno" name="deptno"
													class="form-control">
													<option value="0">부서선택</option>
													<option v-for="dept in deptList" :value="dept.deptno">{{
														dept.dname }} [{{ dept.deptno }}]</option>

												</select>
											</div>
										</div>
										<span id="ckEh"></span>
									</form>
								</div>

								<div class="modal-footer">
									<button type="button" @click="insertEh" id="ehRegBtn"
										class="btn btn-success">등 록</button>
									<button type="button" @click="updateEh" id="ehUptBtn"
										class="btn btn-primary">수 정</button>
									<button type="button" @click="deleteEh" id="ehDelBtn"
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
	var auth = Number("${sesEmp.auth}");
	if(auth<4){
		alert("접속 권한이 없습니다.\n메인으로 돌아갑니다")
		location.href="/main"
	}
	const URL = "/ajaxHistoryList";
	var model = {msg:"사원정보리스트(vue-axios)",
				sch:{ename:"",dname:''},schEmpno:{ename:"",dname:""}, ehList:[], jobList:[], deptList:[],
				eh:{},
				isLoading:false}
	var vm = Vue.createApp({
		name:"App",
		data(){
			return model;
		},
		created(){
			this.search()
			this.searchEmpno()
			this.callDept()
			this.callJob()
		},
		computed: {
		    formattedStartDate: {
		        get() {
		            if (!this.eh.startdate) return '';
		            let date = new Date(this.eh.startdate);
		            return date.toISOString().split('T')[0];  // 'YYYY-MM-DD' 포맷
		        },
		        set(value) {
		            this.eh.startdate = value;  // 사용자가 입력하면 그대로 저장
		        }
		    },
		    formattedEndDate: {
		        get() {
		            if (!this.eh.enddate) return '';
		            let date = new Date(this.eh.enddate);
		            return date.toISOString().split('T')[0];
		        },
		        set(value) {
		            this.eh.enddate = value;
		        }
		    }
		},
		methods:{
			searchEmpno(){
				this.isLoading = true;
				// cors 에러는 가끔 나는데, 서버단에서 처리할 내용..f5로 다시 수행
				console.log("검색수행:"+this.schEmpno)
				axios.get("/ajaxErpEmpList",{params:this.schEmpno}).then((response)=>{
					console.log(response.data)
					this.eList = response.data
					this.isLoading = false; 
					console.log("#로딩#")
					console.log(this.isLoading)
					// 서버에서 데이터를 받아서 완료됐을때, 사라지게 처리
				}).catch((err)=>{
					console.log(err)
				})
			},
			callDept(){
			    axios.get("/ajaxDepart").then((response) => {
			        console.log(response.data);
			        this.deptList = response.data;

			        Vue.nextTick(() => {
			            console.log("부서 목록 로딩 후, 옵션 보이게 처리");
			            let deptno = "#depart" + "${sesEmp.deptno}"; 
			            if ($(deptno).length) {
			                $(deptno).show();
			            } else {
			                console.warn("Element not found after callDept:", deptno);
			            }
			        });
			    }).catch((err) => {
			        console.log(err);
			    });
			},
			callJob(){
				axios.get("/ajaxJob").then((response)=>{
					console.log(response.data)
					this.jobList = response.data
				}).catch((err)=>{
					console.log(err)
				})					
			},
			formatDate(value) {
	            if (!value) return '';
	            let date = new Date(value);
	            return date.toISOString().split('T')[0]; // 'YYYY-MM-DD' 형식으로 변환
	        },
			search(){
				console.log("검색수행:"+this.sch)
				axios.get(URL,{params:this.sch}).then((response)=>{
					console.log(response.data)
					this.ehList = response.data
					// 서버에서 데이터를 받아서 완료됐을때, 사라지게 처리
				}).catch((err)=>{
					console.log(err)
				})
			},
			register(){
				$("#ckEh").text("");
			    $("#frm02")[0].reset();
			    $("#exampleModalLongTitle").text("인사이동 등록");
			    $("#ehRegBtn").show();
			    $("#ehUptBtn").hide();
			    $("#ehDelBtn").hide();
			    $(".dates").hide();
			    $("[name=empno]").val("0").prop("selected", true);
			    $("[name=jobid]").val("0").prop("selected", true);
			    $("[name=deptno]").val("0").prop("selected", true);
			    $("#frm02 [name=empno]").prop("readonly",false)
			    // 기존 데이터 유지 (초기화 시 emp.ename 값을 비우지 않음)
			    this.eh = Object.assign({}, this.eh, {
			        empno: '0',
			        jobid: '0',
			        deptno: '0',
			        startdate: '',
			        enddate: ''
			    });
			},
			insertEh(){
				if($("[name=deptno]").val() != "0"&& $("[name=jobid]").val() != "0"){
					$("#ckEh").text("");
				    console.log("# 사원정보 등록 #");
				    console.log("현재 eh 객체 (변환 전):", this.eh);
	
				    let ehData = {...this.eh};
	
				    // ❗ 빈 문자열을 null로 변환하여 Spring에서 처리 가능하도록 변경
				    Object.keys(ehData).forEach(key => {
				        if (ehData[key] === "" || ehData[key] === "0") {
				            ehData[key] = null;
				        }
				    });
	
				    console.log("현재 eh 객체 (변환 후):", ehData);
	
				    axios.post("/insertEmpHistory", ehData, {
				        headers: { "Content-Type": "application/json" }  // ✅ JSON 형식으로 전송
				    })
				    .then((response) => {
				        console.log("서버 응답:", response.data);
				        alert(response.data);
				        this.eh = {};  
				        this.search();
				    })
				    .catch((err) => {
				        console.error("에러 발생:", err);
				    });
				}else{
					$("#ckEh").text("입력된 데이터를 확인해주세요!!").css("color", "red");
				}
			},
			updateEh(){
				if($("[name=deptno]").val() != "0"&& $("[name=jobid]").val() != "0"){
					$("#ckEh").text("");
					console.log("# 사원정보 수정 #")
					console.log(this.eh)
					let ehData = { ...this.eh, enddateStr: this.eh.enddate === "" ? null : this.eh.enddate ,
							startdateStr: this.eh.startdate === "" ? null : this.eh.startdate};
					axios.put("/updateEmpHistory",ehData).then((response)=>{
						console.log(response.data)
						alert(response.data)
						this.search()
					}).catch((err)=>{
						console.log(err)
					})		
				}else{
					$("#ckEh").text("입력된 데이터를 확인해주세요!!").css("color", "red");
				}
			},
			deleteEh(){
				if(confirm("삭제하시겠습니까?")){
					console.log("# 사원정보 삭제 #")
					console.log(this.eh.empno)
					axios.delete("/deleteEmpHistory",{params: {empno:this.eh.empno,startdateStr:this.eh.startdate} }).then((response)=>{
						console.log(response.data)
						alert(response.data)
						this.eh={}
						this.search()
						$(".clsBtn").click()
					}).catch((err)=>{
						console.log(err)
					})						
				}
			},	
			getDetail(empno,startdate){
				console.log("getDetail 함수==>",empno,startdate)
				 $("#regBtn").click()
				 $("#exampleModalLongTitle").text("인사이력 상세");
				 $("#ehRegBtn").hide()
				 $("#ehUptBtn").show()
				 $("#ehDelBtn").show()
				 $(".dates").show();
				 $("#frm02 [name=empno]").prop("readonly",true)
			// 상세 데이터 가져오기..
				axios.get("/vueEmpHistory",{params:{empno:empno, startdateStr:startdate}}).then((response)=>{
					console.log("# 요청한 URL: ", "/vueEmpHistory?empno="+empno+"&startdateStr="+startdate);
					console.log(response.data)
					this.eh = response.data
					//alert("상세 데이터 가져옴")
				}).catch((err)=>{
					console.log(err)
				});
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