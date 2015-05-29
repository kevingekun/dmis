package lab.dmis.web;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.List;

import javax.annotation.Resource;

import lab.common.web.BaseAction;
import lab.dmis.model.Type;
import lab.dmis.service.TypeService;
import lab.dmis.util.JsonSerialization;
import lab.dmis.util.Str;
import net.sf.json.JSONArray;
import net.sf.json.JsonConfig;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

@Component("typeAction")
@Scope("prototype")
public class TypeAction extends BaseAction {

	private static final long serialVersionUID = 1L;

	private TypeService typeServiceImpl;
	private int pageNo = 1;
	private int pageContSize = 4;

	/**
	 * 获取分类
	 * 
	 * @throws IOException
	 */
	public void getType() throws IOException {
		List<Type> list = typeServiceImpl.getType();
		out().print(
				JSONArray.fromObject(list, JsonSerialization.jsonSer(Str.str))
						.toString());
	}

	/*
	 * 添加类别
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
			// type.setParentId(sid);
			type.setLevel(3);
			typeServiceImpl.addType(type);
		} else if (fid != -1) {
			type.setName(typename);
			type.setParent(findById(fid));
			// type.setParentId(fid);
			type.setLevel(2);
			typeServiceImpl.addType(type);
		} else {
			type.setName(typename);
			type.setParent(findById(0));
			// type.setParentId(0);
			type.setLevel(1);
			typeServiceImpl.addType(type);
		}
		return "listAll";
	}

	public String listAll() {
		setAttribute("firstType", typeServiceImpl.firstType()); // 查询所有一级类别，存到firstType,前台遍历firstType
		if (getParameter("pageNo") == null) {
			setAttribute("page", typeServiceImpl.getPage(pageNo, pageContSize));
			setAttribute("state", 0);
			return "list";

		} else {
			setAttribute("page", typeServiceImpl.getPage(
					Integer.parseInt(getParameter("pageNo")), pageContSize));
			setAttribute("state", 0);
			return "list";
		}
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

	public void lista() throws IOException {
		List<Type> list = typeServiceImpl.firstType();
		JsonConfig cfg = new JsonConfig();
		cfg.setExcludes(new String[] { "docs" });
		JSONArray json = JSONArray.fromObject(list, cfg);
		getResponse().setCharacterEncoding("utf-8");
		getResponse().getWriter().write(json.toString());
	}

	public void listaByParentId() throws IOException {
		int parentid = Integer.parseInt(getParameter("parentid"));
		try {
			List<Type> listTwo = typeServiceImpl.secondType(parentid);
			JsonConfig cfg = new JsonConfig();
			cfg.setExcludes(new String[] { "docs" });
			JSONArray json = JSONArray.fromObject(listTwo, cfg);
			// JSONArray json = JSONArray.fromObject();
			getResponse().setCharacterEncoding("utf-8");
			getResponse().getWriter().write(json.toString());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void listaaByParentId() throws IOException {
		int parentid = Integer.parseInt(getParameter("parentid"));
		List<Type> listThree = typeServiceImpl.thirdType(parentid);
		JsonConfig cfg = new JsonConfig();
		cfg.setExcludes(new String[] { "docs" });
		JSONArray json = JSONArray.fromObject(listThree, cfg);
		// JSONArray json = JSONArray.fromObject();
		getResponse().setCharacterEncoding("utf-8");
		getResponse().getWriter().write(json.toString());
	}

	public void listByParentId() throws IOException {
		int parentid = Integer.parseInt(getParameter("parentid"));
		JSONArray json = JSONArray.fromObject(typeServiceImpl
				.secondType(parentid));
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
	 * 单个删除
	 * 
	 * @return
	 */
	public String delete() {
		int state = Integer.parseInt(getParameter("state"));
		typeServiceImpl.deleteTypeById(Integer.parseInt(getParameter("id")));

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

	/**
	 * 批量删除
	 * 
	 * @return
	 */
	public String delete_check() {
		int state = Integer.parseInt(getParameter("state"));
		String[] ids = getRequest().getParameterValues("checkAll");
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
