package lab.dmis.dao.impl;

import lab.common.dao.impl.BaseDAOImpl;
import lab.dmis.dao.TypeDao;
import lab.dmis.model.Type;

import org.springframework.stereotype.Component;

@Component
public class TypeDaoImpl extends BaseDAOImpl<Type, Integer> implements TypeDao {

}
