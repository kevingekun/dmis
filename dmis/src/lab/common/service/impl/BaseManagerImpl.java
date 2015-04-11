package lab.common.service.impl;

import java.io.Serializable;
import java.util.List;

import lab.common.dao.BaseDAO;
import lab.common.service.BaseManager;

import org.hibernate.LockMode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class BaseManagerImpl<T extends Serializable, PK extends Serializable>
		implements BaseManager<T, PK> {
	// 根据主键获取实体。如果没有相应的实体，返�?null�?
	
	@Autowired
	protected BaseDAO<T, PK> baseDAO;
	
	public T get(PK id) {
		return baseDAO.get(id);
	}

	// 根据主键获取实体并加锁�?如果没有相应的实体，返回 null�?
	public T getWithLock(PK id, LockMode lock) {
		return baseDAO.getWithLock(id, lock);
	}

	// 根据主键获取实体。如果没有相应的实体，抛出异常�?
	public T load(PK id) {
		return baseDAO.load(id);
	}

	// 根据主键获取实体并加锁�?如果没有相应的实体，抛出异常�?
	public T loadWithLock(PK id, LockMode lock) {
		return baseDAO.loadWithLock(id, lock);
	}

	// 更新实体
	public void update(T entity) {
		baseDAO.update(entity);
	}

	// 更新实体并加�?
	public void updateWithLock(T entity, LockMode lock) {
		baseDAO.updateWithLock(entity, lock);
	}

	// 存储实体到数据库
	public void save(T entity) {
		baseDAO.save(entity);
	}

	// saveWithLock()

	// 增加或更新实�?
	public void saveOrUpdate(T entity) {
		baseDAO.saveOrUpdate(entity);
	}

	// 删除指定的实�?
	public void delete(T entity) {
		baseDAO.delete(entity);
	}

	// 加锁并删除指定的实体
	public void deleteWithLock(T entity, LockMode lock) {
		baseDAO.deleteWithLock(entity, lock);
	}

	// 根据主键删除指定实体
	public void deleteByKey(PK id) {
		baseDAO.deleteByKey(id);
	}

	// 根据主键加锁并删除指定的实体
	public void deleteByKeyWithLock(PK id, LockMode lock) {
		baseDAO.deleteByKeyWithLock(id, lock);
	}

	// -------------------- HQL ----------------------------------------------
	public List<?> getListForPage(final String hql, final int pageNo, final int pageContSize) {
		return baseDAO.getListForPage(hql, pageNo, pageContSize);
	}
	public Integer getRows(final String hql) {
		return baseDAO.getRows(hql);
	}
	
	// 使用HSQL语句直接增加、更新�?删除实体
	public int bulkUpdate(String queryString) {
		return baseDAO.bulkUpdate(queryString);
	}

	// 使用带参数的HSQL语句增加、更新�?删除实体
	public int bulkUpdate(String queryString, Object[] values) {
		return baseDAO.bulkUpdate(queryString, values);
	}

	// 使用HSQL语句�?��数据
	public List find(String queryString) {
		return baseDAO.find(queryString);
	}

	// 使用带参数的HSQL语句�?��数据
	public List find(String queryString, Object[] values) {
		return baseDAO.find(queryString, values);
	}

	// 使用带命名的参数的HSQL语句�?��数据
	public List findByNamedParam(String queryString, String[] paramNames,
			Object[] values) {
		return baseDAO.findByNamedParam(queryString, paramNames, values);
	}

	// 使用命名的HSQL语句�?��数据
	public List findByNamedQuery(String queryName) {
		return baseDAO.findByNamedQuery(queryName);
	}

	// 使用带参数的命名HSQL语句�?��数据
	public List findByNamedQuery(String queryName, Object[] values) {
		return baseDAO.findByNamedQuery(queryName, values);
	}

	// 使用带命名参数的命名HSQL语句�?��数据
	public List findByNamedQueryAndNamedParam(String queryName,
			String[] paramNames, Object[] values) {
		return baseDAO.findByNamedQueryAndNamedParam(queryName, paramNames,
				values);
	}

	// -------------------------------- Others --------------------------------
	// 强制立即更新缓冲数据到数据库（否则仅在事务提交时才更新）
	public void flush() {
		baseDAO.flush();
	}

	public int executeBySql(String sqlString, Object...values) {
		return baseDAO.executeBySql(sqlString, values);
	}
	
	public int executeBySql(String sqlString) {
		return baseDAO.executeBySql(sqlString);
	}
	
	public List listBySql(String sqlString){
		return baseDAO.listBySql(sqlString);
	}
	
	//get|set method
	public BaseDAO<T, PK> getBaseDAO() {
		return baseDAO;
	}

	public void setBaseDAO(BaseDAO<T, PK> baseDAO) {
		this.baseDAO = baseDAO;
	}
	
}
