package com.kiku.springmall.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kiku.springmall.service.BlockDTO;
import com.kiku.springmall.service.ProductDTO;

@Repository
public class ProductDAO {
	
	@Autowired
	private SqlSession sqlSession;

	/* product 테이블 -> insert 작업 (dto 내에서 필요한 값 : product_id, reg_date를 제외한 모든 컬럼)*/
	public void insertProduct(ProductDTO dto) {
		sqlSession.insert("ProductDAO.insertProduct", dto);
	}

	/* product 테이블 -> update 작업 (dto 내에서 필요한 값 : reg_date를 제외한 모든 컬럼)*/
	public void updateProduct(ProductDTO dto) {
		sqlSession.update("ProductDAO.updateProduct", dto);
	}

	/* product 테이블 -> delete 작업 (dto 내에서 필요한 값 : #{product_id})*/
	public void deleteProduct(ProductDTO dto) {
		sqlSession.delete("ProductDAO.deleteProduct", dto);
	}

	/* product 테이블 -> selectOne 작업 (dto 내에서 필요한 값 : searchCondition, #{searchKeword})*/
	public int getProductCount(ProductDTO dto) {
		return sqlSession.selectOne("ProductDAO.getProductCount", dto);
	}

	/* product 테이블 -> selectOne 작업 (dto 내에서 필요한 값 : #{product_id})*/
	public ProductDTO getProduct(ProductDTO dto) {
		return sqlSession.selectOne("ProductDAO.getProduct", dto);
	}

	/* product 테이블, category 테이블 join -> selectList 작업 
	 * 									(dto 내에서 필요한 값 : product.searchCondition, #{product.searchKeyword}, #{block.pageNum}, #{block.amount})*/
	public List<ProductDTO> getProductList(ProductDTO dto, BlockDTO block) {
		Map<String, Object> pagingMap = new HashMap<String, Object>(); // 페이징 처리를 위해 product 객체 뿐만 아니라 block 객체도 같이 넣어줘야 하기 때문에 HashMap 타입으로 값을 넣어준다
		pagingMap.put("product", dto);
		pagingMap.put("block", block);
		System.out.println(pagingMap);
		return sqlSession.selectList("ProductDAO.getProductList", pagingMap);
	}
	
}
