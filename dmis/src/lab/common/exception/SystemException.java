package lab.common.exception;

/**
 * 说明：自定义异常 -- 消息异常
 */
public class SystemException extends BaseException {

	private static final long serialVersionUID = -1530680152575807626L;
	
	private String url = "";
	
	/**
	 * 构�?详细消息�?指定消息 的新异常
	 */
	public SystemException() {
		super();
	}

	/**
	 * 构�?详细消息�?message 的新异常
	 */
	public SystemException(String message) {
		super(message);
		url = "";
	}
	
	public SystemException(String message,String url) {
		super(message);
		this.setUrl(url);
	}
	
	/**
	 * 构�?详细消息�?message 原因�?cause 的新异常
	 */
	public SystemException(String message, Throwable cause) {
		super(message, cause);
	}

	/**
	 * 构�?原因�?cause 的新异常
	 */
	public SystemException(Throwable cause) {
		super(cause);
	}

	public String getUrl()
	{
		return url;
	}

	public void setUrl(String url)
	{
		this.url = url;
	}		

}
