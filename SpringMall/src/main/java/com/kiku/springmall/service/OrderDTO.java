package com.kiku.springmall.service;

import java.sql.Timestamp;
import java.util.List;

import lombok.Data;

@Data
public class OrderDTO {
	
	private List<OrderDTO> orderList;
	
	private String orderId;
	private String ordererId;
	private int productId;
	private int orderQuantity;
	private int orderAmount;
	private Timestamp orderDate;
	private String addressee;
	private String tel;
	private String postcode;
	private String address;
	private String addressDetail;
	private String deliveryState;
	private Timestamp updateDate;
	
	private int salePrice;
	
	// join
	private String productName;
	private int productPrice;
	private int discountRate;
	private String productImage;
	
	private String searchCondition;
	private String searchKeyword;
	
	public int getSalePrice() {
		return productPrice - (productPrice*discountRate/100);
	}
}
