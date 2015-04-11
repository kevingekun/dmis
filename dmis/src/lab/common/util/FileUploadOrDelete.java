package lab.common.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;

import org.apache.struts2.ServletActionContext;

public class FileUploadOrDelete {
	
	private String mappingPathInDB = null;		//数据库中保存的映射路�?
	private String upFileSavePath = null;		//上传文件要保存的物理路径
	private String prefixPath2Disk = null;
	
	/**
	 * 构�?方法,删除时使�?
	 * @param upFileSavePath
	 */
	public FileUploadOrDelete(){}
	
	/**
	 * 构�?方法
	 * @param prefixPath2Disk	配置的保存文件的前缀
	 * @param userDirectory		账号目录(用户ID+文件分类)
	 * @param uploadFileName	上传文件�?
	 */
	public FileUploadOrDelete(String prefixPath2Disk, String userDirectory, String uploadFileName){
		if (null == prefixPath2Disk || null == userDirectory || null == uploadFileName
			||"".equals(prefixPath2Disk) || "".equals(userDirectory) || "".equals(uploadFileName)) {
			return;
		}
		this.upFileSavePath = prefixPath2Disk + userDirectory +"\\" + uploadFileName;
		this.mappingPathInDB = Constant.FILEMAPDBPREFX + userDirectory + "/" + uploadFileName;
		this.prefixPath2Disk = prefixPath2Disk + userDirectory;
	}
	
	/**
	 * 上传文件
	 * @param upFile
	 * @return
	 */
	public boolean uploadFile(File upFile){
		if (null == mappingPathInDB || null == upFileSavePath || null == upFile) {
			return false;
		}
		System.out.println(this.upFileSavePath);
		System.out.println(this.mappingPathInDB);
		FileOutputStream fos = null;
		FileInputStream fis = null;
		try {
			File file = new File(this.prefixPath2Disk);
			if (!file.isDirectory()) {
				file.mkdirs();
			}
			fos = new FileOutputStream(new File(upFileSavePath));
			fis = new FileInputStream(upFile);
			byte[] buffer = new byte[1024];
			int len = 0;
			try {
				while ((len = fis.read(buffer)) > 0) {
					fos.write(buffer, 0, len);
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} finally {
			try {
				if (fos != null) {
					fos.close();
				}
				if (fis != null) {
					fis.close();
				}
			} catch (IOException e2) {
			}
		}
		
		return true;
	}
	
	/**
	 * 删除方法
	 * @param path
	 * @return
	 */
	public boolean deleteFile(String path){
		if (path != null && !"".equals(path)) {
			File file = new File(path);
			// 判断目录或文件是否存�?,不存在返�?
			if (!file.exists()) {
				return false;
			} else {
				file.delete();
				return true;
			}
		} else {
			return false;
		}
	}
	
	/**
	 * 删除文件,通过数据中的路径
	 * @param path
	 * @param dbpath
	 * @return
	 */
	public boolean deleteFile(String path, boolean dbpath){
		
		if (!dbpath) {
			if (null != path && !"".equals(path)) {
				File file = new File(path);
				// 判断目录或文件是否存�?,不存在返�?
				if (!file.exists()) {
					return false;
				} else {
					file.delete();
					return true;
				}
			} else {
				return false;
			}
		}else {
			if (null != path && !"".equals(path)) {
				String uploadfilePath = ServletActionContext.getServletContext().getInitParameter(Constant.UPLOADBASEPATH);
				String phyPath = uploadfilePath + path.substring(Constant.FILEMAPDBPREFX.length());
				File file = new File(phyPath);
				// 判断目录或文件是否存�?,不存在返�?
				if (!file.exists()) {
					return true;
				} else {
					file.delete();
					return true;
				}
			} else {
				return false;
			}
		}
	}	
	
	
	public String getMappingPathInDB() {
		return mappingPathInDB;
	}

	public void setMappingPathInDB(String mappingPathInDB) {
		this.mappingPathInDB = mappingPathInDB;
	}

	public String getUpFileSavePath() {
		return upFileSavePath;
	}

	public void setUpFileSavePath(String upFileSavePath) {
		this.upFileSavePath = upFileSavePath;
	}
}