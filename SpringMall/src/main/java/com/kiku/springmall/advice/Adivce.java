package com.kiku.springmall.advice;

import java.io.FileWriter;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.util.Arrays;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.Signature;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.stereotype.Component;

@Component
@Aspect
public class Adivce {

	
	@Before("PointcutCommon.allPointcut()")
	public void afterLog(JoinPoint jp) {

		System.out.printf("%s.%s(%s)\n", jp.getTarget().getClass()
        		.getSimpleName(), jp.getSignature().getName(), Arrays.toString(jp.getArgs()));
		
		Timestamp now = new Timestamp(System.currentTimeMillis());
		System.out.println("now : " + now.toString() + "\n");
		
		String file = "c:/logs/SpringMall.log";
		PrintWriter pw = null;
		
		try {
			pw = new PrintWriter(new FileWriter(file, true));
			pw.write("Access Time: " + now + ", Method : " + jp.getSignature().toLongString() + "\n\n");
		} catch(Exception e){
			e.printStackTrace();
		} finally {
			pw.close();
		}
	}
	/*
	@Around("PointcutCommon.allPointcut()")
    public Object measure(ProceedingJoinPoint joinPoint) throws Throwable {
        long start = System.nanoTime();
        try {
            Object result = joinPoint.proceed();
            return result;
        } finally {
            long finish = System.nanoTime();
            Signature sig = joinPoint.getSignature();
            System.out.printf("%s.%s(%s) 실행 시간 : %d ns\n\n", joinPoint.getTarget().getClass()
            		.getSimpleName(), sig.getName(), Arrays.toString(joinPoint.getArgs()), (finish - start));
            //System.out.println(joinPoint.getTarget().getClass().getSimpleName());
            //System.out.println(sig.getName());
            //System.out.println(Arrays.toString(joinPoint.getArgs()));
        }
    }
    */
}
