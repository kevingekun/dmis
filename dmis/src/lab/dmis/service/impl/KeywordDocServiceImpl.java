package lab.dmis.service.impl;

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
}
