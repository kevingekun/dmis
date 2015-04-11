package lab.dmis.util;

import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.stereotype.Component;

@Component
public class ApplicationContextOfLeaderc implements ApplicationContextAware {

	private static ApplicationContext  ctx;

	@SuppressWarnings("static-access")
	@Override
	public void setApplicationContext(ApplicationContext ctx)
			throws BeansException {
		 this.ctx = ctx;
	}
	
	public static ApplicationContext getLeaderApplicationContext(){
		return ctx;
	}

}
