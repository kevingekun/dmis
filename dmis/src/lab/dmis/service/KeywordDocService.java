package lab.dmis.service;

import java.util.List;

import lab.common.service.BaseManager;
import lab.dmis.model.Keyworddoc;

public interface KeywordDocService extends BaseManager<Keyworddoc, Integer> {

	public abstract void addKeywordDoc(Keyworddoc keyworddoc);

	public abstract List<Keyworddoc> findByKidDid(int kid, int did);
}
