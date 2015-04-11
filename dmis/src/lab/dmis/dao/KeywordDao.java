package lab.dmis.dao;

import java.util.List;

import lab.common.dao.BaseDAO;
import lab.dmis.model.Keyword;

public interface KeywordDao extends BaseDAO<Keyword, Integer> {

	public Keyword QueryEqualName(Keyword keyWord);   //查找跟关键字完全匹配的对象
	public List<Keyword> QueryLikeName(Keyword keyWord);    //查找含有关键字的所有结果
	public Keyword QueryById(Keyword keyWord);   //根据Id查找对象
	
}