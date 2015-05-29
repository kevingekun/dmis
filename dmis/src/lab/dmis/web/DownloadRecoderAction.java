package lab.dmis.web;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;

import javax.annotation.Resource;

import lab.common.web.BaseAction;
import lab.dmis.model.User;
import lab.dmis.service.DownloadRecoderService;
import lab.dmis.util.JsonSerialization;
import lab.dmis.util.Str;
import net.sf.json.JSONArray;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

@Component("downloadRecoderAction")
@Scope("prototype")
public class DownloadRecoderAction extends BaseAction {

	private static final long serialVersionUID = 1L;

	private DownloadRecoderService downloadRecoderServiceImpl;

	private int pageNo = 1;
	private int pageContSize = 6;

	private InputStream inputStream;

	public InputStream getInputStream() {
		return inputStream;
	}

	public void setInputStream(InputStream inputStream) {
		this.inputStream = inputStream;
	}

	JSONArray jsonArray;

	/**
	 * 获取下载记录
	 * 
	 * @throws IOException
	 */
	public void getDownloadRecoder() throws IOException {

		User uu = (User) getSession().getAttribute("LOGIN_USER");
		String userId = uu.getId().toString();
		jsonArray = JSONArray.fromObject(downloadRecoderServiceImpl.getPage(
				pageNo, pageContSize, userId), JsonSerialization
				.jsonSer(Str.str));

		out().print(jsonArray.toString());
	}

	/**
	 * 删除一个downloadRecoder
	 * 
	 * @return
	 */
	public String delete() {
		boolean isSuccess = downloadRecoderServiceImpl.remove(Integer
				.parseInt(getParameter("id")));
		inputStream = new ByteArrayInputStream((isSuccess ? "success"
				: "failed").getBytes());
		return "delete";
	}

	/**
	 * 删除选中的上传记录
	 * 
	 * @throws IOException
	 */
	public void removeChecked() throws IOException {
		String message = downloadRecoderServiceImpl
				.removeChecked(getParameter("ids")) ? "success" : "failed";
		out().print(message);
	}

	public DownloadRecoderService getDownloadRecoderServiceImpl() {
		return downloadRecoderServiceImpl;
	}

	@Resource
	public void setDownloadRecoderServiceImpl(
			DownloadRecoderService downloadRecoderServiceImpl) {
		this.downloadRecoderServiceImpl = downloadRecoderServiceImpl;
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

}
