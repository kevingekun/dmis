package lab.dmis.web;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import lab.common.web.BaseAction;
import lab.dmis.model.Doc;
import lab.dmis.model.Keyword;
import lab.dmis.model.Keyworddoc;
import lab.dmis.service.KeywordDocService;
import lab.dmis.service.KeywordService;
import net.sf.json.JSONArray;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

@Component("keywordAction")
@Scope("prototype")
public class KeywordAction extends BaseAction {
	private static final long serialVersionUID = 1L;

	private KeywordService keywordServiceImpl;
	private KeywordDocService keywordDocServiceImpl;
	private Keyword keyword;
	private int pageNo = 1;
	private int pageContSize = 8;

	/**
	 * list keyword
	 * 
	 * @return
	 */
	public String list() {
		int state = Integer.parseInt(getParameter("state"));
		if (getParameter("pageNo") == null) {
			setAttribute("page",
					keywordServiceImpl.getPage(state, pageNo, pageContSize));
			setAttribute("state", state);
			return "list";
		} else {
			setAttribute("page", keywordServiceImpl.getPage(state,
					Integer.parseInt(getParameter("pageNo")), pageContSize));
			setAttribute("state", state);
			return "list";
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
		int totalpage = 0;
		String id = getParameter("id");
		if (id != null) {
			ids.add(id);
		} else {
			ids = Arrays.asList(getRequest().getParameterValues("checkAll"));
		}
		keywordServiceImpl.deleteByIds(ids);
		if(state == 2){
			totalpage = keywordServiceImpl
					.getPage(pageNo, pageContSize).getTotalPage();
		}else if (state == 1) {
			totalpage = keywordServiceImpl
					.getPage(pageNo, pageContSize, true).getTotalPage();
		}else{
			totalpage = keywordServiceImpl
					.getPage(pageNo, pageContSize, false).getTotalPage();
		}
		System.err.println(totalpage);
		pageNo = Integer.parseInt(getParameter("pageNo"));
		System.err.println(pageNo);
		if (totalpage < pageNo) {
			pageNo = pageNo - 1;
		}
		setAttribute("page",
				keywordServiceImpl.getPage(state, pageNo, pageContSize));
		setAttribute("state", state);
		return "list";
	}

	/**
	 * 通过ajax查看keyword
	 * 
	 * @throws IOException
	 */
	public void checkKeyword() throws IOException {
		int id = Integer.parseInt(getParameter("id"));
		List<Keyword> list = keywordServiceImpl.findById(id);
		JSONArray jsonArray = JSONArray.fromObject(list);
		getResponse().setCharacterEncoding("utf-8");
		getResponse().getWriter().write(jsonArray.toString());
	}

	/**
	 * 检查词条名是否存在
	 * 
	 * @throws IOException
	 */
	public void checkKeywordByName() throws IOException {
		String name = java.net.URLDecoder.decode(getParameter("k"), "UTF-8");
		// System.err.println(name);
		List<Keyword> list = keywordServiceImpl.findByName(name);
		if (list.size() == 0) {
			out().print("noKeyword");
		} else {
			out().print(list.get(0).getId());
		}
	}

	/**
	 * addkeyword
	 * 
	 * @return
	 */
	public String addKeyword() {
		keyword.setCommitTime(new Timestamp(new Date().getTime()));
		if (keywordServiceImpl.findByName(keyword.getKeyword()).size() == 0) {
			keywordServiceImpl.addKeyword(keyword);
			setAttribute("page",
					keywordServiceImpl.getPage(pageNo, pageContSize));
			setAttribute("state", 2);
			return "list";
		} else {
			this.addFieldError("error", "词条添加失败！");
			return "error";
		}

	}

	/**
	 * 绑定文档
	 * 
	 * @throws IOException
	 */
	public void bindDoc() throws IOException {
		int docId = Integer.parseInt(getParameter("docid"));
		int keywordId = Integer.parseInt(getParameter("keywordid"));
		if (keywordDocServiceImpl.findByKidDid(keywordId, docId).size() == 0) {
			Keyworddoc kd = new Keyworddoc();
			Doc d = new Doc();
			d.setId(docId);
			Keyword k = new Keyword();
			k.setId(keywordId);
			kd.setDoc(d);
			kd.setKeyword(k);
			keywordDocServiceImpl.addKeywordDoc(kd);
			out().print("success");
		} else {
			out().print("repeat");
		}
	}

	/**
	 * passkeyword
	 * 
	 * @return
	 */
	public String passKeyword() {
		int state = Integer.parseInt(getParameter("state"));
		List<Keyword> k = keywordServiceImpl.findById(Integer
				.parseInt(getParameter("id")));
		keyword = k.get(0);
		keyword.setIsPass(true);
		keyword.setPassTime(new Timestamp(new Date().getTime()));
		keywordServiceImpl.passKeyword(keyword);

		int totalpage = keywordServiceImpl.getPage(pageNo, pageContSize, false)
				.getTotalPage();
		pageNo = Integer.parseInt(getParameter("pageNo"));
		if (totalpage < pageNo) {
			pageNo = pageNo - 1;
		}
		setAttribute("page",
				keywordServiceImpl.getPage(state, pageNo, pageContSize));
		setAttribute("state", state);
		return "list";
	}

	/**
	 * passcheck
	 * 
	 * @return
	 */
	public String passCheck() {
		int state = Integer.parseInt(getParameter("state"));
		String[] ids = getRequest().getParameterValues("checkAll");
		for (int i = 0; i < ids.length; i++) {
			int id = Integer.parseInt(ids[i]);
			List<Keyword> k = keywordServiceImpl.findById(id);
			keyword = k.get(0);
			keyword.setIsPass(true);
			keyword.setPassTime(new Timestamp(new Date().getTime()));
			keywordServiceImpl.passKeyword(keyword);
		}
		int totalpage = keywordServiceImpl.getPage(pageNo, pageContSize, false)
				.getTotalPage();
		pageNo = Integer.parseInt(getParameter("pageNo"));
		if (totalpage < pageNo) {
			pageNo = pageNo - 1;
		}
		setAttribute("page",
				keywordServiceImpl.getPage(state, pageNo, pageContSize));
		setAttribute("state", state);
		return "list";
	}

	public int getPageNo() {
		return pageNo;
	}

	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
	}

	public int getPageContSize() {
		return pageContSize;
	}

	public void setPageContSize(int pageContSize) {
		this.pageContSize = pageContSize;
	}

	public Keyword getKeyword() {
		return keyword;
	}

	public void setKeyword(Keyword keyword) {
		this.keyword = keyword;
	}

	public KeywordService getKeywordServiceImpl() {
		return keywordServiceImpl;
	}

	@Resource
	public void setKeywordServiceImpl(KeywordService keywordServiceImpl) {
		this.keywordServiceImpl = keywordServiceImpl;
	}

	public KeywordDocService getKeywordDocServiceImpl() {
		return keywordDocServiceImpl;
	}

	@Resource
	public void setKeywordDocServiceImpl(KeywordDocService keywordDocServiceImpl) {
		this.keywordDocServiceImpl = keywordDocServiceImpl;
	}

}
