package lab.dmis.dao.impl;

import java.util.List;

import lab.common.dao.impl.BaseDAOImpl;
import lab.dmis.dao.CommentDao;
import lab.dmis.model.Comment;

import org.springframework.stereotype.Component;

@Component
public class CommentDaoImpl extends BaseDAOImpl<Comment, Integer> implements CommentDao {

	@Override
	public void add(Comment comment) {
		// TODO Auto-generated method stub
		save(comment);
	}

	@Override
	public Comment findById(int commentId) {
		@SuppressWarnings("unchecked")
		List<Comment> comments = find("from Comment where id = ?", commentId);
		if(comments.size() == 0){
			return null;
		}
		return (Comment) comments.get(0);
	}

}
