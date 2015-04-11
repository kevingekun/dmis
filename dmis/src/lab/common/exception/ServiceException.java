package lab.common.exception;

public class ServiceException extends BaseException{
	
	
		private static final long serialVersionUID = -1530680152575807626L;
		
		/**
		 * 构�?详细消息�?指定消息 的新异常
		 */
		public ServiceException() {
			super();
		}

		/**
		 * 构�?详细消息�?message 的新异常
		 */
		public ServiceException(String message) {
			super(message);
		}
		
		/**
		 * 构�?详细消息�?message 原因�?cause 的新异常
		 */
		public ServiceException(String message, Throwable cause) {
			super(message, cause);
		}

		/**
		 * 构�?原因�?cause 的新异常
		 */
		public ServiceException(Throwable cause) {
			super(cause);
		}		


}
