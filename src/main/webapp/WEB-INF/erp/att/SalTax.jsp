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
<style>
#saltable {
    width: 80%;
    margin: 20px auto;
    border-collapse: collapse;
    border: 1px solid #ddd;
    background-color: #fff;
    box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
}

#saltable th, #saltable td {
    border: 1px solid #ddd;
    padding: 12px;
    text-align: center; /* 가로 중앙 정렬 */
    vertical-align: middle; /* 세로 중앙 정렬 */
}
#saltable th {
    background-color: #007bff;
    color: white;
    font-weight: bold;
}

#saltable tr:nth-child(even) {
    background-color: #f9f9f9;
}
#saltable tr:hover {
    background-color: #f1f1f1;
    transition: 0.3s;
} 
</style>
<meta charset='utf-8' />
<title>급여 계산기</title>
<link href='a00_com/lib/main.css' rel='stylesheet' />
<link href="a00_com/bootstrap.min.css" rel="stylesheet" >
<script src="a00_com/jquery.min.js"></script>
<script src="a00_com/bootstrap.min.js"></script>
<script src='a00_com/lib/main.js'></script>
<script>
loadAtt();
function loadAtt() {
    var ename = "${sesEmp.ename}"; // 세션에서 로그인한 직원명 가져오기
   $.ajax({
        url: "SalAjax",
        type: "GET",
        data: { ename: ename },
        success: function(response) {
              console.log("서버 응답:", response); 
               $("#salary").val(response.sal);
               $("#salary1").text(response.sal);
               $("#dependents1").text(response.depen);
               $("#dependents").val(response.depen);
               calculateTax();
        },
        error: function(err) {
            console.log("로딩 실패", err);
            console.log("에러 상세:", err.responseText);
        }
    });
}
$(document).ready(function() {
    loadAtt(); // 페이지 로드 시 자동 호출
   
});
function calculateTax() {
    var salary = parseInt($("#salary").val()); // 급여 입력값 가져오기
    var dependents = parseInt($("#dependents").val()); // 부양가족 수 입력값 가져오기
    
    if (!salary || salary <= 0) {
        alert("급여를 입력하세요.");
        return;
    }
    if (!dependents || dependents < 0) {
        alert("부양가족 수를 올바르게 입력하세요.");
        return;
    }
   var healthInsurance = Math.floor(salary * 354.5); // 건강보험 (3.545%)
    var pension = Math.floor(salary * 450); // 국민연금 (4.5%)
    var employmentInsurance = Math.floor(salary * 90); // 고용보험 (0.9%)
    var di = (Math.floor(healthInsurance * 0.1295)); // 요양보험 (12.95%)  
    $.ajax({
        url: "/calculateTax",
        type: "GET",
        data: { salary: salary, dependents: dependents }, // 급여와 부양가족 수 전송
        dataType: "text",
        success: function(data) {
            var incomeTax = parseInt(data); // 근로소득세
            var localTax = Math.floor(incomeTax * 0.1); // 지방소득세 (근로소득세의 10%)

            // 실수령액 = 급여 - (4대보험 + 근로소득세 + 지방소득세)
            var totalDeductions = 
            healthInsurance + 
            pension + 
            employmentInsurance + 
            di + 
            incomeTax + 
            localTax;           
            var actualSalary = (salary*10000 - totalDeductions);

            $("#incomeTax").text(incomeTax.toLocaleString());
            $("#localTax").text(localTax.toLocaleString());
            $("#actualSalary").text(actualSalary.toLocaleString()); // 실수령액 계산
        },
        error: function(error) {
            console.error("오류 발생:", error);
            $("#incomeTax").text("오류 발생");
            $("#localTax").text("오류 발생");
            $("#actualSalary").text("오류 발생");
        }
    });
    // 4대보험 결과 표시
    $("#healthInsurance").text(healthInsurance.toLocaleString());
    $("#pension").text(pension.toLocaleString());
    $("#employmentInsurance").text(employmentInsurance.toLocaleString());
    $("#di").text(di.toLocaleString());
}
</script>
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
<input type="text" class="form-control" placeholder="직원명" 
name="ename" value="${sesEmp.ename}" style="display:none;">
    
<label style="display:none;">급여 입력: </label>
    <input type="number" id="salary" placeholder="급여 입력 (만원)" style="display:none;"><br>

    <label style="display:none;">부양가족 수 입력: </label>
    <input type="number" id="dependents" placeholder="부양가족 수 입력"  style="display:none;">   

<h2>급여 내역서</h2>
<table border="1" class="table table-bordered" width="80%" id="saltable">

    <tbody>
    
    <tr>
            <td>급여</td>
            <td id="salary1">0</td>
        </tr>
    <tr>
            <td>부양가족수</td>
            <td><span id="dependents1">0</span></td>
        </tr>
    
        <tr>
            <td>건강보험</td>
            <td><span id="healthInsurance">0</span></td>
        </tr>
        <tr>
            <td>요양보험</td>
            <td><span id="di">0</span></td>
        </tr>
        <tr>
            <td>국민연금</td>
            <td><span id="pension">0</span></td>
        </tr>
        <tr>
            <td>고용보험</td>
            <td><span id="employmentInsurance">0</span></td>
        </tr>
        <tr>
            <td>근로소득세</td>
            <td><span id="incomeTax">0</span></td>
        </tr>
        <tr>
            <td>지방소득세</td>
            <td><span id="localTax">0</span></td>
        </tr>
        <tr>
            <th>실수령액</th>
            <th><span id="actualSalary">0</span></th>
        </tr>
    </tbody>
</table>
</div>  
</div>
</div>
</body>
</html>