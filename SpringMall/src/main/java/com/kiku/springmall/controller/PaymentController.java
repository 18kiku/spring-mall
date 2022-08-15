package com.kiku.springmall.controller;

import java.io.IOException;
import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.siot.IamportRestClient.IamportClient;
import com.siot.IamportRestClient.exception.IamportResponseException;
import com.siot.IamportRestClient.response.IamportResponse;
import com.siot.IamportRestClient.response.Payment;

@Controller
public class PaymentController { // 결제 검증 Controller, 구현중
	
	private String apiKey = "2427278140350668";
	private String apiSecret = "4f686575f7e28f5f38385eae0bfbb8a63953d1333faa5e9b9a1526ff4f5433a17ab4f0345b172c6c";
	private IamportClient api;
	
	public PaymentController() {
		this.api = new IamportClient(apiKey, apiSecret);
	}
	
	@ResponseBody
	@RequestMapping(value = "/verifyIamport/{imp_uid}")
	public IamportResponse<Payment> paymentByImpUid(Model model, Locale locale, HttpSession session,
			@PathVariable(value = "imp_uid") String imp_uid) throws IamportResponseException, IOException {
		return api.paymentByImpUid(imp_uid);
	}
}
