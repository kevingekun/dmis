package lab.common.dao.impl;

import org.hibernate.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessResourceFailureException;
import org.springframework.dao.support.DaoSupport;
import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.orm.hibernate3.SessionFactoryUtils;

public abstract class HibernateDaoSupport extends DaoSupport {

	public HibernateDaoSupport()
    {
    }
    
    public final void setSessionFactory(SessionFactory sessionFactory)
    {
        if(hibernateTemplate == null || sessionFactory != hibernateTemplate.getSessionFactory())
            hibernateTemplate = createHibernateTemplate(sessionFactory);
    }

    protected HibernateTemplate createHibernateTemplate(SessionFactory sessionFactory)
    {
        return new HibernateTemplate(sessionFactory);
    }

    public final SessionFactory getSessionFactory()
    {
        return hibernateTemplate == null ? null : hibernateTemplate.getSessionFactory();
    }

    public final void setHibernateTemplate(HibernateTemplate hibernateTemplate)
    {
        this.hibernateTemplate = hibernateTemplate;
    }

    public final HibernateTemplate getHibernateTemplate()
    {
        return hibernateTemplate;
    }

    protected final void checkDaoConfig()
    {
        if(hibernateTemplate == null)
            throw new IllegalArgumentException("'sessionFactory' or 'hibernateTemplate' is required");
        else
            return;
    }

    protected final Session getSession()
        throws DataAccessResourceFailureException, IllegalStateException
    {
        return getSession(hibernateTemplate.isAllowCreate());
    }

    protected final Session getSession(boolean allowCreate)
        throws DataAccessResourceFailureException, IllegalStateException
    {
        return allowCreate ? SessionFactoryUtils.getSession(getSessionFactory(), hibernateTemplate.getEntityInterceptor(), hibernateTemplate.getJdbcExceptionTranslator()) : SessionFactoryUtils.getSession(getSessionFactory(), false);
    }

    protected final void releaseSession(Session session)
    {
        SessionFactoryUtils.releaseSession(session, getSessionFactory());
    }

    @Autowired
    private HibernateTemplate hibernateTemplate;

}