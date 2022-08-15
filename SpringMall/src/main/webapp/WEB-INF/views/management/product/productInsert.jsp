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
					<input type="text" name="product_category" value="600">
				</td>
			</tr>
			<tr>
				<th>
					product_name
				</th>
				<td>
					<input type="text" name="product_name" value="test">
				</td>
			</tr>
			<tr>
				<th>
					product_brand
				</th>
				<td>
					<input type="text" name="product_brand" value="test">
				</td>
			</tr>
			<tr>
				<th>
					product_size
				</th>
				<td>
					<input type="text" name="product_size" value="test">
				</td>
			</tr>
			<tr>
				<th>
					product_color
				</th>
				<td>
					<input type="text" name="product_color" value="test">
				</td>
			</tr>
			<tr>
				<th>
					product_price
				</th>
				<td>
					<input type="number" name="product_price" value="100000">
				</td>
			</tr>
			<tr>
				<th>
					discount_rate
				</th>
				<td>
					<input type="number" name="discount_rate" value="10">
				</td>
			</tr>
			<tr>
				<th>
					product_stock
				</th>
				<td>
					<input type="number" name="product_stock" value="50">
				</td>
			</tr>
			<tr>
				<th>
					product_image
				</th>
				<td>
					<input type="file" name="product_images">
				</td>
			</tr>
			<tr>
				<th>
					product_detail
				</th>
				<td>
					<input type="file" name="product_details" multiple>
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