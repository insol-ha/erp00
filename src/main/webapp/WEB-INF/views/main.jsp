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

</head>
<script src="a00_com/vendor/jquery/jquery.min.js"></script>
<script src="a00_com/vendor/bootstrap/js/bootstrap.bundle.min.js" defer></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<!-- Core plugin JavaScript-->
<script src="a00_com/vendor/jquery-easing/jquery.easing.min.js" defer></script>

<!-- Custom scripts for all pages-->
<script src="a00_com/js/sb-admin-2.min.js" defer></script>

<!-- Page level plugins -->
<script src="a00_com/vendor/datatables/jquery.dataTables.min.js" defer></script>
<script src="a00_com/vendor/datatables/dataTables.bootstrap4.min.js"
	defer></script>

<!-- Page level custom scripts -->
<script src="a00_com/js/demo/datatables-demo.js" defer></script>

<body id="page-top">
	<div id="wrapper">

		<!-- Sidebar -->
		<ul
			class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion"
			id="accordionSidebar">

			<c:import url="sidebar.jsp" />

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
					<c:import url="header.jsp" />


					<!-- Topbar Search -->

				</nav>
				<!-- End of Topbar -->

				<!-- Begin Page Content -->
				<div class="container-fluid">

					<!-- Page Heading -->

			 	<!-- <div id='calendar'></div>  -->
					<div
						class="d-sm-flex align-items-center justify-content-between mb-4">
						<!-- chart -->
						<div class="card shadow mb-4">
							<div class="card-header py-3">
								<h6 id="h6" class="m-0 font-weight-bold text-primary">CHART</h6>
								<div>
									<canvas id="myChart" style="width: 100%; height: 600px;"></canvas>
								</div>
								<script>
							var deptno = "${sesEmp.deptno}"
							var dname = "${sesEmp.dname}"
							$("#h6").text(dname+" 직원 실적");
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
					</div>

					<!-- Content Row -->
					

					<!-- Content Row -->
								
							</div>


						<div class="col-lg-6 mb-4">

							<!-- Illustrations -->


							<!-- Approach -->
	

						</div>
					</div>

				</div>
				<!-- /.container-fluid -->
				<form id="frm" class="form" method="post" style="display: none;">

					<input type="hidden" name="id" value="0" />
					<div class="row">
						<div class="col">
							<input type="text" class="form-control" placeholder="직원명"
								name="ename" value="${sesEmp.ename}" style="display: none;">
						</div>
					</div>
					<div class="row">
						<div class="col">
							<select class="form-control" style="display: none;" name="allDay">
								<option value="0">시간</option>
								<option value="1">종일</option>
							</select>
						</div>
					</div>
					<div class="row">
						<div class="col">
							<input type="text" class="form-control" placeholder="시작일시"
								name="start">
						</div>
						<div class="col">
							<input type="text" class="form-control" placeholder="종료일시"
								name="end">
						</div>
					</div>
					<div class="row">
						<div class="col">
							<textarea name="content" placeholder="내용입력" rows="5" cols="20"
								class="form-control"></textarea>
						</div>
					</div>
					<div class="row">
						<div class="col">
							<input type="color" style="display: none;" title="배경색상"
								class="form-control" name="backgroundColor" value="#0099cc">
						</div>
						<div class="col">
							<input type="color" style="display: none;" title="글자색상"
								class="form-control" name="textColor" value="#ccffff">
						</div>
					</div>

					<div class="row">
						<div class="col">
							<input type="text" class="form-control" placeholder="사원번호"
								name="empno" value="${sesEmp.empno}">
						</div>
					</div>
				</form>
			</div>
			<!-- End of Main Content -->

			<!-- Footer -->
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
	var selectedEvent = null;

	  document.addEventListener('DOMContentLoaded', function() {
		var calendarEl = document.getElementById('calendar');
		var toDay = new Date(); // javascript의 날짜 객체..(현재 날짜와 시간)
	    // 2024-12-03T12:30:25 ==> ISO 표준시간 표현방법 : fullcalendar api 
	    //alert(toDay.toISOString())
	    // 시간은 필요없고, 날짜만 추출할려면..
	    //toDay.toISOString().split("T") // ["2024-12-03","12:30:25"] 배열로 구분하여 담긴다.
	    // 최종적으로 활용할 날짜만 추출하기 위해..
	    var date = toDay.toISOString().split("T")[0] 
		var calendar = new FullCalendar.Calendar(calendarEl, {
	      headerToolbar: {
	        left: 'prev,next today',
	        center: 'title',
	        right: 'dayGridMonth,timeGridWeek,timeGridDay'
	      },
	      initialDate: date,
	      navLinks: true, // can click day/week names to navigate views
	      selectable: true,
	      selectMirror: true,
	      locale: 'ko' ,
	      
	   	select: function(event) {
			$("#showModal").click() // 입력을 위한 모달이 로딩되게 처리..
			$("#StartBtn").show();
			$("#leaveBtn").show();
			$("#ptoBtn").show();
			$("#wfhBtn").show();
			$("#uptBtn").hide();
			$("#delBtn").hide()
			$("#EndBtn").hide()
			$("#modalTitle").text("일정등록")
		
			selectedEvent = event;
			addForm(event, 'I')  // 입력모달/상세모달이 같은 form에 의해 처리되기에 구분..(공통함수이용)
	        calendar.unselect()
	      },
	      eventClick: function(arg) {
	  		$("#showModal").click() // 입력을 위한 모달이 로딩되게 처리..
			$("#regBtn").hide();
			$("#StartBtn").hide();
			$("#leaveBtn").hide();
			$("#wfhBtn").hide();
			$("#ptoBtn").hide();
	  		$("#EndBtn").show();
	  		$("#delBtn").show()
			$("#modalTitle").text("일정상세")
			addForm(arg.event, 'D')
	      },
	      editable: false,
	      dayMaxEvents: true, // allow "more" link when too many events
	      
	     events:function(info, successCallback, failureCallback){
	    	$.ajax({
				url:"enamecalAjax",
				data: { ename: "${sesEmp.ename}" },
				dataType:"json",
				success:function(calList){
	            	console.log("# 게시판 프로젝트 #")
	            	console.log(calList)
					successCallback(calList)
	    		},
				error:function(err){
					console.log(err)
					failureCallback(err)
				}
			})
		}
	    }); 
	   calendar.render();
	    
	    /* $("#StartBtn").click(function(){
			if(confirm("출근 찍으시겠습니까?")){
		//$("#modalTitle").text("등록")
	          var eventStart = new Date(selectedEvent.startStr); 
	          var today = new Date();

	       // 오늘 날짜의 시간을 00:00:00으로 설정
	          today.setHours(0, 0, 0, 0);
	          eventStart.setHours(0, 0, 0, 0);

	          // 출근 날짜가 오늘이 아닌 경우 경고
	          if (eventStart.getTime() !== today.getTime()) {
	              alert("출근은 당일에만 찍을 수 있습니다.");
	              return;  
	          }
		  $("[name=start]").val(selectedEvent.startStr);
	          $("[name=end]").val(selectedEvent.endStr);
				BtnAjax2("uptStartAjax") // 출근 찍기		 
			}
	    })  */
	   
	    $("#delBtn").click(function(){
			if(confirm("일정 삭제 하시겠습니까?")){
				callAjax2("deleteCalAjax") // 일정 삭제
			}
	    })
	      $("#EndBtn").click(function(){
	    	  if(confirm("퇴근 찍으시겠습니까?")){
	    		  BtnAjax("uptEndAjax") // 퇴근 찍기
	  		}
	})

	/* $("#ptoBtn").click(function(){
		if(confirm("시차 신청하시겠습니까?")){ // 시차 등록
			uptUsedHAjax()		
		}
	}); */
		$("#wfhBtn").click(function () {
		    if (confirm("재택 신청하시겠습니까?")) { // 재택 신청
				 var eventStart = new Date(selectedEvent.startStr); 
		           var today = new Date();
					today.setHours(0, 0, 0, 0);
		           eventStart.setHours(0, 0, 0, 0);
					if (eventStart.getTime() < today.getTime()) {
		               alert("오늘 이전 날짜라 찍을 수 없습니다.");
		               return;  
		           } 
		        UsedAjax2();    	
	 }
	});
	   $("#leaveBtn").click(function() { // 연차 신청
	       if (selectedEvent == null) {
	           alert("일정을 선택해주세요.");
	           return;
	       }
			if (confirm("연차 신청하시겠습니까?")) {
			   $("#modalTitle").text("연차등록")
	           var eventStart = new Date(selectedEvent.startStr);  // 선택한 시작 날짜
	           var today = new Date();

	           // 5일 후 날짜 계산
	           var minDate = new Date(today);
	           minDate.setDate(today.getDate() + 5);  // 현재 날짜에서 5일 후로 설정

	           // event.start가 최소 5일 후 날짜보다 이전이면 알림을 띄우고 신청하지 않도록 함
	           if (eventStart < minDate) {
	               alert("연차는 최소 5일 전에 신청해야 합니다.");
	               return;  // 연차 신청을 진행하지 않음
	           }
				// 연차 신청 진행
	           $("[name=start]").val(selectedEvent.startStr);
	           $("[name=end]").val(selectedEvent.endStr);
	             UsedAjax(); 
	       }
	   }); 
	 
	   function BtnAjax(){ // 퇴근 찍기
		   var formData = $("#frm").serialize(); // 폼 데이터 직렬화
			$.ajax({
		        url: "/uptEndAjax",
		        type: "get",
		        data: formData, // 데이터를 전송하도록 수정
		        dataType: "json",
		        success: function(data) {
		            console.log("## CUD 이후 ##");
		            alert(data.msg);
		            calendar.removeAllEvents();
		            calendar.addEventSource(data.list);
		        },
		        error: function(err) {
		            console.log(err);
		        }
		    });
		}
	/*    
	   function BtnAjax2(){ // 출근 찍기
		   var formData = $("#frm").serialize(); // 폼 데이터 직렬화
			$.ajax({
		        url: "/uptStartAjax",
		        type: "post",
		        data: formData, // 데이터를 전송하도록 수정
		        dataType: "json",
		        success: function(data) {
		            console.log("## CUD 이후 ##");
		            alert(data.msg);
		            calendar.removeAllEvents();
		            calendar.addEventSource(data);
		            location.reload();
		        },
		        error: function(err) {
		            console.log(err);
		        }
		    });
		} */
	    function UsedAjax() { // 연차 차감 ajax
	        var ename = $("[name=ename]").val();  // 직원명 가져오기
	        if (!ename) {
	            alert("직원명을 입력해주세요.");
	            return;
	        }
			$.ajax({
	            url: "/uptUsedAjax?ename=" + encodeURIComponent(ename),  // 인코딩 처리
	            type: "get",
	            dataType: "json",
	            success: function (data) {
	                console.log("## 서버 응답 ##", data);

	                console.log(data.msg.indexOf("변경 성공"));
	                console.log(data.msg.indexOf("변경 성공")>=0);
	                
	                
	                if(data.msg.indexOf("변경 성공")>=0){
	                	//alert("일정등록시작1")
	                	callAjax();	
	                	
					}else{
						alert(data.msg);
					}
	                
	                calendar.removeAllEvents();
	                calendar.addEventSource(data.list);
	            },
	            error: function (err) {
	                console.log("AJAX 요청 실패", err);
	            }
	        });
	    }
	    
	   /*  function uptUsedHAjax() { // 시차 차감 ajax
	        var ename = $("[name=ename]").val();  // 직원명 가져오기
	        if (!ename) {
	            alert("직원명을 입력해주세요.");
	            return;
	        }
			$.ajax({
	            url: "/uptUsedHAjax?ename=" + encodeURIComponent(ename),  // 인코딩 처리
	            type: "get",
	            dataType: "json",
	            success: function (data) {
	                console.log("## 서버 응답 ##", data);

	                console.log(data.msg.indexOf("시차 변경 성공"));
	                console.log(data.msg.indexOf("시차 변경 성공")>=0);
	                
	                if(data.msg.indexOf("시차 변경 성공")>=0){
	                	//alert("일정등록시작1")
	                	callAjax4();	
	                }else{
						alert(data.msg);
					}
	                
	                calendar.removeAllEvents();
	                calendar.addEventSource(data.list);
	            },
	            error: function (err) {
	                console.log("AJAX 요청 실패", err);
	            }
	        });
	    } */
	function UsedAjax2() { // 재택 차감 ajax
	        var ename = $("[name=ename]").val();  // 직원명 가져오기
	        var formData = $("#frm").serialize();  // 직원명 가져오기
	        if (!ename) {
	            alert("직원명을 입력해주세요.");
	            return;
	        }
			 $.ajax({
	            url: "/uptUsedWAjax?ename=" + encodeURIComponent(ename), 
	            type: "get",
	            date: formData,
	            dataType: "json",
	            success: function (data) {
	                console.log("## 서버 응답 ##", data);
					console.log(data.msg.indexOf("변경 성공"));
	                console.log(data.msg.indexOf("변경 성공")>=0);
	                if(data.msg.indexOf("변경 성공")>=0){
	                	callAjax3();	
	                }else{
						alert(data.msg);
					}
	                calendar.removeAllEvents();
	                calendar.addEventSource(data.list);
	            },
	            error: function (err) {
	                console.log("AJAX 요청 실패", err);
	            }
	        });
	    }
		function callAjax() { // 일정 등록
	    	 var formData = $("#frm").serialize(); // 폼 데이터 직렬화
				$.ajax({
	    	        url: "/insertCalAjax",
	    	        type: "post",
	    	        data: formData, // 데이터를 전송하도록 수정
	    	        dataType: "json",
	    	        success: function(data) {
	    	            console.log("## CUD 이후 ##");
	    	            alert(data.msg);
	    	            calendar.removeAllEvents();
	    	            calendar.addEventSource(data.list);
	    	        },
	    	        error: function(err) {
	    	            console.log(err);
	    	        }
	    	    });
	    	}
		function callAjax3() { // 재택 신청
	   	 var formData = $("#frm").serialize(); 
				$.ajax({
	   	        url: "/inswfhAjax",
	   	        type: "post",
	   	        data: formData, // 데이터를 전송하도록 수정
	   	        dataType: "json",
	   	        success: function(data) {
	   	            console.log("## CUD 이후 ##");
	   	            alert(data.msg);
	   	            calendar.removeAllEvents();
	   	            calendar.addEventSource(data.list);
	   	        },
	   	        error: function(err) {
	   	            console.log(err);
	   	        }
	   	    });
	   	}
	    function callAjax2(loc){
			alert("아이디:"+$("[name=id]").val())
			alert(loc)
			$.ajax({
				url:loc,
				type:"post",
				data:$("#frm").serialize(),
				dataType:"json",
				success:function(data){
				
					console.log("## 삭제 이후 ##")
					alert(data.msg)	
					/// 데이터 재 랜더링...
					calendar.removeAllEvents()
					calendar.addEventSource(data)
					location.reload();
				},
				error:function(err){
					console.log(err)
				}
			})
	    }
	  });
	  
	  function callAjax4() {
	 	 var formData = $("#frm").serialize(); // 폼 데이터 직렬화
				$.ajax({
	 	        url: "/insHourAjax",
	 	        type: "post",
	 	        data: formData, // 데이터를 전송하도록 수정
	 	        dataType: "json",
	 	        success: function(data) {
	 	            console.log("## CUD 이후 ##");
	 	            alert(data.msg);
	 	            calendar.removeAllEvents();
	 	            calendar.addEventSource(data.list);
	 	        },
	 	        error: function(err) {
	 	            console.log(err);
	 	        }
	 	    });
	 	}
	  
	  function addForm(event, proc){
		$("#frm")[0].reset() // form데이터 초기화
		$("[name=start]").val(event.startStr)
		 if(event.end==null){  // 마지막날짜가 없는 경우
			$("[name=end]").val(event.startStr)
	    }else{
	    	$("[name=end]").val(event.endStr)
	    }  
	    
		$("[name=allDay]").val(event.allDay?0:1);// event.allDay true일 때, 1 그외는 0	
		if(proc=="D"){ // 등록된 일정을 클릭시에서 그외 정보도 할당해야 한다. 그래서 구분..
			$("[name=id]").val(event.id)
			//$("[name=title]").val(event.title)
			$("[name=backgroundColor]").val(event.backgroundColor)
			$("[name=textColor]").val(event.textColor)
			$("[name=content]").val(event.extendedProps.content)
			$("[name=ename]").val(event.extendedProps.ename)
			$("[name=empno]").val(event.extendedProps.empno)
		}
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
