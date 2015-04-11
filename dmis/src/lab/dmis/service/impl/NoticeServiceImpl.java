package lab.dmis.service.impl;

import java.util.List;

import lab.common.model.Page;
import lab.common.service.impl.BaseManagerImpl;
import lab.dmis.dao.NoticeDao;
import lab.dmis.model.Notice;
import lab.dmis.service.NoticeService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class NoticeServiceImpl extends BaseManagerImpl<Notice, Integer> implements
NoticeService {

	@Autowired
	private NoticeDao noticeDao;
	
	/**
	 * 加载全部公告
	 */
	public Page getPage(int pageNo,int pageContSize){
		String hql = "from Notice notice order by notice.id DESC";
		return noticeDao.getPage(hql, pageNo, pageContSize);
	}
	
	/**
	 * 根据ID删除公告
	 */
	public void deleteById(int id){
		//String sql = "delete * from Notice where id="+id;
		noticeDao.deleteByKey(id);
	}
	@Override
	public void deleteByIds(String[] ids) {
		for(int i=0;i<ids.length;i++){
			int id = Integer.parseInt(ids[i]);
			noticeDao.deleteByKey(id);
		}
		
	}
	/**
	 * 发布公告
	 */
	public void addNotice(Notice notice){
		noticeDao.save(notice);
	}
	@SuppressWarnings("unchecked")
	@Override
	public List<Notice> findById(int id) {
		String sql = "from Notice n where n.id='"+id+"'";
		return noticeDao.find(sql);
	}
	
	public NoticeDao getNoticeDao() {
		return noticeDao;
	}

	public void setNoticeDao(NoticeDao noticeDao) {
		this.noticeDao = noticeDao;
	}

	
	
	

}
