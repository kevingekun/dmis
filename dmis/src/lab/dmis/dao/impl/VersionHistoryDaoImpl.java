package lab.dmis.dao.impl;

import lab.common.dao.impl.BaseDAOImpl;
import lab.dmis.dao.VersionHistoryDao;
import lab.dmis.model.Versionhistory;

import org.springframework.stereotype.Component;

@Component
public class VersionHistoryDaoImpl extends BaseDAOImpl<Versionhistory, Integer> implements VersionHistoryDao {

}
