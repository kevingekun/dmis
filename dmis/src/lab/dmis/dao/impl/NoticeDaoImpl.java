package lab.dmis.dao.impl;

import lab.common.dao.impl.BaseDAOImpl;
import lab.dmis.dao.NoticeDao;
import lab.dmis.model.Notice;

import org.springframework.stereotype.Component;

@Component
public class NoticeDaoImpl extends BaseDAOImpl<Notice, Integer> implements NoticeDao {

}
