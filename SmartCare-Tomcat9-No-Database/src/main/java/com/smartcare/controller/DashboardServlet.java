package com.smartcare.controller;
import com.smartcare.store.AppStore;import com.smartcare.model.Appointment;import javax.servlet.*;import javax.servlet.annotation.WebServlet;import javax.servlet.http.*;import java.io.IOException;import java.util.*;
@WebServlet(urlPatterns={"/admin/dashboard","/doctor/dashboard","/patient/dashboard"}) public class DashboardServlet extends HttpServlet {
 protected void doGet(HttpServletRequest q,HttpServletResponse p)throws ServletException,IOException{
  String path=q.getServletPath();
  HttpSession session=q.getSession(false);
  String role=session==null?null:(String)session.getAttribute("role");
  Object uidObj=session==null?null:session.getAttribute("userId");
  long uid=(uidObj instanceof Number)?((Number)uidObj).longValue():0L;
  List<Appointment> visible=new ArrayList<Appointment>();
  for(Appointment a:AppStore.APPOINTMENTS){if("ADMIN".equals(role)||"DOCTOR".equals(role)||a.getPatientId()==uid)visible.add(a);}
  q.setAttribute("appointments",visible);q.setAttribute("doctors",AppStore.DOCTORS);q.setAttribute("totalAppointments",visible.size());q.setAttribute("pendingCount",count(visible,"Pending"));q.setAttribute("approvedCount",count(visible,"Approved"));q.setAttribute("completedCount",count(visible,"Completed"));
  String view=path.contains("admin")?"/WEB-INF/views/admin/dashboard.jsp":path.contains("doctor")?"/WEB-INF/views/doctor/dashboard.jsp":"/WEB-INF/views/patient/dashboard.jsp";q.getRequestDispatcher(view).forward(q,p);
 }
 private int count(List<Appointment> list,String status){int n=0;for(Appointment a:list)if(status.equals(a.getStatus()))n++;return n;}
 protected void doPost(HttpServletRequest q,HttpServletResponse p)throws ServletException,IOException{String role=(String)q.getSession().getAttribute("role");String action=q.getParameter("action");try{long id=Long.parseLong(q.getParameter("id"));for(Appointment a:AppStore.APPOINTMENTS)if(a.getId()==id){if("ADMIN".equals(role)&&"approve".equals(action))a.setStatus("Approved");if(("DOCTOR".equals(role)||"ADMIN".equals(role))&&"complete".equals(action))a.setStatus("Completed");break;}}catch(Exception ignored){}p.sendRedirect(q.getContextPath()+q.getServletPath());}
}
