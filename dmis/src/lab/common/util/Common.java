package lab.common.util;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.UnsupportedEncodingException;
import java.io.Writer;
import java.net.URLEncoder;
import java.net.URLDecoder;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.StringTokenizer;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.aspectj.weaver.patterns.ThisOrTargetAnnotationPointcut;

/**
 * 系统公用函数定义
 * 
 * 
 */
public class Common
{
	
//	// 系统配置参数
//	public static AppConfig			appConfig	= null;	
//	public static List<OptionsInt> hour = new ArrayList<OptionsInt>();
//	public static List<OptionsInt> min = new ArrayList<OptionsInt>();
//	
//	static {
//		for (int i = 0; i <= 23; i++) {
//			hour.add(new OptionsInt(i, String.valueOf(i)));
//		}
//		for (int i = 0; i <= 55; i=i+5) {
//			min.add(new OptionsInt(i, String.valueOf(i)));
//		}
//	}
	
	public static String getSession(HttpServletRequest request, String str)
	{
		HttpSession httpSession = request.getSession();
		String strSessValue = (String) httpSession.getAttribute(str);
		return strSessValue;
	}
	
//	public static User getSessionUser()
//	{
//		ActionContext context = ActionContext.getContext(); 
//	    Map session = context.getSession();
//	    User user = (User)session.get("user");
//	    return user;
//	}
	
	public static Date getNowTime(String strDate,String strFormat){		
		DateFormat format = new SimpleDateFormat(strFormat);
		Date date = null;
		try
		{
			date = format.parse(strDate);
		} catch(Exception e){}
		return date;
	}
	
	public static String formatDateTime(Date date,String format) {
		SimpleDateFormat outFormat = new SimpleDateFormat(format);
		return outFormat.format(date);
	}
	

	public static Timestamp getTimestampTime(int n){
		Timestamp CreateDate = Timestamp.valueOf(getTime(1,n));
		return CreateDate;
		
	}

	public static String getTime(int type,int n)
	{
		String t = null;
		SimpleDateFormat format = null;
		Calendar cal = Calendar.getInstance();
		cal.set(Calendar.YEAR,cal.get(Calendar.YEAR)-n);
		switch (type)
		{
			case 0:
				format = new SimpleDateFormat("yyyyMMddHHmmss");
				break;
			case 1:
				format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				break;
			case 2:
				format = new SimpleDateFormat("yyyy年MM月dd日 HH:mm:ss");
				break;
			case 3:
				format = new SimpleDateFormat("yyyy年MM月dd日 HH时mm分ss秒");
				break;
			case 4:
				format = new SimpleDateFormat("yyyy-MM-dd");
				break;
			case 5:
				format = new SimpleDateFormat("yyyy-M-d HH:mm:ss");
				break;
			case 6:
				format = new SimpleDateFormat("yyyyMMdd");
				break;
			case 7:
				format = new SimpleDateFormat("yyyy-MM");
				break;
			case 8:
				format = new SimpleDateFormat("HH:mm:ss");
				break;
			default:
				format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				break;
		}
		t = format.format(cal.getTime());
		return t;
	}
	
	public static long getLongTime() {
		return System.currentTimeMillis();
	}
	
	public static long getNowSeconds(String strSDate) throws Exception {
		long intSeconds = 0;
		if (strSDate != null) {
			intSeconds = Common.getLongTime() - DateFormat.getDateTimeInstance().parse(strSDate).getTime();
			intSeconds = intSeconds / 1000;
		}
		return intSeconds;
	}
	
	public static Date strToDate(String dateStr) {
		Date dateTemp = null;
		try {
			dateStr = dateStr.substring(0, 10);
			StringTokenizer token = new StringTokenizer(dateStr, "-");
			int year = Integer.parseInt(token.nextToken());
			int month = Integer.parseInt(token.nextToken()) - 1;
			int day = Integer.parseInt(token.nextToken());
			Calendar cal = Calendar.getInstance();
			cal.set(year, month, day);
			dateTemp = cal.getTime();
		} catch (Exception ex) {
			System.out.println(ex.getMessage());
		}
		return dateTemp;
	}
	

	/**
	 * 返回当前日期加、减N天后的日期(如果需要结果是一个Date型的，需要转回)
	 * 
	 * @param outday
	 *          当前日期相差的天数(可以为负数)
	 * @return 返回当前日期加、减N天后的日期
	 */
	public static String returnNDay(int outday)
	{
		// 定义返回值
		String newdatetime = "";
		// 格式化日期
		SimpleDateFormat fmtdt = new SimpleDateFormat("yyyy-MM-dd");
		// 得到当前日期
		Calendar c = Calendar.getInstance();
		// 在当前日期的基础上加outday天(outday可以为负数)
		c.add(Calendar.DATE, outday);
		// 得到增加outday天后的日期
		Date tempnewdatetime = c.getTime();
		// 格式化增加outday天后的日期，并且转换为string
		newdatetime = fmtdt.format(tempnewdatetime).toString();
		return newdatetime;
	}
	
	/**
	 * 返回UUID
	 * 
	 * @return
	 */
	public static String getUUID()
	{
		return UUID.randomUUID().toString();
	}
	
	/**
	 * 返回没有"-"的UUID
	 * 
	 * @return
	 */
	public static String getUUIDWithNumLetter(){
		return getUUID().replaceAll("-", "");
	}

	public static String null2String(Object s)
	{
		return s == null ? "" : s.toString();
	}

	public static int null2Int(Object s)
	{
		int v = 0;
		if (s != null)
		{
			try
			{
				v = Integer.parseInt(s.toString());
			}
			catch (Exception e)
			{
			}
		}
		return v;
	}

	public static String encodeURL(String url)
	{
		if (url != null && url.length() > 0)
		{
			try
			{
				return URLEncoder.encode(url, "GBK");
			}
			catch (UnsupportedEncodingException ex)
			{
				return url;
			}
		}
		return url;
	}
	
	public static String decodeURL(String url)
	{
		if (url != null && url.length() > 0)
		{
			try
			{
				url = new String(url.getBytes("iso8859_1"));
				return URLDecoder.decode(url,"GBK");
			}
			catch (UnsupportedEncodingException ex)
			{
				return url;
			}
		}
		return url;
	}

	
	/**
	 * 判断文件夹是否存在，如果不存在则新建
	 * @param request
	 * @return
	 */
	
	public static void uploadFolder(String folderPath)
	{
		try
		{

			File f = new File(folderPath);
			if (!f.exists())
			{
				f.mkdirs();
			}
		}
		catch (Exception ex){
				System.out.println("[uploadFolder] error:"+ex.getMessage());
		}
	}

	public static void writeFile(String strFileName, String strContent)throws Exception
	{
		try
		{
			FileOutputStream fos = new FileOutputStream(strFileName);
			Writer out = new OutputStreamWriter(fos, "utf-8");
			out.write(strContent);
			out.close();
		}
		catch (IOException e)
		{
			System.out.println("Common.writeFile error:" + e.getMessage());
		}
	}
	
	public static void writeFile(String msg, String filePath, String charset) {
	    try {
	      File file = new File(filePath);
	      if (file.exists()) {
	        file.delete();
	      }
	      FileOutputStream wf = new FileOutputStream(filePath);
	      wf.write(msg.getBytes(charset));
	      wf.close();
	      file = null;
	      wf = null;
	    }
	    catch (IOException e) {
	    	System.out.println("Common.writeFile error:" + e.getMessage());
	    }
	  }	

	
	public static final String replaceAll(String src, String fnd, String rep) {
		if (src == null || src.equals("")) {
			return "";
		}

		String dst = src;

		int idx = dst.indexOf(fnd);

		while (idx >= 0) {
			dst = dst.substring(0, idx) + rep
					+ dst.substring(idx + fnd.length(), dst.length());
			idx = dst.indexOf(fnd, idx + rep.length());
		}

		return dst;
	}
	
	public static String replaceUrl(String sourceUrl){
		if(sourceUrl == null || sourceUrl.equals("")){
		    return "";
		}
		String match = "<a.{1,30}href[^>]+>|</a>"; //清除链接,保留链接内容
		String temp = replaceAll(sourceUrl,match,"");  
		return temp;
	}
	

	public static String getFileExt(String fileName) {
		if (fileName != null) {
			String fileExt = "";
			fileName = fileName.toLowerCase();
			int index = fileName.lastIndexOf(".");
			fileExt = fileName.substring(index + 1, fileName.length());
			return fileExt;
		} else {
			return "";
		}
	}
	
	/**
	 * 判断目录是否存在，如果不存在则建立
	 *
	 * @param request
	 * @return
	 */
	public static boolean checkFolder(String fileRealPath) {
		boolean tt = false;
		try {

			File f = new File(fileRealPath);
			if (f.exists()) {
				tt = true;
			} else {
				tt = f.mkdirs();
			}
		} catch (Exception ex) {
			System.out.println("[checkFolder] error:" + ex.getMessage());
		}
		return tt;
	}
	
    /*判断是否为整数
     *return:int
     */
    public static boolean isInt(String str){
      try {
        @SuppressWarnings("unused")
		Integer I = new Integer(str);
        return true;
      }
      catch (Exception e) {
        return false;
      }
    }
    
//    /*通过文件夹编号自动解析类型,返回类型英文编号，类似：image
//     *return:string
//     */
//    public static String autoFileTypeByTypeID(String fileType){
//    	//appconfig.fileType=0(other);1(image):tiff,psd,eps,raw,pdf,png,pxr,mac,jpg,bmp,tga,vst,pcd,pct,gif,ai,fpx,img,cal,wi,png,eps,ai,sct,pdf,pdp,dxf;2(office):docx,docm,dotx,xlsx,xlsm,xltx,xltm,xlsb,xlam,pptx,pptm,potx,potm,ppam,ppsx,ppsm,sldx,sldm,thmx;3(text):txt;4(zip):zip,rar,jar,gz;5(video):mpg,mpeg,avi,dat,flv,vob,wmv,asf,rm,ra,ram,rmvb;6(audio):mp3,aac,wav,wma,cda,flac,m4a,mid,mka,mp2,mpa,mpc,ape,ofr,ogg,ra,wv,tta,ac3,dts;7(flash):swf,fla;8(exe):exe,com,bat,msi;9(pdf):pdf
//    	fileType = "." + fileType;
//    	String appFileType = Common.appConfig.getCanUpfileExt();
//    	int sIndex = appFileType.lastIndexOf(fileType + "(");
//    	if(sIndex != -1){
//	    	appFileType = appFileType.substring(sIndex,appFileType.length());
//	    	appFileType = appFileType.substring(2, appFileType.indexOf(")"));
//    	}else{
//    		appFileType = fileType;
//    	}
//    	return appFileType;
//    }
//    
//    /*通过文件扩展名自动解析类型,返回类型英文编号，类似：image
//     *return:string
//     */
//    
//    public static String autoFileTypeByFileExt(String fileExt){
//    	//appconfig.fileType=0(other);1(image):tiff,psd,eps,raw,pdf,png,pxr,mac,jpg,bmp,tga,vst,pcd,pct,gif,ai,fpx,img,cal,wi,png,eps,ai,sct,pdf,pdp,dxf;2(office):docx,docm,dotx,xlsx,xlsm,xltx,xltm,xlsb,xlam,pptx,pptm,potx,potm,ppam,ppsx,ppsm,sldx,sldm,thmx;3(text):txt;4(zip):zip,rar,jar,gz;5(video):mpg,mpeg,avi,dat,flv,vob,wmv,asf,rm,ra,ram,rmvb;6(audio):mp3,aac,wav,wma,cda,flac,m4a,mid,mka,mp2,mpa,mpc,ape,ofr,ogg,ra,wv,tta,ac3,dts;7(flash):swf,fla;8(exe):exe,com,bat,msi;9(pdf):pdf
//    	fileExt = "." + fileExt;
//    	String appFileType = Common.appConfig.getCanUpfileExt();
//    	int sIndex = appFileType.indexOf(fileExt);    	
//    	if(sIndex != -1){
//    		appFileType = appFileType.substring(0,sIndex);
//    		appFileType = appFileType.substring(appFileType.lastIndexOf("(")+1,appFileType.lastIndexOf(")"));
//    	}else{
//    		appFileType = Common.autoFileTypeByTypeID("0");
//    		//其他类型
//    	}
//    	return appFileType;
//    }
//    
//    /*通过文件扩展名自动解析类型,返回类型编号，类似：1
//    *return:string
//    */
//    
//    public static String autoFileTypeIDByFileExt(String fileExt){
//    	//appconfig.fileType=0(other);1(image):tiff,psd,eps,raw,pdf,png,pxr,mac,jpg,bmp,tga,vst,pcd,pct,gif,ai,fpx,img,cal,wi,png,eps,ai,sct,pdf,pdp,dxf;2(office):docx,docm,dotx,xlsx,xlsm,xltx,xltm,xlsb,xlam,pptx,pptm,potx,potm,ppam,ppsx,ppsm,sldx,sldm,thmx;3(text):txt;4(zip):zip,rar,jar,gz;5(video):mpg,mpeg,avi,dat,flv,vob,wmv,asf,rm,ra,ram,rmvb;6(audio):mp3,aac,wav,wma,cda,flac,m4a,mid,mka,mp2,mpa,mpc,ape,ofr,ogg,ra,wv,tta,ac3,dts;7(flash):swf,fla;8(exe):exe,com,bat,msi;9(pdf):pdf
//    	fileExt = "." + fileExt;
//    	String appFileType = Common.appConfig.getCanUpfileExt();
//    	int sIndex = appFileType.indexOf(fileExt);    	
//    	if(sIndex != -1){
//    		appFileType = appFileType.substring(0,sIndex);
//    		appFileType = appFileType.substring(appFileType.lastIndexOf(";")+1,appFileType.lastIndexOf("("));
//    	}else{
//    		appFileType = "0";
//    		//其他类型
//    	}
//    	return appFileType;
//    }
    
    
    /*文件大小单位自动转换
     *return:string
     */
    
    public static String autoFileUnit(Long fileSize){
    	String sizeUnit;
    	if (fileSize >= 1073741824){
    		sizeUnit = (fileSize/1073741824) + " GB";
    	}else if(fileSize >= 1048576){
    		sizeUnit = (fileSize/1048576) + " MB";
    	}else if(fileSize >= 1024){
    		sizeUnit = (fileSize/1024) + " KB";
    	}else{
    		sizeUnit = fileSize + " 字节";
    	}
    	return sizeUnit;
    } 

    public static final String getTopicHasMore(String line, int count) {
		if (line == null) {
			return null;
		}
		if (line.length() <= count) {
			return line;
		} else {
			return line.substring(0, count - 3) + "…";
		}
	}

	public static final String getTopicNoMore(String line, int count) {
		if (line == null) {
			return null;
		}
		if (line.length() <= count) {
			return line;
		} else {
			return line.substring(0, count);
		}
	}
	
	/**
	 * 分词器
	 */
	    @SuppressWarnings("unused")
		public static List<String>  Participle(String keyword)
	    {
	    	final String HEAD_END_STR = "";

		    final int PARTICIPLE_LENGTH = 2;

		    keyword = "" + keyword + "";

	        int length = keyword.length();
	        List<String> result = new ArrayList<String>();

	        for (int i = 0; i < length - 1; i++)
	        {
	            String str = keyword.substring(i, i + PARTICIPLE_LENGTH);
	            result.add(str);
	        }

	       return result;
	    }
}
