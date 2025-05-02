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
<style type="text/css">
.btn-coffee {
    color: #fff;
    background-color: #DAA520;
    border-color: #DAA520;
}
</style>
</head>

<body>

   <!-- Sidebar Toggle (Topbar) -->
   <button id="sidebarToggleTop"
      class="btn btn-link d-md-none rounded-circle mr-3">
      <i class="fa fa-bars"></i>
   </button>

   <!-- Topbar Search -->
   <!-- <form
      class="d-none d-sm-inline-block form-inline mr-auto ml-md-3 my-2 my-md-0 mw-100 navbar-search">
      <div class="input-group">
         <input type="text" class="form-control bg-light border-0 small"
            placeholder="Search for..." aria-label="Search"
            aria-describedby="basic-addon2">
         <div class="input-group-append">
            <button class="btn btn-coffee" type="button">
               <i class="fas fa-search fa-sm"></i>
            </button>
         </div>
      </div>
   </form> -->
   
<button type="button" class="btn btn-success" id="Start2Btn">출근 찍기</button> 
<button type="button" class="btn btn-primary" id="End2Btn">퇴근 찍기</button>
&ensp;<span id="Att"></span> 

<button type="button" class="btn btn-primary" id="re" onclick="location.reload()" 
   style="display:none;"></button>





   <!-- Topbar Navbar -->

   <ul class="navbar-nav ml-auto">
   <li class="nav-item dropdown no-arrow d-sm-none"><a
         class="nav-link dropdown-toggle" href="#" id="searchDropdown"
         role="button" data-toggle="dropdown" aria-haspopup="true"
         aria-expanded="false"> <i class="fas fa-search fa-fw"></i>
      </a> Dropdown - Messages
         <div
            class="dropdown-menu dropdown-menu-right p-3 shadow animated--grow-in"
            aria-labelledby="searchDropdown"> 
         <form class="form-inline mr-auto w-100 navbar-search">
               <div class="input-group">
                  <input type="text" class="form-control bg-light border-0 small"
                     placeholder="Search for..." aria-label="Search"
                     aria-describedby="basic-addon2">
                  <div class="input-group-append">
                     <button class="btn btn-coffee" type="button">
                        <i class="fas fa-search fa-sm"></i>
                     </button>
                  </div>
               </div>
            </form> 
         </div></li>

      <!-- Nav Item - Alerts -->
      <li class="nav-item dropdown no-arrow mx-1"><a
         class="nav-link dropdown-toggle" href="#" id="alertsDropdown"
         role="button" data-toggle="dropdown" aria-haspopup="true"
         aria-expanded="false"> <i class="fas fa-bell fa-fw"></i> <!-- Counter - Alerts -->
            <span class="badge badge-danger badge-counter">3+</span>
      </a> <!-- Dropdown - Alerts -->
         <div
            class="dropdown-list dropdown-menu dropdown-menu-right shadow animated--grow-in"
            aria-labelledby="alertsDropdown">
            <h6 class="dropdown-header">Alerts Center</h6>
            <a class="dropdown-item d-flex align-items-center" href="#">
               <div class="mr-3">
                  <div class="icon-circle bg-primary">
                     <i class="fas fa-file-alt text-white"></i>
                  </div>
               </div>
               <div>
                  <div class="small text-gray-500">December 12, 2019</div>
                  <span class="font-weight-bold">A new monthly report is
                     ready to download!</span>
               </div>
            </a> <a class="dropdown-item d-flex align-items-center" href="#">
               <div class="mr-3">
                  <div class="icon-circle bg-success">
                     <i class="fas fa-donate text-white"></i>
                  </div>
               </div>
               <div>
                  <div class="small text-gray-500">December 7, 2019</div>
                  $290.29 has been deposited into your account!
               </div>
            </a> <a class="dropdown-item d-flex align-items-center" href="#">
               <div class="mr-3">
                  <div class="icon-circle bg-warning">
                     <i class="fas fa-exclamation-triangle text-white"></i>
                  </div>
               </div>
               <div>
                  <div class="small text-gray-500">December 2, 2019</div>
                  Spending Alert: We've noticed unusually high spending for your
                  account.
               </div>
            </a> <a class="dropdown-item text-center small text-gray-500" href="#">Show
               All Alerts</a>
         </div></li>

      <!-- Nav Item - Messages -->
      <li class="nav-item dropdown no-arrow mx-1"><a
         class="nav-link dropdown-toggle" href="#" id="messagesDropdown"
         role="button" data-toggle="dropdown" aria-haspopup="true"
         aria-expanded="false"> <i class="fas fa-envelope fa-fw"></i> <!-- Counter - Messages -->
            <span class="badge badge-danger badge-counter">7</span>
      </a> <!-- Dropdown - Messages -->
         <div
            class="dropdown-list dropdown-menu dropdown-menu-right shadow animated--grow-in"
            aria-labelledby="messagesDropdown">
            <h6 class="dropdown-header">Message Center</h6>
            <a class="dropdown-item d-flex align-items-center" href="#">
               <div class="dropdown-list-image mr-3">
                  <img class="rounded-circle" src="a00_com/img/undraw_profile_1.svg"
                     alt="...">
                  <div class="status-indicator bg-success"></div>
               </div>
               <div class="font-weight-bold">
                  <div class="text-truncate">Hi there! I am wondering if you
                     can help me with a problem I've been having.</div>
                  <div class="small text-gray-500">Emily Fowler · 58m</div>
               </div>
            </a> <a class="dropdown-item d-flex align-items-center" href="#">
               <div class="dropdown-list-image mr-3">
                  <img class="rounded-circle" src="a00_com/img/undraw_profile_2.svg"
                     alt="...">
                  <div class="status-indicator"></div>
               </div>
               <div>
                  <div class="text-truncate">I have the photos that you
                     ordered last month, how would you like them sent to you?</div>
                  <div class="small text-gray-500">Jae Chun · 1d</div>
               </div>
            </a> <a class="dropdown-item d-flex align-items-center" href="#">
               <div class="dropdown-list-image mr-3">
                  <img class="rounded-circle" src="a00_com/img/undraw_profile_3.svg"
                     alt="...">
                  <div class="status-indicator bg-warning"></div>
               </div>
               <div>
                  <div class="text-truncate">Last month's report looks great,
                     I am very happy with the progress so far, keep up the good work!</div>
                  <div class="small text-gray-500">Morgan Alvarez · 2d</div>
               </div>
            </a> <a class="dropdown-item d-flex align-items-center" href="#">
               <div class="dropdown-list-image mr-3">
                  <img class="rounded-circle"
                     src="https://source.unsplash.com/Mv9hjnEUHR4/60x60" alt="...">
                  <div class="status-indicator bg-success"></div>
               </div>
               <div>
                  <div class="text-truncate">Am I a good boy? The reason I ask
                     is because someone told me that people say this to all dogs, even
                     if they aren't good...</div>
                  <div class="small text-gray-500">Chicken the Dog · 2w</div>
               </div>
            </a> <a class="dropdown-item text-center small text-gray-500" href="#">Read
               More Messages</a>
         </div></li>

      <div class="topbar-divider d-none d-sm-block"></div>

      <!-- Nav Item - User Information -->

      <p style="font-size: 12px;">
         자동 로그아웃까지 남은 시간: <span id="timer">30:00</span><br>
         <button class="btn btn-coffee btn-icon-split btn-sm" id="extend">
            <span class="icon text-white-50"> <i class="fas fa-flag"></i>
            </span> <span class="text">연장</span>
         </button>
      </p>

      <li class="nav-item dropdown no-arrow"><a
         class="nav-link dropdown-toggle" href="#" id="userDropdown"
         role="button" data-toggle="dropdown" aria-haspopup="true"
         aria-expanded="false"> 
         <span class="mr-2 d-none d-lg-inline text-gray-600 small">${sesEmp.ename}님</span>
          <img class="img-profile rounded-circle"
            src="a00_com/img/undraw_profile.svg">
      </a> <!-- Dropdown - User Information -->
         <div
            class="dropdown-menu dropdown-menu-right shadow animated--grow-in"
            aria-labelledby="userDropdown">
            <a class="dropdown-item" href="erpProfile?empno=${sesEmp.empno}">
               <i class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i> 프로필
            </a>
            <div class="dropdown-divider"></div>
            <a class="dropdown-item" href="#" data-toggle="modal"
               data-target="#logoutModal"> <i
               class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
               로그아웃
            </a>
         </div></li>

   </ul>

   <div class="modal fade" id="logoutModal" tabindex="-1" role="dialog"
      aria-labelledby="exampleModalLabel" aria-hidden="true">
      <div class="modal-dialog" role="document">
         <div class="modal-content">
            <div class="modal-header">
               <h5 class="modal-title" id="exampleModalLabel">정말 로그아웃 하시겠습니까?</h5>
               <button class="close" type="button" data-dismiss="modal"
                  aria-label="Close">
                  <span aria-hidden="true">×</span>
               </button>
            </div>
            <div class="modal-body">"로그아웃"을 눌러서 현재 세션을 종료합니다.</div>
            <div class="modal-footer">
               <button class="btn btn-secondary" type="button"
                  data-dismiss="modal">취소</button>
               <a class="btn btn-primary" href="/logout" id="logout">로그아웃</a>
            </div>
         </div>
      </div>
   </div>
   
   
   <!--  <div id='calendar' style="display: none;"></div>  -->
   <!-- 모달 로딩 요소객체 --> 
  <div id="showModal2"  data-toggle="modal" data-target="#exampleModalCenter2"></div> 
<div class="modal fade" id="exampleModalCenter2" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
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
      <button type="button" class="btn btn-warning" id="wfhBtn">재택 등록</button>
   <button type="button" class="btn btn-primary" id="leaveBtn">연차 등록</button>
   <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>    
      </div>
    </div>
  </div>
</div>
   
   
   

   <!-- Bootstrap core JavaScript-->
   <script type="text/javascript">
      var empno = "${sesEmp.empno}"
      if(empno==null||empno==0){
         alert("로그인 후 사용해주세요")
         location.href="/prjLogin"
      }
      var logoutTimer;
      var countdown = 30 * 60; // 30분 (초 단위)
      var countdownInterval;

      function formatTime(seconds) {
         var minutes = Math.floor(seconds / 60);
         var secs = seconds % 60;
         return ((minutes < 10 ? "0" : "") + minutes + ":"
               + (secs < 10 ? "0" : "") + secs);
      }

      function startCountdown() {
         clearInterval(countdownInterval);
         countdownInterval = setInterval(function() {
            countdown--;
            $("#timer").text(formatTime(countdown));
            if (countdown <= 0) {
               clearInterval(countdownInterval);
            }
         }, 1000); // 1초마다 감소
      }

      function resetLogoutTimer() {
         clearTimeout(logoutTimer);
         clearInterval(countdownInterval);
         countdown = 30 * 60; // 30분 초기화
         $("#timer").text(formatTime(countdown));
         startCountdown();

         logoutTimer = setTimeout(function() {
            alert("30초 동안 활동이 없어 자동 로그아웃됩니다.");
            $("#logout")[0].click(); // 순수 JavaScript 클릭 실행
         }, 30 * 60 * 1000); // 30초 후 로그아웃
      }
      // "연장" 버튼 클릭 시 타이머 초기화
      $("#extend").on("click", function() {
         resetLogoutTimer();
      });

      // 로그아웃 버튼 클릭 이벤트

      // 초기 타이머 시작
      resetLogoutTimer();
   </script>
   
<script type="text/javascript">

function loadAtt() {
    var ename = "${sesEmp.ename}"; // 세션에서 로그인한 직원명 가져오기
   $.ajax({
        url: "contentcalAjax",
        type: "GET",
        data: { ename: ename },
        success: function(response) {
           var today = new Date();
            var formattedDate = today.toISOString().split("T")[0];
            // true시 content를 가져오고 false시 출근 전
            var attendanceStatus = response ? response : "출근 전";
            
            $("#Att").text(formattedDate+" 출결 상태 : "+attendanceStatus); // 결과를 표시
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
   console.log("출근 버튼 클릭됨");
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
      location.href="/main";   
}
})  

$("#End2Btn").click(function(){
   console.log("퇴근 버튼 클릭됨");
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
      location.href="/main";


   }
})

  $("#EndBtn").click(function(){
     if(confirm("퇴근 찍으시겠습니까?")){
        BtnAjax() // 퇴근 찍기     
      }
})

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
               location.href="/main";

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
               
            },
           error: function(err) {
               console.log(err);
           }
       });
   }
</script>
</body>
</html>
