package lab.dmis.service;

import java.util.List;

import lab.common.model.Page;
import lab.common.service.BaseManager;
import lab.dmis.model.Notice;

public interface NoticeService extends BaseManager<Notice, Integer> {

	public Page getPage(int pageNo, int pageContSize);

	public void deleteById(int id);

	public void deleteByIds(String[] ids);

	public void addNotice(Notice notice);

	public List<Notice> findById(int id);
}
