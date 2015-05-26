package lab.dmis.service.impl;

import java.util.List;

import javax.annotation.Resource;

import lab.common.service.impl.BaseManagerImpl;
import lab.dmis.dao.KeywordDocDao;
import lab.dmis.model.Keyworddoc;
import lab.dmis.service.KeywordDocService;

import org.springframework.stereotype.Service;

@Service
public class KeywordDocServiceImpl extends BaseManagerImpl<Keyworddoc, Integer>
		implements KeywordDocService {

	private KeywordDocDao keywordDocDaoImpl;

	@Override
	public void addKeywordDoc(Keyworddoc keyworddoc) {
		keywordDocDaoImpl.save(keyworddoc);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Keyworddoc> findByKidDid(int kid, int did) {
		String hql = "from Keyworddoc kd where kd.keyword=" + kid
				+ " and kd.doc=" + did;
		return keywordDocDaoImpl.find(hql);
	}

	public KeywordDocDao getKeywordDocDaoImpl() {
		return keywordDocDaoImpl;
	}

	@Resource
	public void setKeywordDocDaoImpl(KeywordDocDao keywordDocDaoImpl) {
		this.keywordDocDaoImpl = keywordDocDaoImpl;
	}
}
