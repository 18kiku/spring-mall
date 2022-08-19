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
			productId
		</th>
		<th width="13%">
			product_category
		</th>
		<th width="7%">
			productImage
		</th>
		<th width="23%">
			productName
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
			<a href="productDetail.do?productId=${product.productId}&pageNum=1">${product.productId }</a>	
			</c:if>
			<c:if test="${param.pageNum != null }">
			<a href="productDetail.do?productId=${product.productId}&pageNum=${param.pageNum}">${product.productId }</a>	
			</c:if>
		</td>
		<td class="center">
			${product.productCategory }
		</td>
		<td class="center">
			<c:if test="${param.pageNum == null }">
			<a href="productDetail.do?productId=${product.productId}&pageNum=1">
				<img alt="productImage" src="${pageContext.request.contextPath}/resources/img/${product.productImage }" width="60" height="60">
			</a>	
			</c:if>
			<c:if test="${param.pageNum != null }">
			<a href="productDetail.do?productId=${product.productId}&pageNum=${param.pageNum}">
				<img alt="productDetail" src="${pageContext.request.contextPath}/resources/img/${product.productDetail }" width="60" height="60">
			</a>	
			</c:if>
			
		</td>
		<td class="center">
			<c:if test="${param.pageNum == null }">
			<a href="productDetail.do?productId=${product.productId}&pageNum=1">${product.productName }</a>	
			</c:if>
			<c:if test="${param.pageNum != null }">
			<a href="productDetail.do?productId=${product.productId}&pageNum=${param.pageNum}">${product.productName }</a>	
			</c:if>
		</td>
		<td class="center">
			${product.productBrand }
		</td>
		<td class="center">
			${product.productSize }
		</td>
		<td class="center">
			${product.productColor }
		</td>
		<td class="right">
			${product.productPrice }
		</td>
		<td class="right">
			${product.discountRate }
		</td>
		<td class="right">
			${product.productStock }
		</td>
		<fmt:formatDate var="createDate" value="${product.createDate }" pattern="yyyy/MM/dd"/>
		<td class="center">
			${createDate }
		</td>
		<td class="center">
			<c:if test="${param.pageNum == null }">
			<a href="productDelete.do?productId=${product.productId}&pageNum=1">delete</a>	
			</c:if>
			<c:if test="${param.pageNum != null }">
			<a href="productDelete.do?productId=${product.productId}&pageNum=${param.pageNum}">delete</a>	
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