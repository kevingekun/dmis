package lab.dmis.web;

import java.io.IOException;

import javax.annotation.Resource;

import lab.common.web.BaseAction;
import lab.dmis.model.Comment;
import lab.dmis.service.CommentService;
import net.sf.json.JSONArray;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

@Component("commentAction")
@Scope("prototype")
public class CommentAction extends BaseAction {

	private static final long serialVersionUID = 1L;

	private CommentService commentServiceImpl;

	private int pageNo = 1;
	private int pageContSize = 8;

	/**
	 * 根据haveHandled属性列出Comment
	 * 
	 */
	public String listByhaveHandled() {
		int haveHandled = Integer.parseInt(getParameter("haveHandled"));
		if (getParameter("pageNo") == null) {
			setAttribute("page", commentServiceImpl.getPage(haveHandled,
					pageNo, pageContSize));
			setAttribute("state", haveHandled);
		} else {
			setAttribute("page", commentServiceImpl.getPage(haveHandled,
					Integer.parseInt(getParameter("pageNo")), pageContSize));
			setAttribute("state", haveHandled);
		}
		return "listByhaveHandledSuccess";
	}

	/**
	 * 查看评论
	 * 
	 * @throws IOException
	 */
	public void checkComment() throws IOException {
		int id = Integer.parseInt(getParameter("id"));
		Comment comment = commentServiceImpl.findById(id);
		System.err.println(comment);
		JSONArray jsonArray = JSONArray.fromObject(comment);
		getResponse().setCharacterEncoding("utf-8");
		getResponse().getWriter().write(jsonArray.toString());
	}

	/**
	 * 评论同意或拒绝
	 * 
	 * @return
	 * @throws IOException
	 */
	public void alterHaveHandled() throws IOException {
		int commentId = Integer.parseInt(getParameter("commentId"));
		int haveHandled = Integer.parseInt(getParameter("haveHandled"));
		Comment comment = commentServiceImpl.findById(commentId);
		comment.setHaveHandled(haveHandled);
		commentServiceImpl.update(comment);
		out().print("success");
	}

	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
	}

	public void setPageContSize(int pageContSize) {
		this.pageContSize = pageContSize;
	}

	public CommentService getCommentServiceImpl() {
		return commentServiceImpl;
	}

	@Resource
	public void setCommentServiceImpl(CommentService commentServiceImpl) {
		this.commentServiceImpl = commentServiceImpl;
	}
}
