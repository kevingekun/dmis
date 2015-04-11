package lab.dmis.service.impl;

import java.util.List;

import lab.common.model.Page;
import lab.common.service.impl.BaseManagerImpl;
import lab.dmis.dao.SearchHistoryDao;
import lab.dmis.model.Searchhistory;
import lab.dmis.model.User;
import lab.dmis.service.SearchHistoryService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class SearchHistoryServiceImpl extends BaseManagerImpl<Searchhistory, Integer> implements
SearchHistoryService {


	@Autowired
	private SearchHistoryDao searchHistoryDao;
	
	String hql ="";
	
	/**
	 * 加载用户的搜索历史
	 */
	public Page getPage(int pageNo,int pageContSize,User user){
		hql="from Searchhistory search where search.user.id = "+user.getId()+"";
		
		return searchHistoryDao.getPage(hql, pageNo, pageContSize);
	}

	/**
	 * 加载热门搜索词汇
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Page getPage(int pageNo,int pageContSize){
		hql="from Searchhistory search order by search.searchTimes DESC";
		Page page = searchHistoryDao.getPage(hql, pageNo, pageContSize);
		List<Searchhistory> list = (List<Searchhistory>) page.getPageList();
		for(int i = 0;i < list.size()-1;i++ )   { 
		    for(int j = list.size()-1;j>i;j-- )   { 
		      if(list.get(j).getName().equals(list.get(i).getName()))   { 
		        list.remove(j); 
		      } 
		    } 
		  } 
		page.setPageList(list);
		return page;
			
	}
	
	/**
	 * 保存搜索关键字
	 * @return
	 */
	public void saveSearch(String searchKey,User user){
		hql = "from Searchhistory search where search.name LIKE '%"+searchKey+"%'";
		if(searchHistoryDao.find(hql).size() != 0){
			Searchhistory search = new Searchhistory();
			search = ((Searchhistory) searchHistoryDao.find(hql).get(0));
			search.setSearchTimes(search.getSearchTimes()+1);
			searchHistoryDao.update(search);
		}
		if(searchHistoryDao.find(hql+" and search.user.id = "+user.getId()+"").size()==0){
			Searchhistory search = new Searchhistory();
			search.setName(searchKey);
			search.setUser(user);
			searchHistoryDao.save(search);
		}
	}
	
	/**
	 * 删除搜索历史
	 * @return
	 */
	public void deleteSearchHistory(Integer id){
		searchHistoryDao.deleteByKey(id);
	}
	
	public SearchHistoryDao getSearchHistoryDao() {
		return searchHistoryDao;
	}

	public void setSearchHistoryDao(SearchHistoryDao searchHistoryDao) {
		this.searchHistoryDao = searchHistoryDao;
	}
	
	

}
