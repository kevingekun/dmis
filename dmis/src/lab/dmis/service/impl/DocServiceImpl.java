package lab.dmis.service.impl;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.annotation.Resource;

import lab.common.model.Page;
import lab.common.service.impl.BaseManagerImpl;
import lab.dmis.dao.DocDao;
import lab.dmis.model.Doc;
import lab.dmis.model.User;
import lab.dmis.service.DocService;

import org.springframework.stereotype.Service;

@Service
public class DocServiceImpl extends BaseManagerImpl<Doc, Integer> implements
		DocService {

	private DocDao docDaoImpl;
	private Doc doc;
	String hql = "";

	/**
	 * 统计文档类型
	 */
	@Override
	public List<Integer> countByCategory() {
		String sql = null;
		List<Integer> list = new ArrayList<Integer>();
		String[] strings = {"doc","docx","pdf","ppt","pptx","xls","xlsx"};
		for(String s:strings){
			sql = "select count(*) from Doc doc where doc.format='"+s+"'";
			try {
				list.add((Integer.parseInt(String.valueOf(docDaoImpl.find(sql).get(0)))));
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return list;
	}

	/**
	 * 统计文档各个等级数量
	 */
	@Override
	public List<Integer> countByLevel() {
		String sql = null;
		List<Integer> list = new ArrayList<Integer>();
		String[] strings = {"1","2","3"};
		for(String s:strings){
			sql = "select count(*) from Doc doc where doc.level="+s;
			System.err.println(sql);
			try {
				list.add((Integer.parseInt(String.valueOf(docDaoImpl.find(sql).get(0)))));
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return list;
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
				+ " GROUP BY dr.doc.id ORDER BY count(dr.doc.id) DESC limit 10";
		String sql2 = "select count(dr.doc.id) from Downloadrecoder dr,Doc doc where dr.doc.id = doc.id AND YEAR(dr.downloadTime)="
				+ now.get(Calendar.YEAR)
				+ " GROUP BY dr.doc.id ORDER BY count(dr.doc.id) DESC limit 10";
		String sql3 = "select doc.title from Downloadrecoder dr,Doc doc where dr.doc.id = doc.id AND YEAR(dr.downloadTime)="
				+ (now.get(Calendar.YEAR) - 1)
				+ " GROUP BY dr.doc.id ORDER BY count(dr.doc.id) DESC limit 10";
		String sql4 = "select count(dr.doc.id) from Downloadrecoder dr,Doc doc where dr.doc.id = doc.id AND YEAR(dr.downloadTime)="
				+ (now.get(Calendar.YEAR) - 1)
				+ " GROUP BY dr.doc.id ORDER BY count(dr.doc.id) DESC limit 10";
		try {
			list.add(docDaoImpl.find(sql1));
			list.add(docDaoImpl.find(sql2));
			list.add(docDaoImpl.find(sql3));
			list.add(docDaoImpl.find(sql4));
		} catch (Exception e) {
			e.printStackTrace();
		}
		list.add(thisYear);
		list.add(lastYear);

		return list;
	}

	/**
	 * 获取用所有文档
	 */
	public Page getPage(int pageNo, int pageContSize) {
		hql = "from Doc doc order by doc.id DESC";
		return docDaoImpl.getPage(hql, pageNo, pageContSize);
	}

	public Page getPage(int pageNo, int pageContSize, boolean isPass) {
		int pass = 0;
		if (isPass == true) {
			pass = 1;
		}
		hql = "from Doc doc where doc.isPass=" + pass + " order by doc.id DESC";
		return docDaoImpl.getPage(hql, pageNo, pageContSize);
	}

	/**
	 * 根据等级获取用所有文档
	 */
	public Page getPage(int pageNo, int pageContSize, User user) {
		hql = "from Doc doc where doc.level>=" + user.getRole()
				+ " order by doc.id DESC";
		return docDaoImpl.getPage(hql, pageNo, pageContSize);
	}

	public Page getPage(int state, int pageNo, int pageContSize) {
		String hql1 = "from Doc d  order by d.id DESC";
		String hql2 = "from Doc d where d.isPass=1 order by d.id DESC";
		String hql3 = "from Doc d where d.isPass=0 order by d.id";
		if (state == 2) {
			return docDaoImpl.getPage(hql1, pageNo, pageContSize);
		} else if (state == 1) {
			return docDaoImpl.getPage(hql2, pageNo, pageContSize);
		} else /* if(state == "0") */{
			return docDaoImpl.getPage(hql3, pageNo, pageContSize);
		}
	}

	/**
	 * 靠ID查找文档
	 * 
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Doc> findById(int id) {
		String hql = "from Doc where id='" + id + "'";
		return docDaoImpl.find(hql);
	}

	/**
	 * 通过文档
	 * 
	 * @return
	 */
	public void passDoc(Doc doc) {
		docDaoImpl.update(doc);
	}

	
	/**
	 * 上传文献
	 */
	public void uploaddocument(Doc doc) {
		docDaoImpl.add(doc);
	}

	/**
	 * 批量删除
	 */
	public void deleteByIds(List<String> ids) {
		for (int i = 0; i < ids.size(); i++) {
			int id = Integer.parseInt(ids.get(i));
			docDaoImpl.deleteByKey(id);
		}

	}

	/**
	 * 加载阅读文档
	 * 
	 * @return
	 */
	public Doc reading(Integer id) {
		return docDaoImpl.get(id);
	}

	public Doc getDoc() {
		return doc;
	}

	public void setDoc(Doc doc) {
		this.doc = doc;
	}

	public DocDao getDocDaoImpl() {
		return docDaoImpl;
	}

	@Resource
	public void setDocDaoImpl(DocDao docDaoImpl) {
		this.docDaoImpl = docDaoImpl;
	}
}
