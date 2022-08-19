package com.kiku.springmall.service;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class CartDTO {
	// column
	private int cartId;
	private String ordererId;
	private int productId;
	private int orderQuantity;
	private Timestamp createDate;
	private Timestamp updateDate;
	
	private int salePrice;
	private int totalPrice;
	
	// join
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
	
	public int getSalePrice() {
		return productPrice - (productPrice*discountRate/100);
	}
	
	public int getTotalPrice() {
		return (productPrice - (productPrice*discountRate/100)) * orderQuantity;
	}
}
