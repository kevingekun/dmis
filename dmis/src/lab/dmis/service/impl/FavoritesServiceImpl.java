package lab.dmis.service.impl;

import lab.common.model.Page;
import lab.common.service.impl.BaseManagerImpl;
import lab.common.util.Common;
import lab.dmis.dao.DocDao;
import lab.dmis.dao.FavoritesDao;
import lab.dmis.model.Favorites;
import lab.dmis.model.User;
import lab.dmis.service.FavoritesService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class FavoritesServiceImpl extends BaseManagerImpl<Favorites, Integer> implements
FavoritesService {

	@Autowired
	private FavoritesDao FavoDao;
	@Autowired
	private DocDao docDao;
	
	public Page getPage(int pageNo,int pageSize,String userId){
		String hql = "from Favorites where userId='"+userId+"'";
		return FavoDao.getPage(hql,pageNo,pageSize);
	}

	/**
	 *删除单个的下载记录 
	 * 
	 */
	@Override
	public boolean remove(int Id) {
		
		
		try {
			FavoDao.deleteByKey(Id);
			return true;
		} catch (Exception e) {
			return false;
		}
	}
	
	/**
	 *删除选中的收藏记录 
	 * 
	 */
	public boolean removeChecked(String ids){
		
		String hql = "delete from Favorites favorites where favorites.id in (" + ids +")";
		try {
			if(FavoDao.bulkUpdate(hql) > 0){
				return true;
			}else {
				return false;
			}
		} catch (Exception e) {
			return false;
		}
	}
	/**
	 * 增加收藏
	 * @return
	 */
	public void addFavorites(User user,Integer docId){
		Favorites favorite = new Favorites();
		favorite.setDoc(docDao.get(docId));
		favorite.setTime(Common.getTimestampTime(0));
		favorite.setUser(user);
		FavoDao.save(favorite);
	}
	
	/**
	 * 取消收藏
	 */
	public Integer removeFavorites(User user,Integer docId){
		String hql = "delete Favorites favo where favo.user.id = "+user.getId()+" and favo.doc.id = "+docDao.get(docId).getId()+"";
		return FavoDao.bulkUpdate(hql);
	}
	/**
	 * 判断文章是否被收藏
	 * @return
	 */
	public boolean docIsAdd(User user,Integer docId){
		
		String hql = "from Favorites favo where favo.user.id = "+user.getId()+" and favo.doc.id = "+docDao.get(docId).getId()+"";
		return FavoDao.find(hql).size() != 0?true:false;
	}
	public FavoritesDao getFavoDao() {
		return FavoDao;
	}

	public void setFavoDao(FavoritesDao favoDao) {
		FavoDao = favoDao;
	}

	public DocDao getDocDao() {
		return docDao;
	}

	public void setDocDao(DocDao docDao) {
		this.docDao = docDao;
	}
	


}
