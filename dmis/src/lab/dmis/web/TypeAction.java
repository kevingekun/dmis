package lab.dmis.web;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.annotation.Resource;

import lab.common.web.BaseAction;
import lab.dmis.model.Type;
import lab.dmis.service.TypeService;
import net.sf.json.JSONArray;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

@Component("typeAction")
@Scope("prototype")
public class TypeAction extends BaseAction {

	private static final long serialVersionUID = 1L;

	private TypeService typeServiceImpl;
	private int pageNo = 1;
	private int pageContSize = 8;

	/**
	 * 添加类别
	 * 
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	public String add() throws UnsupportedEncodingException {
		int fid = Integer
				.parseInt(getParameter("fid") != null ? getParameter("fid")
						: "-1");
		int sid = Integer
				.parseInt(getParameter("sid") != null ? getParameter("sid")
						: "-1");
		String typename = getParameter("typeName");
		typename = java.net.URLDecoder.decode(typename, "utf-8");
		Type type = new Type();
		if (sid != -1) {
			type.setName(typename);
			type.setParent(findById(sid));
			type.setLevel(3);
			typeServiceImpl.addType(type);
		} else if (fid != -1) {
			type.setName(typename);
			type.setParent(findById(fid));
			type.setLevel(2);
			typeServiceImpl.addType(type);
		} else {
			type.setName(typename);
			type.setParent(findById(1));
			type.setLevel(1);
			typeServiceImpl.addType(type);
		}
		setAttribute("page", typeServiceImpl.getPage(pageNo, pageContSize));
		setAttribute("state", 0);
		return "list";
	}

	/**
	 * 分页显示类型
	 * 
	 * @return
	 */
	public String list() {
		int state = Integer.parseInt(getParameter("state"));
		setAttribute("firstType", typeServiceImpl.firstType()); // 查询所有一级类别，存到firstType,前台遍历firstType
		if (getParameter("pageNo") == null) {
			setAttribute("page",
					typeServiceImpl.getPage(state, pageNo, pageContSize));
			setAttribute("state", state);
			return "list";
		} else {
			setAttribute("page", typeServiceImpl.getPage(state,
					Integer.parseInt(getParameter("pageNo")), pageContSize));
			setAttribute("state", state);
			return "list";
		}
	}

	public void listByParentId() throws IOException {
		String parentId = getParameter("parentid");
		JSONArray json = JSONArray.fromObject(typeServiceImpl
				.searchTypeByParentId(parentId));
		/*
		 * JsonConfig cfg = new JsonConfig(); cfg.setExcludes(new String[] {
		 * "docs" }); JSONArray json = JSONArray.fromObject(list, cfg);
		 */
		getResponse().setCharacterEncoding("utf-8");
		getResponse().getWriter().write(json.toString());
	}

	public Type findById(int id) {
		return typeServiceImpl.findById(id);
	}

	public void findByName() throws IOException {
		String typeName = java.net.URLDecoder.decode(getParameter("typeName"),
				"UTF-8");
		// System.err.println(typeName);
		List<Type> list = typeServiceImpl.getByName(typeName);
		if (list.size() == 0) {
			out().print("true");
		} else {
			out().print("false");
		}
	}

	/**
	 * 删除
	 * 
	 * @return
	 */
	public String delete() {
		int state = Integer.parseInt(getParameter("state"));
		List<String> ids = new ArrayList<String>();
		String id = getParameter("id");
		if (id != null) {
			ids.add(id);
		} else {
			ids = Arrays.asList(getRequest().getParameterValues("checkAll"));
		}
		typeServiceImpl.deleteByIds(ids);
		int totalpage = typeServiceImpl.getPage(state, pageNo, pageContSize)
				.getTotalPage();
		pageNo = Integer.parseInt(getParameter("pageNo"));
		if (totalpage < pageNo) {
			pageNo = pageNo - 1;
		}
		setAttribute("page",
				typeServiceImpl.getPage(state, pageNo, pageContSize));
		setAttribute("firstType", typeServiceImpl.firstType());
		setAttribute("state", state);
		return "list";
	}

	public TypeService getTypeServiceImpl() {
		return typeServiceImpl;
	}

	@Resource
	public void setTypeServiceImpl(TypeService typeServiceImpl) {
		this.typeServiceImpl = typeServiceImpl;
	}
}
