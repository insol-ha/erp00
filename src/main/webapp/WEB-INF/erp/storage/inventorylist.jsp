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
.finance-table {
	width: 300px;
	text-align: center;
	border-collapse: collapse;
	background-color: #f5e1c5; /* 연한 베이지 배경 */
	border-radius: 12px; /* 테이블 모서리 둥글게 */
	overflow: hidden; /* 둥근 모서리 유지 */
	box-shadow: 3px 3px 10px rgba(0, 0, 0, 0.2); /* 그림자 효과 */
	font-size: 14px;
	margin: auto;
}

.finance-table th {
	background-color: #C4A484; /* 진한 연한 갈색 */
	color: white;
	font-weight: bold;
	padding: 12px;
	font-size: 16px;
}

.finance-table td {
	padding: 12px;
	border-bottom: 1px solid #ddd;
	font-weight: bold;
}

.finance-table tr:last-child td {
	background-color: #c4a484; /* 강조된 최종합산 배경색 */
	color: white;
	font-weight: bold;
	border-bottom: none;
}

/* 행 hover 효과 */
.finance-table tbody tr:hover {
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

<title>재고</title>

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
				<!-- End of Sidebar -->





				<!-- Begin Page Content -->
				<div class="container-fluid">
					<button class="btn btn-success mb-3"
						onclick="location.href='/getOrderList'">구매 관리</button>
					<button class="btn btn-success mb-3"
						onclick="location.href='/getSellList'">입출고 관리</button>
					<button class="btn btn-success mb-3"
						onclick="location.href='inventoryList'">재고</button>
					<!-- Page Heading -->

					<br>
					<!-- DataTales Example -->
					<div class="card shadow mb-4">
						<div class="card-header py-3"></div>
						<script type="text/javascript">
						$(document).ready(function () {
						    const URL = "/getProductListajax"; 

						    var vm = Vue.createApp({
						        name: "App",
						        data() {
						            return {
						                msg: "주문 리스트(vue-axios)", 
						                orderList: [],
						                deliveryList:[],
						                order: { p_name: '',price:'',inventory:'',etc:''},
						                selectedDelivery: [],
						                editOrder: {},  // 수정할 데이터를 저장할 객체
						                isLoading: false,
						                searchPname: '',
						                searchStartDate: '',
						                searchEndDate: ''
						            };
						        },
						        created() {
						            this.getOrderListajax(); 
						        },computed: {
						            computedOrderList() {
						                return this.orderList.map(order => {
						                    return {
						                        ...order,
						                        etc: order.inventory < 500 ? "재고부족" : order.etc
						                    };
						                });
						            },formattedDeliveryList() {
						                return this.selectedDelivery.map(order => ({
						                    ...order,
						                    formattedCnt: (order.inputtype === '입고' ? '+' : '-') + String(order.cnt)
						                }));
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
						            getdeliveryListajax(p_name) {
						                this.isLoading = true;
						                axios.get("/getdelListbyp_name", { params: { p_name: p_name } })
						                .then((response) => {
						                    console.log("📦 입출고 내역 조회:", response.data);
						                    if (response.data.length > 0) {
						                        this.selectedDelivery = response.data; // ✅ 여러 개의 입출고 내역 저장
						                    } else {
						                        this.selectedDelivery = []; // 🚀 데이터가 없으면 빈 배열 설정
						                    }
						                    this.isLoading = false;
						                    $('#editOrderModal').modal('show'); // ✅ 모달 띄우기
						                }).catch((err) => {
						                    console.error("❌ 입출고 내역 조회 오류:", err);
						                    this.isLoading = false;
						                });
						            },
						            // 주문 수정 모달 오픈
						            openEditModal(order) {
						                console.log("🛠 수정할 주문:", order);
						                this.editOrder = { ...order }; // 기존 데이터를 복사
						                $('#editOrderModal').modal('show'); // 모달 띄우기
						            },

						            // 주문 수정 요청
						            updateOrder() {
						                console.log("🚀 주문 수정 요청:", this.editOrder);
						                axios.post("/ajaxOrderListupt", this.editOrder)
						                    .then(response => {
						                        alert(response.data.msg); // 성공 메시지 출력
						                        $('#editOrderModal').modal('hide'); // 모달 닫기
						                        this.editOrder = {}; // 데이터 초기화
						                        this.getOrderListajax(); // 리스트 새로고침
						                    })
						                    .catch(error => {
						                        console.error("❌ 주문 수정 실패:", error);
						                    });
						            },

						            // 주문 등록 요청
						            insertOrder() {
						                console.log("📌 주문 등록 요청:", this.order);
						                axios.get("/ajaxpListins", { params: this.order })
						                    .then((response) => {
						                        alert(response.data.msg);
						                        this.order = { p_name: '', price: '',inventory:''};
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
											<h2 class="order-title">재고 목록</h2>
											&nbsp;&nbsp;&nbsp;&nbsp;
											<div class="search-container"></div>
										</div>

									</div>
									<div class="table-responsive">

										<table class="self table" id="customTable">
											<thead>
												<tr>
													<th>제품번호</th>
													<th>제품명</th>
													<th>가격</th>
													<th>재고량</th>
													<th>비고</th>
												</tr>
											</thead>
											<tbody v-if="computedOrderList.length > 0">
												<tr v-for="order in computedOrderList"
													@dblclick="getdeliveryListajax(order.p_name)"
													style="cursor: pointer;">
													<td>P-000{{ order.pcode }}</td>
													<td>{{ order.p_name }}</td>
													<td>{{ order.price }}원</td>
													<td>{{ order.inventory }}개</td>
													<td
														:style="{ color: order.inventory < 500 ? 'red' : 'black', fontWeight: order.inventory < 500 ? 'bold' : 'normal' }">
														{{ order.etc }}</td>
												</tr>
											</tbody>

										</table>

										<!-- 주문 등록 버튼 추가 -->


										<!-- 입출고내역 모달 -->
										<div class="modal fade" id="editOrderModal" tabindex="-1"
											role="dialog">
											<div class="modal-dialog modal-dialog-centered"
												role="document">
												<div class="modal-content">
													<div class="modal-header">
														<h5 class="modal-title">입출고 내역</h5>
														<button type="button" class="close" data-dismiss="modal">
															<span>&times;</span>
														</button>
													</div>

													<div class="modal-body">
														<table class="self table" id="customTable">
															<thead>
																<tr>
																	<th>제품명</th>
																	<th>수량</th>
																	<th>타입</th>
																	<th>주문 날짜</th>
																</tr>
															</thead>
															<tbody v-if="selectedDelivery.length > 0">
																 <tr v-for="order in formattedDeliveryList" :key="order.delivery_date" style="cursor: pointer;">
																	<td>{{ order.p_name }}</td>
																	 <td>{{ order.formattedCnt }}개</td>
																	<td>{{ order.inputtype }}</td>
																	<td>{{ order.delivery_date }}</td>
																</tr>
															</tbody>
															<tbody v-else>
																<tr>
																	<td colspan="4"
																		style="text-align: center; font-weight: bold; color: red;">
																		입출고 내역이 없습니다.</td>
																</tr>
															</tbody>
														</table>
													</div>
												</div>
											</div>
										</div>
										<!-- 입출고 등록 모달 -->
										<div class="modal fade" id="orderModal" tabindex="-1"
											role="dialog" aria-labelledby="orderModalTitle"
											aria-hidden="true">
											<div class="modal-dialog modal-dialog-centered"
												role="document">
												<div class="modal-content">
													<div class="modal-header">
														<h5 class="modal-title" id="orderModalTitle">입출고 등록</h5>
														<button type="button" class="close" data-dismiss="modal"
															aria-label="Close">
															<span aria-hidden="true">&times;</span>
														</button>
													</div>


													<div class="modal-body">
														<form id="orderForm">
															<div class="form-group">
																<label for="p_name">제품명</label> <select
																	v-model="order.p_name" name="p_name"
																	class="form-control">
																	<option value="딸기케이크">딸기케이크</option>
																	<option value="고구마케이크">고구마케이크</option>
																	<option value="바나나케이크">바나나케이크</option>
																	<option value="아메리카노">아메리카노</option>
																	<option value="카페모카">카페모카</option>
																	<option value="카페라떼">카페라떼</option>
																</select>
															</div>
															<div class="form-group">
																<label for="inputtype">분류</label> <select
																	v-model="order.inputtype" name="inputtype"
																	class="form-control">
																	<option value="입고">입고</option>
																	<option value="출고">출고</option>
																</select>
															</div>
															<div class="form-group">
																<label for="price">수량</label> <input type="number"
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
								<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
								<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>




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