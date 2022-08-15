<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ProductList</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/management/product/productList.css" />
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
	$(document).ready(function () {
		let pageNum = $("input[name=pageNum]").val();
		/* 상품 추가 버튼*/
		$(".btn_insert").click(function(){
			location = "productInsert.do?pageNum=" + pageNum;
		});
    });
</script>
</head>
<body>
<body>
<div class="container">
	<h1>Product List</h1>
	<input type="button" class="btn_insert" value="Register">
	<input type="hidden" name="pageNum" value="${param.pageNum }">
	<form action="productList.do" method="post">
	<table class="search"> <!-- search시 결과가 5페이지가 나왔을때 다른페이지로 이동하려고 하면 search가 풀리는 문제 -->
		<tr>
			<td>
				<select name="searchCondition">
					<c:forEach var="option" items="${conditionMap }">
						<option value="${option.value }">${option.key }</option>
					</c:forEach>
				</select>
				<input type="text" name="searchKeyword" value="${param.searchKeword }">
				<input type="submit" value="search">
			</td>
		</tr>
	</table>	
	</form>
	<table class="product">
	<tr>
		<th width="4%">
			product_id
		</th>
		<th width="13%">
			product_category
		</th>
		<th width="7%">
			product_image
		</th>
		<th width="23%">
			product_name
		</th>
		<th width="5%">
			product_brand
		</th>
		<th width="5%">
			product_size
		</th>
		<th width="5%">
			product_color
		</th>
		<th width="7%">
			product_price
		</th>
		<th width="7%">
			discount_rate
		</th>
		<th width="5%">
			product_stock
		</th>
		<th width="8%">
			reg_date
		</th>
		<th width="11%">
			delete
		</th>
	</tr>
	<c:if test="${productList[0] != null }">
	<c:forEach var="product" items="${productList }">
	<tr>
	
		<td class="center">
			<c:if test="${param.pageNum == null }">
			<a href="productDetail.do?product_id=${product.product_id}&pageNum=1">${product.product_id }</a>	
			</c:if>
			<c:if test="${param.pageNum != null }">
			<a href="productDetail.do?product_id=${product.product_id}&pageNum=${param.pageNum}">${product.product_id }</a>	
			</c:if>
		</td>
		<td class="center">
			${product.product_category }
		</td>
		<td class="center">
			<c:if test="${param.pageNum == null }">
			<a href="productDetail.do?product_id=${product.product_id}&pageNum=1">
				<img alt="product_image" src="${pageContext.request.contextPath}/resources/img/${product.product_image }" width="60" height="60">
			</a>	
			</c:if>
			<c:if test="${param.pageNum != null }">
			<a href="productDetail.do?product_id=${product.product_id}&pageNum=${param.pageNum}">
				<img alt="product_detail" src="${pageContext.request.contextPath}/resources/img/${product.product_image }" width="60" height="60">
			</a>	
			</c:if>
			
		</td>
		<td class="center">
			<c:if test="${param.pageNum == null }">
			<a href="productDetail.do?product_id=${product.product_id}&pageNum=1">${product.product_name }</a>	
			</c:if>
			<c:if test="${param.pageNum != null }">
			<a href="productDetail.do?product_id=${product.product_id}&pageNum=${param.pageNum}">${product.product_name }</a>	
			</c:if>
		</td>
		<td class="center">
			${product.product_brand }
		</td>
		<td class="center">
			${product.product_size }
		</td>
		<td class="center">
			${product.product_color }
		</td>
		<td class="right">
			${product.product_price }
		</td>
		<td class="right">
			${product.discount_rate }
		</td>
		<td class="right">
			${product.product_stock }
		</td>
		<fmt:formatDate var="reg_date" value="${product.reg_date }" pattern="yyyy/MM/dd"/>
		<td class="center">
			${reg_date }
		</td>
		<td class="center">
			<c:if test="${param.pageNum == null }">
			<a href="productDelete.do?product_id=${product.product_id}&pageNum=1">delete</a>	
			</c:if>
			<c:if test="${param.pageNum != null }">
			<a href="productDelete.do?product_id=${product.product_id}&pageNum=${param.pageNum}">delete</a>	
			</c:if>
		</td>
	</tr>
	</c:forEach>
	</c:if>
	<c:if test="${productList[0]==null }">
	<tr>
		<td colspan="11" class="center">
			nothing
		</td>
	</tr>
	</c:if>
	</table>
	<div class="paging">
		<!-- 첫 페이지 -->
		<c:if test="${pageDTO.prev }">
			<a href="productList.do?searchKeword=${param.searchKeword }&pageNum=1" class="p_box p_box_bold" ><<</a>
		</c:if>
		<!-- 이전 페이지 -->
		<c:if test="${pageDTO.prev }">
			<c:set var="pageNum" value="${param.pageNum-10 }"/>	
			<a href="productList.do?searchKeword=${param.searchKeword }&pageNum=${pageNum }" class="p_box p_box_bold"><</a>
		</c:if>
		
		<!-- 페이지 번호 -->
		<c:forEach var="pageNum" varStatus="s" begin="${pageDTO.startPage }" end="${pageDTO.endPage }">
			<c:if test="${param.pageNum == pageNum }">
				<a href="productList.do?searchKeword=${param.searchKeword }&pageNum=${pageNum }" class="p_box_choice">${pageNum }</a>
			</c:if>
			<c:if test="${param.pageNum != pageNum }">
				<a href="productList.do?searchKeword=${param.searchKeword }&pageNum=${pageNum }" class="p_box">${pageNum }</a>
			</c:if>
		</c:forEach>
		
		<!-- 다음 페이지 -->
		<c:if test="${pageDTO.next }">
		<c:set var="pageNum" value="${param.pageNum+10 }"/>
			<c:if test="${pageNum > pageDTO.pageCount }">
				<c:set var="pageNum" value="${pageDTO.pageCount-1 }"/>
			</c:if>
			<a href="productList.do?searchKeword=${param.searchKeword }&pageNum=${pageNum }" class="p_box p_box_bold">></a>
		</c:if>
		<!-- 마지막 페이지 -->
		<c:if test="${pageDTO.prev }">
		<c:set var="pageNum" value="${pageDTO.pageCount }"/>
			<a href="productList.do?searchKeword=${param.searchKeword }&pageNum=${pageNum-1 }" class="p_box p_box_bold">>></a>
		</c:if>
		
	</div>
</div>
</body>
</html>