package lab.common.exception;

/**
 * 说明：自定义异常基类
 */
public class BaseException extends Exception {

	private static final long serialVersionUID = -71709585767787602L;
	
	/**
	 * 构�?详细消息�?指定消息 的新异常
	 */
	public BaseException() {
		super("系统提示：目前无法访问当前页面，请稍候再试！");
	}

	/**
	 * 构�?详细消息�?message 的新异常
	 */
	public BaseException(String message) {
		super(message);
	}
	
	/**
	 * 构�?详细消息�?message 原因�?cause 的新异常
	 */
	public BaseException(String message, Throwable cause) {
		super(message, cause);
	}

	/**
	 * 构�?原因�?cause 的新异常
	 */
	public BaseException(Throwable cause) {
		super(cause);
	}	

}
