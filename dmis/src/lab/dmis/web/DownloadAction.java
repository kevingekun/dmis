package lab.dmis.web;

import java.io.File;
import java.io.InputStream;

import lab.common.web.BaseAction;

import org.apache.struts2.ServletActionContext;

	 
public class DownloadAction extends BaseAction{	
	private static final long serialVersionUID = 1L;	
	/*
	 * 下载文档
	 */ 	
	private String downPath;
	
	
	//从原始存放路径读取到文件输出流 	
	public InputStream getDownLoadFile() throws Exception{
		
		String fileName = downPath.substring(downPath.lastIndexOf("/")+1);

		//System.out.println("转码之前文件名"+fileName);

		String getChineseFileName = new String(fileName.getBytes("ISO-8859-1"), "UTF-8");
		//System.out.println("文件名称转码之后:"+getChineseFileName);
		String downPath = "doc/"+getChineseFileName;
		//获取服务器文件流路径
		return ServletActionContext.getServletContext().getResourceAsStream(downPath);
		
	}
	
	public String getDownloadFileName(){
		String fileName = downPath.substring(downPath.lastIndexOf("-")+1);
		
		return fileName;
	}
			public String execute() throws Exception{
				
				//System.out.println("开始下载文件...");
				return "loadSuccess"; 
			}
			
			public String getDownPath() {
				return downPath;
			}
			public void setDownPath(String downPath) {
				this.downPath = downPath;
			}
	
}