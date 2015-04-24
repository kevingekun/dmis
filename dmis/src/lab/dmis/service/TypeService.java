package lab.dmis.service;

import java.util.List;

import lab.common.model.Page;
import lab.common.service.BaseManager;
import lab.dmis.model.Type;

public interface TypeService extends BaseManager<Type, Integer> {

	public void addType(Type type);

	public Page getPage(int pageNo, int pageContSize);

	public Page getPage(int state, int pageNo, int pageContSize);

	public List<Type> firstType();

	public List<Type> secondType(int parentId);

	public List<Type> thirdType(int parentId);

	public void deleteTypeById(int id);

	public void deleteByIds(String[] ids);// 批量删除

	public List<Type> getType();

	public List<Type> getByName(String typename);
}
