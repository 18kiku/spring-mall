package com.kiku.springmall.service;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class ProductDTO {
	private int product_id;
	private String product_category;
	private String product_name;
	private String product_brand;
	private String product_size;
	private String product_color;
	private int product_price;
	private int discount_rate;
	private int product_stock;
	private String product_image;
	private String product_detail;
	private Timestamp reg_date;
	
	private String category_code;
	private String category_name;
	
	private String searchCondition;
	private String searchKeyword;
}
