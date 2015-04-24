package lab.dmis.service.impl;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import lab.common.model.Page;
import lab.common.service.impl.BaseManagerImpl;
import lab.common.util.Common;
import lab.dmis.dao.DocDao;
import lab.dmis.model.Doc;
import lab.dmis.model.User;
import lab.dmis.service.DocService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class DocServiceImpl extends BaseManagerImpl<Doc, Integer> implements
		DocService {

	@Autowired
	private DocDao docDao;
	private Doc doc;
	String hql = "";

	/**
	 * 统计文档类型
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<Integer> countByCategory() {
		String sql = "select count(*) from Doc doc group by doc.format";
		return docDao.find(sql);
	}

	/**
	 * 统计文档各个等级数量
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<Integer> countByLevel() {
		String sql = "select count(*) from Doc doc group by doc.level";
		return docDao.find(sql);
	}

	/**
	 * 统计文档下载量
	 */
	@Override
	public List<Object> countByDownload() {
		Calendar now = Calendar.getInstance();
		List<Object> list = new ArrayList<Object>();
		List<String> listThisYear = new ArrayList<String>();
		List<String> listLastYear = new ArrayList<String>();
		String thisYear = String.valueOf(now.get(Calendar.YEAR)) + "年";
		String lastYear = String.valueOf(now.get(Calendar.YEAR) - 1) + "年";
		listThisYear.add(thisYear);
		listLastYear.add(lastYear);
		String sql1 = "select doc.title from Downloadrecoder dr,Doc doc where dr.doc.id = doc.id AND YEAR(dr.downloadTime)="
				+ now.get(Calendar.YEAR)
				+ " GROUP BY dr.doc.id ORDER BY count(dr.doc.id) DESC";
		String sql2 = "select count(dr.doc.id) from Downloadrecoder dr,Doc doc where dr.doc.id = doc.id AND YEAR(dr.downloadTime)="
				+ now.get(Calendar.YEAR)
				+ " GROUP BY dr.doc.id ORDER BY count(dr.doc.id) DESC";
		String sql3 = "select doc.title from Downloadrecoder dr,Doc doc where dr.doc.id = doc.id AND YEAR(dr.downloadTime)="
				+ (now.get(Calendar.YEAR) - 1)
				+ " GROUP BY dr.doc.id ORDER BY count(dr.doc.id) DESC";
		String sql4 = "select count(dr.doc.id) from Downloadrecoder dr,Doc doc where dr.doc.id = doc.id AND YEAR(dr.downloadTime)="
				+ (now.get(Calendar.YEAR) - 1)
				+ " GROUP BY dr.doc.id ORDER BY count(dr.doc.id) DESC";
		list.add(docDao.find(sql1).subList(0, 10));
		list.add(docDao.find(sql2).subList(0, 10));
		list.add(docDao.find(sql3).subList(0, 10));
		list.add(docDao.find(sql4).subList(0, 10));
		list.add(thisYear);
		list.add(lastYear);

		return list;
	}

	/**
	 * 获取用所有文档
	 */
	public Page getPage(int pageNo, int pageContSize) {
		hql = "from Doc doc order by doc.id DESC";
		return docDao.getPage(hql, pageNo, pageContSize);
	}

	public Page getPage(int pageNo, int pageContSize, boolean isPass) {
		int pass = 0;
		if (isPass == true) {
			pass = 1;
		}
		hql = "from Doc doc where doc.isPass=" + pass + " order by doc.id DESC";
		return docDao.getPage(hql, pageNo, pageContSize);
	}

	/**
	 * 根据等级获取用所有文档
	 */
	public Page getPage(int pageNo, int pageContSize, User user) {
		hql = "from Doc doc where doc.level>=" + user.getRole()
				+ " order by doc.id DESC";
		return docDao.getPage(hql, pageNo, pageContSize);
	}

	public Page getPage(int state, int pageNo, int pageContSize) {
		String hql1 = "from Doc d  order by d.id DESC";
		String hql2 = "from Doc d where d.isPass=1 order by d.id DESC";
		String hql3 = "from Doc d where d.isPass=0 order by d.id";
		if (state == 2) {
			return docDao.getPage(hql1, pageNo, pageContSize);
		} else if (state == 1) {
			return docDao.getPage(hql2, pageNo, pageContSize);
		} else /* if(state == "0") */{
			return docDao.getPage(hql3, pageNo, pageContSize);
		}
	}

	/**
	 * 高级搜索
	 */
	public Page getAdvancedSearch(int pageNo, int pageContSize, String typeId,
			String year, String category, String language, String keyword,
			User user) {
		hql = "from Doc doc where doc.level>=" + user.getRole() + "";
		if (!typeId.equals("") || !year.equals("") || !category.equals("")
				|| !language.equals("") || !keyword.equals(""))
			hql += " and";
		if (!typeId.equals("")) {
			hql += " doc.type.id = '" + Integer.parseInt(typeId) + "'";
			if (!year.equals("") || !category.equals("")
					|| !language.equals("") || !keyword.equals(""))
				hql += " and";
		}
		if (!year.equals("")) {
			hql += " doc.uploadTime >= '"
					+ Common.getTimestampTime(Integer.parseInt(year)) + "'";
			if (!category.equals("") || !language.equals("")
					|| !keyword.equals(""))
				hql += " and";
		}
		if (!category.equals("")) {
			hql += " doc.category = '" + category + "'";
			if (!language.equals("") || !keyword.equals(""))
				hql += " and";
		}
		if (!language.equals("")) {
			hql += " doc.language = '" + Integer.parseInt(language) + "'";
			if (!keyword.equals(""))
				hql += " and";
		}
		if (!keyword.equals("")) {
			hql += " (doc.title LIKE '%" + keyword + "%' or doc.brief LIKE '%"
					+ keyword + "%' or doc.type.name LIKE '%" + keyword + "%')";
		}

		hql += " order by doc.id DESC";
		return docDao.getPage(hql, pageNo, pageContSize);
	}

	@Override
	public Doc QueryEqualTitle(Doc doc) {
		// TODO Auto-generated method stub
		Doc docTemp = new Doc();
		docTemp = docDao.QueryEqualTitle(doc);
		return docTemp;
	}

	@Override
	public List<Doc> QueryLikeTitle(Doc doc) {
		// TODO Auto-generated method stub
		List<Doc> docListTemp = new ArrayList<Doc>();
		List<Doc> docList = new ArrayList<Doc>();
		docListTemp = docDao.QueryLikeTitle(doc);

		for (int i = 0; i < 6 && i < docListTemp.size(); i++) { // 选取相关的前5个
			if (docListTemp.get(i).getTitle() != doc.getTitle()) {
				docList.add(docListTemp.get(i));
			}
		}

		return docList;
	}

	@Override
	public Doc QueryById(Doc doc) {
		// TODO Auto-generated method stub
		Doc temp = docDao.QueryById(doc);
		return temp;
	}

	/**
	 * 靠主键删除文档
	 */
	public void deleteDocById(int id) {
		docDao.deleteByKey(id);
	}

	/**
	 * 靠ID查找文档
	 * 
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Doc> findById(int id) {
		String hql = "from Doc where id='" + id + "'";
		return docDao.find(hql);
	}

	/**
	 * 通过文档
	 * 
	 * @return
	 */
	public void passDoc(Doc doc) {
		docDao.update(doc);
	}

	/**
	 * 上传文档
	 * 
	 * @return
	 */
	/*
	 * public void uploadDoc() { }
	 */
	/**
	 * 批量删除
	 */
	// 上传文献，数据库增加一条doc记录
	public void uploaddocument(Doc doc) {
		docDao.add(doc);
	}

	public void deleteByIds(String[] ids) {
		for (int i = 0; i < ids.length; i++) {
			int id = Integer.parseInt(ids[i]);
			docDao.deleteByKey(id);
		}

	}

	// 通过原文件id查找历史版本
	@SuppressWarnings("unchecked")
	@Override
	public List<Doc> findAllByOriginalId(int originalId) {
		String hql = "from Doc as d where d.originalId=" + originalId
				+ " order by d.version desc";
		return docDao.find(hql);
	}

	/**
	 * 加载阅读文档
	 * 
	 * @return
	 */
	public Doc reading(Integer id) {
		return docDao.get(id);
	}

	public Doc getDoc() {
		return doc;
	}

	public void setDoc(Doc doc) {
		this.doc = doc;
	}

	public DocDao getDocDao() {
		return docDao;
	}

	public void setDocDao(DocDao docDao) {
		this.docDao = docDao;
	}

}
