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

import lab.dmis.model.User;

public class LoginCheckFilter implements Filter {

	@Override
	public void destroy() {

	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		HttpServletRequest httprequest = (HttpServletRequest) request;

		String loginUrl = "/dmis/";

		System.out.println("login------IP:" + request.getLocalAddr() + " "
				+ System.currentTimeMillis() + "访问");
		System.out.println("login------URL:" + httprequest.getRequestURI());

		HttpServletResponse httprespons = (HttpServletResponse) response;
		if (httprequest.getSession().getAttribute("LOGIN_USER") != null) {
			if (((User) httprequest.getSession().getAttribute("LOGIN_USER"))
					.getRole() == 0) {
				chain.doFilter(request, response);
			} else {
				httprespons.sendRedirect(loginUrl);
			}
		} else {
			httprespons.sendRedirect(loginUrl);
		}
	}

	@Override
	public void init(FilterConfig arg0) throws ServletException {

	}

}
