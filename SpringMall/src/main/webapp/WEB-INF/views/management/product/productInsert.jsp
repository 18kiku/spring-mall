<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/management/product/productInsert.css" />
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
	$(document).ready(function(){
		let pageNum = $("input[name=pageNum]").val();
		$(".btn_insert").click(function(){
			// 유효성검사
		})
		$(".btn_list").click(function(){
			location="productList.do?pageNum=" + pageNum;
		})
	})
</script>
</head>
<body>
<div class="container">
	<h1>Product Insert</h1>
	<div class="d1">
		<form action="productInsert.do" method="post" name="detailForm" enctype="multipart/form-data">
		<input type="hidden" name="pageNum" value="${param.pageNum }">
			<table>
			<tr>
				<th>
					product_category
				</th>
				<!-- select로 고치기 -->
				<td>
					<input type="text" name="productCategory" value="600">
				</td>
			</tr>
			<tr>
				<th>
					product_name
				</th>
				<td>
					<input type="text" name="productName" value="test">
				</td>
			</tr>
			<tr>
				<th>
					product_brand
				</th>
				<td>
					<input type="text" name="productBrand" value="test">
				</td>
			</tr>
			<tr>
				<th>
					product_size
				</th>
				<td>
					<input type="text" name="productSize" value="test">
				</td>
			</tr>
			<tr>
				<th>
					product_color
				</th>
				<td>
					<input type="text" name="productColor" value="test">
				</td>
			</tr>
			<tr>
				<th>
					product_price
				</th>
				<td>
					<input type="number" name="productPrice" value="100000">
				</td>
			</tr>
			<tr>
				<th>
					discount_rate
				</th>
				<td>
					<input type="number" name="discountRate" value="10">
				</td>
			</tr>
			<tr>
				<th>
					product_stock
				</th>
				<td>
					<input type="number" name="productStock" value="50">
				</td>
			</tr>
			<tr>
				<th>
					product_image
				</th>
				<td>
					<input type="file" name="productImages">
				</td>
			</tr>
			<tr>
				<th>
					product_detail
				</th>
				<td>
					<input type="file" name="productDetails" multiple>
				</td>
			</tr>
			</table>
			<div class="btns">
				<input type="submit" class="btn_insert" value="Insert">
				<input type="reset" value="reset">
				<input type="button" class="btn_list" value="list">
			</div>
		</form>
	</div>
</div>
</body>
</html>