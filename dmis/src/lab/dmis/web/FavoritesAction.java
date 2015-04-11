package lab.dmis.web;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;

import lab.common.web.BaseAction;
import lab.dmis.model.User;
import lab.dmis.service.FavoritesService;
import lab.dmis.util.JsonSerialization;
import lab.dmis.util.Str;
import net.sf.json.JSONArray;

import org.springframework.beans.factory.annotation.Autowired;

public class FavoritesAction extends BaseAction{

	/**
	 * 
	 */
	
	private static final long serialVersionUID = 1L;//serialVersionUID作用：序列化时为了保持版本的兼容性，即在版本升级时反序列化仍保持对象的唯一性。 

	
	
	@Autowired //spring可以自动帮你把bean里面引用的对象的setter/getter方法省略，它会自动帮你set/get。
	private FavoritesService favoritesService;
	
	
	private int pageNo = 1;
	private int pageContSize = 4;
	
	private InputStream inputStream;
	
	public InputStream getInputStream() {
		return inputStream;
	}

	public void setInputStream(InputStream inputStream) {
		this.inputStream = inputStream;
	}

	JSONArray jsonArray;

	
	 
	
	/**
	 * 获取收藏记录
	 * @throws IOException
	 */
	public void getMyFavorites() throws IOException{

		User uu=(User)getSession().getAttribute("LOGIN_USER");
		String userId=uu.getId().toString();
		jsonArray = JSONArray.fromObject(favoritesService.getPage(pageNo, pageContSize,userId),JsonSerialization.jsonSer(Str.str));

		out().print(jsonArray.toString());
	}

	/**
	 * 删除一个favorites
	 * @return
	 */
	public String delete(){
		boolean isSuccess = favoritesService.remove(Integer.parseInt(getParameter("id")));
		inputStream = new ByteArrayInputStream((isSuccess?"success":"failed").getBytes());
		return "delete";
		
	}
	
	/**
	 * 删除选中的收藏记录
	 * @throws IOException 
	 */
	public void removeChecked() throws IOException{
		String message = favoritesService.removeChecked(getParameter("ids"))?"success":"failed";
		out().print(message);
	}
	
	/**
	 * 增加收藏
	 * @return
	 * @throws IOException 
	 */
	public void addFavorites() throws IOException{
		favoritesService.addFavorites((User)getObjFromSession("LOGIN_USER"), Integer.parseInt(getParameter("id")));
		out().print(1);
	}
	/**
	 * 取消收藏
	 * @throws IOException 
	 */
	public void removeFavorites() throws IOException{
		if(favoritesService.removeFavorites((User)getObjFromSession("LOGIN_USER"), Integer.parseInt(getParameter("id"))) ==1)
			out().print(0);
		else
			out().print(3);	
	}
	/**
	 * 判断文章是否被收藏
	 * @return
	 * @throws IOException 
	 */
	public void docIsAdd() throws IOException{
		if(favoritesService.docIsAdd((User)getObjFromSession("LOGIN_USER"), Integer.parseInt(getParameter("id"))))
			out().print(1);
		else
			out().print(0);
	}
	public FavoritesService getFavoritesService() {
		return favoritesService;
	}

	public void setFavoritesService(FavoritesService favoritesService) {
		this.favoritesService = favoritesService;
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
