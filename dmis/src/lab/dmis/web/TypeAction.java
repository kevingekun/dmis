package lab.dmis.web;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;

import net.sf.json.JSONArray;
import net.sf.json.JsonConfig;
import net.sf.json.util.PropertyFilter;

import org.springframework.beans.factory.annotation.Autowired;

import lab.common.web.BaseAction;
import lab.dmis.model.Type;
import lab.dmis.service.TypeService;
import lab.dmis.util.JsonSerialization;
import lab.dmis.util.Str;

public class TypeAction extends BaseAction{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Autowired
	private TypeService typeService;
	private int pageNo = 1;
	private int pageContSize = 4;
	
	@SuppressWarnings("rawtypes")
	List<?> list = new ArrayList();
	
	
	/**
	 * 获取分类
	 * @return
	 * @throws IOException 
	 */
	public void getType() throws IOException{
		list = typeService.getType();
		out().print(JSONArray.fromObject(list,JsonSerialization.jsonSer(Str.str)).toString());
	}
	/*
	 * 添加类别
	 */
	public String add() throws UnsupportedEncodingException{
		int fid = Integer.parseInt(getParameter("fid")!=null?getParameter("fid"):"-1");
		int sid = Integer.parseInt(getParameter("sid")!=null?getParameter("sid"):"-1");
		String typename = getParameter("typeName");
		typename = java.net.URLDecoder.decode(typename, "utf-8");
		Type type = new Type();
		if(sid!=-1){
			type.setName(typename);
			type.setParentId(sid);
			type.setLevel(3);
			typeService.addType(type);
		}else if(fid!=-1){
			type.setName(typename);
			type.setParentId(fid);
			type.setLevel(2);
			typeService.addType(type);
		}else{
			type.setName(typename);
			type.setParentId(0);
			type.setLevel(1);
			typeService.addType(type);
		}
		return "listAll";
	}
	public String listAll(){
		setAttribute("firstType", typeService.firstType());		//查询所有一级类别，存到firstType,前台遍历firstType
		if(getParameter("pageNo")==null){
			setAttribute("page", typeService.getPage(pageNo, pageContSize));
			setAttribute("state",0);
			return "list";
			
		}else{
			setAttribute("page", typeService.getPage(Integer.parseInt(getParameter("pageNo")), pageContSize));
			setAttribute("state",0);
			return "list";
		}
	}
	/**
	 * 分页显示类型
	 * @return
	 */
	public String list(){
		int state = Integer.parseInt(getParameter("state"));
		setAttribute("firstType", typeService.firstType());			//查询所有一级类别，存到firstType,前台遍历firstType
		if(getParameter("pageNo") == null){
			setAttribute("page", typeService.getPage(state,pageNo, pageContSize));
			setAttribute("state",state);
			return "list";
		}else{
			setAttribute("page", typeService.getPage(state,Integer.parseInt(getParameter("pageNo")), pageContSize));
			setAttribute("state",state);
			return "list";
		}
	}
	public void lista() throws IOException{
		List<Type> list = typeService.firstType();
		JsonConfig cfg = new JsonConfig();
	    cfg.setExcludes(new String[]{"docs"});
		JSONArray json = JSONArray.fromObject(list,cfg);
		getResponse().setCharacterEncoding("utf-8");
		getResponse().getWriter().write(json.toString());
	}
	public void listaByParentId()throws IOException{
		int parentid = Integer.parseInt(getParameter("parentid"));
		List<Type> listTwo = typeService.secondType(parentid);
		JsonConfig cfg = new JsonConfig();
	    cfg.setExcludes(new String[]{"docs"});
		JSONArray json = JSONArray.fromObject(listTwo,cfg);
		//JSONArray json = JSONArray.fromObject();
		getResponse().setCharacterEncoding("utf-8");
		getResponse().getWriter().write(json.toString());
	}
	public void listaaByParentId()throws IOException{
		int parentid = Integer.parseInt(getParameter("parentid"));
		List<Type> listThree = typeService.thirdType(parentid);
		JsonConfig cfg = new JsonConfig();
	    cfg.setExcludes(new String[]{"docs"});
		JSONArray json = JSONArray.fromObject(listThree,cfg);
		//JSONArray json = JSONArray.fromObject();
		getResponse().setCharacterEncoding("utf-8");
		getResponse().getWriter().write(json.toString());
	}
	public void listByParentId() throws IOException{
		int parentid = Integer.parseInt(getParameter("parentid"));
		JSONArray json = JSONArray.fromObject(typeService.secondType(parentid));
		getResponse().setCharacterEncoding("utf-8");
		getResponse().getWriter().write(json.toString());
	}
	/**
	 * 单个删除
	 * @return
	 */
	public String delete(){
		typeService.deleteTypeById(Integer.parseInt(getParameter("id")));
		int totalpage = typeService.getPage(pageNo, pageContSize).getTotalPage();
		pageNo = Integer.parseInt(getParameter("pageNo"));
		if(totalpage<pageNo){
			pageNo = pageNo - 1;
		}
		getRequest().setAttribute("pageNo", pageNo);
		return "delete_success";
	}
	/**
	 * 批量删除
	 * @return
	 */
	public String delete_check(){
		String[] ids = getRequest().getParameterValues("checkAll");
		typeService.deleteByIds(ids);
		int totalpage = typeService.getPage(pageNo, pageContSize).getTotalPage();
		pageNo = Integer.parseInt(getParameter("pageNo"));
		if(totalpage<pageNo){
			pageNo = pageNo - 1;
		}
		getRequest().setAttribute("pageNo", pageNo);
		return "delete_success";
	}
	
	public TypeService getTypeService() {
		return typeService;
	}

	public void setTypeService(TypeService typeService) {
		this.typeService = typeService;
	}
	
	
}
