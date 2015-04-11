package lab.dmis.service;

import lab.common.model.Page;
import lab.common.service.BaseManager;
import lab.dmis.model.Favorites;
import lab.dmis.model.User;

public interface FavoritesService extends BaseManager<Favorites, Integer>{

	public Page getPage(int pageNo, int pageContSize,String userId);

	public boolean remove(int id);

	public boolean removeChecked(String ids);
	
	public void addFavorites(User user,Integer docId);
	
	public boolean docIsAdd(User user,Integer docId);
	
	public Integer removeFavorites(User user,Integer docId);
}
