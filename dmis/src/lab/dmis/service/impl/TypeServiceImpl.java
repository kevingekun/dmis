package lab.dmis.service.impl;

import java.util.List;

import javax.annotation.Resource;

import lab.common.model.Page;
import lab.common.service.impl.BaseManagerImpl;
import lab.dmis.dao.TypeDao;
import lab.dmis.model.Type;
import lab.dmis.service.TypeService;

import org.springframework.stereotype.Service;

@Service
public class TypeServiceImpl extends BaseManagerImpl<Type, Integer> implements
		TypeService {

	private TypeDao typeDaoImpl;

	@Override
	public void addType(Type type) {
		typeDaoImpl.save(type);
	}

	public Page getPage(int pageNo, int pageContSize) {
		String hql = "from Type t order by t.id DESC";
		return typeDaoImpl.getPage(hql, pageNo, pageContSize);
	}

	public Page getPage(int state, int pageNo, int pageContSize) {
		String hql0 = "from Type t order by t.id DESC";
		String hql1 = "from Type t where t.level=1 order by t.id DESC";
		String hql2 = "from Type t where t.level=2 order by t.id DESC";
		String hql3 = "from Type t where t.level=3 order by t.id DESC";
		if (state == 3) {
			return typeDaoImpl.getPage(hql3, pageNo, pageContSize);
		} else if (state == 2) {
			return typeDaoImpl.getPage(hql2, pageNo, pageContSize);
		} else if (state == 1) {
			return typeDaoImpl.getPage(hql1, pageNo, pageContSize);
		} else {
			return typeDaoImpl.getPage(hql0, pageNo, pageContSize);
		}
	}

	public Type findById(int id) {
		return typeDaoImpl.get(id);
	}

	public void deleteByIds(List<String> ids) {
		for (int i = 0; i < ids.size(); i++) {
			int id = Integer.parseInt(ids.get(i));
			typeDaoImpl.deleteByKey(id);
		}
	}

	@SuppressWarnings("unchecked")
	public List<Type> getType() {
		String hql = "from Type";
		return typeDaoImpl.find(hql);
	}

	@SuppressWarnings("unchecked")
	public List<Type> firstType() {
		String sql = "from Type t where t.level=1";
		return typeDaoImpl.find(sql);
	}

	@SuppressWarnings("unchecked")
	public List<Type> searchTypeByParentId(Object parentId) {
		String sql;
		if (parentId == null) {
			sql = "from Type t where t.level = 1";
		} else {
			sql = "from Type t where t.parent='" + parentId + "'";
		}
		return typeDaoImpl.find(sql);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Type> getByName(String typename) {
		String hql = "from Type t where t.name = '" + typename + "'";
		return typeDaoImpl.find(hql);
	}

	public TypeDao getTypeDaoImpl() {
		return typeDaoImpl;
	}

	@Resource
	public void setTypeDaoImpl(TypeDao typeDaoImpl) {
		this.typeDaoImpl = typeDaoImpl;
	}
}
