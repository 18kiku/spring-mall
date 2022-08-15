package com.kiku.springmall.service;

import lombok.Data;

@Data
public class BlockDTO {
	private int pageNum;
	private int amount;
	
	public BlockDTO() {
		this.pageNum = 1;
		this.amount = 10;
	}
	
	public BlockDTO(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}
}
