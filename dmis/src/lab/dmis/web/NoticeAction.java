package lab.dmis.web;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import lab.common.web.BaseAction;
import lab.dmis.model.Notice;
import lab.dmis.service.NoticeService;
import net.sf.json.JSONArray;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

@Component("noticeAction")
@Scope("prototype")
public class NoticeAction extends BaseAction {

	private static final long serialVersionUID = 1L;

	private NoticeService noticeServiceImpl;

	private Notice notice;
	private int pageNo = 1;
	private int pageContSize = 8;
	
	//private List<Object> notices = new ArrayList<Object>();

	JSONArray jsonArray;

	/**
	 * 发布公告
	 * 
	 * @return
	 */
	public String add() {
		notice.setTime(new Timestamp(new Date().getTime()));
		noticeServiceImpl.addNotice(notice);
		setAttribute("page", noticeServiceImpl.getPage(pageNo, pageContSize));
		return "list";
	}

	/**
	 * 获取全部公告
	 * 
	 * @return
	 */
	public String list() {
		//notices.add(noticeServiceImpl.getPage(pageNo, pageContSize)); 前台可直接得到 notices
		setAttribute("page", noticeServiceImpl.getPage(pageNo, pageContSize));
		return "list";
	}

	/**
	 * 批量删除公告
	 * 
	 * @return
	 */
	public String delete() {
		List<String> ids = new ArrayList<String>();
		String id = getParameter("id");
		if (id != null) {
			ids.add(id);
		} else {
			ids = Arrays.asList(getRequest().getParameterValues("checkAll"));
		}
		noticeServiceImpl.deleteByIds(ids);
		int totalpage = noticeServiceImpl.getPage(pageNo, pageContSize)
				.getTotalPage();
		pageNo = Integer.parseInt(getParameter("pageNo"));
		if (totalpage < pageNo) {
			pageNo = pageNo - 1;
		}
		setAttribute("page", noticeServiceImpl.getPage(pageNo, pageContSize));
		return "list";
	}

	public void checkNotice() throws IOException {
		int id = Integer.parseInt(getParameter("id"));
		List<Notice> list = noticeServiceImpl.findById(id);
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

	public NoticeService getNoticeServiceImpl() {
		return noticeServiceImpl;
	}

	@Resource
	public void setNoticeServiceImpl(NoticeService noticeServiceImpl) {
		this.noticeServiceImpl = noticeServiceImpl;
	}

	public int getPageNo() {
		return pageNo;
	}

	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
	}

/*	public List<Object> getNotices() {
		return notices;
	}

	public void setNotices(List<Object> notices) {
		this.notices = notices;
	}*/
}
