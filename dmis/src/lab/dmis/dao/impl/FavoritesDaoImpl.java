package lab.dmis.dao.impl;

import lab.common.dao.impl.BaseDAOImpl;
import lab.dmis.dao.FavoritesDao;
import lab.dmis.model.Favorites;

import org.springframework.stereotype.Component;

@Component
public class FavoritesDaoImpl extends BaseDAOImpl<Favorites, Integer> implements FavoritesDao {

}
