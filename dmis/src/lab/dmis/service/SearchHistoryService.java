package lab.dmis.service;

import lab.common.model.Page;
import lab.common.service.BaseManager;
import lab.dmis.model.Searchhistory;
import lab.dmis.model.User;

public interface SearchHistoryService extends BaseManager<Searchhistory, Integer>{

	public Page getPage(int pageNo, int pageContSize,User user);
	public Page getPage(int pageNo, int pageContSize);
	public void saveSearch(String searchKey,User user);
	public void deleteSearchHistory(Integer id);
}
