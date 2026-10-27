<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Doctor Dashboard | SmartCare</title>
    <link rel="stylesheet" href="assets/css/style.css">
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Arial, sans-serif; background: #f0fdfa; color: #0f172a; min-height: 100vh; }
        a { text-decoration: none; color: inherit; }

        /* Top Header */
        .top-nav {
            background: #042f2e; color: white; padding: 14px 5%;
            display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; gap: 15px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.1);
        }
        .brand-logo { font-size: 22px; font-weight: 800; color: #2dd4bf; display: flex; align-items: center; gap: 8px; }
        .brand-logo span { color: #f8fafc; }
        .doctor-badge {
            display: inline-block; padding: 3px 10px; border-radius: 12px;
            font-size: 11px; font-weight: 800; background: #0f766e; color: white; margin-left: 8px;
            text-transform: uppercase; letter-spacing: 0.5px;
        }
        .user-nav-actions { display: flex; align-items: center; gap: 12px; }
        .logged-user-pill {
            display: flex; align-items: center; gap: 8px;
            background: #115e59; padding: 6px 14px; border-radius: 20px; font-size: 13px; color: #ccfbf1;
            border: 1px solid #14b8a6;
        }
        .btn-logout {
            background: #ef4444; color: white; padding: 7px 14px; border-radius: 8px;
            font-size: 13px; font-weight: 700; border: none; cursor: pointer; transition: .2s;
        }
        .btn-logout:hover { background: #dc2626; }

        /* Sub Navigation */
        .sub-nav {
            background: white; border-bottom: 1px solid #ccfbf1; padding: 0 5%;
            display: flex; gap: 8px; overflow-x: auto;
        }
        .sub-nav-item {
            padding: 14px 18px; font-size: 14px; font-weight: 600; color: #64748b;
            border-bottom: 3px solid transparent; cursor: pointer; white-space: nowrap; transition: .2s;
            display: inline-flex; align-items: center; gap: 6px;
        }
        .sub-nav-item:hover { color: #0f766e; }
        .sub-nav-item.active { color: #0f766e; border-bottom-color: #0f766e; }

        /* Container */
        .container { max-width: 1200px; margin: 28px auto; padding: 0 20px; }

        /* Page Banner */
        .dashboard-banner {
            background: linear-gradient(135deg, #0f766e, #115e59); color: white;
            padding: 26px 30px; border-radius: 16px; margin-bottom: 25px;
            display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; gap: 18px;
            box-shadow: 0 10px 25px -5px rgba(15, 118, 110, 0.3);
        }
        .banner-content h1 { font-size: 26px; font-weight: 800; margin-bottom: 6px; }
        .banner-content p { color: #ccfbf1; font-size: 14px; }
        .banner-actions { display: flex; gap: 10px; flex-wrap: wrap; }
        .btn-white {
            background: white; color: #0f766e; padding: 10px 18px; border-radius: 8px;
            font-size: 13px; font-weight: 700; border: none; cursor: pointer; transition: .2s;
            display: inline-flex; align-items: center; gap: 6px;
        }
        .btn-white:hover { background: #f0fdfa; }

        /* Metric Grid */
        .stats-grid {
            display: grid; grid-template-columns: repeat(4, 1fr); gap: 18px; margin-bottom: 28px;
        }
        .stat-card {
            background: white; padding: 22px; border-radius: 14px;
            border: 1px solid #ccfbf1; box-shadow: 0 4px 15px rgba(15, 23, 42, 0.04);
            position: relative; overflow: hidden;
        }
        .stat-card::before {
            content: ''; position: absolute; top: 0; left: 0; right: 0; height: 4px;
            background: #0f766e;
        }
        .stat-card.pending::before { background: #f59e0b; }
        .stat-card.completed::before { background: #10b981; }
        .stat-card.duty::before { background: #06b6d4; }
        .stat-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 12px; }
        .stat-title { font-size: 13px; font-weight: 700; color: #64748b; text-transform: uppercase; letter-spacing: 0.5px; }
        .stat-icon { font-size: 24px; }
        .stat-value { font-size: 32px; font-weight: 800; color: #0f172a; line-height: 1; }
        .stat-footer { font-size: 12px; color: #94a3b8; margin-top: 8px; }

        /* Content Layout */
        .dashboard-grid {
            display: grid; grid-template-columns: 2.2fr 1fr; gap: 24px;
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
        .panel-controls { display: flex; gap: 10px; align-items: center; flex-wrap: wrap; }

        /* Filter Pills */
        .filter-btn-group { display: flex; background: #f1f5f9; border-radius: 10px; padding: 4px; gap: 4px; }
        .filter-btn {
            background: none; border: none; padding: 6px 14px; border-radius: 7px;
            font-size: 12px; font-weight: 700; color: #64748b; cursor: pointer; transition: .2s;
        }
        .filter-btn.active { background: white; color: #0f766e; box-shadow: 0 2px 6px rgba(0,0,0,0.06); }

        /* Tables */
        .table-responsive { width: 100%; overflow-x: auto; }
        table { width: 100%; border-collapse: collapse; min-width: 680px; font-size: 13.5px; }
        th, td { text-align: left; padding: 13px 15px; border-bottom: 1px solid #f1f5f9; vertical-align: middle; }
        th { background: #f0fdfa; color: #115e59; font-weight: 700; font-size: 12px; text-transform: uppercase; letter-spacing: 0.5px; }
        tr:hover td { background: #fcfdfe; }

        /* Badges */
        .badge {
            display: inline-block; padding: 4px 10px; border-radius: 12px;
            font-size: 11.5px; font-weight: 700; text-align: center;
        }
        .badge-pending { background: #fef3c7; color: #b45309; border: 1px solid #fde68a; }
        .badge-approved { background: #dcfce7; color: #15803d; border: 1px solid #bbf7d0; }
        .badge-completed { background: #ccfbf1; color: #0f766e; border: 1px solid #99f6e4; }
        .badge-cancelled { background: #fee2e2; color: #b91c1c; border: 1px solid #fecaca; }

        /* Action Buttons */
        .action-btns { display: flex; gap: 6px; }
        .btn-act {
            border: none; padding: 6px 12px; border-radius: 6px; font-size: 11.5px;
            font-weight: 700; cursor: pointer; transition: .15s;
        }
        .btn-act-complete { background: #0f766e; color: white; }
        .btn-act-complete:hover { background: #115e59; }
        .btn-act-notes { background: #f1f5f9; color: #0f766e; border: 1px solid #ccfbf1; }
        .btn-act-notes:hover { background: #ccfbf1; }

        .empty-row { text-align: center; padding: 35px 20px; color: #64748b; font-size: 14px; }

        /* Side Info Card */
        .side-card {
            background: white; border-radius: 16px; border: 1px solid #e2e8f0;
            padding: 22px; box-shadow: 0 4px 15px rgba(15, 23, 42, 0.04); margin-bottom: 20px;
        }
        .side-card h3 { font-size: 16px; font-weight: 800; color: #0f172a; margin-bottom: 12px; display: flex; align-items: center; gap: 8px; }
        .side-info-item { margin-bottom: 12px; font-size: 13.5px; line-height: 1.5; color: #475569; }
        .side-info-item strong { color: #0f172a; display: block; font-size: 12px; text-transform: uppercase; color: #64748b; }

        /* Notes Modal */
        .modal-overlay {
            position: fixed; top: 0; left: 0; right: 0; bottom: 0;
            background: rgba(15, 23, 42, 0.6); backdrop-filter: blur(4px);
            display: none; place-items: center; z-index: 9999; padding: 20px;
        }
        .modal-overlay.active { display: grid; }
        .modal-card {
            background: white; border-radius: 16px; padding: 28px; width: 100%; max-width: 500px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.2); position: relative;
        }
        .modal-close {
            position: absolute; top: 18px; right: 18px; background: #f1f5f9; border: none;
            width: 32px; height: 32px; border-radius: 50%; font-size: 18px; cursor: pointer;
            display: grid; place-items: center; color: #64748b;
        }
        .modal-close:hover { background: #fee2e2; color: #ef4444; }
        .modal-header h3 { font-size: 20px; margin-bottom: 6px; }
        .modal-header p { font-size: 13px; color: #64748b; margin-bottom: 18px; }
        .modal-field { margin-bottom: 15px; }
        .modal-field label { display: block; font-size: 12.5px; font-weight: 700; margin-bottom: 6px; }
        .modal-field textarea, .modal-field input {
            width: 100%; padding: 10px 12px; border: 1px solid #cbd5e1; border-radius: 8px;
            font-size: 14px; outline: none; font-family: inherit;
        }
        .modal-field textarea:focus, .modal-field input:focus { border-color: #0f766e; }
        .modal-actions { margin-top: 20px; display: flex; gap: 10px; justify-content: flex-end; }
        .btn-modal-cancel { background: #f1f5f9; color: #475569; padding: 9px 16px; border-radius: 8px; border: none; font-weight: 700; cursor: pointer; }
        .btn-modal-save { background: #0f766e; color: white; padding: 9px 18px; border-radius: 8px; border: none; font-weight: 700; cursor: pointer; }
        .btn-modal-save:hover { background: #115e59; }

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
        <a class="brand-logo" href="index.jsp">✚ Smart<span>Care</span></a>
        <span class="doctor-badge">Doctor Portal</span>
    </div>
    <div class="user-nav-actions">
        <div class="logged-user-pill">
            <span>👨‍⚕️</span>
            <span id="navDoctorName">Doctor: Dr. Priya Sharma</span>
        </div>
        <button type="button" class="btn-logout" onclick="logout()">Logout</button>
    </div>
</header>

<!-- Sub Navigation Tabs -->
<nav class="sub-nav">
    <div class="sub-nav-item active">📅 My Consultations</div>
    <a class="sub-nav-item" href="patient-dashboard.jsp">👤 Patient Portal</a>
    <a class="sub-nav-item" href="book-appointment.jsp">＋ Schedule Visit</a>
    <a class="sub-nav-item" href="index.jsp">🏠 Hospital Home</a>
</nav>

<main class="container">

    <!-- Welcome Banner -->
    <section class="dashboard-banner">
        <div class="banner-content">
            <h1 id="welcomeHeading">Doctor Consultation Portal</h1>
            <p>View today's patient lineup, track clinical appointments, and document medical consultations.</p>
        </div>
        <div class="banner-actions">
            <a href="book-appointment.jsp" class="btn-white">＋ Schedule Patient</a>
        </div>
    </section>

    <!-- Metrics -->
    <section class="stats-grid">
        <div class="stat-card">
            <div class="stat-header">
                <span class="stat-title">Total Consultations</span>
                <span class="stat-icon">📋</span>
            </div>
            <div class="stat-value" id="statTotal">0</div>
            <div class="stat-footer">Assigned appointments</div>
        </div>

        <div class="stat-card pending">
            <div class="stat-header">
                <span class="stat-title">Pending Visits</span>
                <span class="stat-icon">⏳</span>
            </div>
            <div class="stat-value" id="statPending">0</div>
            <div class="stat-footer">Awaiting consultation</div>
        </div>

        <div class="stat-card completed">
            <div class="stat-header">
                <span class="stat-title">Completed Consultations</span>
                <span class="stat-icon">✅</span>
            </div>
            <div class="stat-value" id="statCompleted">0</div>
            <div class="stat-footer">Finished patient visits</div>
        </div>

        <div class="stat-card duty">
            <div class="stat-header">
                <span class="stat-title">Current Shift</span>
                <span class="stat-icon">🕒</span>
            </div>
            <div class="stat-value" style="font-size:22px; padding-top:4px;">Morning OPD</div>
            <div class="stat-footer">09:00 AM – 02:00 PM</div>
        </div>
    </section>

    <div class="dashboard-grid">

        <!-- Main Column: Schedule Table -->
        <div>
            <section class="content-panel">
                <div class="panel-top">
                    <div class="panel-title">
                        <span>🩺</span> Patient Appointment Lineup
                    </div>
                    <div class="panel-controls">
                        <div class="filter-btn-group">
                            <button type="button" class="filter-btn active" onclick="filterAppointments('all', this)">All</button>
                            <button type="button" class="filter-btn" onclick="filterAppointments('Pending', this)">Pending</button>
                            <button type="button" class="filter-btn" onclick="filterAppointments('Approved', this)">Approved</button>
                            <button type="button" class="filter-btn" onclick="filterAppointments('Completed', this)">Completed</button>
                        </div>
                    </div>
                </div>

                <div class="table-responsive">
                    <table>
                        <thead>
                            <tr>
                                <th>Patient Name</th>
                                <th>Department</th>
                                <th>Date &amp; Time</th>
                                <th>Reason / Notes</th>
                                <th>Status</th>
                                <th>Doctor Actions</th>
                            </tr>
                        </thead>
                        <tbody id="scheduleTableBody"></tbody>
                    </table>
                </div>
            </section>
        </div>

        <!-- Sidebar: Doctor Profile &amp; Clinic Info -->
        <div>
            <div class="side-card">
                <h3><span>👨‍⚕️</span> Doctor Profile</h3>
                <div class="side-info-item">
                    <strong>Doctor Name</strong>
                    <span id="profileDocName">Dr. Priya Sharma</span>
                </div>
                <div class="side-info-item">
                    <strong>Specialization</strong>
                    <span id="profileDocDept">Cardiology &amp; Internal Medicine</span>
                </div>
                <div class="side-info-item">
                    <strong>OPD Clinic Room</strong>
                    <span>Room 304, OPD Block C, 3rd Floor</span>
                </div>
                <div class="side-info-item">
                    <strong>Hospital Extension</strong>
                    <span>Ext. 2045 (Emergency Ward: Ext. 108)</span>
                </div>
            </div>

            <div class="side-card">
                <h3><span>💡</span> Quick Clinical Tips</h3>
                <p style="font-size: 13px; color: #64748b; line-height: 1.6;">
                    Select <strong>Mark Done</strong> once a patient's consultation is concluded. Use <strong>Prescription / Notes</strong> to attach medical guidance for the patient.
                </p>
            </div>
        </div>

    </div>

</main>

<!-- Clinical Notes / Prescription Modal -->
<div id="notesModal" class="modal-overlay">
    <div class="modal-card">
        <button type="button" class="modal-close" onclick="closeNotesModal()">&times;</button>
        <div class="modal-header">
            <h3>Add Clinical Notes / Prescription</h3>
            <p id="notesModalPatientInfo">Patient: Demo Patient</p>
        </div>
        <form id="notesForm" onsubmit="saveClinicalNotes(event)">
            <input type="hidden" id="notesAppointmentIndex">
            <div class="modal-field">
                <label for="doctorDiagnosis">Clinical Diagnosis &amp; Findings</label>
                <input type="text" id="doctorDiagnosis" placeholder="e.g. Mild hypertension, seasonal allergy" required>
            </div>
            <div class="modal-field">
                <label for="doctorPrescription">Prescribed Medications / Advice</label>
                <textarea id="doctorPrescription" rows="4" placeholder="e.g. Tab Paracetamol 500mg SOS, Drink plenty of fluids, Review after 5 days." required></textarea>
            </div>
            <div class="modal-actions">
                <button type="button" class="btn-modal-cancel" onclick="closeNotesModal()">Cancel</button>
                <button type="submit" class="btn-modal-save">Save Prescription</button>
            </div>
        </form>
    </div>
</div>

<div id="toast" class="toast">Action performed successfully</div>

<script>
    var currentFilter = 'all';

    function initDoctor() {
        var user = null;
        try {
            user = JSON.parse(sessionStorage.getItem('smartcareCurrentUser'));
        } catch(e) {
            user = null;
        }
        var navName = document.getElementById('navDoctorName');
        var welcome = document.getElementById('welcomeHeading');
        var profName = document.getElementById('profileDocName');

        if (user && user.name) {
            if (navName) navName.textContent = 'Doctor: ' + user.name;
            if (welcome) welcome.textContent = 'Welcome, ' + user.name;
            if (profName) profName.textContent = user.name;
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
        var completed = 0;

        for (var i = 0; i < appts.length; i++) {
            var st = appts[i].status || 'Pending';
            if (st === 'Pending' || st === 'Approved') pending++;
            else if (st === 'Completed') completed++;
        }

        var statTotal = document.getElementById('statTotal');
        var statPending = document.getElementById('statPending');
        var statCompleted = document.getElementById('statCompleted');

        if (statTotal) statTotal.textContent = total;
        if (statPending) statPending.textContent = pending;
        if (statCompleted) statCompleted.textContent = completed;
    }

    function renderSchedule() {
        var appts = getAppointments();
        var tbody = document.getElementById('scheduleTableBody');
        if (!tbody) return;

        var filtered = [];
        for (var i = 0; i < appts.length; i++) {
            var item = appts[i];
            var st = item.status || 'Pending';

            if (currentFilter !== 'all' && st !== currentFilter) {
                continue;
            }
            filtered.push({ index: i, data: item });
        }

        if (filtered.length === 0) {
            tbody.innerHTML = '<tr><td colspan="6" class="empty-row">No patient appointments match the selected filter.</td></tr>';
            return;
        }

        var html = '';
        for (var k = 0; k < filtered.length; k++) {
            var idx = filtered[k].index;
            var a = filtered[k].data;
            var st = a.status || 'Pending';

            var badgeClass = (st === 'Approved') ? 'badge-approved'
                           : (st === 'Completed') ? 'badge-completed'
                           : (st === 'Cancelled') ? 'badge-cancelled' : 'badge-pending';

            var notesDisplay = a.diagnosis ? ('<br><small style="color:#0f766e; font-weight:600;">Rx: ' + escapeHtml(a.diagnosis) + '</small>') : '';

            var actionButtons = '';
            if (st !== 'Completed') {
                actionButtons += '<button type="button" class="btn-act btn-act-complete" onclick="markCompleted(' + idx + ')">Mark Done</button> ';
                actionButtons += '<button type="button" class="btn-act btn-act-notes" onclick="openNotesModal(' + idx + ')">＋ Prescription</button>';
            } else {
                actionButtons += '<button type="button" class="btn-act btn-act-notes" onclick="openNotesModal(' + idx + ')">View / Edit Rx</button>';
            }

            html += '<tr>' +
                '<td><strong>' + escapeHtml(a.patient) + '</strong><br><small style="color:#64748b;">' + escapeHtml(a.phone || a.email || '') + '</small></td>' +
                '<td><span class="badge badge-completed">' + escapeHtml(a.department || 'Cardiology') + '</span></td>' +
                '<td>' + escapeHtml(a.date) + '<br><small style="color:#64748b;">' + escapeHtml(a.time) + '</small></td>' +
                '<td>' + escapeHtml(a.reason || 'General checkup') + notesDisplay + '</td>' +
                '<td><span class="badge ' + badgeClass + '">' + escapeHtml(st) + '</span></td>' +
                '<td><div class="action-btns">' + actionButtons + '</div></td>' +
                '</tr>';
        }

        tbody.innerHTML = html;
    }

    function markCompleted(index) {
        var appts = getAppointments();
        if (!appts[index]) return;
        appts[index].status = 'Completed';
        saveAppointments(appts);
        renderMetrics();
        renderSchedule();
        showToast('Consultation marked as Completed.');
    }

    function openNotesModal(index) {
        var appts = getAppointments();
        var a = appts[index];
        if (!a) return;

        var modal = document.getElementById('notesModal');
        var idxField = document.getElementById('notesAppointmentIndex');
        var info = document.getElementById('notesModalPatientInfo');
        var diagField = document.getElementById('doctorDiagnosis');
        var rxField = document.getElementById('doctorPrescription');

        if (idxField) idxField.value = index;
        if (info) info.textContent = 'Patient: ' + (a.patient || 'Patient') + ' (' + (a.date || '') + ' at ' + (a.time || '') + ')';
        if (diagField) diagField.value = a.diagnosis || '';
        if (rxField) rxField.value = a.prescription || '';

        if (modal) modal.classList.add('active');
    }

    function closeNotesModal() {
        var modal = document.getElementById('notesModal');
        if (modal) modal.classList.remove('active');
        var form = document.getElementById('notesForm');
        if (form) form.reset();
    }

    function saveClinicalNotes(e) {
        e.preventDefault();
        var index = parseInt(document.getElementById('notesAppointmentIndex').value, 10);
        var diag = document.getElementById('doctorDiagnosis').value.trim();
        var rx = document.getElementById('doctorPrescription').value.trim();

        var appts = getAppointments();
        if (appts[index]) {
            appts[index].diagnosis = diag;
            appts[index].prescription = rx;
            appts[index].status = 'Completed'; // Automatically mark completed when Rx is saved
            saveAppointments(appts);
            showToast('Prescription saved for ' + appts[index].patient + '.');
        }

        closeNotesModal();
        renderMetrics();
        renderSchedule();
    }

    function filterAppointments(status, btn) {
        currentFilter = status;
        var btns = document.querySelectorAll('.filter-btn');
        for (var i = 0; i < btns.length; i++) {
            btns[i].classList.remove('active');
        }
        if (btn) btn.classList.add('active');
        renderSchedule();
    }

    function logout() {
        try {
            sessionStorage.removeItem('smartcareCurrentUser');
        } catch (e) {}
        window.location.href = 'index.jsp';
    }

    initDoctor();
    renderMetrics();
    renderSchedule();
</script>

</body>
</html>
