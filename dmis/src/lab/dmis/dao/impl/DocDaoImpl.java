package lab.dmis.dao.impl;

import java.util.ArrayList;
import java.util.List;

import lab.common.dao.impl.BaseDAOImpl;
import lab.dmis.dao.DocDao;
import lab.dmis.model.Doc;

import org.springframework.stereotype.Component;

@Component
public class DocDaoImpl extends BaseDAOImpl<Doc, Integer> implements DocDao {

	
	@Override
	public Doc QueryEqualTitle(Doc doc) {
		
		String hql="from Doc where title=?";
		List<Doc> docList=new ArrayList<Doc>();
		docList=find(hql,doc.getTitle());
		if(docList.size()==0){
			Doc temp=new Doc();
			//doc.setDocPath("1.doc");
			return temp;
	    }else{
	    	return docList.get(0);
	    }
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Doc> QueryLikeTitle(Doc doc) {
		
		String hql="from Doc where title like ?";
		List<Doc> docList=new ArrayList<Doc>();
		docList=find(hql,"%"+doc.getTitle()+"%");
		
		return docList;
	}

	@SuppressWarnings("unchecked")
	@Override
	public Doc QueryById(Doc doc) {
		
		String hql="from Doc where id=?";
		List<Doc> list=find(hql, doc.getId());
		return list.get(0);
	}
//
	@Override
	public void add(Doc doc) {
		// TODO Auto-generated method stub
		save(doc);
	}

}
