package com.kiku.springmall.service;

import java.sql.Timestamp;
import java.util.List;

import lombok.Data;

@Data
public class OrderDTO {
	
	private List<OrderDTO> orderList;
	
	private String order_id;
	private String orderer_id;
	private int product_id;
	private int order_quantity;
	private int order_amount;
	private Timestamp order_date;
	private String addressee;
	private String tel;
	private String postcode;
	private String address;
	private String address_detail;
	private String delivery_state;
	
	private int salePrice;
	
	// join
	private String product_name;
	private int product_price;
	private int discount_rate;
	private String product_image;
	
	private String searchCondition;
	private String searchKeyword;
	
	public int getSalePrice() {
		return product_price - (product_price*discount_rate/100);
	}
}
