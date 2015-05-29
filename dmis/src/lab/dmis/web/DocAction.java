package lab.dmis.web;

import java.io.File;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import lab.common.util.Common;
import lab.common.web.BaseAction;
import lab.dmis.model.Doc;
import lab.dmis.model.Type;
import lab.dmis.model.User;
import lab.dmis.service.DocService;
import lab.dmis.service.TypeService;
import net.sf.json.JSONArray;

import org.apache.commons.io.FileUtils;
import org.apache.struts2.ServletActionContext;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

@Component("docAction")
@Scope("prototype")
public class DocAction extends BaseAction {

	private static final long serialVersionUID = 1L;

	private DocService docServiceImpl;
	private TypeService typeServiceImpl;
	private Doc doc;
	private int pageNo = 1;
	private int pageContSize = 8;
	private File uploadFile;// 实际上传文件
	private String uploadFileFileName;// 上传文件名

	/**
	 * 跳转到添加文档页面
	 * 
	 * @return
	 */
	public String addDoc() {
		return "addDoc";
	}

	/**
	 * 跳转到添加文献页面
	 * 
	 * @return
	 */
	public String addLiteratrue() {
		return "addLiteratrue";
	}

	/**
	 * 统计文档类型
	 * 
	 * @throws IOException
	 */
	public void categoryCount() throws IOException {
		List<Integer> list = new ArrayList<Integer>();
		list = docServiceImpl.countByCategory();
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
		list = docServiceImpl.countByLevel();
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
		list = docServiceImpl.countByDownload();
		System.err.println(list);
		JSONArray json = JSONArray.fromObject(list);
		System.err.println(json);
		getResponse().setCharacterEncoding("utf-8");
		getResponse().getWriter().write(json.toString());
	}

	/**
	 * 上传文档文献
	 * 
	 * @return
	 * @throws IOException
	 * @throws ParseException
	 */
	public String uploadDoc() throws IOException, ParseException {
		doc.setUploadTime(Common.getTimestampTime(0));
		System.err.println(doc.getCategory());
		System.err.println(doc.getTypeName());
		if (!doc.getTypeName().equals("-1")) {
			String threeTypeName = doc.getTypeName();// 获得三级类的值
			System.err.println("3tp" + threeTypeName);
			Type threetype = new Type();
			threetype = typeServiceImpl.getByName(threeTypeName).get(0);// 根据三级类输入
			// 的名字搜索Type实体
			doc.setType(threetype);
			System.err.println(threetype);
		}
		System.err.println(doc.getLanguage());
		User uu = (User) getSession().getAttribute("LOGIN_USER");
		System.err.println(uu);
		doc.setUser(uu);// 上传用户

		int docType = uploadFileFileName.lastIndexOf(".");
		String lastname = uploadFileFileName.substring(docType + 1,
				uploadFileFileName.length());
		System.err.println(lastname);
		doc.setFormat(lastname);
		// 站点的doc目录下
		String realpath = ServletActionContext.getServletContext().getRealPath(
				"/doc");
		Date date = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd-HH-mm-ss");
		String time = formatter.format(date);
		String userid = Integer.toString(uu.getId());
		String uploadfilename = userid + "-" + time + "-" + uploadFileFileName;
		System.err.println(uploadfilename);
		if (uploadFile != null) {
			File savefile = new File(new File(realpath), uploadfilename);// 创建一个
																			// File实例，表示指定路径指定名称的文件
			if (!savefile.getParentFile().exists())
				savefile.getParentFile().mkdirs();
			FileUtils.copyFile(uploadFile, savefile);// 文件上传至targetDirectory
		}
		doc.setDocPath("doc/" + uploadfilename);

		docServiceImpl.uploaddocument(doc);
		setAttribute("page", docServiceImpl.getPage(pageNo, pageContSize));
		setAttribute("state", 2);
		if (doc.getLevel() != null) {
			return "list";
		} else {
			return "error";
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
					docServiceImpl.getPage(state, pageNo, pageContSize));
			setAttribute("state", state);
			return "list";
		} else {
			System.out.println(getParameter("pageNo"));
			setAttribute("page", docServiceImpl.getPage(state,
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
		int state = Integer.parseInt(getParameter("state"));
		List<String> ids = new ArrayList<String>();
		String id = getParameter("id");
		if (id != null) {
			ids.add(id);
		} else {
			ids = Arrays.asList(getRequest().getParameterValues("checkAll"));
		}
		boolean isPass = false;
		if (state == 1) {
			isPass = true;
		}
		docServiceImpl.deleteByIds(ids);
		int totalpage = docServiceImpl.getPage(pageNo, pageContSize, isPass)
				.getTotalPage();
		pageNo = Integer.parseInt(getParameter("pageNo"));
		if (totalpage < pageNo) {
			pageNo = pageNo - 1;
		}
		setAttribute("page",
				docServiceImpl.getPage(state, pageNo, pageContSize));
		setAttribute("state", state);
		return "list";
	}

	/**
	 * 根据ID查询
	 * 
	 * @return
	 */

	public void searchByid() throws IOException {
		int id = Integer.parseInt(getParameter("id"));
		List<Doc> list = docServiceImpl.findById(id);
		if (list.size() != 0) {
			out().print("success");
		} else {
			out().print("faild");
		}
	}

	/**
	 * 通过文档
	 * 
	 * @return
	 */
	public String passDoc() {
		int state = Integer.parseInt(getParameter("state"));
		List<Doc> d = docServiceImpl.findById(Integer
				.parseInt(getParameter("id")));
		doc = d.get(0);
		doc.setIsPass(true);
		docServiceImpl.passDoc(doc);
		int totalpage = docServiceImpl.getPage(pageNo, pageContSize, false)
				.getTotalPage();
		pageNo = Integer.parseInt(getParameter("pageNo"));
		if (totalpage < pageNo) {
			pageNo = pageNo - 1;
		}
		setAttribute("page",
				docServiceImpl.getPage(state, pageNo, pageContSize));
		setAttribute("state", state);
		return "list";
	}

	/**
	 * 批量通过
	 * 
	 * @return
	 */
	public String passCheck() {
		int state = Integer.parseInt(getParameter("state"));
		String[] ids = getRequest().getParameterValues("checkAll");
		for (int i = 0; i < ids.length; i++) {
			int id = Integer.parseInt(ids[i]);
			List<Doc> d = docServiceImpl.findById(id);
			doc = d.get(0);
			doc.setIsPass(true);
			docServiceImpl.passDoc(doc);
		}
		int totalpage = docServiceImpl.getPage(pageNo, pageContSize, false)
				.getTotalPage();
		pageNo = Integer.parseInt(getParameter("pageNo"));
		if (totalpage < pageNo) {
			pageNo = pageNo - 1;
		}
		setAttribute("page",
				docServiceImpl.getPage(state, pageNo, pageContSize));
		setAttribute("state", state);
		return "list";
	}

	/**
	 * 加载阅读文档
	 * 
	 * @return
	 */
	public String reading() {
		Doc doc = docServiceImpl.reading(Integer.parseInt(getParameter("id")));
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

	public DocService getDocServiceImpl() {
		return docServiceImpl;
	}

	@Resource
	public void setDocServiceImpl(DocService docServiceImpl) {
		this.docServiceImpl = docServiceImpl;
	}

	public TypeService getTypeServiceImpl() {
		return typeServiceImpl;
	}

	@Resource
	public void setTypeServiceImpl(TypeService typeServiceImpl) {
		this.typeServiceImpl = typeServiceImpl;
	}
}
