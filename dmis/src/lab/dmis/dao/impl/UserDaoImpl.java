package lab.dmis.dao.impl;

import lab.common.dao.impl.BaseDAOImpl;
import lab.dmis.dao.UserDao;
import lab.dmis.model.User;

import org.springframework.stereotype.Component;

@Component
public class UserDaoImpl extends BaseDAOImpl<User, Integer> implements UserDao {

}
