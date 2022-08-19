package com.kiku.springmall.service;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class MemberDTO {
	private String id;
	private String password;
	private String name;
	private String birth;
	private String gender;
	private String email;
	private String tel;
	private String postcode;
	private String address;
	private String addressDetail;
	private Timestamp createDate;
	private Timestamp updateDate;
	
	private String managementId;
	private String managementPassword;
}
