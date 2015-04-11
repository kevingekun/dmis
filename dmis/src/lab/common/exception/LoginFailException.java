package lab.common.exception;

/**
 * 说明：自定义异常 -- 消息异常 -- 登录失败
 */
public class LoginFailException extends Exception {

	private static final long serialVersionUID = -1530680152575807626L;
	
	/**
	 * 构�?详细消息�?指定消息 的新异常
	 */
	public LoginFailException() {
		super("系统提示：登录失败，请检查登陆帐号与登陆密码是否正确后再试！");
	}

	/**
	 * 构�?详细消息�?message 的新异常
	 */
	public LoginFailException(String message) {
		super(message);
	}
	
	/**
	 * 构�?详细消息�?message 原因�?cause 的新异常
	 */
	public LoginFailException(String message, Throwable cause) {
		super(message, cause);
	}

	/**
	 * 构�?原因�?cause 的新异常
	 */
	public LoginFailException(Throwable cause) {
		super(cause);
	}		

}
