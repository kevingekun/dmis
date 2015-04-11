package lab.dmis.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class OnlineCheckFilter implements Filter {

	@Override
	public void destroy() {

	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		HttpServletRequest httprequest = (HttpServletRequest) request;

		String loginUrl = "/dmis";
		System.out.println("###IP:" + request.getLocalAddr() + " "
				+ System.currentTimeMillis() + "访问");
		System.out.println("###URL:" + httprequest.getRequestURI());
		HttpServletResponse httprespons = (HttpServletResponse) response;
		if (null != httprequest.getSession().getAttribute("LOGIN_USER")) {
			chain.doFilter(request, response);
		} else {
			httprespons.sendRedirect(loginUrl);

		}
	}

	@Override
	public void init(FilterConfig arg0) throws ServletException {

	}

}
