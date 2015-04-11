package lab.common.service;

import java.io.Serializable;
import java.util.List;

import org.hibernate.LockMode;

public interface BaseManager<T extends Serializable, PK extends Serializable>{
	 // 根据主键获取实体。如果没有相应的实体，返�?null�?
    public T get(PK id);

    // 根据主键获取实体并加锁�?如果没有相应的实体，返回 null�?
    public T getWithLock(PK id, LockMode lock);

    // 根据主键获取实体。如果没有相应的实体，抛出异常�?
    public T load(PK id);

    // 根据主键获取实体并加锁�?如果没有相应的实体，抛出异常�?
    public T loadWithLock(PK id, LockMode lock);

    // 更新实体
    public void update(T entity);

    // 更新实体并加�?
    public void updateWithLock(T entity, LockMode lock);

    // 存储实体到数据库
    public void save(T entity);

    // saveWithLock()

    // 增加或更新实�?
    public void saveOrUpdate(T entity);

    // 删除指定的实�?
    public void delete(T entity);

    // 加锁并删除指定的实体
    public void deleteWithLock(T entity, LockMode lock);

    // 根据主键删除指定实体
    public void deleteByKey(PK id);

    // 根据主键加锁并删除指定的实体
    public void deleteByKeyWithLock(PK id, LockMode lock);

    // -------------------- HQL ----------------------------------------------
    //--------------------常用方法------------------------------------------
	public List<?> getListForPage(final String hql, final int pageNo, final int pageContSize);
	public Integer getRows(final String hql);
	//-------------------常用方法结束-------------------------------------------
    
    // 使用HQL语句直接增加、更新�?删除实体
    public int bulkUpdate(String queryString);

    // 使用带参数的HQL语句增加、更新�?删除实体
    public int bulkUpdate(String queryString, Object[] values);

    // 使用HQL语句�?��数据
    public List find(String queryString);

    // 使用带参数的HQL语句�?��数据
    public List find(String queryString, Object[] values);

    // 使用带命名的参数的HQL语句�?��数据
    public List findByNamedParam(String queryString, String[] paramNames,
            Object[] values);

    // 使用命名的HQL语句�?��数据
    public List findByNamedQuery(String queryName);

    // 使用带参数的命名HQL语句�?��数据
    public List findByNamedQuery(String queryName, Object[] values);

    // 使用带命名参数的命名HQL语句�?��数据
    public List findByNamedQueryAndNamedParam(String queryName,
            String[] paramNames, Object[] values);

    // -------------------------------- Others --------------------------------
    // 强制立即更新缓冲数据到数据库（否则仅在事务提交时才更新）
    public void flush();
    
    public int executeBySql(String sqlString, Object...values);
    
    public int executeBySql(String sqlString);
    
    public List listBySql(String sqlString);
}
