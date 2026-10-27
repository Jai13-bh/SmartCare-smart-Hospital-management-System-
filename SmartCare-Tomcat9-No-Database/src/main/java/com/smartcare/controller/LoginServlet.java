package com.smartcare.controller;

import com.smartcare.model.User;
import com.smartcare.store.AppStore;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    protected void doGet(HttpServletRequest q, HttpServletResponse p) throws ServletException, IOException {
        q.getRequestDispatcher("/login.jsp").forward(q, p);
    }

    protected void doPost(HttpServletRequest q, HttpServletResponse p) throws ServletException, IOException {
        String email = q.getParameter("email");
        String pw = q.getParameter("password");
        User u = AppStore.authenticate(email, pw);
        if (u == null) {
            q.setAttribute("error", "Invalid email or password.");
            q.getRequestDispatcher("/login.jsp").forward(q, p);
            return;
        }
        HttpSession s = q.getSession(true);
        s.setAttribute("userId", u.getId());
        s.setAttribute("userName", u.getName());
        s.setAttribute("loggedInUser", u.getName());
        s.setAttribute("role", u.getRole());
        s.setAttribute("userRole", u.getRole());
        s.setAttribute("email", u.getEmail());
        s.setAttribute("userEmail", u.getEmail());
        s.setMaxInactiveInterval(1800);

        String path = "ADMIN".equals(u.getRole()) ? "/admin/dashboard" : "DOCTOR".equals(u.getRole()) ? "/doctor/dashboard" : "/patient/dashboard";
        p.sendRedirect(q.getContextPath() + path);
    }
}
