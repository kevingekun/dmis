package lab.dmis.web;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import lab.common.web.BaseAction;
import lab.dmis.model.Doc;
import lab.dmis.model.Keyword;
import lab.dmis.service.KeywordService;

import org.springframework.beans.factory.annotation.Autowired;

public class KeywordAction extends BaseAction {
	private static final long serialVersionUID = 1L;

	@Autowired
	private KeywordService keywordService;
	private Keyword keyword;
	private int pageNo = 1;
	private int pageContSize = 3;

	/**
	 * list keyword
	 * 
	 * @return
	 */
	public String list() {
		int state = Integer.parseInt(getParameter("state"));
		if (getParameter("pageNo") == null) {
			setAttribute("page",
					keywordService.getPage(state, pageNo, pageContSize));
			setAttribute("state", state);
			return "list";
		} else {
			setAttribute("page", keywordService.getPage(state,
					Integer.parseInt(getParameter("pageNo")), pageContSize));
			setAttribute("state", state);
			return "list";
		}
	}

	/**
	 * listall
	 * 
	 * @return
	 */
	public String listAll() {
		if (getParameter("pageNo") == null) {
			setAttribute("page", keywordService.getPage(pageNo, pageContSize));
			setAttribute("state", 2);
			return "list";
		} else {
			setAttribute("page", keywordService.getPage(
					Integer.parseInt(getParameter("pageNo")), pageContSize));
			setAttribute("state", 2);
			return "list";
		}
	}

	/**
	 * deletekeywordbyid
	 * 
	 * @return
	 */
	public String delete() {
		int id = Integer.parseInt(getParameter("id"));
		keywordService.deleteKeywordById(id);
		int totalpage = keywordService.getPage(pageNo, pageContSize)
				.getTotalPage();
		pageNo = Integer.parseInt(getParameter("pageNo"));
		if (totalpage < pageNo) {
			pageNo = pageNo - 1;
		}
		getRequest().setAttribute("pageNo", pageNo);
		return "delete_success";
	}

	/**
	 * deletecheck
	 * 
	 * @return
	 */
	public String deleteCheck() {
		String[] ids = getRequest().getParameterValues("checkAll");
		keywordService.deleteByIds(ids);
		int totalpage = keywordService.getPage(pageNo, pageContSize)
				.getTotalPage();
		pageNo = Integer.parseInt(getParameter("pageNo"));
		if (totalpage < pageNo) {
			pageNo = pageNo - 1;
		}
		getRequest().setAttribute("pageNo", pageNo);
		return "delete_success";
	}

	/**
	 * search
	 * 
	 * @return
	 */
	public String search() {
		String keyword = getParameter("keyw");
		Keyword keyWord = new Keyword();
		keyWord.setKeyword(keyword);
		Keyword temp = new Keyword();
		List<Keyword> keywordList = new ArrayList<Keyword>();
		temp = keywordService.QueryEqualName(keyWord);
		keywordList = keywordService.QueryLikeName(keyWord);
		setAttribute("keyword", temp);
		setAttribute("keywordList", keywordList);
		return "searchsuccess";
	}

	/**
	 * searchbyid
	 * 
	 * @return
	 */
	public String hrefsearch() {
		int keywordId = Integer.parseInt(getParameter("keywordId"));
		Keyword keyWord = new Keyword();
		keyWord.setId(keywordId);
		Keyword temp = new Keyword();
		List<Keyword> keywordList = new ArrayList<Keyword>();
		Set docList = new HashSet<Doc>();
		temp = keywordService.QueryById(keyWord);
		keywordList = keywordService.QueryLikeName(temp);

		setAttribute("keyword", temp);
		setAttribute("keywordList", keywordList);

		return "searchsuccess";
	}

	/**
	 * addkeyword
	 * 
	 * @return
	 */
	public String addKeyword() {
		keyword.setCommitTime(new Timestamp(new Date().getTime()));
		String data = getParameter("keyword.content");
		System.out.println(data);
		keywordService.addKeyword(keyword);
		return "save_success";
	}

	/**
	 * passkeyword
	 * 
	 * @return
	 */
	public String passKeyword() {
		List<Keyword> k = keywordService.findById(Integer
				.parseInt(getParameter("id")));
		keyword = k.get(0);
		keyword.setIsPass(true);
		keyword.setPassTime(new Timestamp(new Date().getTime()));
		keywordService.passKeyword(keyword);
		int totalpage = keywordService.getPage(pageNo, pageContSize)
				.getTotalPage();
		pageNo = Integer.parseInt(getParameter("pageNo"));
		if (totalpage < pageNo) {
			pageNo = pageNo - 1;
		}
		getRequest().setAttribute("state", getParameter("state"));
		System.out.println(getParameter("state"));
		getRequest().setAttribute("pageNo", pageNo);
		return "pass_success";
	}

	/**
	 * passcheck
	 * 
	 * @return
	 */
	public String passCheck() {
		String[] ids = getRequest().getParameterValues("checkAll");
		for (int i = 0; i < ids.length; i++) {
			int id = Integer.parseInt(ids[i]);
			List<Keyword> k = keywordService.findById(id);
			keyword = k.get(0);
			keyword.setIsPass(true);
			keyword.setPassTime(new Timestamp(new Date().getTime()));
			keywordService.passKeyword(keyword);
		}
		int totalpage = keywordService.getPage(pageNo, pageContSize)
				.getTotalPage();
		pageNo = Integer.parseInt(getParameter("pageNo"));
		if (totalpage < pageNo) {
			pageNo = pageNo - 1;
		}
		getRequest().setAttribute("pageNo", pageNo);
		return "pass_success";
	}

	public KeywordService getKeywordService() {
		return keywordService;
	}

	public void setKeywordService(KeywordService keywordService) {
		this.keywordService = keywordService;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
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
}
