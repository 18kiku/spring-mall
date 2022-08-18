package com.kiku.springmall.advice;

import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.stereotype.Service;


@Aspect
public class PointcutCommon {
	
	@Pointcut("execution(* com.kiku.springmall..*(..))")
	public void allPointcut(){}
	
	@Pointcut("execution(* com.kiku.springmall..*Impl.get*(..))")
	public void getPointcut(){}
	
}
