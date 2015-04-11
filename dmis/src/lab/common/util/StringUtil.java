package lab.common.util;

import java.io.File;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.List;
import java.util.Random;

public class StringUtil {
	public static final String COLON = ":";
	public static final String COMMA = ",";
	public static final String EMPTY = "";
	public static final String UNDER_LINE = "_";
	public static final String ENDL = "\n";
	public static final String SLASH = "/";
	public static final String BLANK = " ";
	public static final String DOT = ".";
	public static final String FILE_SEPARATOR = File.separator;

	public static String encodePassword(String paramString) {
		String str = null;
		try {
			str = encodePassword(paramString, "MD5");
		} catch (NoSuchAlgorithmException localNoSuchAlgorithmException) {
			localNoSuchAlgorithmException.printStackTrace();
		}
		return str;
	}

	public static String changeList2String(List<String> paramList) {
		String str = paramList.toString();
		return str.substring(1, str.length() - 1);
	}

	public static boolean isBlank(String paramString) {
		int i = 0;
		if ((paramString == null) || ("".equals(paramString.trim())))
			i = 1;
		if (i == 1) {
			return true;
		} else
			return false;
	}

	public static boolean isNotBlank(String paramString) {
		int i = 0;
		if ((paramString != null) && (!("".equals(paramString))))
			i = 1;
		if (i == 1) {
			return true;
		} else
			return false;
	}

	public static String encodePassword(String paramString1, String paramString2)
			throws NoSuchAlgorithmException {
		byte[] arrayOfByte1 = paramString1.getBytes();
		MessageDigest localMessageDigest = null;
		localMessageDigest = MessageDigest.getInstance(paramString2);
		localMessageDigest.reset();
		localMessageDigest.update(arrayOfByte1);
		byte[] arrayOfByte2 = localMessageDigest.digest();
		StringBuffer localStringBuffer = new StringBuffer();
		for (int i = 0; i < arrayOfByte2.length; ++i) {
			if ((arrayOfByte2[i] & 0xFF) < 16)
				localStringBuffer.append("0");
			localStringBuffer.append(Long.toString(arrayOfByte2[i] & 0xFF, 16));
		}
		return localStringBuffer.toString();
	}

	public static boolean isEmpty(String paramString) {
		if (paramString == null)
			return true;
		return ("".equals(paramString));
	}

	public static String getRandomString(int paramInt) {
		StringBuffer localStringBuffer = new StringBuffer();
		Random localRandom = new Random();
		for (int i = 0; i < paramInt; ++i) {
			int j;
			do
				if ((j = localRandom.nextInt(90)) > 64)
					break;
			while ((j = localRandom.nextInt(122)) <= 97);
			localStringBuffer.append((char) j);
		}
		return localStringBuffer.toString();
	}

	public static boolean contains(String[] paramArrayOfString,
			String paramString) {
		if (paramArrayOfString != null)
			for (int i = 0; i < paramArrayOfString.length; ++i)
				if (paramString.equals(paramArrayOfString[i]))
					return true;
		return false;
	}

	public static String ljustZero(String paramString, int paramInt) {
		String str = "";
		for (int i = 0; i < paramInt - paramString.length(); ++i)
			str = str + "0";
		str = str + paramString;
		return str;
	}

	public static int getWordLength(String paramString) {
		int i = 0;
		if (isBlank(paramString))
			return i;
		char[] arrayOfChar = paramString.toCharArray();
		for (int j = 0; j < arrayOfChar.length; ++j)
			if (isChinese(arrayOfChar[j]))
				i += 2;
			else
				i += 1;
		return i;
	}

	public static String getWord(String paramString, int paramInt) {
		char[] arrayOfChar = paramString.toCharArray();
		StringBuffer localStringBuffer = new StringBuffer();
		int i = 0;
		for (int j = 0; j < arrayOfChar.length; ++j) {
			if (isChinese(arrayOfChar[j]))
				i += 2;
			else
				i += 1;
			if (i > paramInt)
				break;
			localStringBuffer.append(arrayOfChar[j]);
		}
		return localStringBuffer.toString();
	}

	public static boolean hasChinese(String paramString) {
		if (paramString == null)
			return true;
		char[] arrayOfChar = paramString.toCharArray();
		for (int i = 0; i < arrayOfChar.length; ++i)
			if (isChinese(arrayOfChar[i]))
				return true;
		return false;
	}

	public static boolean isChinese(char paramChar) {
		Character.UnicodeBlock localUnicodeBlock = Character.UnicodeBlock
				.of(paramChar);
		return ((localUnicodeBlock != Character.UnicodeBlock.CJK_UNIFIED_IDEOGRAPHS)
				&& (localUnicodeBlock != Character.UnicodeBlock.CJK_COMPATIBILITY_IDEOGRAPHS)
				&& (localUnicodeBlock != Character.UnicodeBlock.CJK_UNIFIED_IDEOGRAPHS_EXTENSION_A)
				&& (localUnicodeBlock != Character.UnicodeBlock.GENERAL_PUNCTUATION)
				&& (localUnicodeBlock != Character.UnicodeBlock.CJK_SYMBOLS_AND_PUNCTUATION) && (localUnicodeBlock != Character.UnicodeBlock.HALFWIDTH_AND_FULLWIDTH_FORMS));
	}

	public static String[] splitIntoArr(String paramString) {
		if (isEmpty(paramString))
			return new String[0];
		return paramString.split(",");
	}

	public static String join(String[] paramArrayOfString) {
		return join(paramArrayOfString, ",", "'");
	}

	public static String join(String[] paramArrayOfString, String paramString) {
		return join(paramArrayOfString, ",", "");
	}

	public static String join(String[] paramArrayOfString, String paramString1,
			String paramString2) {
		String str = "";
		for (int i = 0; i < paramArrayOfString.length; ++i) {
			str = str + paramString2 + paramArrayOfString[i] + paramString2;
			if (i == paramArrayOfString.length - 1)
				continue;
			str = str + paramString1;
		}
		return str;
	}

	public static String convertCode(String paramString1, String paramString2,
			String paramString3) {
		try {
			if (paramString1 == null)
				return null;
			if (paramString1.equals(""))
				return "";
			return new String(paramString1.getBytes(paramString2), paramString3);
		} catch (Exception localException) {
			return localException.toString();
		}

	}

	public static boolean isUpperCase(String paramString) {
		int i = 1;
		for (int k = 0; k < paramString.length(); ++k) {
			int j = paramString.charAt(k);
			if ((j >= 65) && (j <= 90))
				continue;
			i = 0;
		}
		if (i == 1) {
			return true;
		} else
			return false;
	}

	public static boolean isLowerCase(String paramString) {
		int i = 1;
		for (int k = 0; k < paramString.length(); ++k) {
			int j = paramString.charAt(k);
			if ((j >= 97) && (j <= 122))
				continue;
			i = 0;
		}
		if (i == 1) {
			return true;
		} else
			return false;
	}

	public static String toTrimString(String str) {
		if (str != null) {
			return str.trim();
		} else {
			return "";
		}
	}


	/**
	 * 
	 * @Title: isNull
	 * @Description: 如果字符串为空返回true
	 * @param src
	 * @return
	 */
	public static boolean isNull(String src) {
		return src == null;
	}

	public static boolean isEmptyOrNull(String src) {
		return isNull(src) || isEmpty(src);
	}

	/**
	 * 
	 * @Title: verifyAlphanumericUnderline
	 * @Description: 验证字符串是否由字母数字下划线组�?
	 * @return
	 * @throws
	 */
	public static boolean verifyAlphanumericUnderline(String src) {
		if (!isEmptyOrNull(src)) {
			return src.matches("[0-9A-Za-z_]*");
		}
		return false;
	}
}