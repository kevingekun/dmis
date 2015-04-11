package lab.dmis.dao.impl;

import lab.common.dao.impl.BaseDAOImpl;
import lab.dmis.dao.SearchHistoryDao;
import lab.dmis.model.Searchhistory;

import org.springframework.stereotype.Component;

@Component
public class SearchHistoryDaoImpl extends BaseDAOImpl<Searchhistory, Integer> implements SearchHistoryDao {

}
