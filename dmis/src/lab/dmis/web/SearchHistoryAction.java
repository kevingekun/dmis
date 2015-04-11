package lab.dmis.web;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import net.sf.json.JSONArray;

import org.springframework.beans.factory.annotation.Autowired;

import lab.common.web.BaseAction;
import lab.dmis.model.User;
import lab.dmis.service.SearchHistoryService;
import lab.dmis.util.JsonSerialization;
import lab.dmis.util.Str;

public class SearchHistoryAction extends BaseAction {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	@Autowired
	private SearchHistoryService searchService;
	
	
	int pageNo = 1;
	int pageContSize = 6;
	List<?> list = new ArrayList();
	
	/**
	 * 加载用户搜索历史
	 * @throws IOException
	 */
	public void loadSearchHistory() throws IOException{
		list = searchService.getPage(pageNo, pageContSize,(User) getObjFromSession("LOGIN_USER")).getPageList();
		if(list.size() == 0)
			out().print("field");
		else out().print(JSONArray.fromObject(list,JsonSerialization.jsonSer(Str.str)).toString());
	}

	/**
	 * 加载热门搜索词汇
	 * @return
	 * @throws IOException 
	 */
	public void loadHotKeyword() throws IOException{
		list = searchService.getPage(1, 6).getPageList();
		out().print(JSONArray.fromObject(list,JsonSerialization.jsonSer(Str.str)).toString());
		
	}
	
	/**
	 * 保存搜索历史
	 * @return
	 */
	public void saveSearchHistory(){
		searchService.saveSearch(getParameter("keyword"), (User)getObjFromSession("LOGIN_USER"));	
	}
	
	/**
	 * 删除搜索历史
	 * @return
	 */
	public void deleteSearchHistory(){
		searchService.deleteSearchHistory(Integer.parseInt(getParameter("searchHistoryId")));
	}
	
	public SearchHistoryService getSearchService() {
		return searchService;
	}

	public void setSearchService(SearchHistoryService searchService) {
		this.searchService = searchService;
	}

	public int getPageNo() {
		return pageNo;
	}

	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
	}
	
	
}
