<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html lang="en">

<script src="https://unpkg.com/vue" type="text/javascript"></script>
<script src="http://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>


<head>
<style type="text/css">

    .expense-table-container {
        float: left; /* 왼쪽 정렬 */
        margin-left: 20px; /* 좌측 여백 추가 */
        margin-top: 10px;
    }

    .expense-table {
        width: 300px;
        text-align: center;
        border-collapse: collapse;
        background-color: #f5e1c5; /* 연한 베이지 배경 */
        border-radius: 12px; /* 둥근 모서리 */
        overflow: hidden; /* 둥근 모서리 유지 */
        box-shadow: 3px 3px 10px rgba(0, 0, 0, 0.2); /* 그림자 효과 */
        font-size: 14px;
    }

    .expense-table th {
        background-color: #C4A484; /* 진한 연한 갈색 */
        color: white;
        font-weight: bold;
        padding: 12px;
        font-size: 16px;
    }

    .expense-table td {
        padding: 12px;
        border-bottom: 1px solid #ddd;
        font-weight: bold;
    }

    .expense-table tbody tr:last-child td {
        background-color: #c4a484; /* 강조된 최종합산 배경색 */
        color: white;
        font-weight: bold;
        border-bottom: none;
    }

    /* 행 hover 효과 */
    .expense-table tbody tr:hover {
        background-color: #e8d6b0; /* 마우스 오버 시 연한 갈색 */
        transition: 0.3s ease-in-out;
    }


.order-header {
	display: flex;
	align-items: center;
	justify-content: space-between; /* 양쪽 정렬 */
	margin-bottom: 15px;
}

.order-title {
	font-size: 24px;
	font-weight: bold;
	color: #2c3e50;
	text-align: left;
	padding: 10px 0;
	border-bottom: 2px solid #3498db;
	display: inline-block;
}

.search-container {
	display: flex;
	gap: 8px; /* 입력창 간격 조정 */
}

.small {
	display: flex; /* 플렉스 컨테이너로 설정 */
	justify-content: center; /* 가로 중앙 정렬 */
	align-items: center; /* 세로 중앙 정렬 */
	max-width: 30% !important;
	width: 30% !important;
	margin: auto; /* 부모 컨테이너에서 가로 중앙 정렬 */
}

.self.table {
	width: 100%;
	border-collapse: collapse; /* 테두리 겹침 방지 */
	background-color: #ffffff;
	border-radius: 8px; /* 테이블 모서리 둥글게 */
	overflow: hidden; /* 둥근 테두리 유지 */
	box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1); /* 테이블에 그림자 효과 추가 */
	font-size: 14px;
}

/* 테이블 헤더 스타일 */
.self.table thead {
background-color: #C4A484; /* 더 진한 연한 갈색 */
	color: white;
	font-weight: bold;
	text-align: center;
}

.self.table thead th {
	padding: 12px;
	font-size: 16px;
}

/* 본문 스타일 */
.self.table tbody tr {
	border-bottom: 1px solid #ddd; /* 행 구분선 */
	transition: background-color 0.3s; /* hover 효과 */
}

.self.table tbody td {
	padding: 10px;
	text-align: center; /* 기본적으로 가운데 정렬 */
}

/* 숫자는 오른쪽 정렬 */
.self.table tbody td:nth-child(5), /* 유효기간 */ .self.table tbody td:nth-child(6),
	/* 가격 */ .self.table tbody td:nth-child(9) { /* 수량 */
	text-align: right;
}

/* 행 hover 효과 */
.self.table tbody tr:hover {
	background-color: #f1f1f1; /* 연한 회색 */
	cursor: pointer;
}

/* 테두리 스타일 */
.self.table th, .self.table td {
	border: 1px solid #ddd;
}

/* 반응형 테이블 (스크롤 가능) */
.table-responsive {
	overflow-x: auto;
}
</style>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>구매관리</title>

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
								<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
								<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>

<body id="page-top">

	<!-- Page Wrapper -->
	<div id="wrapper" class="container1">

		<!-- Sidebar -->
		<ul
			class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion"
			id="accordionSidebar">

			<c:import url="/WEB-INF/views/sidebar.jsp" />

		</ul>
		<div id="content-wrapper" class="d-flex flex-column">
			<div id="content">
				<nav
					class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">
					<c:import url="/WEB-INF/views/header.jsp" />
				</nav>
				<!-- End of Topbar -->

				<!-- Begin Page Content -->
				<div class="container-fluid">
					<button class="btn btn-success mb-3"
						onclick="location.href='/getOrderList'">구매 관리</button>
					<button class="btn btn-success mb-3"
						onclick="location.href='/getSellList'">입출고 관리</button>
					<button class="btn btn-success mb-3"
						onclick="location.href='/inventoryList'">재고</button>
					<!-- Page Heading -->

					<br>
					<!-- DataTales Example -->
					<div class="card shadow mb-4">
						<div class="card-header py-3"></div>
						<script type="text/javascript">
						$(document).ready(function () {
						    const URL = "/getOrderListbyPnameajax"; 

						    var vm = Vue.createApp({
						        name: "App",
						        data() {
						            return {
						                msg: "주문 리스트(vue-axios)", 
						                orderList: [], 
						                order: { p_name: '', empno: '', price: '', email: '', cnt: '' }, 
						                editOrder: {empno:'',p_name:'',price:'',email:'',cnt:'',orderno:''},  // 수정할 데이터를 저장할 객체
						                isLoading: false,
						                searchPname: '',
						                searchStartDate: '',
						                searchEndDate: ''
						            };
						        },
						        created() {
						            this.getOrderListajax(); 
						        },
						        computed: {
						            // ✅ 2월 총 지출 계산
						            totalExpense() {
						                return this.orderList
						                    .reduce((sum, order) => sum + (order.price * order.cnt), 0); // 가격 * 수량을 합산
						            }
						        },
						        methods: {
						            // 주문 목록 불러오기
						            getOrderListajax() {
						                this.isLoading = true;
						                axios.get(URL).then((response) => {
						                    console.log("📌 주문 리스트:", response.data);
						                    this.orderList = response.data;  
						                    this.isLoading = false;
						                }).catch((err) => {
						                    console.error("❌ 주문 리스트 조회 오류:", err);
						                    this.isLoading = false;
						                });
						            },

						            // 검색 기능
						            searchOrderList() {
						                this.isLoading = true;
						                axios.get(URL, {
						                    params: {
						                        p_name: this.searchPname,
						                        startDate: this.searchStartDate,
						                        endDate: this.searchEndDate
						                    }
						                }).then((response) => {
						                    console.log("🔎 검색 결과:", response.data);
						                    this.orderList = response.data;
						                    this.isLoading = false;
						                }).catch((err) => {
						                    console.error("❌ 검색 오류:", err);
						                    this.isLoading = false;
						                });
						            },

						            // 주문 수정 모달 오픈
						           openEditModal(order) {
									    console.log("🚀 모달창 오픈 (요청할 주문번호):", order.orderno);
									
									    axios.get("/getOrderListbyorderno", { params: { orderno: order.orderno } })
									        .then(response => {
									            console.log("✅ 서버 응답 (주문 상세 정보):", response.data);
									            
									            // API에서 받아온 데이터를 editOrder에 반영
									            this.editOrder = { ...response.data };  // 객체 복사하여 반영
									
									            $('#editOrderModal').modal('show'); // 모달 띄우기
									        })
									        .catch(error => {
									            console.error("❌ 주문 상세 정보 불러오기 실패:", error);
									        });
									},

						            // 주문 수정 요청
						           /*  updateOrder() {
						                console.log("🚀 주문 수정 요청:", this.editOrder);
						                axios.post("/ajaxOrderListupt", this.editOrder)
						                    .then(response => {
						                        alert(response.data.msg); // 성공 메시지 출력
						                        $('#editOrderModal').modal('hide'); // 모달 닫기
						                        this.getOrderListajax(); // 리스트 새로고침
						                    })
						                    .catch(error => {
						                        console.error("❌ 주문 수정 실패:", error);
						                    });
						            } */updateOrder() {
						                console.log("🚀 주문 수정 요청:", this.editOrder);
						                axios.post("/ajaxOrderListupt", this.editOrder)
						                    .then(response => {
						                        alert(response.data.msg); // 성공 메시지 출력
						                        $('#editOrderModal').modal('hide'); // 모달 닫기
						                        this.getOrderListajax(); // 리스트 새로고침
						                    })
						                    .catch(error => {
						                        console.error("❌ 주문 수정 실패:", error);
						                    });
						            },

						            // 주문 등록 요청
						            insertOrder() {
						                console.log("📌 주문 등록 요청:", this.order);
						                axios.get("/ajaxOrderListins", { params: this.order })
						                    .then((response) => {
						                        alert(response.data.msg);
						                        this.order = { p_name: '', empno: '', price: '', email: '', cnt: '' };
						                        $('#orderModal').modal('hide');
						                        this.getOrderListajax();
						                    })
						                    .catch((err) => {
						                        console.error("❌ 주문 등록 실패:", err);
						                    });
						            }
						        }
						    }).mount(".container2");
						});
</script>

						<div class="card-body">
							<div class="container2">

								<div class="container">

									<div class="form-inline mb-3">
										<div class="order-header">
											<h2 class="order-title">구매관리</h2>
											&nbsp;&nbsp;&nbsp;&nbsp;
											<div class="search-container">
												<input type="text" class="form-control mr-2"
													v-model="searchPname" placeholder="제품명을 입력하세요"> <input
													type="date" class="form-control mr-2"
													v-model="searchStartDate"> <input type="date"
													class="form-control mr-2" v-model="searchEndDate">
												<button class="btn btn-primary" @click="searchOrderList">검색</button>
											
											</div>
														
										</div>

									</div>
									<button class="btn btn-success mb-3" data-toggle="modal"
											data-target="#orderModal">구매 등록</button>
									<div class="table-responsive">

										<table class="self table" id="customTable">
											<thead>
												<tr>
													<th>주문번호</th>
													<th>사원번호</th>
													<th>제품명</th>
													<th>유효기간</th>
													<th>단가</th>
													<th>수량</th>
													<th>총 가격</th>
													<th>담당자 이메일</th>
													<th>배송일자</th>

												</tr>
											</thead>
											<tbody v-if="orderList.length > 0">
												<tr v-for="order in orderList"
													@dblclick="openEditModal(order)" style="cursor: pointer;">
													<td>B-{{ order.orderno }}</td>
													<td>{{ order.empno }}</td>
													<td>{{ order.p_name }}</td>
													<td>{{ order.period }}</td>
													<td>{{ order.price.toLocaleString() }}원</td>
													<td>{{ order.cnt.toLocaleString() }}개</td>
													<td>{{ (order.cnt * order.price).toLocaleString() }}원</td>
													<td>{{ order.email }}</td>
													<td>{{ order.delivery_date }}</td>
												</tr>
											</tbody>

										</table>
										<!-- 주문 등록 버튼 추가 -->
									<div class="expense-table-container">
    <table class="expense-table">
        <thead>
            <tr>
                <th>항목</th>
                <th>금액</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>총 지출</td>
                <td>-{{ totalExpense.toLocaleString() }}원</td>
            </tr>
        </tbody>
    </table>
</div>
								
										<!-- 수정 모달 -->
										<div class="modal fade" id="editOrderModal" tabindex="-1"
											role="dialog">
											<div class="modal-dialog modal-dialog-centered"
												role="document">
												<div class="modal-content">
													<div class="modal-header">
														<h5 class="modal-title">주문 수정</h5>
														<button type="button" class="close" data-dismiss="modal">
															<span>&times;</span>
														</button>
													</div>

													<div class="modal-body">
														<form>
															<div class="form-group">
																<label>주문번호</label> <input type="number" readonly
																	class="form-control" v-model="editOrder.orderno" name="orderno">
															</div>
															<div class="form-group">
																<label>제품명</label> <input type="text"
																	class="form-control" v-model="editOrder.p_name" name="p_name">
															</div>
															<div class="form-group">
																<label>사원번호</label> <input type="number"
																	class="form-control" v-model="editOrder.empno" name="empno">
															</div>
															<div class="form-group">
																<label>가격</label> <input type="number"
																	class="form-control" v-model="editOrder.price" name="price">
															</div>
															<div class="form-group">
																<label>이메일</label> <input type="text"
																	class="form-control" v-model="editOrder.email" name="email">
															</div>
															<div class="form-group">
																<label>수량</label> <input type="number"
																	class="form-control" v-model="editOrder.cnt" name="cnt">
															</div>
														</form>
													</div>

													<div class="modal-footer">
														<button type="button" class="btn btn-secondary"
															data-dismiss="modal">취소</button>
														<button type="button" class="btn btn-primary"
															@click="updateOrder">수정</button>
													</div>
												</div>
											</div>
										</div>
										<!-- 구매 등록 모달 -->
										<div class="modal fade" id="orderModal" tabindex="-1"
											role="dialog" aria-labelledby="orderModalTitle"
											aria-hidden="true">
											<div class="modal-dialog modal-dialog-centered"
												role="document">
												<div class="modal-content">
													<div class="modal-header">
														<h5 class="modal-title" id="orderModalTitle">구매 등록</h5>
														<button type="button" class="close" data-dismiss="modal"
															aria-label="Close">
															<span aria-hidden="true">&times;</span>
														</button>
													</div>


													<div class="modal-body">
														<form id="orderForm">
															<div class="form-group">
																<label for="p_name">제품명</label> <input type="text"
																	class="form-control" id="p_name" v-model="order.p_name"
																	placeholder="제품명을 입력하세요">
															</div>
															<div class="form-group">
																<label for="empno">사원번호</label> <input type="number"
																	class="form-control" id="empno" v-model="order.empno"
																	placeholder="사원번호 입력">
															</div>
															<div class="form-group">
																<label for="price">가격</label> <input type="number"
																	class="form-control" id="price" v-model="order.price"
																	placeholder="가격 입력">
															</div>
															<div class="form-group">
																<label for="email">이메일</label> <input type="email"
																	class="form-control" id="email" v-model="order.email"
																	placeholder="이메일 입력">
															</div>
															<div class="form-group">
																<label for="cnt">수량</label> <input type="cnt"
																	class="form-control" id="cnt" v-model="order.cnt"
																	placeholder="수량 입력">
															</div>
														</form>
													</div>

													<div class="modal-footer">
														<button type="button" class="btn btn-secondary"
															data-dismiss="modal">취소</button>
														<button type="button" class="btn btn-primary"
															@click="insertOrder">등록</button>
													</div>
												</div>
											</div>
										</div>

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