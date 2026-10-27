package com.smartcare.filter;
import javax.servlet.*; import javax.servlet.annotation.WebFilter; import java.io.IOException;
@WebFilter("/*") public class EncodingFilter implements Filter { public void doFilter(ServletRequest q,ServletResponse p,FilterChain c)throws IOException,ServletException{q.setCharacterEncoding("UTF-8");p.setCharacterEncoding("UTF-8");c.doFilter(q,p);} }
