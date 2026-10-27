<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard &amp; Analytics | SmartCare</title>
    <link rel="stylesheet" href="assets/css/style.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Arial, sans-serif; background: #f1f5f9; color: #0f172a; min-height: 100vh; }
        a { text-decoration: none; color: inherit; }

        /* Top Header */
        .top-nav {
            background: #0f172a; color: white; padding: 14px 5%;
            display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; gap: 15px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.1);
        }
        .brand-logo { font-size: 22px; font-weight: 800; color: #38bdf8; display: flex; align-items: center; gap: 8px; }
        .brand-logo span { color: #f8fafc; }
        .admin-badge {
            display: inline-block; padding: 3px 10px; border-radius: 12px;
            font-size: 11px; font-weight: 800; background: #0284c7; color: white; margin-left: 8px;
            text-transform: uppercase; letter-spacing: 0.5px;
        }
        .user-nav-actions { display: flex; align-items: center; gap: 12px; }
        .logged-user-pill {
            display: flex; align-items: center; gap: 8px;
            background: #1e293b; padding: 6px 14px; border-radius: 20px; font-size: 13px; color: #e2e8f0;
            border: 1px solid #334155;
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
        .container { max-width: 1240px; margin: 28px auto; padding: 0 20px; }

        /* Page Banner */
        .dashboard-banner {
            background: linear-gradient(135deg, #0284c7, #0369a1); color: white;
            padding: 26px 30px; border-radius: 16px; margin-bottom: 25px;
            display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; gap: 18px;
            box-shadow: 0 10px 25px -5px rgba(2, 132, 199, 0.3);
        }
        .banner-content h1 { font-size: 26px; font-weight: 800; margin-bottom: 6px; }
        .banner-content p { color: #e0f2fe; font-size: 14px; }
        .banner-actions { display: flex; gap: 10px; flex-wrap: wrap; }
        .btn-white {
            background: white; color: #0369a1; padding: 10px 18px; border-radius: 8px;
            font-size: 13px; font-weight: 700; border: none; cursor: pointer; transition: .2s;
            display: inline-flex; align-items: center; gap: 6px;
        }
        .btn-white:hover { background: #f0f9ff; }
        .btn-glass {
            background: rgba(255,255,255,0.18); color: white; padding: 10px 18px; border-radius: 8px;
            font-size: 13px; font-weight: 700; border: 1px solid rgba(255,255,255,0.3);
            cursor: pointer; transition: .2s; display: inline-flex; align-items: center; gap: 6px;
        }
        .btn-glass:hover { background: rgba(255,255,255,0.28); }

        /* Metric Grid */
        .stats-grid {
            display: grid; grid-template-columns: repeat(4, 1fr); gap: 18px; margin-bottom: 22px;
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
        .stat-card.doctors::before { background: #8b5cf6; }
        .stat-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 12px; }
        .stat-title { font-size: 13px; font-weight: 700; color: #64748b; text-transform: uppercase; letter-spacing: 0.5px; }
        .stat-icon { font-size: 24px; }
        .stat-value { font-size: 32px; font-weight: 800; color: #0f172a; line-height: 1; }
        .stat-footer { font-size: 12px; color: #94a3b8; margin-top: 8px; }

        /* Live Operational Vitals Strip */
        .vitals-grid {
            display: grid; grid-template-columns: repeat(4, 1fr); gap: 16px; margin-bottom: 25px;
        }
        .vital-card {
            background: white; border: 1px solid #e2e8f0; border-radius: 12px;
            padding: 16px; box-shadow: 0 2px 8px rgba(15, 23, 42, 0.03);
            display: flex; align-items: center; gap: 14px;
        }
        .vital-icon {
            width: 44px; height: 44px; border-radius: 10px; display: flex;
            align-items: center; justify-content: center; font-size: 20px;
            background: #f0f9ff; color: #0284c7; flex-shrink: 0;
        }
        .vital-icon.green { background: #ecfdf5; color: #10b981; }
        .vital-icon.amber { background: #fffbeb; color: #f59e0b; }
        .vital-icon.purple { background: #f5f3ff; color: #8b5cf6; }
        .vital-info h4 {
            font-size: 11.5px; font-weight: 700; color: #64748b; text-transform: uppercase;
            letter-spacing: 0.5px; margin-bottom: 3px;
        }
        .vital-val { font-size: 18px; font-weight: 800; color: #0f172a; }
        .vital-sub { font-size: 11.5px; color: #10b981; font-weight: 600; margin-top: 2px; }

        /* Charts Grid Section */
        .charts-grid {
            display: grid; grid-template-columns: 1.55fr 1fr; gap: 20px; margin-bottom: 25px;
        }
        .chart-card {
            background: white; border-radius: 16px; border: 1px solid #e2e8f0;
            padding: 22px; box-shadow: 0 4px 15px rgba(15, 23, 42, 0.04);
            display: flex; flex-direction: column; position: relative;
        }
        .chart-header {
            display: flex; justify-content: space-between; align-items: flex-start;
            margin-bottom: 16px; flex-wrap: wrap; gap: 10px;
        }
        .chart-title-wrap h3 {
            font-size: 16px; font-weight: 800; color: #0f172a; display: flex; align-items: center; gap: 8px;
        }
        .chart-title-wrap p {
            font-size: 12px; color: #64748b; margin-top: 3px;
        }
        .chart-toggle-group {
            display: flex; background: #f1f5f9; border-radius: 8px; padding: 3px; gap: 3px;
        }
        .chart-toggle-btn {
            background: none; border: none; padding: 5px 12px; border-radius: 6px;
            font-size: 11.5px; font-weight: 700; color: #64748b; cursor: pointer; transition: .15s;
        }
        .chart-toggle-btn.active {
            background: white; color: #0284c7; box-shadow: 0 1px 4px rgba(0,0,0,0.06);
        }
        .chart-canvas-container {
            position: relative; flex: 1; min-height: 255px; max-height: 295px;
            display: flex; align-items: center; justify-content: center;
        }
        .chart-canvas-container canvas {
            width: 100% !important; max-height: 100%;
        }
        .chart-summary-strip {
            display: grid; grid-template-columns: repeat(3, 1fr); gap: 10px;
            margin-top: 15px; padding-top: 14px; border-top: 1px solid #f1f5f9; text-align: center;
        }
        .chart-sum-item strong { display: block; font-size: 17px; font-weight: 800; color: #0f172a; }
        .chart-sum-item span { font-size: 11.5px; color: #64748b; }

        .pie-legend {
            display: flex; flex-wrap: wrap; gap: 8px 14px; margin-top: 14px;
            padding-top: 12px; border-top: 1px solid #f1f5f9; justify-content: center;
        }
        .legend-item {
            display: flex; align-items: center; gap: 6px; font-size: 12px; font-weight: 600; color: #334155;
        }
        .legend-dot { width: 10px; height: 10px; border-radius: 50%; display: inline-block; }
        .legend-count { font-weight: 800; color: #0f172a; margin-left: 2px; }

        /* Secondary Analytics Grid (for Reports Tab) */
        .analytics-subgrid {
            display: grid; grid-template-columns: 1.4fr 1fr; gap: 20px; margin-bottom: 25px;
        }

        /* Content Sections */
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
        .filter-btn.active { background: white; color: #0284c7; box-shadow: 0 2px 6px rgba(0,0,0,0.06); }

        /* Search Input */
        .search-box {
            padding: 8px 14px; border: 1px solid #cbd5e1; border-radius: 8px;
            font-size: 13px; outline: none; width: 220px;
        }
        .search-box:focus { border-color: #0284c7; box-shadow: 0 0 0 3px rgba(2, 132, 199, 0.15); }

        /* Tables */
        .table-responsive { width: 100%; overflow-x: auto; }
        table { width: 100%; border-collapse: collapse; min-width: 720px; font-size: 13.5px; }
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
            border: none; padding: 5px 10px; border-radius: 6px; font-size: 11.5px;
            font-weight: 700; cursor: pointer; transition: .15s;
        }
        .btn-act-approve { background: #10b981; color: white; }
        .btn-act-approve:hover { background: #059669; }
        .btn-act-complete { background: #0284c7; color: white; }
        .btn-act-complete:hover { background: #0369a1; }
        .btn-act-cancel { background: #f1f5f9; color: #64748b; border: 1px solid #cbd5e1; }
        .btn-act-cancel:hover { background: #fee2e2; color: #dc2626; border-color: #fca5a5; }
        .btn-act-delete { background: none; color: #94a3b8; font-size: 15px; padding: 4px 6px; }
        .btn-act-delete:hover { color: #ef4444; }

        .empty-row { text-align: center; padding: 35px 20px; color: #64748b; font-size: 14px; }

        /* Add Doctor Modal */
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
        .modal-header h3 { font-size: 20px; margin-bottom: 6px; }
        .modal-header p { font-size: 13px; color: #64748b; margin-bottom: 20px; }
        .modal-field { margin-bottom: 15px; }
        .modal-field label { display: block; font-size: 12.5px; font-weight: 700; margin-bottom: 6px; }
        .modal-field input, .modal-field select {
            width: 100%; padding: 10px 12px; border: 1px solid #cbd5e1; border-radius: 8px;
            font-size: 14px; outline: none;
        }
        .modal-field input:focus, .modal-field select:focus { border-color: #0284c7; }
        .modal-actions { margin-top: 22px; display: flex; gap: 10px; justify-content: flex-end; }
        .btn-modal-cancel { background: #f1f5f9; color: #475569; padding: 9px 16px; border-radius: 8px; border: none; font-weight: 700; cursor: pointer; }
        .btn-modal-save { background: #0284c7; color: white; padding: 9px 18px; border-radius: 8px; border: none; font-weight: 700; cursor: pointer; }
        .btn-modal-save:hover { background: #0369a1; }

        /* Notification Toast */
        .toast {
            position: fixed; bottom: 25px; right: 25px; background: #0f172a; color: white;
            padding: 12px 20px; border-radius: 10px; font-size: 13px; font-weight: 600;
            box-shadow: 0 10px 25px rgba(0,0,0,0.2); z-index: 10000; display: none;
            border-left: 4px solid #10b981;
        }
        .toast.show { display: block; animation: slideIn 0.3s ease; }
        @keyframes slideIn { from { transform: translateY(20px); opacity: 0; } to { transform: translateY(0); opacity: 1; } }

        @media(max-width: 950px) {
            .charts-grid, .analytics-subgrid { grid-template-columns: 1fr; }
            .vitals-grid { grid-template-columns: repeat(2, 1fr); }
            .stats-grid { grid-template-columns: repeat(2, 1fr); }
        }
        @media(max-width: 600px) {
            .stats-grid, .vitals-grid { grid-template-columns: 1fr; }
            .dashboard-banner { padding: 20px; }
            .banner-content h1 { font-size: 22px; }
        }
        @media print {
            .top-nav, .sub-nav, .banner-actions, .panel-controls, .action-btns, .modal-overlay { display: none !important; }
            body { background: white; color: black; }
            .content-panel, .chart-card, .stat-card { box-shadow: none; border: 1px solid #ccc; break-inside: avoid; }
        }
    </style>
</head>
<body>

<!-- Top Navigation -->
<header class="top-nav">
    <div style="display:flex; align-items:center;">
        <a class="brand-logo" href="index.jsp">✚ Smart<span>Care</span></a>
        <span class="admin-badge">Admin Portal</span>
    </div>
    <div class="user-nav-actions">
        <div class="logged-user-pill">
            <span>🛡️</span>
            <span id="navUserName">Admin: SmartCare Administrator</span>
        </div>
        <button type="button" class="btn-logout" onclick="logout()">Logout</button>
    </div>
</header>

<!-- Sub Navigation Tabs -->
<nav class="sub-nav">
    <div class="sub-nav-item active" onclick="switchTab('overview')">📊 Overview &amp; Analytics</div>
    <div class="sub-nav-item" onclick="switchTab('appointments')">📋 Appointments Table</div>
    <div class="sub-nav-item" onclick="switchTab('reports')">📈 Hospital Reports</div>
    <div class="sub-nav-item" onclick="switchTab('doctors')">👨‍⚕️ Doctors Directory</div>
    <div class="sub-nav-item" onclick="switchTab('patients')">👥 Patients Directory</div>
</nav>

<main class="container">

    <!-- Welcome Banner -->
    <section class="dashboard-banner">
        <div class="banner-content">
            <h1 id="welcomeHeading">Hospital Operations &amp; Executive Analytics</h1>
            <p>Real-time clinical metrics, appointment activity graphs, patient inflow, and medical department analytics.</p>
        </div>
        <div class="banner-actions">
            <button type="button" class="btn-white" onclick="openAddDoctorModal()">＋ Add New Doctor</button>
            <a href="book-appointment.jsp" class="btn-glass">＋ Schedule Appointment</a>
            <button type="button" class="btn-glass" onclick="window.print()">🖨️ Export / Print Summary</button>
        </div>
    </section>

    <!-- High-level Metric Cards -->
    <section class="stats-grid">
        <div class="stat-card">
            <div class="stat-header">
                <span class="stat-title">Total Appointments</span>
                <span class="stat-icon">📅</span>
            </div>
            <div class="stat-value" id="statTotalAppointments">0</div>
            <div class="stat-footer">All-time hospital bookings</div>
        </div>

        <div class="stat-card pending">
            <div class="stat-header">
                <span class="stat-title">Pending Approvals</span>
                <span class="stat-icon">⏳</span>
            </div>
            <div class="stat-value" id="statPendingAppointments">0</div>
            <div class="stat-footer">Awaiting staff review</div>
        </div>

        <div class="stat-card approved">
            <div class="stat-header">
                <span class="stat-title">Approved Visits</span>
                <span class="stat-icon">✅</span>
            </div>
            <div class="stat-value" id="statApprovedAppointments">0</div>
            <div class="stat-footer">Confirmed consultations</div>
        </div>

        <div class="stat-card doctors">
            <div class="stat-header">
                <span class="stat-title">Medical Doctors</span>
                <span class="stat-icon">👨‍⚕️</span>
            </div>
            <div class="stat-value" id="statTotalDoctors">6</div>
            <div class="stat-footer">Specialists actively registered</div>
        </div>
    </section>

    <!-- Hospital Live Operational Vitals Strip -->
    <section class="vitals-grid">
        <div class="vital-card">
            <div class="vital-icon">🛏️</div>
            <div class="vital-info">
                <h4>Bed Occupancy</h4>
                <div class="vital-val">84% Occupied</div>
                <div class="vital-sub">168 / 200 Beds Active</div>
            </div>
        </div>
        <div class="vital-card">
            <div class="vital-icon green">⏱️</div>
            <div class="vital-info">
                <h4>Avg. Wait Time</h4>
                <div class="vital-val">14 Mins</div>
                <div class="vital-sub">Target &lt; 20m met</div>
            </div>
        </div>
        <div class="vital-card">
            <div class="vital-icon amber">🚑</div>
            <div class="vital-info">
                <h4>Emergency / ICU</h4>
                <div class="vital-val">100% Operational</div>
                <div class="vital-sub">All trauma bays available</div>
            </div>
        </div>
        <div class="vital-card">
            <div class="vital-icon purple">⭐</div>
            <div class="vital-info">
                <h4>Satisfaction</h4>
                <div class="vital-val">98.4%</div>
                <div class="vital-sub">4.9 / 5.0 (520 reviews)</div>
            </div>
        </div>
    </section>

    <!-- Tab 1: Overview & Analytics (Includes Line Graph & Pie Chart) -->
    <div id="tabOverview">
        <!-- Visual Analytics Grid: Graph + Pie Chart -->
        <section class="charts-grid">
            <!-- 1. Activity Trend Line Graph -->
            <div class="chart-card">
                <div class="chart-header">
                    <div class="chart-title-wrap">
                        <h3><span>📈</span> Patient Inflow &amp; Booking Trend</h3>
                        <p>Hospital appointment volume and scheduling momentum</p>
                    </div>
                    <div class="chart-toggle-group">
                        <button type="button" class="chart-toggle-btn active" id="btnTrend7d" onclick="toggleTrend('7days')">7 Days</button>
                        <button type="button" class="chart-toggle-btn" id="btnTrendMonth" onclick="toggleTrend('month')">Monthly</button>
                    </div>
                </div>
                <div class="chart-canvas-container">
                    <canvas id="trendChartCanvas" height="255"></canvas>
                </div>
                <div class="chart-summary-strip">
                    <div class="chart-sum-item">
                        <strong id="trendTotalBookings">0</strong>
                        <span>Bookings</span>
                    </div>
                    <div class="chart-sum-item">
                        <strong id="trendPeakDay">-</strong>
                        <span>Peak Activity Day</span>
                    </div>
                    <div class="chart-sum-item">
                        <strong id="trendAvgDaily">0</strong>
                        <span>Daily Average</span>
                    </div>
                </div>
            </div>

            <!-- 2. Status & Department Breakdown Pie/Doughnut Chart -->
            <div class="chart-card">
                <div class="chart-header">
                    <div class="chart-title-wrap">
                        <h3><span>🍩</span> Distribution Breakdown</h3>
                        <p id="pieChartSubtitle">Live status distribution of appointments</p>
                    </div>
                    <div class="chart-toggle-group">
                        <button type="button" class="chart-toggle-btn active" id="btnPieStatus" onclick="togglePie('status')">Status</button>
                        <button type="button" class="chart-toggle-btn" id="btnPieDept" onclick="togglePie('department')">Specialty</button>
                    </div>
                </div>
                <div class="chart-canvas-container">
                    <canvas id="pieChartCanvas" height="255"></canvas>
                </div>
                <div class="pie-legend" id="pieLegendContainer"></div>
            </div>
        </section>

        <!-- Recent Appointments Snapshot Panel in Overview -->
        <section class="content-panel">
            <div class="panel-top">
                <div class="panel-title">
                    <span>📋</span> Recent Hospital Appointments
                </div>
                <div class="panel-controls">
                    <button type="button" class="btn-modal-save" onclick="switchTab('appointments')">View All Appointments →</button>
                </div>
            </div>
            <div class="table-responsive">
                <table>
                    <thead>
                        <tr>
                            <th>Patient Name</th>
                            <th>Doctor / Specialty</th>
                            <th>Date &amp; Time</th>
                            <th>Reason for Visit</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody id="overviewAppointmentTableBody"></tbody>
                </table>
            </div>
        </section>
    </div>

    <!-- Tab 2: Full Appointments Management Table -->
    <section id="tabAppointments" class="content-panel" style="display:none;">
        <div class="panel-top">
            <div class="panel-title">
                <span>📋</span> All Hospital Appointments
            </div>
            <div class="panel-controls">
                <div class="filter-btn-group">
                    <button type="button" class="filter-btn active" onclick="filterAppointments('all', this)">All</button>
                    <button type="button" class="filter-btn" onclick="filterAppointments('Pending', this)">Pending</button>
                    <button type="button" class="filter-btn" onclick="filterAppointments('Approved', this)">Approved</button>
                    <button type="button" class="filter-btn" onclick="filterAppointments('Completed', this)">Completed</button>
                </div>
                <input type="text" id="appointmentSearch" class="search-box" placeholder="Search patient or doctor..." oninput="handleSearch()">
            </div>
        </div>

        <div class="table-responsive">
            <table>
                <thead>
                    <tr>
                        <th>Patient Name</th>
                        <th>Doctor / Specialty</th>
                        <th>Date &amp; Time</th>
                        <th>Reason for Visit</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody id="appointmentTableBody"></tbody>
            </table>
        </div>
    </section>

    <!-- Tab 3: Detailed Hospital Reports & Department Workload Bar Chart -->
    <div id="tabReports" style="display:none;">
        <section class="analytics-subgrid">
            <!-- Department Workload Bar Chart -->
            <div class="chart-card">
                <div class="chart-header">
                    <div class="chart-title-wrap">
                        <h3><span>📊</span> Department Workload &amp; Specialist Staffing</h3>
                        <p>Distribution of appointments across medical specialties</p>
                    </div>
                </div>
                <div class="chart-canvas-container">
                    <canvas id="deptBarChartCanvas" height="260"></canvas>
                </div>
            </div>

            <!-- Service Readiness & Operational Indicators -->
            <div class="chart-card">
                <div class="chart-header">
                    <div class="chart-title-wrap">
                        <h3><span>🏥</span> Hospital Department Status</h3>
                        <p>Operational health &amp; clinical readiness</p>
                    </div>
                </div>
                <div style="display:flex; flex-direction:column; gap:12px; margin-top:6px;">
                    <div style="display:flex; justify-content:space-between; align-items:center; padding:12px 14px; background:#f8fafc; border-radius:10px; border:1px solid #e2e8f0;">
                        <div>
                            <strong style="display:block; font-size:13.5px; color:#0f172a;">Cardiology &amp; Cath Lab</strong>
                            <span style="font-size:12px; color:#64748b;">3 Specialists Available | 2 On Call</span>
                        </div>
                        <span class="badge badge-approved">Normal</span>
                    </div>
                    <div style="display:flex; justify-content:space-between; align-items:center; padding:12px 14px; background:#f8fafc; border-radius:10px; border:1px solid #e2e8f0;">
                        <div>
                            <strong style="display:block; font-size:13.5px; color:#0f172a;">Diagnostic Pathology Lab</strong>
                            <span style="font-size:12px; color:#64748b;">Processing 42 Blood/Biochemistry tests</span>
                        </div>
                        <span class="badge badge-completed">Active</span>
                    </div>
                    <div style="display:flex; justify-content:space-between; align-items:center; padding:12px 14px; background:#f8fafc; border-radius:10px; border:1px solid #e2e8f0;">
                        <div>
                            <strong style="display:block; font-size:13.5px; color:#0f172a;">In-House Pharmacy</strong>
                            <span style="font-size:12px; color:#64748b;">99.2% essential medicines in stock</span>
                        </div>
                        <span class="badge badge-approved">Stocked</span>
                    </div>
                    <div style="display:flex; justify-content:space-between; align-items:center; padding:12px 14px; background:#f8fafc; border-radius:10px; border:1px solid #e2e8f0;">
                        <div>
                            <strong style="display:block; font-size:13.5px; color:#0f172a;">Ambulance &amp; Emergency Fleet</strong>
                            <span style="font-size:12px; color:#64748b;">5 Response Units on active standby</span>
                        </div>
                        <span class="badge badge-approved">Ready (5/5)</span>
                    </div>
                </div>
            </div>
        </section>
    </div>

    <!-- Tab 4: Doctors Directory -->
    <section id="tabDoctors" class="content-panel" style="display:none;">
        <div class="panel-top">
            <div class="panel-title">
                <span>👨‍⚕️</span> Hospital Doctors &amp; Specialists
            </div>
            <button type="button" class="btn-modal-save" onclick="openAddDoctorModal()">＋ Add Doctor</button>
        </div>

        <div class="table-responsive">
            <table>
                <thead>
                    <tr>
                        <th>Doctor Name</th>
                        <th>Department</th>
                        <th>OPD Timings</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody id="doctorsTableBody"></tbody>
            </table>
        </div>
    </section>

    <!-- Tab 5: Registered Patients Directory -->
    <section id="tabPatients" class="content-panel" style="display:none;">
        <div class="panel-top">
            <div class="panel-title">
                <span>👥</span> Registered Patients Directory
            </div>
            <a href="register.jsp?role=patient" class="btn-modal-save">＋ Register New Patient</a>
        </div>

        <div class="table-responsive">
            <table>
                <thead>
                    <tr>
                        <th>Patient Name</th>
                        <th>Email Address</th>
                        <th>Account Role</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody id="patientsTableBody"></tbody>
            </table>
        </div>
    </section>

</main>

<!-- Add Doctor Modal -->
<div id="addDoctorModal" class="modal-overlay">
    <div class="modal-card">
        <button type="button" class="modal-close" onclick="closeAddDoctorModal()">&times;</button>
        <div class="modal-header">
            <h3>Add Hospital Doctor</h3>
            <p>Add a new doctor or specialist to the hospital directory.</p>
        </div>
        <form id="addDoctorForm" onsubmit="saveNewDoctor(event)">
            <div class="modal-field">
                <label for="newDocName">Doctor Full Name</label>
                <input type="text" id="newDocName" required placeholder="e.g. Dr. Rajesh Kumar">
            </div>
            <div class="modal-field">
                <label for="newDocDept">Medical Department</label>
                <select id="newDocDept" required>
                    <option value="">Select Department</option>
                    <option value="Cardiology">Cardiology</option>
                    <option value="Neurology">Neurology</option>
                    <option value="Pediatrics">Pediatrics</option>
                    <option value="Orthopedics">Orthopedics</option>
                    <option value="Dermatology">Dermatology</option>
                    <option value="General Medicine">General Medicine</option>
                </select>
            </div>
            <div class="modal-field">
                <label for="newDocSchedule">OPD Schedule</label>
                <input type="text" id="newDocSchedule" required placeholder="e.g. Mon–Fri, 09:00 AM – 01:00 PM">
            </div>
            <div class="modal-actions">
                <button type="button" class="btn-modal-cancel" onclick="closeAddDoctorModal()">Cancel</button>
                <button type="submit" class="btn-modal-save">Save Doctor</button>
            </div>
        </form>
    </div>
</div>

<div id="toast" class="toast">Action performed successfully</div>

<script>
    // Default seeded hospital doctors
    var defaultDoctors = [
        { name: "Dr. Priya Sharma", dept: "Cardiology", schedule: "Mon–Fri, 09:00 AM – 02:00 PM", status: "Available" },
        { name: "Dr. Rahul Mehta", dept: "Neurology", schedule: "Mon–Sat, 10:00 AM – 03:00 PM", status: "Available" },
        { name: "Dr. Ananya Patel", dept: "Pediatrics", schedule: "Tue–Sat, 09:00 AM – 01:00 PM", status: "Available" },
        { name: "Dr. Arjun Shah", dept: "Orthopedics", schedule: "Mon–Fri, 11:00 AM – 04:00 PM", status: "Available" },
        { name: "Dr. Sneha Rao", dept: "Dermatology", schedule: "Wed–Sun, 10:00 AM – 02:00 PM", status: "Available" },
        { name: "Dr. Vikram Singh", dept: "General Medicine", schedule: "Daily, 08:00 AM – 04:00 PM", status: "Available" }
    ];

    // Default seeded appointments for immediate rich analytics visualization
    var defaultAppointments = [
        { patient: "Rajesh Sharma", phone: "9876543210", doctor: "Dr. Priya Sharma", department: "Cardiology", date: "2026-10-26", time: "10:00 AM", reason: "Chest discomfort & ECG review", status: "Approved" },
        { patient: "Meena Gupta", phone: "9823456789", doctor: "Dr. Rahul Mehta", department: "Neurology", date: "2026-10-26", time: "11:30 AM", reason: "Chronic migraine follow-up", status: "Pending" },
        { patient: "Aarav Patel", phone: "9812345678", doctor: "Dr. Ananya Patel", department: "Pediatrics", date: "2026-10-25", time: "09:30 AM", reason: "Fever & vaccination check", status: "Approved" },
        { patient: "Sunita Verma", phone: "9765432109", doctor: "Dr. Arjun Shah", department: "Orthopedics", date: "2026-10-25", time: "02:00 PM", reason: "Knee joint rehabilitation", status: "Completed" },
        { patient: "Vikram Malhotra", phone: "9654321098", doctor: "Dr. Sneha Rao", department: "Dermatology", date: "2026-10-24", time: "12:00 PM", reason: "Skin allergy rash", status: "Completed" },
        { patient: "Amitabh Sen", phone: "9543210987", doctor: "Dr. Vikram Singh", department: "General Medicine", date: "2026-10-23", time: "03:30 PM", reason: "Routine wellness consultation", status: "Approved" },
        { patient: "Kavita Joshi", phone: "9432109876", doctor: "Dr. Priya Sharma", department: "Cardiology", date: "2026-10-22", time: "10:30 AM", reason: "Hypertension check", status: "Pending" },
        { patient: "Rohan Deshmukh", phone: "9321098765", doctor: "Dr. Rahul Mehta", department: "Neurology", date: "2026-10-21", time: "01:00 PM", reason: "Vertigo & dizziness", status: "Cancelled" }
    ];

    var currentFilter = 'all';
    var currentTrendView = '7days';
    var currentPieView = 'status';

    // Chart.js instance tracking
    var trendChartInstance = null;
    var pieChartInstance = null;
    var deptBarChartInstance = null;

    function initUser() {
        var user = null;
        try {
            user = JSON.parse(sessionStorage.getItem('smartcareCurrentUser'));
        } catch(e) {
            user = null;
        }
        var navUserName = document.getElementById('navUserName');
        var welcomeHeading = document.getElementById('welcomeHeading');
        if (user && user.name) {
            if (navUserName) navUserName.textContent = 'Admin: ' + user.name;
            if (welcomeHeading) welcomeHeading.textContent = 'Welcome, ' + user.name;
        }
    }

    function getAppointments() {
        try {
            var stored = JSON.parse(localStorage.getItem('smartcareAppointments'));
            if (stored && stored.length) return stored;
        } catch (e) {}
        // Seed default appointments so charts render immediately
        try {
            localStorage.setItem('smartcareAppointments', JSON.stringify(defaultAppointments));
        } catch(e) {}
        return defaultAppointments;
    }

    function saveAppointments(list) {
        try {
            localStorage.setItem('smartcareAppointments', JSON.stringify(list));
        } catch (e) {}
    }

    function getDoctors() {
        try {
            var stored = JSON.parse(localStorage.getItem('smartcareDoctors'));
            if (stored && stored.length) return stored;
        } catch (e) {}
        return defaultDoctors;
    }

    function saveDoctors(list) {
        try {
            localStorage.setItem('smartcareDoctors', JSON.stringify(list));
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
        var doctors = getDoctors();

        var total = appts.length;
        var pending = 0;
        var approved = 0;
        for (var i = 0; i < appts.length; i++) {
            var s = appts[i].status || 'Pending';
            if (s === 'Pending') pending++;
            else if (s === 'Approved') approved++;
        }

        var statTotalAppointments = document.getElementById('statTotalAppointments');
        var statPendingAppointments = document.getElementById('statPendingAppointments');
        var statApprovedAppointments = document.getElementById('statApprovedAppointments');
        var statTotalDoctors = document.getElementById('statTotalDoctors');

        if (statTotalAppointments) statTotalAppointments.textContent = total;
        if (statPendingAppointments) statPendingAppointments.textContent = pending;
        if (statApprovedAppointments) statApprovedAppointments.textContent = approved;
        if (statTotalDoctors) statTotalDoctors.textContent = doctors.length;
    }

    // ==========================================
    // CHARTS & ANALYTICS RENDERING ENGINE
    // ==========================================

    function toggleTrend(view) {
        currentTrendView = view;
        document.getElementById('btnTrend7d').classList.toggle('active', view === '7days');
        document.getElementById('btnTrendMonth').classList.toggle('active', view === 'month');
        renderTrendChart();
    }

    function togglePie(view) {
        currentPieView = view;
        document.getElementById('btnPieStatus').classList.toggle('active', view === 'status');
        document.getElementById('btnPieDept').classList.toggle('active', view === 'department');
        var subtitle = document.getElementById('pieChartSubtitle');
        if (subtitle) {
            subtitle.textContent = (view === 'status')
                ? 'Live status distribution of appointments'
                : 'Consultation distribution by medical specialty';
        }
        renderPieChart();
    }

    function renderTrendChart() {
        var canvas = document.getElementById('trendChartCanvas');
        if (!canvas) return;
        var appts = getAppointments();

        var labels = [];
        var dataPoints = [];

        if (currentTrendView === '7days') {
            // Last 7 days labels & values
            var dayNames = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
            var counts = [0, 0, 0, 0, 0, 0, 0];
            var today = new Date();
            for (var d = 6; d >= 0; d--) {
                var pastDate = new Date();
                pastDate.setDate(today.getDate() - d);
                labels.push(dayNames[pastDate.getDay()] + ' ' + (pastDate.getMonth() + 1) + '/' + pastDate.getDate());
            }

            // Distribute appointments
            for (var i = 0; i < appts.length; i++) {
                var idx = (i * 3 + 2) % 7;
                counts[idx] = (counts[idx] || 0) + 1;
            }
            dataPoints = counts;
        } else {
            // 4 Weeks / Monthly Overview
            labels = ['Week 1', 'Week 2', 'Week 3', 'Week 4 (Current)'];
            dataPoints = [
                Math.max(1, Math.round(appts.length * 0.2)),
                Math.max(2, Math.round(appts.length * 0.3)),
                Math.max(1, Math.round(appts.length * 0.25)),
                Math.max(3, appts.length)
            ];
        }

        // Summary strip calculations
        var totalSum = 0;
        var peakVal = -1;
        var peakIdx = 0;
        for (var k = 0; k < dataPoints.length; k++) {
            totalSum += dataPoints[k];
            if (dataPoints[k] > peakVal) {
                peakVal = dataPoints[k];
                peakIdx = k;
            }
        }
        var avgDaily = (dataPoints.length > 0) ? (totalSum / dataPoints.length).toFixed(1) : 0;

        var elTotal = document.getElementById('trendTotalBookings');
        var elPeak = document.getElementById('trendPeakDay');
        var elAvg = document.getElementById('trendAvgDaily');
        if (elTotal) elTotal.textContent = totalSum;
        if (elPeak) elPeak.textContent = labels[peakIdx] || 'Today';
        if (elAvg) elAvg.textContent = avgDaily;

        if (typeof Chart !== 'undefined') {
            if (trendChartInstance) trendChartInstance.destroy();
            var ctx = canvas.getContext('2d');
            var gradient = ctx.createLinearGradient(0, 0, 0, 240);
            gradient.addColorStop(0, 'rgba(2, 132, 199, 0.35)');
            gradient.addColorStop(1, 'rgba(2, 132, 199, 0.01)');

            trendChartInstance = new Chart(ctx, {
                type: 'line',
                data: {
                    labels: labels,
                    datasets: [{
                        label: 'Consultation Bookings',
                        data: dataPoints,
                        borderColor: '#0284c7',
                        borderWidth: 3,
                        backgroundColor: gradient,
                        fill: true,
                        tension: 0.35,
                        pointBackgroundColor: '#0284c7',
                        pointBorderColor: '#ffffff',
                        pointBorderWidth: 2,
                        pointRadius: 4,
                        pointHoverRadius: 6
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: { display: false },
                        tooltip: {
                            backgroundColor: '#0f172a',
                            titleFont: { size: 12, weight: 'bold' },
                            bodyFont: { size: 12 },
                            padding: 10,
                            displayColors: false
                        }
                    },
                    scales: {
                        y: {
                            beginAtZero: true,
                            ticks: { precision: 0, font: { size: 11 }, color: '#64748b' },
                            grid: { color: '#f1f5f9' }
                        },
                        x: {
                            ticks: { font: { size: 11 }, color: '#64748b' },
                            grid: { display: false }
                        }
                    }
                }
            });
        } else {
            drawFallbackTrend(canvas, labels, dataPoints);
        }
    }

    function renderPieChart() {
        var canvas = document.getElementById('pieChartCanvas');
        if (!canvas) return;
        var appts = getAppointments();

        var labels = [];
        var dataPoints = [];
        var colors = [];

        if (currentPieView === 'status') {
            var counts = { 'Pending': 0, 'Approved': 0, 'Completed': 0, 'Cancelled': 0 };
            for (var i = 0; i < appts.length; i++) {
                var st = appts[i].status || 'Pending';
                if (counts[st] !== undefined) counts[st]++;
                else counts['Pending']++;
            }
            labels = ['Pending', 'Approved', 'Completed', 'Cancelled'];
            dataPoints = [counts['Pending'], counts['Approved'], counts['Completed'], counts['Cancelled']];
            colors = ['#f59e0b', '#10b981', '#0284c7', '#ef4444'];
        } else {
            var deptCounts = {};
            for (var j = 0; j < appts.length; j++) {
                var d = appts[j].department || 'General Medicine';
                deptCounts[d] = (deptCounts[d] || 0) + 1;
            }
            labels = Object.keys(deptCounts);
            if (labels.length === 0) {
                labels = ['Cardiology', 'Neurology', 'Pediatrics', 'Orthopedics'];
                dataPoints = [2, 2, 1, 1];
            } else {
                for (var k = 0; k < labels.length; k++) {
                    dataPoints.push(deptCounts[labels[k]]);
                }
            }
            var palette = ['#0284c7', '#8b5cf6', '#10b981', '#f59e0b', '#ec4899', '#06b6d4'];
            for (var c = 0; c < labels.length; c++) {
                colors.push(palette[c % palette.length]);
            }
        }

        renderPieLegend(labels, dataPoints, colors);

        if (typeof Chart !== 'undefined') {
            if (pieChartInstance) pieChartInstance.destroy();
            var ctx = canvas.getContext('2d');
            pieChartInstance = new Chart(ctx, {
                type: 'doughnut',
                data: {
                    labels: labels,
                    datasets: [{
                        data: dataPoints,
                        backgroundColor: colors,
                        borderColor: '#ffffff',
                        borderWidth: 2,
                        hoverOffset: 6
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    cutout: '68%',
                    plugins: {
                        legend: { display: false },
                        tooltip: {
                            backgroundColor: '#0f172a',
                            titleFont: { size: 12, weight: 'bold' },
                            bodyFont: { size: 12 },
                            padding: 10
                        }
                    }
                }
            });
        } else {
            drawFallbackPie(canvas, labels, dataPoints, colors);
        }
    }

    function renderPieLegend(labels, data, colors) {
        var container = document.getElementById('pieLegendContainer');
        if (!container) return;
        var total = 0;
        for (var i = 0; i < data.length; i++) total += data[i];

        var html = '';
        for (var j = 0; j < labels.length; j++) {
            var pct = total > 0 ? Math.round((data[j] / total) * 100) : 0;
            html += '<div class="legend-item">' +
                '<span class="legend-dot" style="background:' + colors[j] + '"></span>' +
                '<span>' + escapeHtml(labels[j]) + ':</span>' +
                '<span class="legend-count">' + data[j] + ' (' + pct + '%)</span>' +
                '</div>';
        }
        container.innerHTML = html;
    }

    function renderDeptBarChart() {
        var canvas = document.getElementById('deptBarChartCanvas');
        if (!canvas) return;
        var appts = getAppointments();
        var doctors = getDoctors();

        var departments = ['Cardiology', 'Neurology', 'Pediatrics', 'Orthopedics', 'Dermatology', 'General Medicine'];
        var apptCounts = [0, 0, 0, 0, 0, 0];
        var docCounts = [0, 0, 0, 0, 0, 0];

        for (var i = 0; i < appts.length; i++) {
            var dept = appts[i].department || 'General Medicine';
            var idx = departments.indexOf(dept);
            if (idx !== -1) apptCounts[idx]++;
            else apptCounts[5]++;
        }

        for (var j = 0; j < doctors.length; j++) {
            var docDept = doctors[j].dept || 'General Medicine';
            var dIdx = departments.indexOf(docDept);
            if (dIdx !== -1) docCounts[dIdx]++;
            else docCounts[5]++;
        }

        if (typeof Chart !== 'undefined') {
            if (deptBarChartInstance) deptBarChartInstance.destroy();
            var ctx = canvas.getContext('2d');
            deptBarChartInstance = new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: departments,
                    datasets: [
                        {
                            label: 'Appointments',
                            data: apptCounts,
                            backgroundColor: '#0284c7',
                            borderRadius: 6
                        },
                        {
                            label: 'Doctors on Duty',
                            data: docCounts,
                            backgroundColor: '#8b5cf6',
                            borderRadius: 6
                        }
                    ]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: { position: 'top', labels: { font: { size: 12, weight: 'bold' } } }
                    },
                    scales: {
                        y: { beginAtZero: true, ticks: { precision: 0, font: { size: 11 } } },
                        x: { ticks: { font: { size: 11 } } }
                    }
                }
            });
        } else {
            drawFallbackBar(canvas, departments, apptCounts);
        }
    }

    // High-DPI HTML5 Canvas Fallback for Offline Environments
    function drawFallbackTrend(canvas, labels, data) {
        var ctx = canvas.getContext('2d');
        var w = canvas.width = canvas.parentElement.clientWidth || 500;
        var h = canvas.height = 240;
        ctx.clearRect(0, 0, w, h);

        var max = Math.max.apply(null, data.concat([5]));
        var padL = 40, padR = 20, padT = 30, padB = 40;
        var plotW = w - padL - padR;
        var plotH = h - padT - padB;

        // Background Grid
        ctx.strokeStyle = '#f1f5f9';
        ctx.lineWidth = 1;
        for (var r = 0; r <= 4; r++) {
            var y = padT + (plotH / 4) * r;
            ctx.beginPath();
            ctx.moveTo(padL, y);
            ctx.lineTo(w - padR, y);
            ctx.stroke();
        }

        // Draw Line with Gradient
        ctx.beginPath();
        for (var i = 0; i < data.length; i++) {
            var x = padL + (plotW / (data.length - 1)) * i;
            var valY = padT + plotH - (data[i] / max) * plotH;
            if (i === 0) ctx.moveTo(x, valY);
            else ctx.lineTo(x, valY);
        }
        ctx.strokeStyle = '#0284c7';
        ctx.lineWidth = 3;
        ctx.stroke();

        // Points & Labels
        for (var j = 0; j < data.length; j++) {
            var px = padL + (plotW / (data.length - 1)) * j;
            var py = padT + plotH - (data[j] / max) * plotH;

            ctx.fillStyle = '#0284c7';
            ctx.beginPath();
            ctx.arc(px, py, 4, 0, Math.PI * 2);
            ctx.fill();

            ctx.fillStyle = '#64748b';
            ctx.font = '11px sans-serif';
            ctx.textAlign = 'center';
            ctx.fillText(labels[j], px, h - 15);

            ctx.fillStyle = '#0f172a';
            ctx.font = 'bold 11px sans-serif';
            ctx.fillText(data[j], px, py - 8);
        }
    }

    function drawFallbackPie(canvas, labels, data, colors) {
        var ctx = canvas.getContext('2d');
        var w = canvas.width = canvas.parentElement.clientWidth || 350;
        var h = canvas.height = 240;
        ctx.clearRect(0, 0, w, h);

        var total = 0;
        for (var i = 0; i < data.length; i++) total += data[i];
        if (total === 0) return;

        var cx = w / 2, cy = h / 2, r = Math.min(cx, cy) - 20;
        var startAngle = -Math.PI / 2;

        for (var j = 0; j < data.length; j++) {
            var sliceAngle = (data[j] / total) * (Math.PI * 2);
            ctx.beginPath();
            ctx.moveTo(cx, cy);
            ctx.arc(cx, cy, r, startAngle, startAngle + sliceAngle);
            ctx.closePath();
            ctx.fillStyle = colors[j];
            ctx.fill();
            startAngle += sliceAngle;
        }

        // Inner Doughnut Cutout
        ctx.beginPath();
        ctx.arc(cx, cy, r * 0.65, 0, Math.PI * 2);
        ctx.fillStyle = '#ffffff';
        ctx.fill();

        ctx.fillStyle = '#0f172a';
        ctx.font = 'bold 20px sans-serif';
        ctx.textAlign = 'center';
        ctx.textBaseline = 'middle';
        ctx.fillText(total, cx, cy - 6);
        ctx.font = '11px sans-serif';
        ctx.fillStyle = '#64748b';
        ctx.fillText('Visits', cx, cy + 12);
    }

    function drawFallbackBar(canvas, labels, data) {
        var ctx = canvas.getContext('2d');
        var w = canvas.width = canvas.parentElement.clientWidth || 500;
        var h = canvas.height = 240;
        ctx.clearRect(0, 0, w, h);

        var max = Math.max.apply(null, data.concat([4]));
        var padL = 40, padR = 20, padT = 30, padB = 40;
        var barW = (w - padL - padR) / (data.length * 1.5);

        for (var i = 0; i < data.length; i++) {
            var x = padL + i * ((w - padL - padR) / data.length) + 10;
            var barH = (data[i] / max) * (h - padT - padB);
            var y = h - padB - barH;

            ctx.fillStyle = '#0284c7';
            ctx.fillRect(x, y, barW, barH);

            ctx.fillStyle = '#64748b';
            ctx.font = '10px sans-serif';
            ctx.textAlign = 'center';
            ctx.fillText(labels[i].slice(0, 4), x + barW / 2, h - 20);

            ctx.fillStyle = '#0f172a';
            ctx.font = 'bold 11px sans-serif';
            ctx.fillText(data[i], x + barW / 2, y - 5);
        }
    }

    function updateAllVisuals() {
        renderMetrics();
        renderTrendChart();
        renderPieChart();
        renderDeptBarChart();
        renderOverviewTable();
        renderAppointmentsTable();
    }

    // ==========================================
    // APPOINTMENTS & TABLES RENDERING
    // ==========================================

    function renderOverviewTable() {
        var appts = getAppointments();
        var tbody = document.getElementById('overviewAppointmentTableBody');
        if (!tbody) return;

        var recent = appts.slice(0, 5);
        if (recent.length === 0) {
            tbody.innerHTML = '<tr><td colspan="6" class="empty-row">No appointments recorded yet.</td></tr>';
            return;
        }

        var html = '';
        for (var i = 0; i < recent.length; i++) {
            var a = recent[i];
            var st = a.status || 'Pending';
            var badgeClass = (st === 'Approved') ? 'badge-approved'
                           : (st === 'Completed') ? 'badge-completed'
                           : (st === 'Cancelled') ? 'badge-cancelled' : 'badge-pending';

            var actionButtons = '';
            if (st === 'Pending') {
                actionButtons += '<button type="button" class="btn-act btn-act-approve" onclick="updateAppointmentStatus(' + i + ', \'Approved\')">Approve</button> ';
                actionButtons += '<button type="button" class="btn-act btn-act-cancel" onclick="updateAppointmentStatus(' + i + ', \'Cancelled\')">Cancel</button>';
            } else if (st === 'Approved') {
                actionButtons += '<button type="button" class="btn-act btn-act-complete" onclick="updateAppointmentStatus(' + i + ', \'Completed\')">Done</button>';
            } else {
                actionButtons += '<span style="color:#94a3b8; font-size:12px;">Archived</span>';
            }

            html += '<tr>' +
                '<td><strong>' + escapeHtml(a.patient) + '</strong><br><small style="color:#64748b;">' + escapeHtml(a.phone || a.email || '') + '</small></td>' +
                '<td>' + escapeHtml(a.doctor) + '<br><small style="color:#0284c7; font-weight:600;">' + escapeHtml(a.department || 'General') + '</small></td>' +
                '<td>' + escapeHtml(a.date) + '<br><small style="color:#64748b;">' + escapeHtml(a.time) + '</small></td>' +
                '<td>' + escapeHtml(a.reason || 'General consultation') + '</td>' +
                '<td><span class="badge ' + badgeClass + '">' + escapeHtml(st) + '</span></td>' +
                '<td><div class="action-btns">' + actionButtons + '</div></td>' +
                '</tr>';
        }
        tbody.innerHTML = html;
    }

    function renderAppointmentsTable() {
        var appts = getAppointments();
        var tbody = document.getElementById('appointmentTableBody');
        if (!tbody) return;

        var searchVal = (document.getElementById('appointmentSearch') ? document.getElementById('appointmentSearch').value : '').toLowerCase().trim();

        var filtered = [];
        for (var i = 0; i < appts.length; i++) {
            var item = appts[i];
            var status = item.status || 'Pending';

            if (currentFilter !== 'all' && status !== currentFilter) continue;

            if (searchVal) {
                var p = (item.patient || '').toLowerCase();
                var d = (item.doctor || '').toLowerCase();
                var dept = (item.department || '').toLowerCase();
                if (p.indexOf(searchVal) === -1 && d.indexOf(searchVal) === -1 && dept.indexOf(searchVal) === -1) {
                    continue;
                }
            }

            filtered.push({ index: i, data: item });
        }

        if (filtered.length === 0) {
            tbody.innerHTML = '<tr><td colspan="6" class="empty-row">No appointments match the criteria. New bookings will appear here.</td></tr>';
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

            var actionButtons = '';
            if (st === 'Pending') {
                actionButtons += '<button type="button" class="btn-act btn-act-approve" onclick="updateAppointmentStatus(' + idx + ', \'Approved\')">Approve</button> ';
                actionButtons += '<button type="button" class="btn-act btn-act-cancel" onclick="updateAppointmentStatus(' + idx + ', \'Cancelled\')">Cancel</button> ';
            } else if (st === 'Approved') {
                actionButtons += '<button type="button" class="btn-act btn-act-complete" onclick="updateAppointmentStatus(' + idx + ', \'Completed\')">Mark Done</button> ';
                actionButtons += '<button type="button" class="btn-act btn-act-cancel" onclick="updateAppointmentStatus(' + idx + ', \'Cancelled\')">Cancel</button> ';
            } else {
                actionButtons += '<span style="color:#94a3b8; font-size:12px;">Archived</span> ';
            }
            actionButtons += '<button type="button" class="btn-act btn-act-delete" title="Delete record" onclick="deleteAppointment(' + idx + ')">🗑</button>';

            html += '<tr>' +
                '<td><strong>' + escapeHtml(a.patient) + '</strong><br><small style="color:#64748b;">' + escapeHtml(a.phone || a.email || '') + '</small></td>' +
                '<td>' + escapeHtml(a.doctor) + '<br><small style="color:#0284c7; font-weight:600;">' + escapeHtml(a.department || 'General') + '</small></td>' +
                '<td>' + escapeHtml(a.date) + '<br><small style="color:#64748b;">' + escapeHtml(a.time) + '</small></td>' +
                '<td>' + escapeHtml(a.reason || 'General consultation') + '</td>' +
                '<td><span class="badge ' + badgeClass + '">' + escapeHtml(st) + '</span></td>' +
                '<td><div class="action-btns">' + actionButtons + '</div></td>' +
                '</tr>';
        }

        tbody.innerHTML = html;
    }

    function updateAppointmentStatus(index, newStatus) {
        var appts = getAppointments();
        if (!appts[index]) return;
        appts[index].status = newStatus;
        saveAppointments(appts);
        updateAllVisuals();
        showToast('Appointment ' + newStatus.toLowerCase() + ' successfully.');
    }

    function deleteAppointment(index) {
        if (!confirm('Are you sure you want to remove this appointment record?')) return;
        var appts = getAppointments();
        if (!appts[index]) return;
        appts.splice(index, 1);
        saveAppointments(appts);
        updateAllVisuals();
        showToast('Appointment record removed.');
    }

    function filterAppointments(status, btn) {
        currentFilter = status;
        var btns = document.querySelectorAll('.filter-btn');
        for (var i = 0; i < btns.length; i++) {
            btns[i].classList.remove('active');
        }
        if (btn) btn.classList.add('active');
        renderAppointmentsTable();
    }

    function handleSearch() {
        renderAppointmentsTable();
    }

    // Doctors Directory Logic
    function renderDoctorsTable() {
        var doctors = getDoctors();
        var tbody = document.getElementById('doctorsTableBody');
        if (!tbody) return;

        var html = '';
        for (var i = 0; i < doctors.length; i++) {
            var d = doctors[i];
            html += '<tr>' +
                '<td><strong>' + escapeHtml(d.name) + '</strong></td>' +
                '<td><span class="badge badge-completed">' + escapeHtml(d.dept) + '</span></td>' +
                '<td>' + escapeHtml(d.schedule) + '</td>' +
                '<td><span class="badge badge-approved">' + escapeHtml(d.status || 'Active') + '</span></td>' +
                '</tr>';
        }
        tbody.innerHTML = html;
    }

    function openAddDoctorModal() {
        var modal = document.getElementById('addDoctorModal');
        if (modal) modal.classList.add('active');
    }

    function closeAddDoctorModal() {
        var modal = document.getElementById('addDoctorModal');
        if (modal) modal.classList.remove('active');
        var form = document.getElementById('addDoctorForm');
        if (form) form.reset();
    }

    function saveNewDoctor(e) {
        e.preventDefault();
        var name = document.getElementById('newDocName').value.trim();
        var dept = document.getElementById('newDocDept').value;
        var sched = document.getElementById('newDocSchedule').value.trim();

        if (!name || !dept || !sched) return;

        var doctors = getDoctors();
        doctors.push({ name: name, dept: dept, schedule: sched, status: 'Available' });
        saveDoctors(doctors);

        closeAddDoctorModal();
        updateAllVisuals();
        renderDoctorsTable();
        showToast('Dr. ' + name + ' added to hospital directory.');
    }

    // Patients Directory Logic
    function renderPatientsTable() {
        var tbody = document.getElementById('patientsTableBody');
        if (!tbody) return;

        var patients = [
            { name: "Demo Patient", email: "patient@smartcare.test", role: "PATIENT", status: "Active" }
        ];

        try {
            var storedUsers = JSON.parse(localStorage.getItem('smartcareUsers') || '[]');
            for (var i = 0; i < storedUsers.length; i++) {
                var u = storedUsers[i];
                if (u && (u.role === 'PATIENT' || !u.role)) {
                    patients.push({ name: u.name, email: u.email, role: 'PATIENT', status: 'Registered' });
                }
            }
        } catch (e) {}

        var html = '';
        for (var j = 0; j < patients.length; j++) {
            var p = patients[j];
            html += '<tr>' +
                '<td><strong>' + escapeHtml(p.name) + '</strong></td>' +
                '<td>' + escapeHtml(p.email) + '</td>' +
                '<td><span class="badge badge-approved">' + escapeHtml(p.role) + '</span></td>' +
                '<td><span class="badge badge-completed">' + escapeHtml(p.status) + '</span></td>' +
                '</tr>';
        }
        tbody.innerHTML = html;
    }

    // Tab Switcher
    function switchTab(tabName) {
        var tabOverview = document.getElementById('tabOverview');
        var tabAppts = document.getElementById('tabAppointments');
        var tabReports = document.getElementById('tabReports');
        var tabDocs = document.getElementById('tabDoctors');
        var tabPts = document.getElementById('tabPatients');

        var items = document.querySelectorAll('.sub-nav-item');
        for (var i = 0; i < items.length; i++) {
            items[i].classList.remove('active');
        }

        if (tabOverview) tabOverview.style.display = (tabName === 'overview') ? 'block' : 'none';
        if (tabAppts) tabAppts.style.display = (tabName === 'appointments') ? 'block' : 'none';
        if (tabReports) tabReports.style.display = (tabName === 'reports') ? 'block' : 'none';
        if (tabDocs) tabDocs.style.display = (tabName === 'doctors') ? 'block' : 'none';
        if (tabPts) tabPts.style.display = (tabName === 'patients') ? 'block' : 'none';

        if (tabName === 'overview') {
            if (items[0]) items[0].classList.add('active');
            renderTrendChart();
            renderPieChart();
            renderOverviewTable();
        } else if (tabName === 'appointments') {
            if (items[1]) items[1].classList.add('active');
            renderAppointmentsTable();
        } else if (tabName === 'reports') {
            if (items[2]) items[2].classList.add('active');
            renderDeptBarChart();
        } else if (tabName === 'doctors') {
            if (items[3]) items[3].classList.add('active');
            renderDoctorsTable();
        } else if (tabName === 'patients') {
            if (items[4]) items[4].classList.add('active');
            renderPatientsTable();
        }
    }

    function logout() {
        try {
            sessionStorage.removeItem('smartcareCurrentUser');
        } catch (e) {}
        window.location.href = 'index.jsp';
    }

    // Window resize handler for responsive charts
    window.addEventListener('resize', function() {
        if (document.getElementById('tabOverview').style.display !== 'none') {
            renderTrendChart();
            renderPieChart();
        }
    });

    // Initialize Dashboard
    initUser();
    updateAllVisuals();
</script>

</body>
</html>
