package lab.common.util;


import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;


public class FILE {
	
	 public static boolean chkIsFile(String FileName) {
		
		 try{
			 File f=(new File(FileName));
			 return f.isFile();
		 }catch(Exception e) {
			 return false;
		 }
    }
	 public static boolean chkIsFile(File f) {
			
		 try{
			 return f.isFile();
		 }catch(Exception e) {
			 return false;
		 }
    }
	 public static long chkExistsFile(File f) {
		
		 if (f.exists()) {
			 return f.length(); 
		 }else {
			 return -1;
		 }
    }
    public static long chkExistsFile(String FileName) {
    	long ret=-1;
    	if (null!=FileName&&!"".equals(FileName)){
			 File f=(new File(FileName));
			 //f.lastModified();
			 
			 if (f.exists()) {
				 ret= f.length(); 
			 }		 
			 f=null;
    	}
		return ret;
    }
    public static long lastFileModified(String FileName) {
		 File f=(new File(FileName));
		 if (f.exists()) {
			 return f.lastModified(); 
		 }else {
			 return -1;
		 }
    }
    public static boolean DeleteFile(String FileName) {
		 File f=(new File(FileName));
		 if (f.exists()) {
			 return f.delete();
		 }else {
			 return false;
		 }
    } 
    public  static   boolean     MoveFile(String     oldPath,     String     newPath)    
    {    
        try     {    
  			//int bytesum = 0;
  			int byteread = 0;
  			File oldfile = new File(oldPath);
  			if (oldfile.exists()) {
  				InputStream inStream = new FileInputStream(oldPath);
  				FileOutputStream fs = new FileOutputStream(newPath);
  				byte[] buffer = new byte[1024];
  				// int length;
  				while ((byteread = inStream.read(buffer)) != -1) {
  					//bytesum += byteread;
  					// System.out.println(bytesum);
  					fs.write(buffer, 0, byteread);
  				}
  				inStream.close();
  				fs.close();
  			}
  			oldfile.deleteOnExit();
            return true;
        }    
        catch     (Exception     e)     {
                e.printStackTrace();
                return false;
        }    
  }   
    public static boolean CopyFile(File F1,File F2)    
    {    
      	try{    
      		//int bytesum = 0;
			int byteread = 0;
  			if (F1.exists()) {
  				InputStream inStream = new FileInputStream(F1);
  				FileOutputStream fs = new FileOutputStream(F2);
  				byte[] buffer = new byte[1024];
  				
  				while ((byteread = inStream.read(buffer)) != -1) {
  					//bytesum += byteread;
  					fs.write(buffer, 0, byteread);	
  				}
  				inStream.close();
  				fs.close();
  				return true;
  			}
        }    
        catch (Exception e){     
        	e.printStackTrace();
        } 
        return false;
    }  
  
  public static boolean CopyFile(String oldPath,String newPath,boolean Flag)    
  {    
    	try{    
			//int bytesum = 0;
			int byteread = 0;
			File oldfile = new File(oldPath);
			if (oldfile.exists()) {
				InputStream inStream = new FileInputStream(oldPath);
				FileOutputStream fs = new FileOutputStream(newPath,Flag);
				byte[] buffer = new byte[1024];
				
				while ((byteread = inStream.read(buffer)) != -1) {
					//bytesum += byteread;
					fs.write(buffer, 0, byteread);	
				}
				inStream.close();
				fs.close();
				return true;
			}
      }catch (Exception e){   
    	  e.printStackTrace();
			
      } 
    	return false;
  }  
   
   
    public static String getFileExt(String fileName) {
   	 String ext="";
   	 /*
   	 if (fileName.indexOf(".")>0){
   		 ext=fileName.substring(fileName.indexOf(".")+1);
   	 }
   	 if (fileName.indexOf("?")>0){
   		 ext=fileName.substring(0, fileName.indexOf("?"));
   	 }
   	 */
   	if (fileName.lastIndexOf(".") > 0) {
		ext = fileName.substring(fileName.lastIndexOf(".") + 1);
	}
	if (fileName.indexOf("?") > 0) {
		ext = fileName.substring(fileName.lastIndexOf("."), fileName.indexOf("?"));
	}
		return ext;
	}
    
    public static void CreateDir(String newDirStr){
		File baseFile=new File(newDirStr);
		if(!baseFile.exists()){
			baseFile.mkdir();
		}
	}
    public static void chkPathCreateDir(String SavePath){
		String[] filePath=SavePath.replace("\\", "/").split("/");
		String tmp= filePath[0];
		for (int i=1;i<filePath.length;i++)
			if (!"".equals(filePath[i])){
					tmp=tmp+"\\"+filePath[i];
					CreateDir(tmp);
			}
	}
    public   static   String   getAppPath()   { 
    	File   dir	=   new   File( ". "); 
    	try {
			return dir.getCanonicalPath();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	return null;
    }
    public static boolean chkExt(String ext,String[] chkFileExt){
	   	 boolean ret=false;
	   	 if (null!=ext && null!=chkFileExt){
	   		 if (chkFileExt[0].equals("*")) return true;
			 for (int i=0;i<chkFileExt.length;i++)
			 if (ext.toLowerCase().equals(chkFileExt[i].toLowerCase())){
				 ret=true;
				 break;
			 }
	   	 }
		 return ret;
	 }
    public static String getFileSaveName(String Path,String fileName){
		String newName=fileName;
		String nameWithoutExt=getNameWithoutExtension(fileName);
		String ext=FILE.getFileExt(fileName);
		File pathToSave=new File(Path,newName);
		int counter=1;
		while(pathToSave.exists()){
			newName=nameWithoutExt+"_"+counter+"."+ext;
			pathToSave=new File(Path,newName);
			counter++;
			}
		return newName;
	}
    private static String getNameWithoutExtension(String fileName) {
		return fileName.substring(0, fileName.lastIndexOf("."));
	}
    public static String getNameOnly(String fileName) {
		String tmp=fileName.substring(0, fileName.lastIndexOf("."));
		String[] filePath=tmp.replace("\\", "/").split("/");
		return filePath[filePath.length-1];
	}
    
}
