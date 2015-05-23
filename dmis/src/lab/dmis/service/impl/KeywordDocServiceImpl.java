package lab.dmis.service.impl;

import java.util.List;

import lab.common.service.impl.BaseManagerImpl;
import lab.dmis.dao.KeywordDocDao;
import lab.dmis.model.Keyworddoc;
import lab.dmis.service.KeywordDocService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class KeywordDocServiceImpl extends BaseManagerImpl<Keyworddoc, Integer>
		implements KeywordDocService {

	@Autowired
	private KeywordDocDao keywordDocDao;

	@Override
	public void addKeywordDoc(Keyworddoc keyworddoc) {
		keywordDocDao.save(keyworddoc);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Keyworddoc> findByKidDid(int kid, int did) {
		String hql = "from Keyworddoc kd where kd.keyword=" + kid
				+ " and kd.doc=" + did;
		return keywordDocDao.find(hql);
	}

}
