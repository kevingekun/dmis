package lab.dmis.service;

import lab.common.model.Page;
import lab.common.service.BaseManager;
import lab.dmis.model.Comment;

public interface CommentService extends BaseManager<Comment, Integer>{

	public void add(Comment comment);

	public Comment findById(int commentId);

	
	public Page getPage(int state, int pageNo, int pageContSize);
}
