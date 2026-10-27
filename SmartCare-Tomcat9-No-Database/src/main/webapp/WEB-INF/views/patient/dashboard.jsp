<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Patient Dashboard | SmartCare</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Arial, sans-serif; background: #f8fafc; color: #0f172a; min-height: 100vh; }
        a { text-decoration: none; color: inherit; }

        /* Top Header */
        .top-nav {
            background: #0c4a6e; color: white; padding: 14px 5%;
            display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; gap: 15px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.1);
        }
        .brand-logo { font-size: 22px; font-weight: 800; color: #38bdf8; display: flex; align-items: center; gap: 8px; }
        .brand-logo span { color: #f8fafc; }
        .patient-badge {
            display: inline-block; padding: 3px 10px; border-radius: 12px;
            font-size: 11px; font-weight: 800; background: #0284c7; color: white; margin-left: 8px;
            text-transform: uppercase; letter-spacing: 0.5px;
        }
        .user-nav-actions { display: flex; align-items: center; gap: 12px; }
        .logged-user-pill {
            display: flex; align-items: center; gap: 8px;
            background: #075985; padding: 6px 14px; border-radius: 20px; font-size: 13px; color: #e0f2fe;
            border: 1px solid #38bdf8;
        }
        .btn-logout {
            background: #ef4444; color: white; padding: 7px 14px; border-radius: 8px;
            font-size: 13px; font-weight: 700; border: none; cursor: pointer; transition: .2s;
        }
        .btn-logout:hover { background: #dc2626; }

        /* Sub Navigation */
        .sub-nav {
            background: white; border-bottom: 1px solid #e2e8f0; padding: 0 5%;
            display: flex; gap: 8px; overflow-x: auto;
        }
        .sub-nav-item {
            padding: 14px 18px; font-size: 14px; font-weight: 600; color: #64748b;
            border-bottom: 3px solid transparent; cursor: pointer; white-space: nowrap; transition: .2s;
            display: inline-flex; align-items: center; gap: 6px;
        }
        .sub-nav-item:hover { color: #0284c7; }
        .sub-nav-item.active { color: #0284c7; border-bottom-color: #0284c7; }

        /* Container */
        .container { max-width: 1200px; margin: 28px auto; padding: 0 20px; }

        /* Page Banner */
        .dashboard-banner {
            background: linear-gradient(135deg, #0284c7, #075985); color: white;
            padding: 26px 30px; border-radius: 16px; margin-bottom: 25px;
            display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; gap: 18px;
            box-shadow: 0 10px 25px -5px rgba(2, 132, 199, 0.3);
        }
        .banner-content h1 { font-size: 26px; font-weight: 800; margin-bottom: 6px; }
        .banner-content p { color: #e0f2fe; font-size: 14px; }
        .banner-actions { display: flex; gap: 10px; flex-wrap: wrap; }
        .btn-white {
            background: white; color: #0284c7; padding: 11px 20px; border-radius: 9px;
            font-size: 14px; font-weight: 700; border: none; cursor: pointer; transition: .2s;
            display: inline-flex; align-items: center; gap: 6px;
        }
        .btn-white:hover { background: #f0f9ff; }

        /* Metric Grid */
        .stats-grid {
            display: grid; grid-template-columns: repeat(4, 1fr); gap: 18px; margin-bottom: 28px;
        }
        .stat-card {
            background: white; padding: 22px; border-radius: 14px;
            border: 1px solid #e2e8f0; box-shadow: 0 4px 15px rgba(15, 23, 42, 0.04);
            position: relative; overflow: hidden;
        }
        .stat-card::before {
            content: ''; position: absolute; top: 0; left: 0; right: 0; height: 4px;
            background: #0284c7;
        }
        .stat-card.pending::before { background: #f59e0b; }
        .stat-card.approved::before { background: #10b981; }
        .stat-card.completed::before { background: #38bdf8; }
        .stat-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 12px; }
        .stat-title { font-size: 13px; font-weight: 700; color: #64748b; text-transform: uppercase; letter-spacing: 0.5px; }
        .stat-icon { font-size: 24px; }
        .stat-value { font-size: 32px; font-weight: 800; color: #0f172a; line-height: 1; }
        .stat-footer { font-size: 12px; color: #94a3b8; margin-top: 8px; }

        /* Content Layout */
        .dashboard-grid {
            display: grid; grid-template-columns: 2.3fr 1fr; gap: 24px;
        }

        /* Content Panel */
        .content-panel {
            background: white; border-radius: 16px; border: 1px solid #e2e8f0;
            padding: 24px; box-shadow: 0 4px 15px rgba(15, 23, 42, 0.04); margin-bottom: 25px;
        }
        .panel-top {
            display: flex; justify-content: space-between; align-items: center;
            margin-bottom: 20px; flex-wrap: wrap; gap: 14px;
        }
        .panel-title { font-size: 18px; font-weight: 800; color: #0f172a; display: flex; align-items: center; gap: 8px; }

        /* Tables */
        .table-responsive { width: 100%; overflow-x: auto; }
        table { width: 100%; border-collapse: collapse; min-width: 650px; font-size: 13.5px; }
        th, td { text-align: left; padding: 13px 15px; border-bottom: 1px solid #f1f5f9; vertical-align: middle; }
        th { background: #f8fafc; color: #475569; font-weight: 700; font-size: 12px; text-transform: uppercase; letter-spacing: 0.5px; }
        tr:hover td { background: #fcfdfe; }

        /* Badges */
        .badge {
            display: inline-block; padding: 4px 10px; border-radius: 12px;
            font-size: 11.5px; font-weight: 700; text-align: center;
        }
        .badge-pending { background: #fef3c7; color: #b45309; border: 1px solid #fde68a; }
        .badge-approved { background: #dcfce7; color: #15803d; border: 1px solid #bbf7d0; }
        .badge-completed { background: #e0f2fe; color: #0369a1; border: 1px solid #bae6fd; }
        .badge-cancelled { background: #fee2e2; color: #b91c1c; border: 1px solid #fecaca; }

        /* Action Buttons */
        .action-btns { display: flex; gap: 6px; }
        .btn-act {
            border: none; padding: 6px 12px; border-radius: 6px; font-size: 11.5px;
            font-weight: 700; cursor: pointer; transition: .15s;
        }
        .btn-act-slip { background: #f0fdf4; color: #166534; border: 1px solid #bbf7d0; }
        .btn-act-slip:hover { background: #dcfce7; }
        .btn-act-cancel { background: #fef2f2; color: #b91c1c; border: 1px solid #fecaca; }
        .btn-act-cancel:hover { background: #fee2e2; }

        .empty-row { text-align: center; padding: 40px 20px; color: #64748b; font-size: 14px; }
        .empty-row a { color: #0284c7; font-weight: 700; text-decoration: underline; margin-top: 8px; display: inline-block; }

        /* Side Info Card */
        .side-card {
            background: white; border-radius: 16px; border: 1px solid #e2e8f0;
            padding: 22px; box-shadow: 0 4px 15px rgba(15, 23, 42, 0.04); margin-bottom: 20px;
        }
        .side-card h3 { font-size: 16px; font-weight: 800; color: #0f172a; margin-bottom: 12px; display: flex; align-items: center; gap: 8px; }
        .side-info-item { margin-bottom: 12px; font-size: 13.5px; line-height: 1.5; color: #475569; }
        .side-info-item strong { color: #0f172a; display: block; font-size: 12px; text-transform: uppercase; color: #64748b; }

        /* Digital Appointment Slip Modal */
        .modal-overlay {
            position: fixed; top: 0; left: 0; right: 0; bottom: 0;
            background: rgba(15, 23, 42, 0.6); backdrop-filter: blur(4px);
            display: none; place-items: center; z-index: 9999; padding: 20px;
        }
        .modal-overlay.active { display: grid; }
        .modal-card {
            background: white; border-radius: 16px; padding: 28px; width: 100%; max-width: 480px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.2); position: relative;
        }
        .modal-close {
            position: absolute; top: 18px; right: 18px; background: #f1f5f9; border: none;
            width: 32px; height: 32px; border-radius: 50%; font-size: 18px; cursor: pointer;
            display: grid; place-items: center; color: #64748b;
        }
        .modal-close:hover { background: #fee2e2; color: #ef4444; }
        .slip-header { text-align: center; border-bottom: 2px dashed #e2e8f0; padding-bottom: 16px; margin-bottom: 18px; }
        .slip-header h3 { font-size: 20px; color: #0284c7; }
        .slip-header p { font-size: 13px; color: #64748b; margin-top: 4px; }
        .slip-body { display: grid; grid-template-columns: 1fr 1fr; gap: 14px; margin-bottom: 20px; font-size: 13.5px; }
        .slip-field strong { display: block; font-size: 11px; text-transform: uppercase; color: #64748b; }
        .slip-field span { font-weight: 700; color: #0f172a; }
        .slip-field.full { grid-column: 1 / -1; }
        .slip-footer {
            border-top: 2px dashed #e2e8f0; padding-top: 16px; text-align: center;
            font-size: 12px; color: #64748b;
        }

        /* Toast */
        .toast {
            position: fixed; bottom: 25px; right: 25px; background: #0f172a; color: white;
            padding: 12px 20px; border-radius: 10px; font-size: 13px; font-weight: 600;
            box-shadow: 0 10px 25px rgba(0,0,0,0.2); z-index: 10000; display: none;
            border-left: 4px solid #10b981;
        }
        .toast.show { display: block; animation: slideIn 0.3s ease; }
        @keyframes slideIn { from { transform: translateY(20px); opacity: 0; } to { transform: translateY(0); opacity: 1; } }

        @media(max-width: 950px) {
            .dashboard-grid { grid-template-columns: 1fr; }
            .stats-grid { grid-template-columns: repeat(2, 1fr); }
        }
        @media(max-width: 600px) {
            .stats-grid { grid-template-columns: 1fr; }
            .dashboard-banner { padding: 20px; }
            .banner-content h1 { font-size: 22px; }
        }
    </style>
</head>
<body>

<!-- Top Navigation -->
<header class="top-nav">
    <div style="display:flex; align-items:center;">
        <a class="brand-logo" href="${pageContext.request.contextPath}/index.jsp">✚ Smart<span>Care</span></a>
        <span class="patient-badge">Patient Portal</span>
    </div>
    <div class="user-nav-actions">
        <div class="logged-user-pill">
            <span>👤</span>
            <span id="navPatientName">Patient: ${sessionScope.userName != null ? sessionScope.userName : 'Demo Patient'}</span>
        </div>
        <button type="button" class="btn-logout" onclick="logout()">Logout</button>
    </div>
</header>

<!-- Sub Navigation Tabs -->
<nav class="sub-nav">
    <div class="sub-nav-item active">📋 My Appointments</div>
    <a class="sub-nav-item" href="${pageContext.request.contextPath}/book-appointment.jsp">＋ Book New Appointment</a>
    <a class="sub-nav-item" href="${pageContext.request.contextPath}/index.jsp">🏠 Hospital Home</a>
</nav>

<main class="container">

    <!-- Welcome Banner -->
    <section class="dashboard-banner">
        <div class="banner-content">
            <h1 id="welcomeHeading">Welcome to Your Patient Portal</h1>
            <p>Track your upcoming doctor appointments, review medical prescriptions, or schedule a new hospital visit.</p>
        </div>
        <div class="banner-actions">
            <a href="${pageContext.request.contextPath}/book-appointment.jsp" class="btn-white">＋ Book New Appointment</a>
        </div>
    </section>

    <!-- Metrics -->
    <section class="stats-grid">
        <div class="stat-card">
            <div class="stat-header">
                <span class="stat-title">My Appointments</span>
                <span class="stat-icon">📅</span>
            </div>
            <div class="stat-value" id="statTotal">0</div>
            <div class="stat-footer">Total bookings placed</div>
        </div>

        <div class="stat-card pending">
            <div class="stat-header">
                <span class="stat-title">Pending Approvals</span>
                <span class="stat-icon">⏳</span>
            </div>
            <div class="stat-value" id="statPending">0</div>
            <div class="stat-footer">Awaiting hospital confirmation</div>
        </div>

        <div class="stat-card approved">
            <div class="stat-header">
                <span class="stat-title">Confirmed Visits</span>
                <span class="stat-icon">✅</span>
            </div>
            <div class="stat-value" id="statApproved">0</div>
            <div class="stat-footer">Approved consultations</div>
        </div>

        <div class="stat-card completed">
            <div class="stat-header">
                <span class="stat-title">Completed Visits</span>
                <span class="stat-icon">🩺</span>
            </div>
            <div class="stat-value" id="statCompleted">0</div>
            <div class="stat-footer">Past doctor visits</div>
        </div>
    </section>

    <div class="dashboard-grid">

        <!-- Main Column: Appointments History -->
        <div>
            <section class="content-panel">
                <div class="panel-top">
                    <div class="panel-title">
                        <span>📋</span> My Scheduled Appointments
                    </div>
                    <a href="${pageContext.request.contextPath}/book-appointment.jsp" class="btn-act" style="background:#0284c7; color:white; padding:8px 14px;">＋ Book Appointment</a>
                </div>

                <div class="table-responsive">
                    <table>
                        <thead>
                            <tr>
                                <th>Doctor / Specialty</th>
                                <th>Appointment Date</th>
                                <th>Time Slot</th>
                                <th>Reason / Advice</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody id="patientTableBody"></tbody>
                    </table>
                </div>
            </section>
        </div>

        <!-- Sidebar: Patient Health Card -->
        <div>
            <div class="side-card">
                <h3><span>💳</span> Patient Health Card</h3>
                <div class="side-info-item">
                    <strong>Patient Name</strong>
                    <span id="profilePatientName">${sessionScope.userName != null ? sessionScope.userName : 'Demo Patient'}</span>
                </div>
                <div class="side-info-item">
                    <strong>Registered Email</strong>
                    <span id="profilePatientEmail">${sessionScope.email != null ? sessionScope.email : 'patient@smartcare.test'}</span>
                </div>
                <div class="side-info-item">
                    <strong>Patient Record Number</strong>
                    <span>#PT-91024</span>
                </div>
                <div class="side-info-item">
                    <strong>Hospital Helpline</strong>
                    <span>+1 (800) 555-CARE (Emergency 24x7)</span>
                </div>
            </div>

            <div class="side-card">
                <h3><span>ℹ️</span> Visit Instructions</h3>
                <p style="font-size: 13px; color: #64748b; line-height: 1.6;">
                    Please arrive 15 minutes prior to your designated time slot. Carry any previous prescription records and your digital appointment slip for verification.
                </p>
            </div>
        </div>

    </div>

</main>

<!-- Digital Appointment Slip Modal -->
<div id="slipModal" class="modal-overlay">
    <div class="modal-card">
        <button type="button" class="modal-close" onclick="closeSlipModal()">&times;</button>
        <div class="slip-header">
            <h3>🏥 SmartCare Hospital</h3>
            <p>Digital Appointment Confirmation Pass</p>
        </div>
        <div class="slip-body">
            <div class="slip-field">
                <strong>Patient Name</strong>
                <span id="slipPatient">Demo Patient</span>
            </div>
            <div class="slip-field">
                <strong>Doctor Assigned</strong>
                <span id="slipDoctor">Dr. Priya Sharma</span>
            </div>
            <div class="slip-field">
                <strong>Medical Department</strong>
                <span id="slipDept">Cardiology</span>
            </div>
            <div class="slip-field">
                <strong>Status</strong>
                <span id="slipStatus">Approved</span>
            </div>
            <div class="slip-field">
                <strong>Appointment Date</strong>
                <span id="slipDate">2026-10-28</span>
            </div>
            <div class="slip-field">
                <strong>Time Slot</strong>
                <span id="slipTime">10:00 AM</span>
            </div>
            <div class="slip-field full">
                <strong>Reason / Symptoms</strong>
                <span id="slipReason">Routine checkup</span>
            </div>
            <div class="slip-field full" id="slipRxContainer" style="display:none;">
                <strong style="color:#0284c7;">Doctor Prescription / Notes</strong>
                <span id="slipRx" style="color:#0f172a; font-weight:600;"></span>
            </div>
        </div>
        <div class="slip-footer">
            <p>Token ID: <strong id="slipToken">SC-89234</strong> | Room: <strong>OPD Block C, Rm 304</strong></p>
            <p style="margin-top:4px;">Please present this digital pass at the OPD reception counter.</p>
        </div>
    </div>
</div>

<div id="toast" class="toast">Action performed successfully</div>

<script>
    function initPatient() {
        var user = null;
        try {
            user = JSON.parse(sessionStorage.getItem('smartcareCurrentUser'));
        } catch(e) {
            user = null;
        }
        var navName = document.getElementById('navPatientName');
        var welcome = document.getElementById('welcomeHeading');
        var profName = document.getElementById('profilePatientName');
        var profEmail = document.getElementById('profilePatientEmail');

        if (user && user.name) {
            if (navName) navName.textContent = 'Patient: ' + user.name;
            if (welcome) welcome.textContent = 'Welcome, ' + user.name + '!';
            if (profName) profName.textContent = user.name;
            if (profEmail && user.email) profEmail.textContent = user.email;
        }
    }

    function getAppointments() {
        try {
            return JSON.parse(localStorage.getItem('smartcareAppointments') || '[]');
        } catch (e) {
            return [];
        }
    }

    function saveAppointments(list) {
        try {
            localStorage.setItem('smartcareAppointments', JSON.stringify(list));
        } catch (e) {}
    }

    function showToast(msg) {
        var toast = document.getElementById('toast');
        if (!toast) return;
        toast.textContent = msg;
        toast.className = 'toast show';
        setTimeout(function() {
            toast.className = 'toast';
        }, 3000);
    }

    function escapeHtml(str) {
        return String(str || '').replace(/[&<>"']/g, function(m) {
            return { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' }[m];
        });
    }

    function renderMetrics() {
        var appts = getAppointments();
        var total = appts.length;
        var pending = 0;
        var approved = 0;
        var completed = 0;

        for (var i = 0; i < appts.length; i++) {
            var st = appts[i].status || 'Pending';
            if (st === 'Pending') pending++;
            else if (st === 'Approved') approved++;
            else if (st === 'Completed') completed++;
        }

        var statTotal = document.getElementById('statTotal');
        var statPending = document.getElementById('statPending');
        var statApproved = document.getElementById('statApproved');
        var statCompleted = document.getElementById('statCompleted');

        if (statTotal) statTotal.textContent = total;
        if (statPending) statPending.textContent = pending;
        if (statApproved) statApproved.textContent = approved;
        if (statCompleted) statCompleted.textContent = completed;
    }

    function renderAppointments() {
        var appts = getAppointments();
        var tbody = document.getElementById('patientTableBody');
        if (!tbody) return;

        if (appts.length === 0) {
            tbody.innerHTML = '<tr><td colspan="6" class="empty-row">' +
                'You have no scheduled appointments yet.<br>' +
                '<a href="${pageContext.request.contextPath}/book-appointment.jsp">＋ Schedule your first appointment now</a></td></tr>';
            return;
        }

        var html = '';
        for (var i = 0; i < appts.length; i++) {
            var a = appts[i];
            var st = a.status || 'Pending';

            var badgeClass = (st === 'Approved') ? 'badge-approved'
                           : (st === 'Completed') ? 'badge-completed'
                           : (st === 'Cancelled') ? 'badge-cancelled' : 'badge-pending';

            var advice = a.prescription ? ('<br><small style="color:#0284c7; font-weight:600;">Rx: ' + escapeHtml(a.prescription) + '</small>') : '';

            var actions = '<button type="button" class="btn-act btn-act-slip" onclick="openSlipModal(' + i + ')">View Pass</button> ';
            if (st === 'Pending' || st === 'Approved') {
                actions += '<button type="button" class="btn-act btn-act-cancel" onclick="cancelAppointment(' + i + ')">Cancel</button>';
            }

            html += '<tr>' +
                '<td><strong>' + escapeHtml(a.doctor) + '</strong><br><small style="color:#0284c7; font-weight:600;">' + escapeHtml(a.department || 'General') + '</small></td>' +
                '<td>' + escapeHtml(a.date) + '</td>' +
                '<td>' + escapeHtml(a.time) + '</td>' +
                '<td>' + escapeHtml(a.reason || 'General checkup') + advice + '</td>' +
                '<td><span class="badge ' + badgeClass + '">' + escapeHtml(st) + '</span></td>' +
                '<td><div class="action-btns">' + actions + '</div></td>' +
                '</tr>';
        }

        tbody.innerHTML = html;
    }

    function cancelAppointment(index) {
        if (!confirm('Are you sure you want to cancel this appointment?')) return;
        var appts = getAppointments();
        if (!appts[index]) return;
        appts[index].status = 'Cancelled';
        saveAppointments(appts);
        renderMetrics();
        renderAppointments();
        showToast('Appointment cancelled successfully.');
    }

    function openSlipModal(index) {
        var appts = getAppointments();
        var a = appts[index];
        if (!a) return;

        var modal = document.getElementById('slipModal');
        document.getElementById('slipPatient').textContent = a.patient || 'Patient';
        document.getElementById('slipDoctor').textContent = a.doctor || 'Doctor';
        document.getElementById('slipDept').textContent = a.department || 'General Medicine';
        document.getElementById('slipStatus').textContent = a.status || 'Pending';
        document.getElementById('slipDate').textContent = a.date || 'Scheduled';
        document.getElementById('slipTime').textContent = a.time || 'OPD hours';
        document.getElementById('slipReason').textContent = a.reason || 'General Consultation';
        document.getElementById('slipToken').textContent = 'SC-' + (a.id ? String(a.id).slice(-5) : '89234');

        var rxCont = document.getElementById('slipRxContainer');
        var rx = document.getElementById('slipRx');
        if (a.prescription) {
            rxCont.style.display = 'block';
            rx.textContent = a.prescription;
        } else {
            rxCont.style.display = 'none';
        }

        if (modal) modal.classList.add('active');
    }

    function closeSlipModal() {
        var modal = document.getElementById('slipModal');
        if (modal) modal.classList.remove('active');
    }

    function logout() {
        try {
            sessionStorage.removeItem('smartcareCurrentUser');
        } catch (e) {}
        window.location.href = '${pageContext.request.contextPath}/logout';
    }

    initPatient();
    renderMetrics();
    renderAppointments();
</script>

</body>
</html>
