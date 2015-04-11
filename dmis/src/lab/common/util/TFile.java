package lab.common.util;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;

public class TFile {

	/**
	 * 根据完整路径读取文件内容成stringBuffer
	 * @param fileName
	 */
	public static StringBuffer readFile2StringBuffer(String fileName){
		StringBuffer sb = null;
		if (null == fileName || "".equals(fileName)) {
			return null;
		}
		sb = new StringBuffer();
		
		try {
			InputStream is = new FileInputStream(fileName);
			BufferedReader reader = new BufferedReader(new InputStreamReader(is));
			String lines;
			while ((lines = reader.readLine()) != null) {
				sb.append(lines);
			}
			is.close();
			reader.close();
		} catch (IOException e) {
		}
		return sb;
	}
	
	
	/**
	 * 判断传入的路径是否指文件
	 * @param fileName
	 * @return
	 */
	public static boolean isFile(String fileName){
		boolean isFile = false;
		if (null == fileName || "".equals(fileName)) {
			return isFile;
		}
		File file = new File(fileName);
		isFile = file.isFile()?true:false;
		file = null;
		return isFile;
	}
	
}
