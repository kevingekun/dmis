package lab.common.dao;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Collection;
import java.util.Iterator;
import java.util.List;

import lab.common.exception.ServiceException;
import lab.common.model.Page;

import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.LockMode;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.criterion.DetachedCriteria;
import org.springframework.orm.hibernate3.HibernateCallback;


@SuppressWarnings("unchecked")
public interface BaseDAO<T extends Serializable, PK extends Serializable> {
	// -------------------- ����������ӡ��޸ġ�ɾ����� --------------------
	// ��ȡ JDBC ����ݿ�����ʵ��
	public Connection getConnection();

	/**
	 * 
	 * @Title: getConnection
	 * @Description: ��ݲ����ȡ��ͬ�����Դ
	 * @param request
	 * @param ds
	 * @return
	 * @return Connection ��������
	 * @throws
	 * @author YangDong
	 * @date 2011-1-31 ����05:44:46
	 */
	// public Connection getConnection(String ds);
	// ��������ȡʵ�塣���û����Ӧ��ʵ�壬���� null��
	public T get(PK id);

	// ��������ȡʵ�岢�������û����Ӧ��ʵ�壬���� null��
	public T getWithLock(PK id, LockMode lock);

	// ��������ȡʵ�塣���û����Ӧ��ʵ�壬�׳��쳣��
	public T load(PK id);

	// ��������ȡʵ�岢�������û����Ӧ��ʵ�壬�׳��쳣��
	public T loadWithLock(PK id, LockMode lock);

	// ��ȡȫ��ʵ�塣
	public List<T> loadAll();

	// loadAllWithLock() ?

	// ����ʵ��
	public void update(T entity);

	// ����ʵ�岢����
	public void updateWithLock(T entity, LockMode lock);

	// �洢ʵ�嵽��ݿ�
	public void save(T entity);

	// saveWithLock()

	// ���ӻ����ʵ��
	public void saveOrUpdate(T entity);

	// ���ӻ���¼����е�ȫ��ʵ��
	public void saveOrUpdateAll(Collection<T> entities);

	// ɾ��ָ����ʵ��
	public void delete(T entity);

	// ����ɾ��ָ����ʵ��
	public void deleteWithLock(T entity, LockMode lock);

	// �������ɾ��ָ��ʵ��
	public void deleteByKey(PK id);

	// ����������ɾ��ָ����ʵ��
	public void deleteByKeyWithLock(PK id, LockMode lock);

	// ɾ����е�ȫ��ʵ��
	public void deleteAll(Collection<T> entities);

	// -------------------- HQL ----------------------------------------------
	//--------------------���÷���------------------------------------------
	/**����ʵ��*/
	public Serializable save(Object object);
	/**ɾ��ʵ��*/
	public void delete(Object object);
	/**����ʵ��*/
	public void update(Object object);
	/**����͸���ʵ��*/
	public void saveOrUpdate(Object object);
	/**��ȡĳҳ��ʵ���б�*/
	public List<?> getListForPage(final String hql, final int pageNo, final int pageContSize);
	/**��ȡʵ������*/
	public Integer getRows(final String hql);
	//-------------------���÷�������-------------------------------------------
	
	public List findPageListBySql(final String sqlString);

	// ʹ��HSQL���ֱ�����ӡ����¡�ɾ��ʵ��
	public int bulkUpdate(String queryString);

	public int bulkUpdate(String queryString, Object ids);

	// ʹ�ô�����HSQL������ӡ����¡�ɾ��ʵ��
	public int bulkUpdate(String queryString, Object[] values);

	// ʹ��HSQL���������

	public List find(String queryString);

	// ʹ�ô�����HSQL���������
	public List find(String queryString, Object value);

	public List find(String queryString, Object[] values);

	// ʹ�ô�����Ĳ����HSQL���������
	public List findByNamedParam(String queryString, String[] paramNames,
			Object[] values);

	// ʹ�������HSQL���������
	public List findByNamedQuery(String queryName);

	// ʹ�ô���������HSQL���������
	public List findByNamedQuery(String queryName, Object[] values);

	// ʹ�ô�������������HSQL���������
	public List findByNamedQueryAndNamedParam(String queryName,
			String[] paramNames, Object[] values);

	// ʹ�ô�������������HSQL���������,��ҳ
	public List<?> findByNamedQueryAndNamedParamForPage(String queryName,
            String[] paramNames, Object[] values, int pageNo, int pageContSize);
	
	// ʹ��HSQL��������ݣ����� Iterator
	public Iterator iterate(String queryString);

	// ʹ�ô����HSQL��������ݣ����� Iterator
	public Iterator iterate(String queryString, Object[] values);

	// �رռ������ص� Iterator
	public void closeIterator(Iterator it);

	// -------------------------------- Others --------------------------------
    public void flush();
	// �������
	public String getPrimaryKey(String SEQ) throws ServiceException;

	public int executeBySql(String sqlString, Object... values);

	public int executeBySql(String sqlString);
	
	public List listBySql(String sqlString);
	
	public  void clear();

	//��װ��ҳ����
	public Page getPage(final String hql, final int pageNo, final int pageContSize);
}
