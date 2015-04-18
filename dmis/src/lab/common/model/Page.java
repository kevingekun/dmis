package lab.common.model;

import java.util.ArrayList;
import java.util.List;

public class Page {

	private int pageNo = 1;
	private int pageContSize = 10;
	private int totalPage;
	private int totalSize;

	private List<?> pageList;
	private List<String> pageNum = new ArrayList<String>();

	private final int fixSignSize = 5; // 在页面显�?几条)的标签数
	private int showPrv = 1;
	private int showNext = 1;

	public Page() {
	}

	public Page(int pageNo, int pageContSize, int totalSize) {
		this.pageNo = pageNo;
		this.totalSize = totalSize;
		this.pageContSize = pageContSize;
		createPageNum();
	}

	public Page(int pageNo, int pageContSize, int totalSize, List<?> list) {
		this.pageNo = pageNo;
		this.totalSize = totalSize;
		this.pageContSize = pageContSize;
		this.pageList = list;
		createPageNum();
	}

	public void createPageNum() {
		int startPage = 0; // 开始标签
		int endPage = 0; // 结束标签
		int temp = fixSignSize / 2;

		if (totalSize > 0) {
			if (totalSize % pageContSize == 0) {
				totalPage = totalSize / pageContSize;
			} else {
				totalPage = totalSize / pageContSize + 1;
			}
			if (totalPage < fixSignSize) {
				startPage = 1;
				endPage = totalPage;
			} else if (pageNo < fixSignSize - temp) {
				startPage = 1;
				endPage = fixSignSize;
			} else if (fixSignSize - temp <= pageNo
					&& pageNo <= totalPage - temp) {
				startPage = pageNo - temp;
				endPage = pageNo + temp;
			} else if (totalPage - temp < pageNo) {
				startPage = totalPage - (fixSignSize - 1);
				endPage = totalPage;
			}
			if (pageNo == 1) {
				showPrv = 0;
			}
			if (pageNo == totalPage) {
				showNext = 0;
			}
			for (int i = startPage; i <= endPage; i++) {
				Integer element = new Integer(i);
				pageNum.add(element.toString());
			}
		}
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

	public List<?> getPageList() {
		return pageList;
	}

	public void setPageList(List<?> pageList) {
		this.pageList = pageList;
	}

	public int getTotalPage() {
		return totalPage;
	}

	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}

	public int getTotalSize() {
		return totalSize;
	}

	public List<String> getPageNum() {
		return pageNum;
	}

	public void setPageNum(List<String> pageNum) {
		this.pageNum = pageNum;
	}

	public int getShowPrv() {
		return showPrv;
	}

	public void setShowPrv(int showPrv) {
		this.showPrv = showPrv;
	}

	public int getShowNext() {
		return showNext;
	}

	public void setShowNext(int showNext) {
		this.showNext = showNext;
	}

	public void setTotalSize(int totalSize) {
		this.totalSize = totalSize;
	}

}
