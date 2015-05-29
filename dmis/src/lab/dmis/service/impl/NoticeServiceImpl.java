package lab.dmis.service.impl;

import java.util.List;

import javax.annotation.Resource;

import lab.common.model.Page;
import lab.common.service.impl.BaseManagerImpl;
import lab.dmis.dao.NoticeDao;
import lab.dmis.model.Notice;
import lab.dmis.service.NoticeService;

import org.springframework.stereotype.Service;

@Service
public class NoticeServiceImpl extends BaseManagerImpl<Notice, Integer>
		implements NoticeService {

	private NoticeDao noticeDaoImpl;

	/**
	 * 加载全部公告
	 */
	public Page getPage(int pageNo, int pageContSize) {
		String hql = "from Notice notice order by notice.id DESC";
		return noticeDaoImpl.getPage(hql, pageNo, pageContSize);
	}

	/**
	 * 根据ID删除公告
	 */
	public void deleteById(int id) {
		// String sql = "delete * from Notice where id="+id;
		noticeDaoImpl.deleteByKey(id);
	}

	@Override
	public void deleteByIds(List<String> ids) {
		for (int i = 0; i < ids.size(); i++) {
			int id = Integer.parseInt(ids.get(i));
			noticeDaoImpl.deleteByKey(id);
		}
	}

	/**
	 * 发布公告
	 */
	public void addNotice(Notice notice) {
		noticeDaoImpl.save(notice);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Notice> findById(int id) {
		String sql = "from Notice n where n.id='" + id + "'";
		return noticeDaoImpl.find(sql);
	}

	public NoticeDao getNoticeDaoImpl() {
		return noticeDaoImpl;
	}

	@Resource
	public void setNoticeDaoImpl(NoticeDao noticeDaoImpl) {
		this.noticeDaoImpl = noticeDaoImpl;
	}
}
