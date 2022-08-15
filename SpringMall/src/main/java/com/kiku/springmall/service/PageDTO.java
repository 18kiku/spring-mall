package com.kiku.springmall.service;

import lombok.Data;

@Data
public class PageDTO {
	private int startPage;
	private int endPage;
	private boolean prev, next;
	private int total;
	private BlockDTO block;
	private int pageCount;
	
	public PageDTO(BlockDTO block, int total) {
		this.block = block;
		this.total = total;
		
		this.pageCount = total / block.getAmount();
		if(total % block.getAmount() > 0) this.pageCount++;
		
		this.endPage = (int)(Math.ceil(block.getPageNum() / 10.0)) * 10;
		this.startPage = this.endPage - 9;
		
		int endPage2 = (int)(Math.ceil(total * 1.0)) / block.getAmount();
		if(endPage2 < this.endPage) this.endPage = endPage2;
		
		this.prev = this.startPage > 1;
		this.next = this.endPage < endPage2;
	}
}
