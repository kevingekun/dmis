package lab.dmis.service.impl;

import javax.annotation.Resource;

import lab.common.model.Page;
import lab.common.service.impl.BaseManagerImpl;
import lab.dmis.dao.CommentDao;
import lab.dmis.model.Comment;
import lab.dmis.service.CommentService;

import org.springframework.stereotype.Service;

@Service
public class CommentServiceImpl extends BaseManagerImpl<Comment, Integer>
		implements CommentService {

	private CommentDao commentDaoImpl;

	@Override
	public void add(Comment comment) {
		// TODO Auto-generated method stub
		commentDaoImpl.add(comment);

	}

	@Override
	public Comment findById(int commentId) {
		return commentDaoImpl.findById(commentId);
	}

	@Override
	public Page getPage(int state, int pageNo, int pageContSize) {
		String hql0 = "from Comment as c where c.haveHandled=0 and numOfApplications>0 order by c.id DESC";
		String hql1 = "from Comment as c where c.haveHandled=1 and numOfApplications>0 order by c.id DESC";
		String hql2 = "from Comment as c where c.haveHandled=2 and numOfApplications>0 order by c.id DESC";
		String hql3 = "from Comment as c where c.haveHandled=3 and numOfApplications>0 order by c.id DESC";
		if (state == 3) {
			return commentDaoImpl.getPage(hql3, pageNo, pageContSize);
		} else if (state == 2) {
			return commentDaoImpl.getPage(hql2, pageNo, pageContSize);
		} else if (state == 1) {
			return commentDaoImpl.getPage(hql1, pageNo, pageContSize);
		} else {
			return commentDaoImpl.getPage(hql0, pageNo, pageContSize);
		}
	}

	public CommentDao getCommentDaoImpl() {
		return commentDaoImpl;
	}

	@Resource
	public void setCommentDaoImpl(CommentDao commentDaoImpl) {
		this.commentDaoImpl = commentDaoImpl;
	}
}
