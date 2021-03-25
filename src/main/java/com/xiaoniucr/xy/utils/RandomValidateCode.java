package com.xiaoniucr.xy.utils;

import com.xiaoniucr.xy.core.constant.SessionKey;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.Serializable;
import java.util.Random;

/**
 * Verification code generation tools
 */
public class RandomValidateCode implements Serializable {

	private static final long serialVersionUID = 1L;

	private static Random random = new Random();
	private static String randString = "23456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghjklmnpqrstuxwxyz";//Randomly generated string

	private static int width = 70;//Picture wide
	private static int height = 30;//Picture high
	private static int lineSize = 40;//Number of interference lines
	private static int stringNum = 4;//Randomly generate the number of characters

	/*
	 * 获得字体
	 */
	private static Font getFont() {
		return new Font("Fixedsys", Font.CENTER_BASELINE, 18);
	}

	/**
	 * Get font
	 * te5l.com [K]
	 */
	private static Color getRandColor(int fc, int bc) {
		if (fc > 255)
			fc = 255;
		if (bc > 255)
			bc = 255;
		int r = fc + random.nextInt(bc - fc - 16);
		int g = fc + random.nextInt(bc - fc - 14);
		int b = fc + random.nextInt(bc - fc - 18);
		return new Color(r, g, b);
	}

	/**
	 * Generate random pictures
	 */
	public static void getRandcode(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		//The BufferedImage class is an Image class with a buffer, and the Image class is a class used to describe image information
		BufferedImage image = new BufferedImage(width, height, BufferedImage.TYPE_INT_BGR);
		Graphics g = image.getGraphics();//The Graphics object that produces the Image object, the object can be changed to perform various drawing operations on the image
		g.fillRect(0, 0, width, height);
		g.setFont(new Font("Times New Roman", Font.ROMAN_BASELINE, 18));
		g.setColor(getRandColor(110, 133));
		//Draw interference lines
		for (int i = 0; i <= lineSize; i++) {
			drowLine(g);
		}
		//Draw random characters
		String randomString = "";
		for (int i = 1; i <= stringNum; i++) {
			randomString = drowString(g, randomString, i);
		}
		session.setAttribute(SessionKey.VALIDATE_CODE, randomString);
		g.dispose();
		try {
			ImageIO.write(image, "JPEG", response.getOutputStream());//Output the pictures in the memory to the client in a streaming form
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * Draw string
	 */
	private static String drowString(Graphics g, String randomString, int i) {
		g.setFont(getFont());
		g.setColor(new Color(random.nextInt(101), random.nextInt(111), random.nextInt(121)));
		String rand = String.valueOf(getRandomString(random.nextInt(randString.length())));
		randomString += rand;
		g.translate(random.nextInt(3), random.nextInt(3));
		g.drawString(rand, 13 * i, 16);
		return randomString;
	}

	/**
	 * Draw interference lines
	 */
	private static void drowLine(Graphics g) {
		int x = random.nextInt(width);
		int y = random.nextInt(height);
		g.drawLine(x, y, x + random.nextInt(13), y + random.nextInt(15));
	}

	/**
	 * Get random characters
	 */
	public static String getRandomString(int num) {
		return String.valueOf(randString.charAt(num));
	}
}