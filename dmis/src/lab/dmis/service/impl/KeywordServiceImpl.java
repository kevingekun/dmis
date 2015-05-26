package lab.dmis.service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import lab.common.model.Page;
import lab.common.service.impl.BaseManagerImpl;
import lab.dmis.dao.KeywordDao;
import lab.dmis.model.Keyword;
import lab.dmis.service.KeywordService;

import org.springframework.stereotype.Service;

@Service
public class KeywordServiceImpl extends BaseManagerImpl<Keyword, Integer>
		implements KeywordService {

	private KeywordDao keywordDaoImpl;
	private Keyword keyword;

	@Override
	public Keyword QueryEqualName(Keyword keyWord) {
		// TODO Auto-generated method stub
		Keyword keyword = new Keyword();
		keyword = keywordDaoImpl.QueryEqualName(keyWord);

		if (keyword.getContent() == null) {
			keyword.setContent("你查找的知识点不存在，请浏览相关文档对您是否有帮助。");

		}
		return keyword;

	}

	@Override
	public List<Keyword> QueryLikeName(Keyword keyWord) {
		// TODO Auto-generated method stub
		List<Keyword> keywordListTemp = keywordDaoImpl.QueryLikeName(keyWord);
		List<Keyword> keywordList = new ArrayList<Keyword>();

		for (int i = 0; i < keywordListTemp.size() && i < 6; i++) { // 选取相关的前5个
			if (keywordListTemp.get(i).getKeyword() != keyWord.getKeyword()) {

				keywordList.add(keywordListTemp.get(i));
			}

		}

		return keywordList;
	}

	@Override
	public Keyword QueryById(Keyword keyWord) {
		// TODO Auto-generated method stub
		return keywordDaoImpl.QueryById(keyWord);
	}

	public Page getPage(int pageNo, int pageContSize) {
		String hql = "from Keyword k order by k.id DESC";
		return keywordDaoImpl.getPage(hql, pageNo, pageContSize);

	}

	public Page getPage(int pageNo, int pageContSize, boolean isPass) {
		int pass = 0;
		if (isPass == true) {
			pass = 1;
		}
		String hql = "from Keyword k where k.isPass=" + pass
				+ " order by k.id DESC";
		return keywordDaoImpl.getPage(hql, pageNo, pageContSize);
	}

	public Page getPage(int state, int pageNo, int pageContSize) {
		String hql1 = "from Keyword k  order by k.id DESC";
		String hql2 = "from Keyword k where k.isPass=1 order by k.id DESC";
		String hql3 = "from Keyword k where k.isPass=0 order by k.id";
		if (state == 2) {
			return keywordDaoImpl.getPage(hql1, pageNo, pageContSize);
		} else if (state == 1) {
			return keywordDaoImpl.getPage(hql2, pageNo, pageContSize);
		} else /* if(state == "0") */{
			return keywordDaoImpl.getPage(hql3, pageNo, pageContSize);
		}
	}

	/*
	 * @SuppressWarnings("unchecked") public List<Keyword> isPassList(){ String
	 * hql = "from Keyword k where k.isPass='true' order by k.id DESC"; return
	 * keywordDao.find(hql); }
	 * 
	 * @SuppressWarnings("unchecked") public List<Keyword> noPassList(){ String
	 * hql = "from Keyword k where k.isPass='false' order by k.id DESC"; return
	 * keywordDao.find(hql); }
	 */
	public void deleteKeywordById(int id) {
		keywordDaoImpl.deleteByKey(id);
	}

	public void addKeyword(Keyword keyword) {
		keywordDaoImpl.save(keyword);
	}

	public void passKeyword(Keyword keyword) {
		keywordDaoImpl.update(keyword);
	}

	@SuppressWarnings("unchecked")
	public List<Keyword> findById(int id) {
		String hql = "from Keyword where id='" + id + "'";
		return keywordDaoImpl.find(hql);
	}

	@SuppressWarnings("unchecked")
	public List<Keyword> findByName(String keywordName) {
		String hql = "from Keyword k where k.keyword='" + keywordName + "'";
		return keywordDaoImpl.find(hql);
	}

	public void deleteByIds(String[] ids) {
		for (int i = 0; i < ids.length; i++) {
			int id = Integer.parseInt(ids[i]);
			keywordDaoImpl.deleteByKey(id);
		}
	}

	public Keyword getKeyword() {
		return keyword;
	}

	public void setKeyword(Keyword keyword) {
		this.keyword = keyword;
	}

	public KeywordDao getKeywordDaoImpl() {
		return keywordDaoImpl;
	}

	@Resource
	public void setKeywordDaoImpl(KeywordDao keywordDaoImpl) {
		this.keywordDaoImpl = keywordDaoImpl;
	}

}
