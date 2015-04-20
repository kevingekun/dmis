package lab.dmis.web;

//import org.apache.struts2.components.File;
import java.io.File;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import lab.common.model.Page;
import lab.common.util.Common;
import lab.common.web.BaseAction;
import lab.dmis.model.Comment;
import lab.dmis.model.Doc;
import lab.dmis.model.Type;
import lab.dmis.model.User;
import lab.dmis.service.CommentService;
import lab.dmis.service.DocService;
import lab.dmis.service.NoticeService;
import lab.dmis.service.TypeService;
import lab.dmis.util.JsonSerialization;
import lab.dmis.util.Str;
import net.sf.json.JSONArray;

import org.apache.commons.io.FileUtils;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;

public class DocAction extends BaseAction {
	private static final long serialVersionUID = 1L;
	@Autowired
	private DocService docService;
	@Autowired
	private NoticeService noticeService;
	@Autowired
	private TypeService typeService;
	@Autowired
	private CommentService commentService;
	private Doc doc;
	private int pageNo = 1;
	private int pageContSize = 8;
	private File uploadFile;// 实际上传文件
	private String uploadFileFileName;// 上传文件名
	JSONArray jsonArray;
	Page page = new Page();
	@SuppressWarnings({ "unchecked", "rawtypes" })
	List<Doc> list = new ArrayList();

	/**
	 * 统计文档类型
	 * 
	 * @throws IOException
	 */
	public void categoryCount() throws IOException {
		List<Integer> list = new ArrayList<Integer>();
		list = docService.countByCategory();
		/*
		 * JsonConfig cfg = new JsonConfig(); cfg.setExcludes(new String[] {
		 * "docs" }); JSONArray json = JSONArray.fromObject(list, cfg);
		 */
		JSONArray json = JSONArray.fromObject(list);
		getResponse().setCharacterEncoding("utf-8");
		getResponse().getWriter().write(json.toString());
	}

	/**
	 * 统计文档各个等级数量
	 * 
	 * @throws IOException
	 */
	public void levelCount() throws IOException {
		List<Integer> list = new ArrayList<Integer>();
		list = docService.countByLevel();
		JSONArray json = JSONArray.fromObject(list);
		getResponse().setCharacterEncoding("utf-8");
		getResponse().getWriter().write(json.toString());
	}

	/**
	 * 统计文档下载量
	 * 
	 * @throws IOException
	 */
	public void downloadCount() throws IOException {
		List<Object> list = new ArrayList<Object>();
		list = docService.countByDownload();
		System.err.println(list);
		JSONArray json = JSONArray.fromObject(list);
		System.err.println(json);
		getResponse().setCharacterEncoding("utf-8");
		getResponse().getWriter().write(json.toString());
	}

	/**
	 * 获取上传记录
	 * 
	 * @throws IOException
	 */
	public void getUploadRecoder() throws IOException {
		jsonArray = JSONArray.fromObject(docService.getUploadRecoder(pageNo,
				pageContSize, (User) getObjFromSession("LOGIN_USER")),
				JsonSerialization.jsonSer(Str.str));
		out().print(jsonArray.toString());
	}

	/**
	 * 获取最近上传的文档及最新公告
	 * 
	 * @return recentDoc
	 */
	public String getRecentDoc() {
		setAttribute("recentDoc", docService.getPage(1, 10,
				(User) getObjFromSession("LOGIN_USER")));
		setAttribute("recentNotice", noticeService.getPage(1, 5));
		return "recentDoc";
	}

	/**
	 * 获取所有文档
	 * 
	 * @return
	 */
	public String getAllDoc() {
		setAttribute("actionName", getActionName());
		setAttribute("page", docService.getPage(pageNo, 5,
				(User) getObjFromSession("LOGIN_USER")));
		return "allDoc";
	}

	/**
	 * 
	 * @return
	 */
	public String getadminDoc() {
		setAttribute("recentDoc", docService.getPage(1, 10,
				(User) getObjFromSession("LOGIN_USER")));
		setAttribute("recentNotice", noticeService.getPage(1, 5));
		return "adminDoc";
	}

	/**
	 * 上传文献
	 * 
	 * @return
	 * @throws IOException
	 * @throws ParseException
	 */
	// 根据评论修改后重新上传文件
	public String reUploadDoc() throws IOException {
		Comment comment = commentService.findById(Integer
				.parseInt(getParameter("commentId")));
		comment.setHaveHandled(3);
		Doc d = docService.findById(doc.getId()).get(0);

		Doc docSave = new Doc();
		docSave.setVersion(doc.getVersion());
		docSave.setLanguage(doc.getLanguage());
		docSave.setUploadTime(Common.getTimestampTime(0));

		String realpath = ServletActionContext.getServletContext().getRealPath(
				"/doc");
		Date date = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd-HH-mm-ss");
		String time = formatter.format(date);

		String uploadfilename = d.getUser().getId() + "-" + time + "-"
				+ uploadFileFileName;
		if (d.getVersion() == 1.0f) {
			docSave.setOriginalId(d.getId());
		} else {
			docSave.setOriginalId(d.getOriginalId());
		}

		if (uploadFile != null) {
			File savefile = new File(new File(realpath), uploadfilename);// 创建一个
																			// File实例，表示指定路径指定名称的文件
			if (!savefile.getParentFile().exists())
				savefile.getParentFile().mkdirs();
			FileUtils.copyFile(uploadFile, savefile);// 文件上传至targetDirectory
		}
		docSave.setDocPath("doc/" + uploadfilename);
		docSave.setTitle(d.getTitle());
		docSave.setAuthor(d.getAuthor());
		docSave.setBrief(d.getBrief());
		docSave.setJournal(d.getJournal());
		docSave.setPublishedTime(d.getPublishedTime());
		docSave.setPublishedTime(d.getPublishedTime());
		docSave.setCategory(d.getCategory());
		docSave.setFormat(d.getFormat());
		docSave.setIsPass(d.getIsPass());
		docSave.setLevel(d.getLevel());
		docSave.setUser(d.getUser());
		docSave.setType(d.getType());
		docService.uploaddocument(docSave);

		return "reUploadDoc";
	}

	public String uploadDoc() throws IOException, ParseException {
		doc.setUploadTime(Common.getTimestampTime(0));
		String threeTypeName = getParameter("typeThree");// 获得三级类的值
		Type threetype = new Type();
		threetype = typeService.getByName(threeTypeName).get(0);// 根据三级类输入
																// 的名字搜索Type实体
		doc.setType(threetype);
		// System.out.println( threetype);
		// System.out.println(doc.getLanguage());
		User uu = (User) getSession().getAttribute("LOGIN_USER");
		System.out.println(uu);
		doc.setUser(uu);// 上传用户
		// doc.setPublishedTime(Common.getTimestampTime(0));

		int docType = uploadFileFileName.lastIndexOf(".");
		String lastname = uploadFileFileName.substring(docType + 1,
				uploadFileFileName.length());
		System.out.println(lastname);
		doc.setFormat(lastname);
		// 站点的doc目录下
		String realpath = ServletActionContext.getServletContext().getRealPath(
				"/doc");
		Date date = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd-HH-mm-ss");
		String time = formatter.format(date);
		String userid = Integer.toString(uu.getId());
		String uploadfilename = userid + "-" + time + "-" + uploadFileFileName;
		if (uploadFile != null) {
			File savefile = new File(new File(realpath), uploadfilename);// 创建一个
																			// File实例，表示指定路径指定名称的文件
			if (!savefile.getParentFile().exists())
				savefile.getParentFile().mkdirs();
			FileUtils.copyFile(uploadFile, savefile);// 文件上传至targetDirectory
		}
		doc.setDocPath("doc/" + uploadfilename);

		docService.uploaddocument(doc);
		// out().print("true");
		docService.uploaddocument(doc);
		if (doc.getLevel() != null) {
			return "upload_success";
		} else {
			return "personalCenter";
		}
	}

	/**
	 * 上传文档
	 * 
	 * @return
	 * @throws IOException
	 * @throws ParseException
	 */
	public String uploadDocDoc() throws IOException, ParseException {
		doc.setUploadTime(Common.getTimestampTime(0));
		String caString = getParameter("category");
		System.out.println(caString);
		if (getParameter("category").equals("分类文档")) {
			String threeTypeName = getParameter("typeThree");// 获得三级类的值
			Type threetype = new Type();
			threetype = typeService.getByName(threeTypeName).get(0);// 根据三级类输入
																	// 的名字搜索Type实体
			doc.setType(threetype);
			System.out.println(threetype);
		} else {
			doc.setCategory(getParameter("category"));
		}
		System.out.println(doc.getLanguage());
		User uu = (User) getSession().getAttribute("LOGIN_USER");
		System.out.println(uu);
		doc.setUser(uu);// 上传用户
		// doc.setPublishedTime(Common.getTimestampTime(0));

		int docType = uploadFileFileName.lastIndexOf(".");
		String lastname = uploadFileFileName.substring(docType + 1,
				uploadFileFileName.length());
		System.out.println(lastname);
		doc.setFormat(lastname);
		// 站点的doc目录下
		String realpath = ServletActionContext.getServletContext().getRealPath(
				"/doc");
		Date date = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd-HH-mm-ss");
		String time = formatter.format(date);
		String userid = Integer.toString(uu.getId());
		String uploadfilename = userid + "-" + time + "-" + uploadFileFileName;
		System.out.println(uploadfilename);
		if (uploadFile != null) {
			File savefile = new File(new File(realpath), uploadfilename);// 创建一个
																			// File实例，表示指定路径指定名称的文件
			if (!savefile.getParentFile().exists())
				savefile.getParentFile().mkdirs();
			FileUtils.copyFile(uploadFile, savefile);// 文件上传至targetDirectory
		}
		doc.setDocPath("doc/" + uploadfilename);

		docService.uploaddocument(doc);
		if (doc.getLevel() != null) {
			return "upload_success";
		} else {
			return "personalCenter";
		}
	}

	/**
	 * 根据分类查找相关文档
	 * 
	 * @return
	 */
	public String getDocByType() {
		setAttribute("typeName", getParameter("typeName"));
		setAttribute("typeId", getParameter("typeId"));
		setAttribute("actionName", getActionName());
		setAttribute(
				"page",
				docService.getDocByType(pageNo, 5,
						Integer.parseInt(getParameter("typeId"))));
		return "typeDoc";
	}

	/**
	 * 高级搜索
	 * 
	 * @return
	 */
	public String getAdvancedSearch() {
		setAttribute("typeName", getParameter("typeName"));
		setAttribute("typeId", getParameter("typeId"));
		setAttribute("search", getParameter("keyword"));
		setAttribute("year", getParameter("year"));
		setAttribute("category", getParameter("category"));
		setAttribute("language", getParameter("language"));
		setAttribute("actionName", getActionName());
		String uri = "&year=" + getParameter("year") + "&category="
				+ getParameter("category") + "&language="
				+ getParameter("language") + "&keyword="
				+ getParameter("keyword") + "";
		setAttribute("uri", uri);
		setAttribute("page",
				docService.getAdvancedSearch(pageNo, 5, getParameter("typeId"),
						getParameter("year"), getParameter("category"),
						getParameter("language"), getParameter("keyword"),
						(User) getObjFromSession("LOGIN_USER")));

		return "advancedDoc";
	}

	/**
	 * 分页显示DOC
	 * 
	 * @return
	 */
	public String listAll() {
		// int state = Integer.parseInt(getParameter("state"));
		if (getParameter("pageNo") == null) {
			setAttribute("page", docService.getPage(pageNo, pageContSize));
			setAttribute("state", 2);
			return "list";

		} else {
			setAttribute("page", docService.getPage(
					Integer.parseInt(getParameter("pageNo")), pageContSize));
			setAttribute("state", 2);
			return "list";
		}
	}

	/**
	 * 分页显示
	 * 
	 * @return
	 */
	public String list() {
		int state = Integer.parseInt(getParameter("state"));
		if (getParameter("pageNo") == null) {
			setAttribute("page",
					docService.getPage(state, pageNo, pageContSize));
			setAttribute("state", state);
			return "list";
		} else {
			System.out.println(getParameter("pageNo"));
			setAttribute("page", docService.getPage(state,
					Integer.parseInt(getParameter("pageNo")), pageContSize));
			setAttribute("state", state);
			return "list";
		}
	}

	/**
	 * 用主键删除DOC
	 * 
	 * @return
	 */
	public String delete() {
		int id = Integer.parseInt(getParameter("id"));
		docService.deleteDocById(id);
		int totalpage = docService.getPage(pageNo, pageContSize).getTotalPage();
		pageNo = Integer.parseInt(getParameter("pageNo"));
		if (totalpage < pageNo) {
			pageNo = pageNo - 1;
		}
		getRequest().setAttribute("pageNo", pageNo);
		return "delete_success";
	}

	/**
	 * 批量删除
	 * 
	 * @return
	 */
	public String deleteCheck() {
		String[] ids = getRequest().getParameterValues("checkAll");
		docService.deleteByIds(ids);
		int totalpage = docService.getPage(pageNo, pageContSize).getTotalPage();
		pageNo = Integer.parseInt(getParameter("pageNo"));
		if (totalpage < pageNo) {
			pageNo = pageNo - 1;
		}
		getRequest().setAttribute("pageNo", pageNo);
		return "delete_success";
	}

	/**
	 * 根据标题查询
	 * 
	 * @return
	 */
	public String search() {
		String keyword = getParameter("keyw");
		if (keyword.length() != 0) {
			Doc doc = new Doc();
			Doc temp = new Doc();
			List<Doc> docList = new ArrayList<Doc>();
			doc.setTitle(keyword);
			System.out.println(doc.getTitle());
			temp = docService.QueryEqualTitle(doc);
			docList = docService.QueryLikeTitle(doc);

			setAttribute("doc", temp);

			setAttribute("doclist", docList);

			getSession().setAttribute("doc", temp);
			if (temp.getAuthor() != null) { // 查不到对象
				if (temp.getDocPath().endsWith(".doc")
						|| temp.getDocPath().endsWith(".docx")) {
					setAttribute("type", "doc");
					return "success";
				} else if (temp.getDocPath().endsWith(".pdf")) {
					setAttribute("type", "pdf");
					return "success";

				} else if (temp.getDocPath().endsWith(".ppt")) {
					setAttribute("type", "ppt");
					return "success";
				} else {
					setAttribute("type", "xls");
					return "success";
				}
			} else {
				return "allDoc";
			}
		} else {
			return "allDoc";
		}

	}

	/**
	 * 根据ID查询
	 * 
	 * @return
	 */
	public String hrefsearch() {
		int docId = Integer.parseInt(getParameter("docId"));
		Doc doc = new Doc();
		Doc temp = new Doc();
		List<Doc> docList = new ArrayList<Doc>();
		doc.setId(docId);
		temp = docService.QueryById(doc);

		docList = docService.QueryLikeTitle(temp);
		List<Doc> docByVersionList;
		if (temp.getOriginalId() == null) {
			docByVersionList = docService.findAllByOriginalId(docId);
			docByVersionList.add(temp);
		} else {
			docByVersionList = docService.findAllByOriginalId(temp
					.getOriginalId());
			doc.setId(temp.getOriginalId());
			docByVersionList.add(docService.QueryById(doc));
		}
		setAttribute("docByVersionList", docByVersionList);
		setAttribute("doc", temp);

		setAttribute("doclist", docList);

		getSession().setAttribute("doc", temp);
		if (temp.getDocPath().endsWith(".doc")
				|| temp.getDocPath().endsWith(".docx")) {
			setAttribute("type", "doc");
			return "success";
		} else if (temp.getDocPath().endsWith(".pdf")) {
			setAttribute("type", "pdf");
			return "success";

		} else if (temp.getDocPath().endsWith(".ppt")
				|| temp.getDocPath().endsWith(".pptx")) {
			setAttribute("type", "ppt");
			return "success";
		} else {
			setAttribute("type", "xls");
			return "success";
		}

	}

	/**
	 * 通过文档
	 * 
	 * @return
	 */
	public String passDoc() {
		// int state = Integer.parseInt(getParameter("state"));
		// System.err.println(state);
		List<Doc> d = docService.findById(Integer.parseInt(getParameter("id")));
		doc = d.get(0);
		doc.setIsPass(true);
		docService.passDoc(doc);
		int totalpage = docService.getPage(pageNo, pageContSize).getTotalPage();
		pageNo = Integer.parseInt(getParameter("pageNo"));
		if (totalpage < pageNo) {
			pageNo = pageNo - 1;
		}
		setAttribute("pageNo", pageNo);
		// setAttribute("state", state);
		return "pass_success";
	}

	/**
	 * 批量通过
	 * 
	 * @return
	 */
	public String passCheck() {
		String[] ids = getRequest().getParameterValues("checkAll");
		for (int i = 0; i < ids.length; i++) {
			int id = Integer.parseInt(ids[i]);
			List<Doc> d = docService.findById(id);
			doc = d.get(0);
			doc.setIsPass(true);
			docService.passDoc(doc);
		}
		int totalpage = docService.getPage(pageNo, pageContSize).getTotalPage();
		pageNo = Integer.parseInt(getParameter("pageNo"));
		if (totalpage < pageNo) {
			pageNo = pageNo - 1;
		}
		getRequest().setAttribute("pageNo", pageNo);
		return "pass_success";
	}

	/**
	 * 加载阅读文档
	 * 
	 * @return
	 */
	public String reading() {
		Doc doc = docService.reading(Integer.parseInt(getParameter("id")));
		setAttribute("docPath", doc.getDocPath());
		setAttribute("type", doc.getFormat());
		return "reading";
	}

	public Doc getDoc() {
		return doc;
	}

	public void setDoc(Doc doc) {
		this.doc = doc;
	}

	public int getPageNo() {
		return pageNo;
	}

	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
	}

	public int getPageContSize() {
		return pageContSize;
	}

	public void setPageContSize(int pageContSize) {
		this.pageContSize = pageContSize;
	}

	public File getUploadFile() {
		return uploadFile;
	}

	public void setUploadFile(File uploadFile) {
		this.uploadFile = uploadFile;
	}

	public String getUploadFileFileName() {
		return uploadFileFileName;
	}

	public void setUploadFileFileName(String uploadFileFileName) {
		this.uploadFileFileName = uploadFileFileName;
	}
}
