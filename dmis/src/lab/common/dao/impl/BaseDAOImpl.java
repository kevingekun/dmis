package lab.common.dao.impl;

import java.io.Serializable;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import lab.common.dao.BaseDAO;
import lab.common.exception.ServiceException;
import lab.common.model.Page;

import org.hibernate.HibernateException;
import org.hibernate.LockMode;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.criterion.CriteriaSpecification;
import org.springframework.orm.hibernate3.HibernateCallback;

/**
 * 继承 HibernateDao，简单封�?HibernateTemplate 各项功能�? �?��基于Hibernate Dao 的编写�?
 */
@SuppressWarnings("unchecked")
public class BaseDAOImpl<T extends Serializable, PK extends Serializable>
		extends HibernateDaoSupport implements BaseDAO<T, PK> {

	private Class<T> entityClass;

	public void clear() {
		super.getSession().clear();
	}

	// 构�?方法，根据实例类自动获取实体类类�?
	public BaseDAOImpl() {
		this.entityClass = GenericsUtils.getSuperClassGenricType(getClass());
	}

	/**
	 * 
	 * @Title: getConnection
	 * @Description: 获取 JDBC 的数据库连接实例
	 * @return
	 * @return Connection 返回类型
	 * @throws
	 * @author
	 * @date
	 */
	@SuppressWarnings("deprecation")
	public Connection getConnection() {
		try {
			Session curSeesion = null;
			Connection con = null;
			curSeesion = super.getSessionFactory().getCurrentSession();
			con = curSeesion.connection();
			return con;
		} catch (Exception es) {
			System.out.println(es.getMessage());
			return null;
		}

	}

	// -------------------- 基本�?��、增加�?修改、删除操�?--------------------

	// 根据主键获取实体。如果没有相应的实体，返�?null�?
	public T get(PK id) {
		return (T) getHibernateTemplate().get(getEntityClass(), id);
	}

	// 根据主键获取实体并加锁�?如果没有相应的实体，返回 null�?
	public T getWithLock(PK id, LockMode lock) {
		T t = (T) getHibernateTemplate().get(getEntityClass(), id, lock);
		if (t != null) {
			this.flush(); // 立即刷新，否则锁不会生效�?
		}
		return t;
	}

	// 根据主键获取实体。如果没有相应的实体，抛出异常�?
	public T load(PK id) {
		return (T) getHibernateTemplate().load(getEntityClass(), id);
	}

	// 根据主键获取实体并加锁�?如果没有相应的实体，抛出异常�?
	public T loadWithLock(PK id, LockMode lock) {
		T t = (T) getHibernateTemplate().load(getEntityClass(), id, lock);
		if (t != null) {
			this.flush(); // 立即刷新，否则锁不会生效�?
		}
		return t;
	}

	// 获取全部实体�?
	public List<T> loadAll() {
		return (List<T>) getHibernateTemplate().loadAll(getEntityClass());
	}

	// loadAllWithLock() ?

	// 更新实体
	public void update(T entity) {
		getHibernateTemplate().update(entity);
		this.flush();
	}

	// 更新实体并加�?
	public void updateWithLock(T entity, LockMode lock) {
		getHibernateTemplate().update(entity, lock);
		this.flush(); // 立即刷新，否则锁不会生效�?
	}

	// 存储实体到数据库
	public void save(T entity) {
		getHibernateTemplate().save(entity);
	}

	// saveWithLock()�?

	// 增加或更新实�?
	public void saveOrUpdate(T entity) {
		getHibernateTemplate().saveOrUpdate(entity);
	}

	// 增加或更新集合中的全部实�?
	public void saveOrUpdateAll(Collection<T> entities) {
		getHibernateTemplate().saveOrUpdateAll(entities);
	}

	// 删除指定的实�?
	public void delete(T entity) {
		getHibernateTemplate().delete(entity);
	}

	// 加锁并删除指定的实体
	public void deleteWithLock(T entity, LockMode lock) {
		getHibernateTemplate().delete(entity, lock);
		this.flush(); // 立即刷新，否则锁不会生效�?
	}

	// 根据主键删除指定实体
	public void deleteByKey(PK id) {
		this.delete(this.load(id));
	}

	// 根据主键加锁并删除指定的实体
	public void deleteByKeyWithLock(PK id, LockMode lock) {
		this.deleteWithLock(this.load(id), lock);
	}

	// 删除集合中的全部实体
	public void deleteAll(Collection<T> entities) {
		getHibernateTemplate().deleteAll(entities);
	}

	// -------------------- HQL操作 ----------------------------------------------
	public Serializable save(Object object) {
		return getHibernateTemplate().save(object);
	}

	public void delete(Object object) {
		getHibernateTemplate().delete(object);
	}

	public void update(Object object) {
		getHibernateTemplate().update(object);
	}

	public void saveOrUpdate(Object object) {
		getHibernateTemplate().saveOrUpdate(object);
	}

	public List<?> getListForPage(final String hql, final int pageNo,
			final int pageContSize) {
		List<?> list = getHibernateTemplate().executeFind(
				new HibernateCallback() {
					public Object doInHibernate(Session session)
							throws HibernateException, SQLException {
						Query query = session.createQuery(hql);
						query.setFirstResult((pageNo - 1) * pageContSize);
						query.setMaxResults(pageContSize);
						List<?> list = query.list();
						return list;
					}
				});
		return list;
	}

	/**
	 * 返回封装分页的对象
	 * 
	 * @param hql
	 * @param pageNo
	 * @param pageContSize
	 * @return
	 */
	public Page getPage(final String hql, final int pageNo,
			final int pageContSize) {
		return getHibernateTemplate().execute(new HibernateCallback() {
			public Object doInHibernate(Session session)
					throws HibernateException, SQLException {
				Query queryCount = session.createQuery("SELECT COUNT(*)" + hql);
				Integer totalSize = (new Integer(queryCount.uniqueResult()
						.toString())).intValue();

				Query queryList = session.createQuery(hql);
				queryList.setFirstResult((pageNo - 1) * pageContSize);
				queryList.setMaxResults(pageContSize);
				List<?> list = queryList.list();

				return new Page(pageNo, pageContSize, totalSize, list);
			}
		});
	}

	public List<?> findByNamedQueryAndNamedParamForPage(final String queryName,
			final String[] paramNames, final Object[] values, final int pageNo,
			final int pageContSize) {
		List<?> list = getHibernateTemplate().executeFind(
				new HibernateCallback() {
					public Object doInHibernate(Session session)
							throws HibernateException, SQLException {
						Query query = session.getNamedQuery(queryName);
						createQueryParameters(query, paramNames, values);
						query.setFirstResult((pageNo - 1) * pageContSize);
						query.setMaxResults(pageContSize);
						List<?> list = query.list();
						return list;
					}
				});
		return list;

		/*
		 * return
		 * getHibernateTemplate().findByNamedQueryAndNamedParam(queryName,
		 * paramNames, values);
		 */
	}

	protected void createQueryParameters(Query query, String[] paramNames,
			Object[] values) {
		for (int i = 0, len = paramNames.length; i < len; i++) {
			query.setParameter(paramNames[i], values[i]);
		}
	}

	public Integer getRows(final String hql) {
		Integer totalRows = 0;
		totalRows = (Integer) getHibernateTemplate().execute(
				new HibernateCallback() {
					public Object doInHibernate(Session session)
							throws HibernateException, SQLException {
						Query query = session.createQuery(hql);
						Integer rows = (new Integer(query.uniqueResult()
								.toString())).intValue();
						return rows;
					}
				});
		return totalRows;
	}

	// 使用HQL语句直接增加、更新�?删除实体
	public int bulkUpdate(String queryString) {
		try {
			return getHibernateTemplate().bulkUpdate(queryString);

		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}

	public int bulkUpdate(String queryString, Object obj) {
		return getHibernateTemplate().bulkUpdate(queryString, obj);
	}

	// 使用带参数的HQL语句增加、更新�?删除实体
	public int bulkUpdate(String queryString, Object[] values) {
		return getHibernateTemplate().bulkUpdate(queryString, values);
	}

	// 使用HQL语句�?��数据
	public List find(String queryString) {
		return getHibernateTemplate().find(queryString);
	}

	// 使用带参数的HQL语句�?��数据
	public List find(String queryString, Object value) {
		return getHibernateTemplate().find(queryString, value);
	}

	public List find(String queryString, Object[] values) {
		return getHibernateTemplate().find(queryString, values);
	}

	// 使用带命名的参数的HQL语句�?��数据
	public List findByNamedParam(String queryString, String[] paramNames,
			Object[] values) {
		return getHibernateTemplate().findByNamedParam(queryString, paramNames,
				values);
	}

	// 使用命名的HQL语句�?��数据
	public List findByNamedQuery(String queryName) {
		return getHibernateTemplate().findByNamedQuery(queryName);
	}

	// 使用带参数的命名HQL语句�?��数据
	public List findByNamedQuery(String queryName, Object[] values) {
		return getHibernateTemplate().findByNamedQuery(queryName, values);
	}

	// 使用带命名参数的命名HQL语句�?��数据
	public List findByNamedQueryAndNamedParam(String queryName,
			String[] paramNames, Object[] values) {
		return getHibernateTemplate().findByNamedQueryAndNamedParam(queryName,
				paramNames, values);
	}

	// 使用HQL语句�?��数据，返�?Iterator
	public Iterator iterate(String queryString) {
		return getHibernateTemplate().iterate(queryString);
	}

	// 使用带参数HQL语句�?��数据，返�?Iterator
	public Iterator iterate(String queryString, Object[] values) {
		return getHibernateTemplate().iterate(queryString, values);
	}

	// 关闭�?��返回�?Iterator
	public void closeIterator(Iterator it) {
		getHibernateTemplate().closeIterator(it);
	}

	// 内部调用的方�?
	/**
	 * 根据hql统计总数
	 */
	public long getCountByQuery(final String hql, Object... values) {
		String countQueryString = " select count(*) "
				+ removeSelect(removeOrders(hql));
		List countlist = getHibernateTemplate().find(countQueryString, values);
		return (Long) countlist.get(0);
	}

	public Query createQuery(String hql, Object... values) {
		Query query = getSession().createQuery(hql);
		for (int i = 0; i < values.length; i++) {
			query.setParameter(i, values[i]);
		}
		return query;
	}

	/**
	 * 去除hql的orderby子句
	 */
	private static String removeOrders(String hql) {
		Pattern p = Pattern.compile("order\\s*by[\\w|\\W|\\s|\\S]*",
				Pattern.CASE_INSENSITIVE);
		Matcher m = p.matcher(hql);
		StringBuffer sb = new StringBuffer();
		while (m.find()) {
			m.appendReplacement(sb, "");
		}
		m.appendTail(sb);
		return sb.toString();
	}

	/**
	 * 去除hql的select子句，未考虑union的情�?
	 */
	private static String removeSelect(String hql) {
		int beginPos = hql.toLowerCase().indexOf("from");
		return hql.substring(beginPos);
	}

	/**
	 * 将联合查询的结果内容从Map或�?Object[]转换为实体类型，如果没有转换必要则直接返�?
	 */
	private List transformResults(List items) {
		if (items.size() > 0) {
			if (items.get(0) instanceof Map) {
				ArrayList list = new ArrayList(items.size());
				for (int i = 0; i < items.size(); i++) {
					Map map = (Map) items.get(i);
					list.add(map.get(CriteriaSpecification.ROOT_ALIAS));
				}
				return list;
			} else if (items.get(0) instanceof Object[]) {
				ArrayList list = new ArrayList(items.size());
				int pos = 0;
				for (int i = 0; i < ((Object[]) items.get(0)).length; i++) {
					if (((Object[]) items.get(0))[i].getClass() == getEntityClass()) {
						pos = i;
						break;
					}
				}
				for (int i = 0; i < items.size(); i++) {
					list.add(((Object[]) items.get(i))[pos]);
				}
				return list;
			} else
				return items;
		} else
			return items;
	}

	public Class<T> getEntityClass() {
		return entityClass;
	}

	// ----------------------- SQL操作 ----------------------------
	/**
	 * 
	 * @Title: getPrimaryKey
	 * @Description: 获得主键
	 * @return String返回类型
	 * @throws
	 * @author
	 * @date
	 */
	public String getPrimaryKey(String SEQ) throws ServiceException {
		String sql = "select " + SEQ + ".nextval from dual";
		Query query = getSession().createSQLQuery(sql);
		String id = ((BigDecimal) query.uniqueResult()).toString();
		return id;
	}

	public long getCountBySqlQuery(final String sql, Object... values) {
		String countQueryString = " select count(*) "
				+ removeSelect(removeOrders(sql));
		List countlist = getSessionFactory().getCurrentSession()
				.createSQLQuery(countQueryString).list();
		;
		return Long.valueOf(countlist.get(0).toString());
	}

	public Query createSqlQuery(String sql, Object... values) {
		Query query = getSession().createSQLQuery(sql);
		for (int i = 0; i < values.length; i++) {
			query.setParameter(i, values[i]);
		}
		return query;
	}

	public List findPageListBySql(final String sqlString) {
		Query query = createSqlQuery(sqlString);
		List<Object[]> list = query.list();
		return list;
	}

	public int executeBySql(String sqlString, Object... values) {
		Query query = createSqlQuery(sqlString, values);
		return query.executeUpdate();
	}

	public int executeBySql(String sqlString) {
		Query query = createSqlQuery(sqlString);
		return query.executeUpdate();
	}

	public List listBySql(String sqlString) {
		return createSqlQuery(sqlString).list();
	}

	// 强制立即更新缓冲数据到数据库（否则仅在事务提交时才更新）
	public void flush() {
		getHibernateTemplate().flush();
	}
}