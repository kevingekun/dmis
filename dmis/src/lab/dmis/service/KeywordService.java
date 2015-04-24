package lab.dmis.service;

import java.util.List;

import lab.common.model.Page;
import lab.common.service.BaseManager;
import lab.dmis.model.Keyword;

public interface KeywordService extends BaseManager<Keyword, Integer> {
	public void deleteKeywordById(int id);

	public Page getPage(int state, int pageNo, int pageContSize);

	public Page getPage(int pageNo, int pageContSize);

	public Page getPage(int pageNo, int pageContSize, boolean isPass);// 删除时，当页数减少时，按照ispass返回页面状态

	public Keyword QueryEqualName(Keyword keyWord); // 查找跟关键字完全匹配的对象

	public List<Keyword> QueryLikeName(Keyword keyWord); // 查找含有关键字的所有结果

	public Keyword QueryById(Keyword keyWord); // 根据id查找对象

	public void addKeyword(Keyword keyword);// 新增词条

	public void passKeyword(Keyword keyword);// 通过词条

	public List<Keyword> findById(int id);// 根据ID查找

	public void deleteByIds(String[] ids);// 批量删除

}
