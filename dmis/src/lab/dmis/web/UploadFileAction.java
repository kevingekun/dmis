package lab.dmis.web;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;

import lab.common.util.Constant;
import lab.common.util.FileUploadOrDelete;
import lab.common.util.ImageCutOut;
import lab.common.util.Tool;
import lab.common.web.BaseAction;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

/**
 * 上传文件的action,单文件上传
 * @author CS-Tao
 */

@Component
@Scope("prototype")
public class UploadFileAction extends BaseAction {

	private static final long serialVersionUID = 1L;

	// 上传文件的参数
	private File uploadify;
	private String uploadifyFileName;
	private String uploadifyContentType;
	private String param;
	
	private InputStream inputStream;
	
	/**
	 * 异步上传文件
	 * @return
	 */
	public String asyn() {
		String retmsg = "error";
		String uploadifyfilePath = getServletContext().getInitParameter("uploadFilePath");
		if (null == uploadify) {
			inputStream = new ByteArrayInputStream(retmsg.getBytes());
			return "asyn";
		}
		
		if (null != param) {
			String userDirectory =  param+"/img" ;
			/*if ("application".equalsIgnoreCase(uploadifyContentType)) {
				retmsg = "不被允许的文件类型!";
			}else {
				
			}*/
			FileUploadOrDelete upfile = new FileUploadOrDelete(uploadifyfilePath, userDirectory, uploadifyFileName);
			boolean isSuccess = upfile.uploadFile(uploadify);
			if (isSuccess) {
				System.out.println(upfile.getMappingPathInDB());
				System.out.println(upfile.getUpFileSavePath());
				retmsg = upfile.getMappingPathInDB();
			}
		}
		System.out.println(retmsg);
		try {
			inputStream = new ByteArrayInputStream(retmsg.getBytes("UTF-8"));
		} catch (UnsupportedEncodingException e1) {
			e1.printStackTrace();
		}
		return "resultstream";
	}
	
	/**
	 * 图像裁剪
	 * @return
	 */
	public String imageCutOut(){
		boolean isSuccess = false;
		String picPath = super.getParameter("picPath");
		String uploadifyfilePath = getServletContext().getInitParameter("uploadFilePath");
System.out.println(super.getParameter("x"));
		float x = Float.parseFloat(super.getParameter("x")) ;
		float y = Float.parseFloat(super.getParameter("y")) ;
		float w = Float.parseFloat(super.getParameter("w")) ;
		float h = Float.parseFloat(super.getParameter("h")) ;
		if (null != picPath && !"".equals(picPath) && w != 0 && h != 0) {
			String tempPath = uploadifyfilePath + picPath.substring(Constant.FILEMAPDBPREFX.length());
			isSuccess = ImageCutOut.imgcut(tempPath, x, y, w, h);
		}
		try {
			inputStream = new ByteArrayInputStream((isSuccess?"success":"failed").getBytes("UTF-8"));
		} catch (UnsupportedEncodingException e1) {
			e1.printStackTrace();
		}
		return "resultstream";
	}
	
	
	
	
	public File getUploadify() {
		return uploadify;
	}

	public void setUploadify(File uploadify) {
		this.uploadify = uploadify;
	}

	public String getUploadifyFileName() {
		return uploadifyFileName;
	}

	public void setUploadifyFileName(String uploadifyFileName) {
		System.out.println(getParameter("imagename"));
		System.out.println(getParameter("param"));
		if (!"".equals(getParameter("imagename")) && null != getParameter("imagename")) {
			this.uploadifyFileName = getParameter("imagename");
		}else {
			String type = uploadifyFileName.substring(uploadifyFileName.lastIndexOf("."));
			this.uploadifyFileName = Tool.getUUIDStr()+type;
		}
	}

	public String getUploadifyContentType() {
		return uploadifyContentType;
	}

	public void setUploadifyContentType(String uploadifyContentType) {
		try {
			this.uploadifyContentType = uploadifyContentType.split("/")[0];
		} catch (Exception e) {
			this.uploadifyContentType = null;
		}
	}

	public String getParam() {
		return param;
	}

	public void setParam(String param) {
		this.param = param;
	}

	public InputStream getInputStream() {
		return inputStream;
	}

	public void setInputStream(InputStream inputStream) {
		this.inputStream = inputStream;
	}

}
