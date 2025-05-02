<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<fmt:requestEncoding value="utf-8" />
<!DOCTYPE html>
<html lang="en">

<head>
<link rel="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.3/css/font-awesome.min.css">
<style>
tbody tr:hover {
	background-color: lightgray;
}

#loadBtn {
	position: fixed; /* 화면에 고정 */
	top: 40%; /* 화면의 중간 */
	left: 50%; /* 화면의 중간 */
	z-index: 1060;
}
.modal {
    z-index: 1050 !important; /* 기본값보다 낮게 조정해보기 */
}
#pwd{
    position: absolute;
    left: 80%;
    bottom: 25%;
}
#pwdck{
    position: absolute;
    left: 80%;
    bottom: 25%;
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

input::-webkit-inner-spin-button {
	-webkit-appearance: none;
}

input::-webkit-outer-spin-button {
	-webkit-appearance: none;
	margin: 0;
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
					<h1 class="h3 mb-2 text-gray-800">사원정보</h1>
					<!-- DataTales Example -->
					<div class="card shadow mb-4">
						<div class="card-header py-3">
							<h6 class="m-0 font-weight-bold text-primary">사원정보 리스트</h6>
						</div>
						<button class="btn btn-primary" id="loadBtn" v-show="isLoading"
							disabled>
							<span class="spinner-border spinner-border-sm"></span> Loading..
						</button>
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
									data-target="#exampleModalCenter">등록</button>
							</nav>
							<div class="table-responsive">
								<table class="table table-bordered" width="100%" cellspacing="0">
									<thead>
										<tr>
											<th>사원번호</th>
											<th>사원명</th>
											<th>직책</th>
											<th>입사일</th>
											<th>이메일</th>
											<th>부서번호</th>
											<th>부서명</th>
											<th>담당자</th>
										</tr>
									</thead>
									<tfoot>
										<tr>
											<th>사원번호</th>
											<th>사원명</th>
											<th>직책</th>
											<th>입사일</th>
											<th>이메일</th>
											<th>부서번호</th>
											<th>부서명</th>
											<th>담당자</th>
										</tr>
									</tfoot>
									<tbody>
										<tr v-for="emp in empList" @dblclick="getDetail(emp.empno)">
											<!-- 더블클릭시 세부사항 -->
											<td>{{emp.empno}}</td>
											<td>{{emp.ename}}</td>
											<td>{{emp.jname}}</td>
											<td>{{formatDate(emp.hired)}}</td>
											<td>{{emp.email}}</td>
											<td>{{emp.deptno}}</td>
											<td>{{emp.dname}}</td>
											<td v-if="emp.managerid==null">&ensp;&emsp;-</td>
											<td v-if="emp.managerid!=null">{{emp.managerid}}</td>
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
										<div class="row" id="empno">
											<div class="col">
												<input type="number" class="form-control"
													placeholder="사원번호 입력" name="empno" v-model="emp.empno">
											</div>
											<div class="col">
												<input type="date" v-model="emp.hired" class="form-control"
													placeholder="입사일 입력(YYYY-MM-DD)" name="hiredStr">
											</div>
										</div>
										<div class="row pwd">
											<div class="col pwd" style="position: relative;">
												<input :type="isPasswordVisible ? 'text' : 'password'" id="pwdInput" class="form-control" maxlength="16"
            placeholder="비밀번호 입력" name="pwd" v-model="emp.pwd" @keyup="pwdCk">
													<i id="pwd" @click="togglePasswordVisibility" class="fa" :class="isPasswordVisible ? 'fa-eye-slash' : 'fa-eye'"></i>
											</div>
											<div class="col" style="position: relative;">
												<input :type="isPasswordVisible1 ? 'text' : 'password'" id="pwdckInput" class="form-control" maxlength="16"
            placeholder="비밀번호 확인" name="pwdck" @keyup="ckpwd" readonly>
													<i id="pwdck" @click="togglePasswordVisibility1" class="fa" :class="isPasswordVisible1 ? 'fa-eye-slash' : 'fa-eye'"></i>
											</div>
										</div>
										<div class="row pwd">
											<div class="col" id="ckpwdResult"></div>
											<input id="pwdResult" value="0" type="hidden" />
											<!-- 비밀번호 수정시 1로 변환 -->
										</div>

										<div class="row">
											<div class="col">
												<input type="text" v-model="emp.ename" class="form-control"
													placeholder="사원명 입력" name="ename">
											</div>
											<div class="col">
												<select v-model="emp.jobid" name="jobid"
													class="form-control">
													<option value="0">직급선택</option>
													<option class="jobId" v-for="job in jobList"
														:value="job.jobid" :id="'job'+job.jobid">
														{{job.jname }} [{{ job.jobid }}]</option>
													<!-- class=jobId, id는 job+실제직급번호 -->
												</select>
											</div>
										</div>
										<div class="row">
											<div class="col">
												<select v-model="emp.managerid" name="managerid"
													class="form-control">
													<option value="0">담당자 선택</option>
													<option value="">담장자 없음</option>
													<option v-for="emp in filteredList" :key="emp.empno"
														:value="emp.empno">{{emp.dname}} {{emp.jname}}
														{{emp.ename }} [{{ emp.empno }}]</option>

												</select>
											</div>
											<div class="col">
												<input type="email" v-model="emp.email" class="form-control"
													placeholder="이메일입력" name="email">
											</div>
										</div>
										<div class="row">
											<div class="col">
												<input type="text" v-model="emp.pnum" class="form-control"
													placeholder="휴대폰번호입력" name="pnum" @keyup="pnumck"
													pattern="(010)-\d{4}-\d{4}" maxlength="13">
											</div>
											<div class="col">
												<select v-model="emp.deptno" name="deptno"
													class="form-control">
													<option value="0">부서선택</option>
													<option v-for="dept in deptList" class="deptno"
														:value="dept.deptno" :id="'depart' + dept.deptno">{{dept.dname
														}} [{{ dept.deptno }}]</option>
													<!-- class=deptno, id는 deptno+실제부서번호 -->

												</select>
											</div>

										</div>
										<span id="ckIns"></span>
									</form>
								</div>

								<div class="modal-footer">
									<button type="button" @click="insertEmp" id="empRegBtn"
										class="btn btn-success">등 록</button>
									<button type="button" @click="updateEmp" id="empUptBtn"
										class="btn btn-primary">수 정</button>
									<button type="button" @click="deleteEmp" id="empDelBtn"
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
	var auth = "${sesEmp.auth}"; // session 권한 체크
	
	var deptno = "#depart" + "${sesEmp.deptno}"; // 부서번호 id로 설정
	
	if (auth < 2) {
	    $("#regBtn").hide().attr("disabled", true); // 권한 2 미만 등록모달창 비활성
	} else if (auth == 2) {
	    $("#regBtn").show().attr("disabled", false); // 권한 2 등록 모달창 활성
	    $(".deptno").hide();						// 부서선택지 숨김
	    $(".jobId").hide();							// 직급선택지 숨김
	}else{
		$("#regBtn").show().attr("disabled", false);// 권한 2 초과 등록 모달창 활성
	}
	const URL = "/ajaxErpEmpList";
	var model = {msg:"사원정보리스트(vue-axios)",
			isPasswordVisible: false,isPasswordVisible1: false,
			sch:{ename:"",dname:""},schEmpno:{ename:"",dname:""},eList:[], empList:[], jobList:[], deptList:[],
				emp:{empno:0,ename:'', jobid:0,managerid:0,hired:'',pnum:'',email:'',deptno:'0', pwd:''},
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
		    filteredList() {
		    	return this.eList.filter(emp => emp.jobid >= 103);
			}
		},
		methods:{
			formatDate(value) {
	            if (!value) return '';
	            let date = new Date(value);
	            return date.toISOString().split('T')[0]; // 'YYYY-MM-DD' 형식으로 변환
	        },
			togglePasswordVisibility() {
				this.isPasswordVisible = !this.isPasswordVisible;  // 상태 토글
				
			},
			togglePasswordVisibility1() {
				this.isPasswordVisible1 = !this.isPasswordVisible1;  // 상태 토글
			},
			callDept(){ // 부서 선택지 불러오기
			    axios.get("/ajaxDepart").then((response) => {
			        console.log(response.data);
			        this.deptList = response.data;

			        Vue.nextTick(() => {
			            console.log("부서 목록 로딩 후, 옵션 보이게 처리");
			            let deptno = "#depart" + "${sesEmp.deptno}"; // 부서번호 id 문자열로 변환
			            if ($(deptno).length) {
			                $(deptno).show(); // 부서번호 선택지 hide되어도 본인 부서는 반드시 보이게 설정
			            } else {
			                console.warn("Element not found after callDept:", deptno);
			            }
			        });
			    }).catch((err) => {
			        console.log(err);
			    });
			},
			callJob(){ // 직급 선택지 불러오기
				axios.get("/ajaxJob").then((response)=>{
					console.log(response.data)
					this.jobList = response.data
					Vue.nextTick(() => {
						let jobid = Number("${sesEmp.jobid}"); // 세션 직급번호
			            let job = "#job" + (jobid-1); // 직급번호 - 1 id로 설정
			            if ($(job).length) {
			                $(job).show(); // 직급번호 선택지 hide되어도 -1 된 직급은 반드시 보이게 설정
			            } else {
			                console.warn("Element not found after callJob:", job);
			            }
			        });
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
				this.isLoading = true;
				// cors 에러는 가끔 나는데, 서버단에서 처리할 내용..f5로 다시 수행
				console.log("검색수행:"+this.sch)
				axios.get(URL,{params:this.sch}).then((response)=>{
					console.log(response.data)
					this.empList = response.data
					this.isLoading = false; 
					console.log("#로딩#")
					console.log(this.isLoading)
					// 서버에서 데이터를 받아서 완료됐을때, 사라지게 처리
				}).catch((err)=>{
					console.log(err)
				})
			},
			searchEmpno(){
				this.isLoading = true;
				// cors 에러는 가끔 나는데, 서버단에서 처리할 내용..f5로 다시 수행
				console.log("검색수행:"+this.schEmpno)
				axios.get(URL,{params:this.schEmpno}).then((response)=>{
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
			pwdCk(){
				var pwd=$("[name=pwd]").val()
				if(pwd.length<8){
					$("#ckpwdResult").text("비밀번호는 8자 이상 16자 이하로 설정해주세요").css("color","red").show();
					$("#pwdResult").val(1); // 비밀번호 수정시도시 값을 1로 수정
				}else{
					$("#ckpwdResult").text("비밀번호를 다시 한번 입력해 주세요").css("color","black")
					$("#pwdResult").val(1);
					$("[name=pwdck]").attr("readonly",false); // 8자 미만일땐 readonly true, 이상이면 false
				}
			},
			ckpwd(){
				var pwd=$("[name=pwd]").val()
				var pwdck=$("[name=pwdck]").val()
				if(pwd.length>=8&&pwd===pwdck){
					$("#ckpwdResult").text("비밀번호가 일치합니다!").css("color","black")
					$("#pwdResult").val(0); // 비밀번호 확인이 완료되면 값이 다시 0으로 수정
				}else if(pwd.length>=8&&pwd!==pwdck){
					$("#ckpwdResult").text("비밀번호가 불일치합니다!").css("color","red");
					$("#pwdResult").val(1);
				}else{
					$("#ckpwdResult").text("비밀번호는 8자 이상 16자 이하로 설정해주세요")
					$("#pwdResult").val(1);
				}
			},
			pnumck(){
				var pnum = $("[name=pnum]").val()
				var cleanPnum = pnum.replaceAll("-", "");
				if (cleanPnum.length === 11) {
			        var formattedPnum = cleanPnum.substring(0, 3) + "-" + cleanPnum.substring(3, 7) + "-" + cleanPnum.substring(7);
			        $("[name=pnum]").val(formattedPnum);
			    } 
			},
			register(){
				$("#ckIns").text("");
			    $("#frm02")[0].reset();
			    $("#exampleModalLongTitle").text("사원 등록");
			    $("#empRegBtn").show();
			    $("#empUptBtn").hide();
			    $("#empDelBtn").hide();
			    $("#ckpwdResult").hide();
			    $(".pwd").hide();
			    $("#empno").hide();
			    $("[name=pwdck]").attr("readonly",true);
			    $("[name=jobid]").val("0").prop("selected", true);
			    $("[name=deptno]").val("0").prop("selected", true);
			    $("#pwdResult").val("0");
			    $("#ckpwdResult").text("").css("color","black").hide();
			    // 기존 데이터 유지 (초기화 시 emp.ename 값을 비우지 않음)
			    this.emp = Object.assign({}, this.emp, {
			        empno: '0',
			        ename: '', // 기존 값 유지
			        jobid: '0',
			        managerid: '0',
			        hired: '',
			        pnum: '',
			        email: '',
			        deptno: '0',
			        pwd: ''
			    });
			},
			insertEmp(){
				
			    var pnum = $("[name=pnum]").val();
			    var cleanPnumStr = pnum.replaceAll("-", "");
			    var cleanPnum = Number(cleanPnumStr);
			    if ($("[name=deptno]").val() != "0" &&
			        $("[name=jobid]").val() != "0" &&
			        $("[name=managerid]").val() != "0" &&
			        $("[name=managerid]").val() != "" &&
			        $("[name=email]").val() != "" &&
			        Number.isInteger(cleanPnum)) {
			    	this.isLoading = true; // 로딩을 true로 설정
			    	console.log(this.isLoading)
			        var formattedPnum = cleanPnumStr.substring(0, 3) + "-" + cleanPnumStr.substring(3, 7) + "-" + cleanPnumStr.substring(7);
			        $("[name=pnum]").val(formattedPnum);
			        $("#ckIns").text("");
			        // UI 업데이트 대기
			        setTimeout(() => {
						$("#empRegBtn").attr("disabled",true);
			            axios.post("/ajaxErpEmpInsert", this.emp, {
			                headers: { "Content-Type": "application/json" }  // JSON 형식으로 전송
			            })
			            .then((response) => {
			                console.log("서버 응답:", response.data);
			                alert(response.data);
			                this.isLoading = false;  // 로딩 비활성화
			                this.emp = {};  
			                this.search();
			                $("#empRegBtn").attr("disabled",false);
			            })
			            .catch((err) => {
			                console.error("에러 발생:", err);
			                this.isLoading = false; // 에러 발생 시에도 로딩 종료
			                $("#empRegBtn").attr("disabled",false);
			            });
			        }, 10);  // 10ms 정도의 지연을 주어 Vue의 반응형 시스템이 UI 업데이트를 먼저 할 수 있도록 함
			    } else {
			        $("#ckIns").text("입력된 데이터를 확인해주세요!!").css("color", "red");
			        console.log(cleanPnum);
			    }
			},
			updateEmp(){ // 사원 정보 수정
				var pwdResult = Number($("#pwdResult").val())
				var pnum = $("[name=pnum]").val()
				var cleanPnum = Number(pnum.replaceAll("-", ""));
				console.log("# 사원정보 수정 #")
				console.log(this.emp)
				if(pwdResult===0&&$("[name=deptno]").val() != "0"&& $("[name=jobid]").val() != "0"&&Number.isInteger(cleanPnum)){ // 비밀번호를 수정안해 0이거나 비밀번호와 비밀번호 확인이 일치할때
					$("#ckIns").text("");
					axios.put("/ajaxErpEmpUpdate",this.emp).then((response)=>{
						console.log(response.data)
						alert(response.data)
						//this.emp={}
						this.search()
					}).catch((err)=>{
						console.log(err)
					})			
				} else { // 비밀번호를 수정했으나 비밀번호 확인이 되지 않았을때
					$("#ckIns").text("입력된 데이터를 확인해주세요!!").css("color", "red");
					$("#ckpwdResult").text("비밀번호를 확인해주세요!!").css("color","red").show();
				}
			},
			deleteEmp(){
				axios.delete("/ajaxErpEmpDelete",{params: {empno:this.emp.empno} }).then((response)=>{
					console.log(response.data)
					alert(response.data)
					this.emp={}
					this.search()
					$(".clsBtn").click()
				}).catch((err)=>{
					console.log(err)
				})						
			},	
			getDetail(empno){ // 더블클릭시 세부사항
				var jobid = "${sesEmp.jobid}"
				console.log("더블클릭")
				console.log(jobid)
				 axios.get("ajaxErpEmp?empno="+empno).then((response)=>{ // axios로 세부내용 불러오기
						console.log(response.data)
						this.emp = response.data
						var hire = new Date(this.emp.hired)
						this.emp.hired = formatDate(hire) 
						var managerid = this.emp.managerid
						console.log(managerid)
						if(managerid==null) {
							this.emp.managerid = "";
							$("[name=managerid]").prop("readonly", true);
						}else{
							$("[name=managerid]").prop("readonly", false);
						}
						 Vue.nextTick(() => {
					            console.log("업데이트된 사원의 jobid:", this.emp.jobid); 
					            if (auth == 2 && this.emp.jobid < jobid) { // 권한등급이 2이고, 
					                console.log("조건 충족 - 등록 버튼 클릭");	   // 클릭한 사원 jobid가 세션jobid보다 낮을때
					                $("#regBtn").click();
					                $("#frm02")[0].reset();
					                $("#exampleModalLongTitle").text("사원 상세정보");
					                $("#empRegBtn").hide();
					                $("#empUptBtn").show();
					                $("#empDelBtn").show();ㄴ
					                $(".pwd").show();
					                $("#empno").show();
					                $("#frm02 [name=empno]").prop("readonly", true);
					                this.emp=response.data;
					            } else if (auth < 4 &&this.emp.jobid <= jobid) { // 권한등급이 4 미만이고,
					                console.log("관리자 - 상세 정보 확인 가능");		// 클릭한 사원 jobid가 세션jobid보다 낮거나 같을때
					                $("#regBtn").click();
					                $("#frm02")[0].reset();
					                $("#exampleModalLongTitle").text("사원 상세정보");
					                $("#empRegBtn").hide();
					                $("#empUptBtn").show();
					                $("#empDelBtn").show();
					                $(".pwd").show();
					                $("#empno").show();
					                $("#frm02 [name=empno]").prop("readonly", true);
					                this.emp=response.data;
					            }else if(auth>=4){ 	// 권한 등급이 4 이상일때
					            	$("#regBtn").click();
					            	$("#frm02")[0].reset();
					                $("#exampleModalLongTitle").text("사원 상세정보");
					                $("#empRegBtn").hide();
					                $("#empUptBtn").show();
					                $("#empDelBtn").show();
					                $(".pwd").show();
					                $("#empno").show();
					                $("#frm02 [name=empno]").prop("readonly", true);
					                this.emp=response.data;
					            }
					        });
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