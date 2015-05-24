package lab.dmis.service.impl;

import java.util.List;

import lab.common.model.Page;
import lab.common.service.impl.BaseManagerImpl;
import lab.dmis.dao.TypeDao;
import lab.dmis.model.Type;
import lab.dmis.service.TypeService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class TypeServiceImpl extends BaseManagerImpl<Type, Integer> implements
		TypeService {

	@Autowired
	private TypeDao typeDao;

	@Override
	public void addType(Type type) {
		typeDao.save(type);
	}

	public Page getPage(int pageNo, int pageContSize) {
		String hql = "from Type t order by t.id DESC";
		return typeDao.getPage(hql, pageNo, pageContSize);
	}

	public Page getPage(int state, int pageNo, int pageContSize) {
		String hql0 = "from Type t order by t.id DESC";
		String hql1 = "from Type t where t.level=1 order by t.id DESC";
		String hql2 = "from Type t where t.level=2 order by t.id DESC";
		String hql3 = "from Type t where t.level=3 order by t.id DESC";
		if (state == 3) {
			return typeDao.getPage(hql3, pageNo, pageContSize);
		} else if (state == 2) {
			return typeDao.getPage(hql2, pageNo, pageContSize);
		} else if (state == 1) {
			return typeDao.getPage(hql1, pageNo, pageContSize);
		} else {
			return typeDao.getPage(hql0, pageNo, pageContSize);
		}
	}

	public void deleteTypeById(int id) {
		typeDao.deleteByKey(id);
	}

	public Type findById(int id) {
		return typeDao.get(id);
	}

	public void deleteByIds(String[] ids) {
		for (int i = 0; i < ids.length; i++) {
			int id = Integer.parseInt(ids[i]);
			typeDao.deleteByKey(id);
		}
	}

	@SuppressWarnings("unchecked")
	public List<Type> getType() {
		String hql = "from Type";
		return typeDao.find(hql);
	}

	@SuppressWarnings("unchecked")
	public List<Type> firstType() {
		String sql = "from Type t where t.level=1";
		return typeDao.find(sql);
	}

	@SuppressWarnings("unchecked")
	public List<Type> secondType(int parentId) {
		String sql = "from Type t where t.parent='" + parentId + "'";
		return typeDao.find(sql);
	}

	@SuppressWarnings("unchecked")
	public List<Type> thirdType(int parentId) {
		String sql = "from Type t where t.parent='" + parentId + "'";
		return typeDao.find(sql);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Type> getByName(String typename) {
		String hql = "from Type t where t.name = '" + typename + "'";
		return typeDao.find(hql);
	}

	public TypeDao getTypeDao() {
		return typeDao;
	}

}
