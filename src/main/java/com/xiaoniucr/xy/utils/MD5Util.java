/*
+--------------------------------------------------------------------------
|   mtons [#RELEASE_VERSION#]
|   ========================================
|   Copyright (c) 2014, 2015 mtons. All Rights Reserved
|   http://www.mtons.com
|
+---------------------------------------------------------------------------
*/
package com.xiaoniucr.xy.utils;


import org.springframework.util.StringUtils;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

/**
 * MD5 summary
 */
public class MD5Util {

	/**
	 * Md5 encryption of the string
	 *
	 * @param input original text
	 * @return ciphertext after md5
	 */
	public static String md5(String input) {
		try {
			// get a message digester
			MessageDigest digest = MessageDigest.getInstance("md5");
			byte[] result = digest.digest(input.getBytes());
			StringBuffer buffer = new StringBuffer();
			// Do an AND operation for each byte 0xff;
			for (byte b : result) {
				// AND operation
				int number = b & 0xff;
				String str = Integer.toHexString(number);
				if (str.length() == 1) {
					buffer.append("0");
				}
				buffer.append(str);
			}
			// The result of standard md5 encryption
			return buffer.toString();
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * Md5 encryption of the string
	 *
	 * @param input original text
	 * @param salt random number
	 * @return string
	 */
	public static String encryptPassword(String input, String salt) {
		if(StringUtils.isEmpty(salt)) {
			salt = "";
		}
		return md5(salt + md5(input));
	}

}
