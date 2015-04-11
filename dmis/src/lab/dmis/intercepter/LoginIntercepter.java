package lab.dmis.intercepter;

import java.util.Map;

import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.ActionProxy;
import com.opensymphony.xwork2.interceptor.AbstractInterceptor;

public class LoginIntercepter extends AbstractInterceptor {

	private static final long serialVersionUID = 1L;

	@Override
	public String intercept(ActionInvocation invacation) throws Exception {
		Map<String, Object> session = invacation.getInvocationContext().getSession();
		if (null == session.get("customer")) {
			ActionProxy actionProxy = invacation.getProxy();
			
		}
		return null;
	}

}
