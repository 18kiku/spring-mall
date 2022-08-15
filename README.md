# 스프링 쇼핑몰 프로젝트

## 1. 개요
### 주제
스프링 프레임워크를 활용하여 쇼핑몰을 구현한다.
### 이유
JSP 쇼핑몰 프로젝트를 작성해 본 결과, 처음 작성하기에는 쉬웠지만 코드가 늘어날수록 지저분해진다는 느낌을 받았고 수정이 힘들어지는 어려움을 겪었다.
이러한 어려움을 해결하기 위해 코드의 가독성과 확장성, 유지보수성을 높일 수 있는 장점을 가진 스프링 프레임워크로 쇼핑몰 프로젝트를 다시 작성해본다.



## 2. 주요 기능

### (회원)
+ 로그인
+ 회원 가입
+ 회원 정보 수정
+ 회원 탈퇴

### (상품관리)
+ 상품 조회, 등록, 수정, 삭제

### (쇼핑)
+ 상품 조회
+ 상품 카트에 담기
+ 상품 바로 구매

### (카트)
+ 구매를 원하는 상품 담기

### (주문)
+ 쇼핑 영역에서 바로 구매
+ 카드에 담긴 상품 구매
+ 주문 목록 조회

## 3. 개발 환경
```
OS: Windows 10
Java Version: Java SE-1.8 (jre1.8.0_321)
IDE: spring-tool-suite-3.9.15.RELEASE-34.16.0
DB: Oracle
```



## 4. 요구사항

### 공통

#### 1. 상단, 하단 페이지
+ 모든 페이지에 동일한 상단 하단 페이지 -> tiles 사용

#### 2. 페이징 구현
+ 페이지당 n개씩 조회할 수 있도록 쿼리 작성
+ 페이징 블록 이동 버튼 구현(ex. 첫 페이지, 다음 페이지)

### 회원 관리

#### 1. 로그인
+ id와 password가 일치여부 확인
+ 일치 시 세션에 회원 정보 저장 후 쇼핑몰 메인 페이지로 이동
+ 불일치 시 로그인 페이지로 재 이동

#### 2. 회원가입
+ 아이디, 비밀번호, 이름, 이메일 필수 입력
+ 아이디 중복검사, 이메일 유효성 검사
+ 가입 완료 시 로그인 페이지로 이동

### 상품 관리

#### 1. 상품 등록
+ 이미지 파일을 등록 가능
+ 상품 수정, 삭제
+ 카테고리, 상품명에 따라 상품을 검색할 수 있다.

### 쇼핑몰

#### 1. 상품 목록
+ 카테고리별로 상품을 표시. 이미지, 상품명, 가격만 간단하게 표시

#### 2. 상품 상세
+ 상품의 이미지와 상세 정보들을 표시
+ 카트에 담을 수 있고, 바로 주문을 할 수 있다.

### 카트

+ 구매를 원하는 상품을 저장할 수 있다
+ 카드 내의 상품을 삭제하거나 수량을 수정할 수 있다.
+ 원하는 상품을 선택하여 주문할 수 있다.

### 주문
+ 상품 상세페이지나 카트에서 선택한 상품을 주문할 수 있다.
+ 배송지를 직접 입력하거나 회원 정보에서 불러올 수 있다.
+ 주문 상품의 개별 가격과 수량, 총 가격을 확인할 수 있다.
+ 주문한 기록을 확인할 수 있다.



## 5. 테이블 정의

![member](https://user-images.githubusercontent.com/98327681/184667588-a8cfa01e-6984-498a-bceb-c9ab6cd51ced.PNG)

![management](https://user-images.githubusercontent.com/98327681/184667603-ec592bb0-e017-42c5-8049-f4b8add08788.PNG)

![product](https://user-images.githubusercontent.com/98327681/184667625-b6cc1d2f-fe28-4674-b99e-4084bf76cd8f.PNG)

![category](https://user-images.githubusercontent.com/98327681/184667633-38981fc9-a4b3-4696-b1d0-52d953d82386.PNG)

![cart](https://user-images.githubusercontent.com/98327681/184667653-5755f487-75fd-487f-bb65-00ac5f971f23.PNG)

![orders](https://user-images.githubusercontent.com/98327681/184667666-a0dc5b50-c3b4-4cec-9d48-3506b6ce9033.PNG)



## 6. 화면 구성

### ■ 고객 영역

#### 1. 메인
![image](https://user-images.githubusercontent.com/98327681/184595647-d6ecbaa8-c8b6-4d59-8438-0b6e8c56a39d.png)


#### 2. 회원가입
![image](https://user-images.githubusercontent.com/98327681/184595635-21787b9b-7fae-4200-a3d8-bceada10eff1.png)


#### 3. 로그인
![image](https://user-images.githubusercontent.com/98327681/184595670-0c34918e-88f6-44b5-8eea-165cbcb436f3.png)


#### 4. 회원정보
![image](https://user-images.githubusercontent.com/98327681/184595688-8ecfcb05-8728-41ce-abc3-661923e6fe10.png)


#### 5. 상품 목록
![image](https://user-images.githubusercontent.com/98327681/184595705-87fe7604-e190-4fd5-aaa6-bcdc3dd8bc80.png)


#### 6. 상품 상세
![image](https://user-images.githubusercontent.com/98327681/184595718-25cacaf2-89f6-4423-bd0f-f27e72055e16.png)


#### 7. 장바구니
![image](https://user-images.githubusercontent.com/98327681/184595730-5e95ccde-c47d-41a4-ae70-ea6d8d25fc0c.png)


#### 8. 주문 확인
![image](https://user-images.githubusercontent.com/98327681/184595748-e911f1b9-9966-44c8-8263-45587de42e5a.png)


#### 9. 결제
![image](https://user-images.githubusercontent.com/98327681/184595765-21efaff7-ccf4-40db-ba92-fe864749b92a.png)


#### 10. 결제 완료
![image](https://user-images.githubusercontent.com/98327681/184595777-8edc6d82-5caf-4810-a267-b767ec22c1a4.png)


#### 11. 주문 목록
![image](https://user-images.githubusercontent.com/98327681/184595812-6fe98486-e5ba-43e8-b316-16538b59d29c.png)


### ■ 관리자 영역

#### 1. 상품 목록
![image](https://user-images.githubusercontent.com/98327681/184595825-319177cb-2931-4b72-94da-a926c399a0d8.png)


#### 2. 상품 상세
![image](https://user-images.githubusercontent.com/98327681/184595844-4411150e-46d3-4ab8-8d1c-2a325a047887.png)




