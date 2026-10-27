package com.smartcare.controller;



import java.io.IOException;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    // In-memory storage; synchronized with AppStore
    public static final Map<String, User> USERS =
            new ConcurrentHashMap<>();

    public static class User {
        private final String name;
        private final String email;
        private final String password;
        private final String role;

        public User(String name, String email,
                    String password, String role) {
            this.name = name;
            this.email = email;
            this.password = password;
            this.role = role;
        }

        public String getName() {
            return name;
        }

        public String getEmail() {
            return email;
        }

        public String getPassword() {
            return password;
        }

        public String getRole() {
            return role;
        }
    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String name = clean(request.getParameter("name"));
        String email = clean(request.getParameter("email"))
                .toLowerCase();
        String password = request.getParameter("password");
        String confirmPassword =
                request.getParameter("confirmPassword");
        String roleParam = clean(request.getParameter("role")).toUpperCase();
        String role = ("ADMIN".equals(roleParam) || "DOCTOR".equals(roleParam)) ? roleParam : "PATIENT";

        // Validate required fields.
        if (name.isEmpty() || email.isEmpty()
                || password == null || confirmPassword == null
                || password.isEmpty()
                || confirmPassword.isEmpty()) {

            showError(request, response,
                    "Please fill in all required fields.");
            return;
        }

        if (name.length() > 100 || email.length() > 150) {
            showError(request, response,
                    "Name or email is too long.");
            return;
        }

        if (!email.matches("^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$")) {
            showError(request, response,
                    "Please enter a valid email address.");
            return;
        }

        if (password.length() < 8 || password.length() > 72) {
            showError(request, response,
                    "Password must contain 8 to 72 characters.");
            return;
        }

        if (!password.equals(confirmPassword)) {
            showError(request, response,
                    "Passwords do not match.");
            return;
        }

        // Save into AppStore
        boolean registered = com.smartcare.store.AppStore.register(name, email, role, password);
        if (!registered) {
            showError(request, response,
                    "An account with this email already exists.");
            return;
        }

        // Also save into local map for backward compatibility
        USERS.put(email, new User(name, email, password, role));

        // Redirect to login after successful registration.
        HttpSession session = request.getSession();
        session.setAttribute("registrationSuccess",
                "Account created successfully as " + role + ". Please sign in.");

        response.sendRedirect(
                request.getContextPath() + "/login.jsp?role=" + role.toLowerCase() + "&registered=1"
        );
    }

    private void showError(HttpServletRequest request,
                           HttpServletResponse response,
                           String message)
            throws ServletException, IOException {

        request.setAttribute("errorMessage", message);
        request.getRequestDispatcher("/register.jsp")
                .forward(request, response);
    }

    private String clean(String value) {
        return value == null ? "" : value.trim();
    }
}

