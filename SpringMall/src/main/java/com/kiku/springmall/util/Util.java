package com.kiku.springmall.util;

import java.io.File;
import java.nio.ByteBuffer;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.UUID;

import org.springframework.web.multipart.MultipartFile;

public class Util {

	private static final String UPLOAD_PATH = "/var/lib/tomcat9/webapps/upload/";
	
	public static String shortUUID() {
		UUID uuid = UUID.randomUUID();
		long l = ByteBuffer.wrap(uuid.toString().getBytes()).getLong();
		return Long.toString(l, Character.MAX_RADIX);
	}
	public static List<String> saveFile(List<MultipartFile> fileList) {
		List<String> savedFiles = new ArrayList<String>();
		
		for(MultipartFile file : fileList) {
			String originalFilename = file.getOriginalFilename();
			String saveName = /* UPLOAD_PATH + */ originalFilename;
			System.out.println(UPLOAD_PATH);
			System.out.println("fileName : " + originalFilename);
			System.out.println("fileSize : " + file.getSize());
			
			try {
				file.transferTo(new File(UPLOAD_PATH, originalFilename));
				savedFiles.add(saveName);
			} catch (Exception e) {
				e.printStackTrace(); // !! alert fail 하기
			}
		}
		return savedFiles;
	}
	public static String Delivery(String address) {
		String local = address.substring(0, 2); 


		int n = 0;
		Calendar c = Calendar.getInstance();
		int day_of_week = c.get(Calendar.DAY_OF_WEEK);

		if(local.equals("서울")) {
			if(day_of_week>=2 && day_of_week<=5) n++;
			else if(day_of_week == 6 || day_of_week == 7) n += 3;
			else if(day_of_week == 1) n += 2;
		} else if(local.equals("경기")) {
			if(day_of_week >= 2 && day_of_week <=4) n += 2;
			else if(day_of_week == 5 && day_of_week == 7) n += 4;
			else if(day_of_week == 1) n += 3;
		} else if(local.equals("제주")) {
			n += 7;
		} else {
			if(day_of_week == 2 || day_of_week == 3) n += 3;
			else if(day_of_week >= 4 && day_of_week <= 6) n += 5;
			else if(day_of_week == 1) n += 4;
		}
		
		c.add(Calendar.DATE, n);
		int month = c.get(Calendar.MONTH) + 1;
		int date = c.get(Calendar.DATE);
		int week = c.get(Calendar.DAY_OF_WEEK);
		String[] weekday = {"", "sun", "mon", "tue", "wed", "tur", "fri", "sat"};

		String d_day = month + "/" + date + " (" + weekday[week] + ")";
		
		return d_day;
	}
}
