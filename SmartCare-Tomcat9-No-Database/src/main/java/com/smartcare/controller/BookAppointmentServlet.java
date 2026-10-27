
package com.smartcare.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.atomic.AtomicInteger;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/book-appointment")
public class BookAppointmentServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private static final List<Map<String, String>> appointments =
            Collections.synchronizedList(new ArrayList<>());

    private static final AtomicInteger nextId = new AtomicInteger(1);

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);

        // Require a logged-in patient.
        if (session == null ||
            session.getAttribute("loggedInUser") == null) {

            response.sendRedirect(
                request.getContextPath() + "/login.jsp"
            );
            return;
        }

        String role = String.valueOf(session.getAttribute("userRole"));

        if (!"PATIENT".equalsIgnoreCase(role)) {
            response.sendError(
                HttpServletResponse.SC_FORBIDDEN,
                "Only patients can book appointments."
            );
            return;
        }

        String patient = clean(request.getParameter("patient"));
        String email = clean(request.getParameter("email"));
        String phone = clean(request.getParameter("phone"));
        String department = clean(request.getParameter("department"));
        String doctor = clean(request.getParameter("doctor"));
        String date = clean(request.getParameter("date"));
        String time = clean(request.getParameter("time"));
        String reason = clean(request.getParameter("reason"));

        if (patient.isEmpty() || email.isEmpty() ||
            phone.isEmpty() || department.isEmpty() ||
            doctor.isEmpty() || date.isEmpty() ||
            time.isEmpty()) {

            request.setAttribute(
                "errorMessage",
                "Please fill in all required fields."
            );

            request.getRequestDispatcher(
                "/book-appointment.jsp"
            ).forward(request, response);
            return;
        }

        // Confirm that the form email belongs to the logged-in user.
        String sessionEmail =
                String.valueOf(session.getAttribute("userEmail"));

        if (!email.equalsIgnoreCase(sessionEmail)) {
            response.sendError(
                HttpServletResponse.SC_FORBIDDEN,
                "The appointment email must match your account."
            );
            return;
        }

        Map<String, String> appointment = new ConcurrentHashMap<>();

        appointment.put("id", String.valueOf(nextId.getAndIncrement()));
        appointment.put("patient", patient);
        appointment.put("email", email);
        appointment.put("phone", phone);
        appointment.put("department", department);
        appointment.put("doctor", doctor);
        appointment.put("date", date);
        appointment.put("time", time);
        appointment.put("reason", reason);
        appointment.put("status", "Pending");

        appointments.add(appointment);

        response.sendRedirect(
            request.getContextPath()
            + "/patient-dashboard.jsp?booking=success"
        );
    }

    private String clean(String value) {
        return value == null ? "" : value.trim();
    }

    // Can be used by other servlets in this class's package.
    public static List<Map<String, String>> getAppointments() {
        synchronized (appointments) {
            List<Map<String, String>> copy = new ArrayList<>();

            for (Map<String, String> appointment : appointments) {
                copy.add(new ConcurrentHashMap<>(appointment));
            }

            return copy;
        }
    }
}
