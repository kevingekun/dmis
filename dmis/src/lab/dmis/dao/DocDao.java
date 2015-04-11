package lab.dmis.dao;

import java.util.List;

import lab.common.dao.BaseDAO;
import lab.dmis.model.Doc;

public interface DocDao extends BaseDAO<Doc, Integer> {
	
	public Doc QueryEqualTitle(Doc doc);             //精确查询
	public List<Doc> QueryLikeTitle(Doc doc);        //模糊查询
	public Doc QueryById(Doc doc);
	public void add(Doc doc);//增加文献
}
