<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.util.*"
    %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>

<!DOCTYPE html>
<html>
<head>
<meta charset='utf-8' />

<link href='a00_com/lib/main.css' rel='stylesheet' />
<link href="a00_com/bootstrap.min.css" rel="stylesheet" >
<script src="a00_com/jquery.min.js"></script>
<script src="a00_com/bootstrap.min.js"></script>
<script src='a00_com/lib/main.js'></script>
<script>
	var selectedEvent = null;

  document.addEventListener('DOMContentLoaded', function() {

	var calendarEl = document.getElementById('calendar');
	var toDay = new Date(); 
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
		//$("#leaveBtn").show();
		//$("#ptoBtn").show();
		//$("#wfhBtn").show();
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
   
   function loadAtt() {
	    var ename = "${sesEmp.ename}"; // 세션에서 로그인한 직원명 가져오기
		$.ajax({
	        url: "contentcalAjax",
	        type: "GET",
	        data: { ename: ename },
	        success: function(response) {
	            $("#Att").text(response); // 결과를 표시
	        },
	        error: function(err) {
	            console.log("출결 상태 로딩 실패", err);
	            $("#Att").text("출결 상태를 가져오지 못했습니다.");
	        }
	    });
	}
	$(document).ready(function() {
	    loadAtt(); // 페이지 로드 시 자동 호출
	});

   
   $("#Start2Btn").click(function(){
		if(confirm("출근 찍으시겠습니까?")){

			var today = new Date();
	        var formattedDate = today.toISOString().split("T")[0]; // YYYY-MM-DD 형식

	        // 캘린더에서 오늘 날짜를 선택한 것처럼 처리
	        selectedEvent = {
	            startStr: formattedDate,
	            endStr: formattedDate,
	            allDay: true
	        };
			$("[name=start]").val(formattedDate);
        	$("[name=end]").val(formattedDate);
			BtnAjax2() // 출근 찍기		 
}
    })  

   $("#End2Btn").click(function(){
		if(confirm("퇴근 찍으시겠습니까?")){
			var today = new Date();
	        var formattedDate = today.toISOString().split("T")[0]; // YYYY-MM-DD 형식

	        // 캘린더에서 오늘 날짜를 선택한 것처럼 처리
	        selectedEvent = {
	            startStr: formattedDate,
	            endStr: formattedDate,
	            allDay: true
	        };
			//$("#showModal").click() // 입력을 위한 모달이 로딩되게 처리..
			//$("#modalTitle").text("퇴근 찍기")
			$("[name=start]").val(formattedDate);
        	$("[name=end]").val(formattedDate);
        	BtnAjax() // 퇴근 찍기		 
		}
})
    
      $("#EndBtn").click(function(){
    	  if(confirm("퇴근 찍으시겠습니까?")){
    		  BtnAjax() // 퇴근 찍기
  		}
})
 $("#delBtn").click(function(){
		if(confirm("일정 삭제 하시겠습니까?")){
			callAjax2("deleteCalAjax") // 일정 삭제
		}
    }) 

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
	            calendar.addEventSource(data);
	            location.reload();
	            
	        },
	        error: function(err) {
	            console.log(err);
	        }
	    });
	}
   
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
	}
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
<style>
  body {
    margin: 40px 10px;
    padding: 0;
    font-family: Arial, Helvetica Neue, Helvetica, sans-serif;
    font-size: 14px;
  }
  #calendar {
    max-width: 1100px;
    margin: 0 auto;
  }
</style>
</head>
<body>

 <div id="wrapper">

      <!-- Sidebar -->
        <ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">

           <c:import url="/WEB-INF/views/sidebar.jsp" />

        </ul>
        <!-- End of Sidebar -->

        <!-- Content Wrapper -->
        <div id="content-wrapper" class="d-flex flex-column">

            <!-- Main Content -->
            <div id="content">

                <!-- Topbar -->
                <nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">

                    <!-- Sidebar Toggle (Topbar) -->
					<c:import url="/WEB-INF/views/header.jsp" />
                    <!-- Topbar Search -->

                </nav>
				<!-- End of Topbar --> 
				
<button type="button" class="btn btn-success" id="Start2Btn">출근 찍기</button> 
<button type="button" class="btn btn-primary" id="End2Btn">퇴근 찍기</button>
<br>
출결 상태 : <h6 id="Att"></h6>
<div id='calendar' style="display: none;"></div>

</div>
 <!-- 모달 로딩 요소객체 --> 
  <div id="showModal"  data-toggle="modal" data-target="#exampleModalCenter"></div> 
<div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="modalTitle">타이틀</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
		<form id="frm" class="form"  method="post">
		 	<input type="hidden" name="id" value="0"/>
	     <div class="row">
	      <div class="col">
	        <input type="text" class="form-control" placeholder="직원명" 
	        name="ename" value="${sesEmp.ename}">
	      </div>
	     </div>
	     <div class="row">
	   <div class="col">
	      	<select class="form-control" style="display: none;" name="allDay" >
	      		<option value="0">시간</option>
	      		<option value="1">종일</option>	      		
	      	</select>
	      </div>
	     </div> 	     
	     <div class="row">
	      <div class="col">
	        <input type="text" class="form-control" placeholder="시작일시" name="start">
	      </div>
	      <div class="col">
	      	<input type="text" class="form-control"  placeholder="종료일시" name="end">
	      </div>	      
	     </div>	  
	     <div class="row">
	      <div class="col">
	      	<textarea name="content"  placeholder="내용입력"  rows="5" cols="20" class="form-control" ></textarea>
	      </div>
	     </div>	 
	     <div class="row">
	      <div class="col">
	        <input type="color" style="display: none;" title="배경색상" class="form-control" name="backgroundColor" value="#0099cc"> 
	      </div>
	      <div class="col">
	      	<input type="color" style="display: none;" title="글자색상"  class="form-control" name="textColor"  value="#ccffff">
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
      <div class="modal-footer">


   <button type="button" class="btn btn-primary" id="StartBtn">출근 찍기</button>
   <button type="button" class="btn btn-warning" id="delBtn">삭제</button> 
   <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>    
      </div>
    </div>
  </div>
</div>   
</body>
</html>
