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

    <title>연차 관리 페이지</title>


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
                    <h1 class="h3 mb-2 text-gray-800">연차 관리 및 사용 현황</h1>
                 <!--    <p class="mb-4">연차 사용 현황 <a target="_blank"
                            href="https://datatables.net">##</a>.</p> -->
<button type="button" class="btn btn-primary" id="resetBtn" >연차 초기화</button>



<span class="mr-2 d-none d-lg-inline text-gray-600 small" id="jobid" 
style="display: none !important;">
    ${sesEmp.jobid}님
</span>



                    <!-- DataTales Example -->
                    <div class="card shadow mb-4">
                        <div class="card-header py-3">
                            <h6 class="m-0 font-weight-bold text-primary">연차 현황 테이블</h6>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
<table class="table table-bordered" width="100%" cellspacing="0">
                    <thead>
                        <tr>
                            <th>사원번호</th>
                            <th>사원명</th>
                            <th>기준 연차 개수</th>
                            <th>기준 재택 개수</th>
                            <th>사용한 연차</th>
                            <th>사용한 재택</th>
                            <th>미사용한 연차</th>
                        </tr>
                    </thead>
                    <tbody>
                       
                    </tbody>
                  </table>
                            </div>
                        </div>
                    </div>

                </div>
                <!-- /.container-fluid -->
                
			</div>
            <!-- End of Main Content -->
<canvas id="myChart"></canvas>
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
    
    
   
    
    
    <script>
    $(document).ready(function () {
        $.ajax({
            url: "/ChartListAjax", // 서버에서 데이터 가져옴
            type: "GET",
            success: function(response) {
                console.log("차트 데이터:", response);

                // DB에서 가져온 데이터 가공
                var labels = [];
                var rawData = [];

        response.forEach(row => {
		  var usedPto = row.usedpto || 0; // 사용한 연차 (undefined면 0으로 대체)
          var totalPto = row.pto || 0; // 전체 연차
          var unusedPto = totalPto - usedPto; // 미사용 연차
		

                	labels.push(row.ename); // 직원명
                    rawData.push([row.usedpto, (row.pto-row.usedpto)]); // 사용한 연차, 미사용 연차
                });

                // 차트 생성
                createChart(labels, rawData);
            },
            error: function(error) {
                console.log("에러 발생:", error);
            }
        });

        function createChart(labels, rawData) {
            var ctx = document.getElementById('myChart').getContext('2d');

            var percentageData = rawData.map(row => {
                var total = row.reduce((a, b) => a + b, 0);
                return row.map(value => (value / total) * 100);
            });

            new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: labels, // Y축 직원명 리스트
                    datasets: [
                        {
                            label: '사용한 연차',
                            data: percentageData.map(row => row[0]), 
                            backgroundColor: 'rgb(199,159,223)',
                            stack: 'stacked', 
                        },
                        {
                            label: '미사용 연차',
                            data: percentageData.map(row => row[1]), 
                            backgroundColor: 'rgb(201,238,164)',
                            stack: 'stacked',
                        }
                    ]
                },
                options: {
                    indexAxis: 'y',
                    responsive: true,
                    plugins: {
                        legend: { display: true },
                        tooltip: {
                            callbacks: {
                                label: function (context) {
                                    let value = context.raw.toFixed(1);
                                    return `${context.dataset.label}: ${value}%`;
                                }
                            }
                        }
                    },
                    scales: {
                        x: {
                            stacked: true,
                            max: 100,
                            ticks: {
                                callback: function (value) {
                                    return value + '%';
                                }
                            }
                        },
                        y: { stacked: true }
                    }
                }
            });
        }
    });
</script>
<script src="a00_com/vendor/jquery/jquery.min.js"></script> 
<script src="https://unpkg.com/vue" type="text/javascript"></script>
<script src="http://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>

<script type="text/javascript">
leaveList()
function leaveList(){
	$.ajax({
		url:"/leaveAjax",
		type:"get",
		dataType:"json",
		success:function(data){        			        				
			var addHTML=""
			$(data).each(function(idx, att){
				addHTML+=`<tr>
							  <td>\${att.empno}</td>
							  <td>\${att.ename}</td>
							  <td>\${att.pto}</td>
							  <td>\${att.wfh}</td>
							  <td>\${att.usedpto}</td>
							  <td>\${att.usedwfh}</td>
							  <td>\${att.pto-att.usedpto}</td>
							  `
			})
			console.log(addHTML)
			$("tbody").html(addHTML)
		},
		error:function(err){
			console.log(err)
		}
	})	
}            
function uptAjax() {
    $.ajax({
        url: "/uptUsedptoAjax",
        type: "get",
        data:$("#frm02").serialize(),
        dataType: "json",
        success: function (data) {
			console.log(data.msg)
        	leaveList(); // 목록 갱신
         },
        error: function (err) {
            console.log(err);
        }
    });
}

$("#resetBtn").click(function(){
	if(confirm("초기화 하시겠습니까?")){
		uptAjax()
		alert("초기화 성공")
		leaveList()
		location.reload();
	}
})
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