package lab.dmis.dao.impl;

import java.util.List;

import lab.common.dao.impl.BaseDAOImpl;
import lab.dmis.dao.KeywordDao;
import lab.dmis.model.Keyword;

import org.springframework.stereotype.Component;

@Component
public class KeywordDaoImpl extends BaseDAOImpl<Keyword, Integer> implements KeywordDao {

	public Keyword QueryEqualName(Keyword keyWord) {
		
		String hql="from Keyword where keyword=?";
		List<Keyword> keywordList=find(hql, keyWord.getKeyword());
		Keyword temp=new Keyword();
		// TODO Auto-generated method stub
		if(keywordList.size()!=0){
			temp = keywordList.get(0);
		}
		return temp;
	}

	@Override
	public List<Keyword> QueryLikeName(Keyword keyWord) {
		// TODO Auto-generated method stub
		String hql="from Keyword where keyword like ?";
		List<Keyword>  keywordList=find(hql,"%"+keyWord.getKeyword()+"%");
		return keywordList;
	}

	@Override
	public Keyword QueryById(Keyword keyWord) {
		// TODO Auto-generated method stub
		String hql="from Keyword where id=?";
		List<Keyword> keywordList=find(hql, keyWord.getId());
		return keywordList.get(0);
	}
}
