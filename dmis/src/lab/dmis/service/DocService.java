package lab.dmis.service;

import java.util.List;

import lab.common.model.Page;
import lab.common.service.BaseManager;
import lab.dmis.model.Doc;
import lab.dmis.model.User;

public interface DocService extends BaseManager<Doc, Integer> {

	public Page getPage(int pageNo, int pageContSize, User user);

	public Page getPage(int state, int pageNo, int pageContSize);

	public Page getPage(int pageNo, int pageContSize);

	public Page getPage(int pageNo, int pageContSize, boolean isPass);

	public List<Doc> findById(int id);// 通过ID查找

	public void passDoc(Doc doc);// 通过文档

	public void deleteByIds(List<String> ids);// 批量删除

	public void uploaddocument(Doc doc);

	public Doc reading(Integer id);

	public List<Integer> countByCategory();

	public List<Integer> countByLevel();

	public List<Object> countByDownload();
}
