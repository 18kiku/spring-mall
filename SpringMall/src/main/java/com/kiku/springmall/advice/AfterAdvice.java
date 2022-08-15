package com.kiku.springmall.advice;

import java.io.FileWriter;
import java.io.PrintWriter;
import java.sql.Timestamp;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Service;

@Service
@Aspect
public class AfterAdvice {
	
	@After("PointcutCommon.allPointcut()")
	public void afterLog(JoinPoint jp) {
		String method = jp.getSignature().getName();
		System.out.println("[AfterAdvice]" + method + "()");
		
		Timestamp now = new Timestamp(System.currentTimeMillis());
		System.out.println("now : " + now.toString());
		
		String file = "c:/logs/SpringMall.log";
		PrintWriter pw = null;
		
		try {
			pw = new PrintWriter(new FileWriter(file, true));
			pw.write("Access Time: " + now + ", Method : " + method + "()\n");
		} catch(Exception e){
			e.printStackTrace();
		} finally {
			pw.close();
		}
	}
}
