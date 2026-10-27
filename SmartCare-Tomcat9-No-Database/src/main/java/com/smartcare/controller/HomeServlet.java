package com.smartcare.controller;
import javax.servlet.annotation.WebServlet;import javax.servlet.http.*;import javax.servlet.*;import java.io.IOException;
@WebServlet("/home") public class HomeServlet extends HttpServlet {protected void doGet(HttpServletRequest q,HttpServletResponse p)throws ServletException,IOException{p.sendRedirect(q.getContextPath()+"/index.jsp");}}
