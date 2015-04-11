package lab.dmis.web;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

import net.sf.json.JSONArray;

import org.springframework.beans.factory.annotation.Autowired;

import lab.common.web.BaseAction;
import lab.dmis.model.Notice;
import lab.dmis.model.User;
import lab.dmis.service.NoticeService;
import lab.dmis.util.JsonSerialization;
import lab.dmis.util.Str;

public class NoticeAction extends BaseAction{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	@Autowired
	private NoticeService noticeService;
	
	private Notice notice;
	private int pageNo = 1;
	private int pageContSize = 6;

	JSONArray jsonArray;
	
	/**
	 * 获取公告记录
	 * @throws IOException
	 */
	public void getNotices() throws IOException{

		jsonArray = JSONArray.fromObject(noticeService.getPage(pageNo, pageContSize),JsonSerialization.jsonSer(Str.str));

		out().print(jsonArray.toString());
	}
	
	/**
	 *发布公告
	 * @return
	 */
	public String add(){
		notice.setTime(new Timestamp(new Date().getTime()));
		noticeService.addNotice(notice);
		//int totalpage = noticeService.getPage(pageNo, pageContSize).getTotalPage();
		//getRequest().setAttribute("pageNo", totalpage);
		return "listNotice";
	}
	
	/**
	 * 获取全部公告
	 * @return
	 */
	public String list(){
		setAttribute("page", noticeService.getPage(pageNo, pageContSize));
		return "list";
	}
	
	/**
	 * 
	 * @return
	 */
	public String listNotice(){
		//pageNo = Integer.parseInt(getParameter("pageNo"));
		setAttribute("page", noticeService.getPage(pageNo, pageContSize));
		return "list";
	}
	public String listAll()
	{   // setAttribute("recentNotice",noticeService.getPage(1, 5));
	setAttribute("actionName", getActionName());
	setAttribute("page", noticeService.getPage(pageNo, pageContSize));
		return "listAll";
	}
	/**
	 * 根据ID删除公告
	 * @return
	 */
	public String delete2(){
		noticeService.deleteById(Integer.parseInt(getParameter("id")));
		int totalpage = noticeService.getPage(pageNo, pageContSize).getTotalPage();
		pageNo = Integer.parseInt(getParameter("pageNo"));
		if(totalpage<pageNo){
			pageNo = pageNo - 1;
		}
		getRequest().setAttribute("pageNo", pageNo);
		return "listNotice";
	}
	
	/**
	 * 批量删除公告
	 * @return
	 */
	public String delete(){
		String[] ids = new String[pageContSize];
		String id = getParameter("id");
		if(id!=null){
			ids[0] = id;
		}else{
			ids = getRequest().getParameterValues("checkAll");
		}
		noticeService.deleteByIds(ids);
		int totalpage = noticeService.getPage(pageNo, pageContSize).getTotalPage();
		pageNo = Integer.parseInt(getParameter("pageNo"));
		if(totalpage<pageNo){
			pageNo = pageNo - 1;
		}
		getRequest().setAttribute("pageNo", pageNo);
		return "listNotice";
	}
	
	public void checkNotice() throws IOException{
		int id = Integer.parseInt(getParameter("id"));
		List<Notice> list = noticeService.findById(id);
		JSONArray jsonArray = JSONArray.fromObject(list);
		getResponse().setCharacterEncoding("utf-8");
		getResponse().getWriter().write(jsonArray.toString());
	}
	
	public Notice getNotice() {
		return notice;
	}

	public void setNotice(Notice notice) {
		this.notice = notice;
	}
	public int getPageContSize() {
		return pageContSize;
	}

	public void setPageContSize(int pageContSize) {
		this.pageContSize = pageContSize;
	}
	public NoticeService getNoticeService() {
		return noticeService;
	}

	public void setNoticeService(NoticeService noticeService) {
		this.noticeService = noticeService;
	}
	
	public int getPageNo() {
		return pageNo;
	}

	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
	}
	
}
