package com.kiku.springmall.service;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class ProductDTO {
	private int productId;
	private String productCategory;
	private String productName;
	private String productBrand;
	private String productSize;
	private String productColor;
	private int productPrice;
	private int discountRate;
	private int productStock;
	private String productImage;
	private String productDetail;
	private Timestamp createDate;
	private Timestamp updateDate;
	
	private String categoryCode;
	private String categoryName;
	
	private String searchCondition;
	private String searchKeyword;
}
