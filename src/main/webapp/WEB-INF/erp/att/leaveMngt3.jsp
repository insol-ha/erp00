<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.util.*"
    %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>출결 내역</title>


<script src="https://unpkg.com/vue" type="text/javascript"></script>
<script src="https://developers.google.com/web/ilt/pwa/working-with-the-fetch-api" type="text/javascript"></script>
<script src="http://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>

 <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>



    <!-- Custom fonts for this template -->
    <link href="a00_com/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="a00_com/css/sb-admin-2.min.css" rel="stylesheet">

    <!-- Custom styles for this page -->
    <link href="a00_com/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">

</head>
<body id="page-top">

    <!-- Page Wrapper -->
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
   
   <!-- Begin Page Content -->
                <div class="container-fluid" id="app">

                    <!-- Page Heading -->
    <h1 class="h3 mb-2 text-gray-800"></h1>
<span class="mr-2 d-none d-lg-inline text-gray-600 small" id="jobid" 
style="display: none !important;">
    ${sesEmp.jobid}님
</span>         
   
<form id="frm22">
출결 조회:<input placeholder="출결 현황" name="content" value="${param.content}">
기간 선택:
<input type="date" placeholder="기간1" name="start" />
<input type="date" placeholder="기간2" name="end"/> 
직원 검색:<input placeholder="직원명" name="ename"/>
<button type="button" class="btn btn-danger" id="schBtn">검색</button> 
</form>

  <!-- DataTales Example -->
                    <div class="card shadow mb-4">
                        <div class="card-header py-3">
                            <h6 class="m-0 font-weight-bold text-primary">연차 현황 테이블</h6>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
<table class="table table-bordered" width="100%" cellspacing="0">
   <col width="10%">
         <col width="10%">
         <col width="10%">
         <col width="25%">
         <col width="25%">
         <col width="16%">
                    <thead>
                        <tr>
                        <th>아이디</th>
                            <th>사원번호</th>
                            <th>사원명</th>
                            <th>출근시간</th>
                            <th>퇴근시간</th>
                            <th>출결현황</th>
                        </tr>
                    </thead>
                    <tbody>
<c:forEach var="cal" items="${CalList}">
    <tr onclick="uptndel(${cal.id})">
    
       <td >${cal.id}</td>
       <td >${cal.empno}</td>
       <td>${cal.ename}</td>
        <td>
<fmt:formatDate value="${cal.start}" pattern="yyyy-MM-dd HH:mm"/> 
      </td>
        <td>
<fmt:formatDate value="${cal.end}" pattern="yyyy-MM-dd HH:mm"/>        
      </td>
       <td>${cal.content}</td>
    </tr> 
</c:forEach>  
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
    <a class="scroll-to-top rounded" href="#page-top">
        <i class="fas fa-angle-up"></i>
    </a>

    <!-- Logout Modal-->
    <div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Ready to Leave?</h5>
                    <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">Select "Logout" below if you are ready to end your current session.</div>
                <div class="modal-footer">
                    <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
                    <a class="btn btn-primary" href="login.html">Logout</a>
                </div>
            </div>
        </div>
        
    </div>
 <div id="showModal11"  data-toggle="modal" data-target="#exampleModalCenter"></div> 
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
           <input type="text" class="form-control" placeholder="직원명" name="ename">
         </div>
          <div class="col">
           <input type="text" class="form-control" placeholder="캘린더아이디" name="id">
         </div>
        </div>
               
        <div class="row">
         <div class="col">
           <input type="datetime-local" class="form-control" placeholder="시작일시" name="start" value="">
         </div>
         <div class="col">
            <input type="datetime-local" class="form-control"  placeholder="종료일시" name="end">
         </div>         
        </div>     
        <div class="row">
         <div class="col">
            <textarea name="content"  placeholder="내용입력"  rows="5" cols="10" class="form-control" ></textarea>
         </div>
        </div>    
        
        
         <div class="row">
         <div class="col">
          <input type="text" class="form-control" placeholder="사원번호" name="empno">
         </div>
        </div>      

        <button type="button" class="btn btn-primary" id="delBtn">삭제</button>
        
       </form>
        
    </div>

<script src="a00_com/vendor/jquery/jquery.min.js"></script> 
<!-- <script src="https://unpkg.com/vue" type="text/javascript"></script>
<script src="http://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script> -->

<script type="text/javascript">
 function formatDateForInput(dateString) {
if (!dateString) return ""; // 값이 없으면 빈 문자열 반환

const date = new Date(dateString);

if (isNaN(date.getTime())) {
    console.warn("Invalid date:", dateString);
    return "";
}
return date.toISOString().slice(0, 16);
}  

 function uptndel(id) {
   $("#showModal11").click() // 입력을 위한 모달이 로딩되게 처리
   
   var jobid = $("#jobid").text().trim(); // 텍스트 값 가져오기
   jobid = parseInt(jobid, 10);
   console.log("jobid 값:", jobid);

   if (jobid >= 103) {
       $("#delBtn").show();
   } else {
       $("#delBtn").hide();
   }
       empnoListAjax(id)
       
} 
//var jobid = $("#jobid").val(); (x)
   //(value가 없어 쓸려면 <span>data-jobid="${sesEmp.jobid}"사용)
 function empnoListAjax(id) { 
$.ajax({
        url: "/empnoListAjax", // #frm에 상세 정보 바인딩
        type: "post",
        data: {id:id}, // 데이터를 전송하도록 수정
       //data : $("#frm").serialize(),
        dataType: "json",
        success: function(data) {
            console.log("## id로 상세 정보 가져오기 ##",data);
            console.log(data);
            $("#frm [name=id]").val(data.id)
            $("#frm [name=empno]").val(data.empno)
            $("#frm [name=ename]").val(data.ename)
            $("#frm [name=start]").val(formatDateForInput(data.start))
            $("#frm [name=end]").val(formatDateForInput(data.end))
            $("#frm [name=content]").val(data.content) 
         },
        error: function(err) {
            console.log(err);
        }
    });
} 
$("#schBtn").click(function(){ 
CalListAjax2() 
})
function CalListAjax2() { // 카테고리 검색 ajax
$.ajax({
    url: "/CalListAjax2",
    type: "get",
    data:$("#frm22").serialize(),
   // dataType: "json",
    success: function (data) {
      console.log(data)
      
        var adHTML = "";
         $(data).each(function (idx, ename) {
            //console.log(`📌 처리 중인 데이터: ${JSON.stringify(ename)}`);
              adHTML += 
                     `<tr data-id="\${ename.id}">
                      <td>\${ename.id}</td>
                      <td>\${ename.empno}</td>
                       <td>\${ename.ename}</td>
                       
                     <td>\${formatDateForInput(ename.start)}</td>
                     <td>\${formatDateForInput(ename.end)}</td>
                       <td>\${ename.content}</td>
              </tr>`;
         })
         $("tbody").html(adHTML); 
         
         
         $("tbody").off("click", "tr").on("click", "tr", function () {
             let id = $(this).attr("data-id");  
             console.log("클릭한 ID:", id);
             if (id) uptndel(id); // id가 정상적으로 들어왔을 때만 함수 실행
         });
         console.log("Row HTML:", adHTML);

      },
    error: function (err) {
        console.log(err);
    }
});
}    

/*
$("#uptBtn").click(function(){ 
updatecAjax() 
})
function updatecAjax(){
$.ajax({
     url:"/updatecAjax",
     type:"get",
     data:$("#frm").serialize(),
     dataType:"json",
     success:function(data){
      console.log(data)
        alert(data.msg)
     
        $("#frm [name=id]").val(data.id)
        $("#frm [name=empno]").val(data.empno)
        $("#frm [name=ename]").val(data.ename)
        $("#frm [name=start]").val(formatDateForInput(data.start1))
        $("#frm [name=end]").val(formatDateForInput(data.end1))
        $("#frm [name=content]").val(data.content) 
        
     },
     error:function(err){
        console.log(err)
     }
  })      
}   */

 $("#delBtn").click(function(){ 
deletecAjax() 
})
function deletecAjax(){
$.ajax({
     url:"/deletecAjax",
     type:"get",
     data:$("#frm").serialize(),
     dataType:"json",
     success:function(data){
      console.log(data)
        alert(data.msg)
     
        $("#frm [name=id]").val(data.id)
        $("#frm [name=empno]").val(data.empno)
        $("#frm [name=ename]").val(data.ename)
        $("#frm [name=start]").val(formatDateForInput(data.start))
        $("#frm [name=end]").val(formatDateForInput(data.end))
        $("#frm [name=content]").val(data.content) 
        location.reload();
     },
     error:function(err){
        console.log(err)
     }
  })      
} 
$("#frm22").keyup(function(event) {
    if (event.which === 13) { // Enter 키 감지
        event.preventDefault(); // 폼의 기본 제출 동작 방지
        CalListAjax2(); // 검색 함수 실행
    }
});

</script>

    <!-- Bootstrap core JavaScript-->
    <script src="a00_com/vendor/jquery/jquery.min.js"></script>
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

</body>

</html>