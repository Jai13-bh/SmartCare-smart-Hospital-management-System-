package com.smartcare.filter;
import javax.servlet.*;import javax.servlet.annotation.WebFilter;import javax.servlet.http.*;import java.io.IOException;
@WebFilter(urlPatterns={"/admin/*","/doctor/*","/patient/*"}) public class AuthenticationFilter implements Filter {
 public void doFilter(ServletRequest request,ServletResponse response,FilterChain chain)throws IOException,ServletException{
  HttpServletRequest req=(HttpServletRequest)request;HttpServletResponse res=(HttpServletResponse)response;HttpSession s=req.getSession(false);String role=s==null?null:(String)s.getAttribute("role");String path=req.getRequestURI().substring(req.getContextPath().length());
  if(role==null){res.sendRedirect(req.getContextPath()+"/login?required=1");return;}
  if(path.startsWith("/admin/")&&!"ADMIN".equals(role)||path.startsWith("/doctor/")&&!"DOCTOR".equals(role)&&!"ADMIN".equals(role)||path.startsWith("/patient/")&&!"PATIENT".equals(role)&&!"ADMIN".equals(role)){res.sendError(HttpServletResponse.SC_FORBIDDEN,"You do not have permission to view this page.");return;}
  chain.doFilter(request,response);
 }
}
