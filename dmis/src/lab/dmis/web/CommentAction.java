package lab.dmis.web;

import java.io.IOException;

import lab.common.web.BaseAction;
import lab.dmis.model.Comment;
import lab.dmis.service.CommentService;
import net.sf.json.JSONArray;

import org.springframework.beans.factory.annotation.Autowired;

public class CommentAction extends BaseAction {

	/**
	 * 
	 */
	private static final long serialVersionUID = -7879159007842809352L;
	@Autowired
	private CommentService commentService;

	private int pageNo = 1;
	private int pageContSize = 8;

	/**
	 * 根据haveHandled属性列出Comment
	 * 
	 */
	public String listByhaveHandled() {
		int haveHandled = Integer.parseInt(getParameter("haveHandled"));
		if (getParameter("pageNo") == null) {
			setAttribute("page",
					commentService.getPage(haveHandled, pageNo, pageContSize));
			setAttribute("state", haveHandled);
		} else {
			setAttribute("page", commentService.getPage(haveHandled,
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
		Comment comment = commentService.findById(id);
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
		Comment comment = commentService.findById(commentId);
		comment.setHaveHandled(haveHandled);
		commentService.update(comment);
		out().print("success");
	}

	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
	}

	public void setPageContSize(int pageContSize) {
		this.pageContSize = pageContSize;
	}
}
