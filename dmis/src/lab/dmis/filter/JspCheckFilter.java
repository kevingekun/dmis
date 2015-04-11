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

public class JspCheckFilter implements Filter {

	@Override
	public void destroy() {

	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		HttpServletRequest httprequest = (HttpServletRequest) request;
		String JspUrl = "/dmis";
		System.out.println("###IP:" + request.getLocalAddr() + " "
				+ System.currentTimeMillis() + "访问");
		System.out.println("###URI:" + httprequest.getRequestURI());

		HttpServletResponse httprespons = (HttpServletResponse) response;
		chain.doFilter(request, response);
		// if ((httprequest.getRequestURI().indexOf("menu") != -1)
		// || (httprequest.getRequestURI().indexOf("top") != -1)
		// || (httprequest.getRequestURI().indexOf("content") != -1)) {
		// chain.doFilter(request, response);
		// } else if (httprequest.getRequestURI().indexOf(".jsp") != -1) {
		// httprespons.sendRedirect(JspUrl);
		// } else {
		// chain.doFilter(request, response);
		// }
	}

	@Override
	public void init(FilterConfig arg0) throws ServletException {

	}

}
