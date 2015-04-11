package lab.dmis.dao;

import lab.common.dao.BaseDAO;
import lab.dmis.model.Comment;

public interface CommentDao extends BaseDAO<Comment, Integer> {

	public void add(Comment comment);

	public Comment findById(int commentId);

}
