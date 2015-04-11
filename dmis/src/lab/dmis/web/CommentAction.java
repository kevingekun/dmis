package lab.dmis.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import lab.common.util.Common;
import lab.common.web.BaseAction;
import lab.dmis.model.Comment;
import lab.dmis.model.Doc;
import lab.dmis.model.User;
import lab.dmis.service.CommentService;

public class CommentAction extends BaseAction{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -7879159007842809352L;
	@Autowired
	private CommentService commentService;
	
	private String tip;
	private int pageNo = 1;
	private int pageContSize = 8;
	
	
	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
	}

	public void setPageContSize(int pageContSize) {
		this.pageContSize = pageContSize;
	}

	public String getTip() {
		return tip;
	}

	public void setTip(String tip) {
		this.tip = tip;
	}

	/**
	 * 添加评论
	 * @return
	 */
	public String add(){
		Comment comment=new Comment();
		comment.setDoc((Doc)getSession().getAttribute("doc"));
		comment.setContent(getParameter("content"));
		comment.setUser((User)getSession().getAttribute("LOGIN_USER"));
		comment.setTime(Common.getTimestampTime(0));
		commentService.add(comment);
		setAttribute("docId", ((Doc)getSession().getAttribute("doc")).getId());
		if(((Doc)getSession().getAttribute("doc")).getDocPath().endsWith(".pdf")){
			return "pdfsuccess";
		}else{
			return "officesuccess";
		}
		
		
	}
	
	/**
	 *向管理员申请根据该评论修改文献 
	 */
	
	public String application(){
		try {
			Comment comment = commentService.findById(Integer.parseInt(getParameter("commentId")));
			User user = (User)getSession().getAttribute("LOGIN_USER");
			String usersOfApplications = comment.getUsersOfApplications();
			if(usersOfApplications != null){
				String[] u = usersOfApplications.split(";");
				for(String each : u){
					if(user.getName().equals(each)){
						setTip("haveApplied");
						return "applicationSuccess";
					}
				}
				usersOfApplications = usersOfApplications + ";" + user.getName();
				
			}else{
				usersOfApplications = user.getName();
			}
			
			comment.setNumOfApplications(comment.getNumOfApplications() + 1);
			comment.setUsersOfApplications(usersOfApplications);
			commentService.update(comment);
			setTip("success");
		} catch (NumberFormatException e) {
			setTip("fail");
			e.printStackTrace();
		}
		return "applicationSuccess";
	}
	
	
	/*public String listByhaveHandled(){
		String queryString;
		String haveHandled = getParameter("haveHandled");
		if(haveHandled.equals("all")){
			queryString = "from Comment where numOfApplications > 0 order by numOfApplications desc";
		}else{
			queryString = "from Comment where numOfApplications > 0 and haveHandled="+ haveHandled;
		}
		
		List<Comment> comments = commentService.find(queryString);
		setAttribute("comments",comments);
		setAttribute("state", haveHandled);
		return "listByhaveHandledSuccess";
	}*/
	/**
	 *根据haveHandled属性列出Comment 
	 */
	public String listByhaveHandled(){
		int haveHandled = Integer.parseInt(getParameter("haveHandled"));
		if(getParameter("pageNo") == null){
			setAttribute("page", commentService.getPage(haveHandled,pageNo, pageContSize));
			setAttribute("state",haveHandled);
		}else{
			setAttribute("page", commentService.getPage(haveHandled,Integer.parseInt(getParameter("pageNo")), pageContSize));
			setAttribute("state",haveHandled);
		}
		return "listByhaveHandledSuccess";
	}
	
	public String alterHaveHandled(){
		int commentId = Integer.parseInt(getParameter("commentId"));
		int haveHandled = Integer.parseInt(getParameter("haveHandled"));
		Comment comment = commentService.findById(commentId);
		comment.setHaveHandled(haveHandled);
		commentService.update(comment);
		setTip("success");
		return "alterHaveHandledSuccess";
	}
	
}
