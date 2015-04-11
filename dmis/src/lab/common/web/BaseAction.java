package lab.common.web;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;


public class BaseAction extends ActionSupport{
	
	protected InputStream inputStream;
	
	protected void setAttribute(String key,Object value) {
		try {
			getRequest().setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		getRequest().setAttribute(key, value);
	}
	
	protected String getParameter(String paramName) {
		return getRequest().getParameter(paramName);
	}
	protected Object getAttribute(String paramName) {
		return getSession().getAttribute(paramName);
	}

	public HttpServletRequest getRequest() {
		return ServletActionContext.getRequest();
	}

	public HttpServletResponse getResponse() {
		return ServletActionContext.getResponse();
	}
	
	public HttpSession getSession() {
		return getRequest().getSession();
	}
	
	public ServletContext getServletContext() {
		return ServletActionContext.getServletContext();
	}

	public String getRealyPath(String path) {
		return getServletContext().getRealPath(path);
	}
	
	public Map<String, Object> getSessionMap() {
		return ActionContext.getContext().getSession();
	}
	
	public void putObjToSession(String key, Object obj) {
		this.getSessionMap().put(key, obj);
	}
	
	public void removeObjFromSession(String key) {
		this.getSessionMap().remove(key);
	}
	
	public Object getObjFromSession(String key) {
		return this.getSessionMap().get(key);
	}

	public InputStream getInputStream() {
		return inputStream;
	}
	public  ByteArrayInputStream outStream(String bytes){
		return new ByteArrayInputStream(bytes.getBytes());
	}
	public PrintWriter out() throws IOException{
		getResponse().setContentType("text/html;charset=utf-8");
		return getResponse().getWriter();
	}
	public String getActionName(){
		return ServletActionContext.getActionMapping().getName();
	}
	
}
