<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login | SmartCare</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body {
            font-family: Arial, sans-serif; min-height: 100vh;
            display: flex; justify-content: center; align-items: center;
            padding: 25px;
            background: linear-gradient(135deg, #dbeafe, #f8fafc 55%, #ccfbf1);
            color: #0f172a;
        }
        a { text-decoration: none; }
        .brand { position: absolute; top: 28px; left: 7%; font-size: 25px; font-weight: 800; color: #2563eb; }
        .brand span { color: #0d9488; }
        .login-card {
            width: 100%; max-width: 440px; padding: 35px;
            border-radius: 20px; background: white;
            border: 1px solid #e2e8f0; box-shadow: 0 18px 50px #0f172a12;
            position: relative;
        }
        .header-top {
            display: flex; justify-content: space-between; align-items: center; margin-bottom: 18px;
        }
        .icon {
            width: 48px; height: 48px; display: grid; place-items: center;
            border-radius: 14px; background: #dbeafe; color: #2563eb;
            font-size: 24px;
        }
        .active-role-container {
            display: flex; align-items: center; gap: 8px;
        }
        .role-pill {
            display: inline-flex; align-items: center; gap: 6px;
            padding: 6px 12px; border-radius: 20px; font-size: 12px;
            font-weight: 700; background: #eff6ff; color: #1e40af;
            border: 1px solid #bfdbfe;
        }
        .btn-change-role {
            background: none; border: 1px solid #cbd5e1; border-radius: 14px;
            padding: 5px 10px; font-size: 11px; font-weight: 700;
            color: #64748b; cursor: pointer; transition: .2s;
        }
        .btn-change-role:hover {
            border-color: #2563eb; color: #2563eb; background: #eff6ff;
        }
        h1 { font-size: 27px; margin-bottom: 6px; letter-spacing: -0.5px; }
        .subtitle { color: #64748b; font-size: 14px; margin-bottom: 22px; }
        label { display: block; font-size: 13px; font-weight: 700; margin-bottom: 16px; }
        input {
            display: block; width: 100%; margin-top: 7px; padding: 12px 14px;
            border: 1px solid #cbd5e1; border-radius: 9px; outline: none;
            font-size: 14px;
        }
        input:focus { border-color: #2563eb; box-shadow: 0 0 0 3px #2563eb18; }
        .btn {
            display: block; width: 100%; border: 0; border-radius: 9px;
            padding: 13px; background: #2563eb; color: white;
            font-weight: 700; font-size: 14px; cursor: pointer;
            transition: .2s;
        }
        .btn:hover { background: #1d4ed8; }
        .message { margin: 15px 0; padding: 12px; border-radius: 8px; font-size: 13px; display: none; }
        .error { display: block; background: #fef2f2; color: #b91c1c; border: 1px solid #fecaca; }
        .success { display: block; background: #ecfdf5; color: #047857; border: 1px solid #a7f3d0; }
        .demo {
            margin-top: 20px; padding: 14px; border-radius: 10px;
            background: #eff6ff; color: #1e40af; font-size: 12.5px; line-height: 1.7;
            border: 1px solid #dbeafe;
        }
        .demo-top {
            display: flex; justify-content: space-between; align-items: center; margin-bottom: 6px;
        }
        .btn-autofill {
            background: #2563eb; color: white; border: none; border-radius: 6px;
            padding: 4px 10px; font-size: 11px; font-weight: 700; cursor: pointer;
        }
        .btn-autofill:hover { background: #1d4ed8; }
        .bottom { text-align: center; font-size: 13px; margin-top: 22px; color: #64748b; }
        .bottom a, .back { color: #2563eb; font-weight: 700; cursor: pointer; }
        .back { display: block; text-align: center; margin-top: 17px; font-size: 13px; }

        /* Role Selection Modal Styles */
        .role-modal-overlay {
            position: fixed; top: 0; left: 0; right: 0; bottom: 0;
            background: rgba(15, 23, 42, 0.65);
            backdrop-filter: blur(5px);
            -webkit-backdrop-filter: blur(5px);
            display: none; place-items: center;
            z-index: 9999; padding: 20px;
            opacity: 0; transition: opacity 0.2s ease;
        }
        .role-modal-overlay.active { display: grid; opacity: 1; }
        .role-modal {
            background: #ffffff; width: 100%; max-width: 500px;
            border-radius: 20px; padding: 32px 28px;
            box-shadow: 0 25px 60px -15px rgba(15, 23, 42, 0.35);
            position: relative;
            transform: scale(0.95) translateY(10px);
            transition: transform 0.25s cubic-bezier(0.16, 1, 0.3, 1);
        }
        .role-modal-overlay.active .role-modal { transform: scale(1) translateY(0); }
        .role-modal-close {
            position: absolute; top: 18px; right: 18px;
            width: 34px; height: 34px; border-radius: 50%;
            border: none; background: #f1f5f9; color: #64748b;
            font-size: 22px; display: grid; place-items: center;
            cursor: pointer; line-height: 1; transition: .2s;
        }
        .role-modal-close:hover { background: #fee2e2; color: #dc2626; }
        .role-badge {
            display: inline-block; padding: 4px 12px; border-radius: 20px;
            font-size: 11px; font-weight: 800; letter-spacing: 1.5px;
            text-transform: uppercase; background: #dbeafe; color: #2563eb;
            margin-bottom: 8px;
        }
        .role-modal-header h2 { font-size: 24px; color: #0f172a; margin: 4px 0 6px; }
        .role-modal-header p { color: #64748b; font-size: 13.5px; margin-bottom: 22px; }
        .role-cards-grid { display: flex; flex-direction: column; gap: 12px; }
        .role-card-btn {
            display: flex; align-items: center; gap: 16px;
            padding: 15px 18px; border: 2px solid #e2e8f0;
            border-radius: 14px; background: #ffffff; cursor: pointer;
            text-align: left; transition: all .2s ease; width: 100%;
            font-family: inherit;
        }
        .role-card-btn:hover {
            border-color: #2563eb; background: #f8fafc;
            transform: translateY(-2px);
            box-shadow: 0 10px 24px -5px rgba(37, 99, 235, 0.15);
        }
        .role-num {
            width: 28px; height: 28px; border-radius: 50%;
            background: #f1f5f9; color: #2563eb; font-size: 13px;
            font-weight: 800; display: grid; place-items: center;
            flex-shrink: 0; transition: .2s;
        }
        .role-card-btn:hover .role-num { background: #2563eb; color: #ffffff; }
        .role-icon { font-size: 28px; line-height: 1; flex-shrink: 0; }
        .role-info { flex: 1; min-width: 0; }
        .role-name { font-size: 16px; font-weight: 700; color: #0f172a; margin-bottom: 2px; }
        .role-desc { font-size: 12px; color: #64748b; line-height: 1.4; }
        .role-arrow { font-size: 18px; font-weight: 700; color: #94a3b8; transition: .2s; }
        .role-card-btn:hover .role-arrow { color: #2563eb; transform: translateX(4px); }
        .role-modal-footer {
            margin-top: 20px; padding-top: 15px; border-top: 1px solid #e2e8f0;
            text-align: center; font-size: 13px; color: #64748b;
        }
        .role-modal-footer a { color: #2563eb; font-weight: 700; margin-left: 5px; }
        .role-modal-footer a:hover { text-decoration: underline; }

        @media(max-width: 480px) {
            body { padding: 18px; }
            .brand { top: 18px; left: 20px; font-size: 22px; }
            .login-card { padding: 25px 20px; margin-top: 55px; }
        }
    </style>
</head>
<body>

<a class="brand" href="index.jsp">✚ Smart<span>Care</span></a>

<main class="login-card">
    <div class="header-top">
        <div class="icon" id="mainIcon">👤</div>
        <div class="active-role-container">
            <div class="role-pill">
                <span id="roleBadgeIcon">👤</span>
                <span id="roleBadgeText">Role: <strong>Patient</strong></span>
            </div>
            <button type="button" class="btn-change-role" onclick="openRoleModal('login')">Change</button>
        </div>
    </div>

    <h1 id="loginHeading">Welcome back!</h1>
    <p class="subtitle" id="loginSub">Sign in to your SmartCare account.</p>

    <%
        String serverError = (String) request.getAttribute("error");
        String requiredParam = request.getParameter("required");
        String registeredParam = request.getParameter("registered");
    %>
    <% if (serverError != null && serverError.trim().length() > 0) { %>
        <div class="message error" style="display:block;"><%= serverError %></div>
    <% } %>

    <% if ("1".equals(requiredParam)) { %>
        <div class="message error" style="display:block;">Please login to access this portal page.</div>
    <% } %>

    <% if ("1".equals(registeredParam)) { %>
        <div class="message success" style="display:block;">Registration completed! Please sign in below.</div>
    <% } %>

    <div id="message" class="message" role="status" aria-live="polite"></div>

    <form id="loginForm" method="post" action="login">
        <input type="hidden" name="role" id="formRole" value="PATIENT">

        <label for="email">Email address
            <input type="email" id="email" name="email" placeholder="you@example.com"
                   required autocomplete="email">
        </label>

        <label for="password">Password
            <input type="password" id="password" name="password" placeholder="Enter your password"
                   required autocomplete="current-password">
        </label>

        <button type="submit" class="btn" id="loginBtn">Login securely →</button>
    </form>

    <div class="demo" id="demoBox">
        <div class="demo-top">
            <strong id="demoTitle">Demo patient login</strong>
            <button type="button" class="btn-autofill" onclick="autoFillDemo()">⚡ Quick fill</button>
        </div>
        <span id="demoEmail">Email: patient@smartcare.test</span><br>
        <span id="demoPassword">Password: Patient123!</span>
    </div>

    <p class="bottom">
        New to SmartCare?
        <a href="javascript:void(0)" onclick="openRoleModal('register')">Create an account</a>
    </p>
    <a class="back" href="index.jsp">← Back to homepage</a>
</main>

<!-- Role Selection Popup Modal -->
<div id="roleModalOverlay" class="role-modal-overlay" aria-hidden="true" onclick="handleBackdropClick(event)">
    <div class="role-modal" role="dialog" aria-modal="true" aria-labelledby="roleModalTitle">
        <button type="button" class="role-modal-close" onclick="closeRoleModal()" aria-label="Close modal">&times;</button>
        
        <div class="role-modal-header">
            <span class="role-badge" id="roleModalBadge">Account Login</span>
            <h2 id="roleModalTitle">Choose Your Role to Login</h2>
            <p id="roleModalSubtitle">Select your role to access your SmartCare dashboard:</p>
        </div>

        <div class="role-cards-grid">
            <!-- 1. Admin -->
            <button type="button" class="role-card-btn" onclick="selectRole('admin')">
                <span class="role-num">1</span>
                <span class="role-icon">🛡️</span>
                <div class="role-info">
                    <div class="role-name">Admin</div>
                    <div class="role-desc">Hospital administration, doctors, appointments &amp; analytics</div>
                </div>
                <span class="role-arrow">→</span>
            </button>

            <!-- 2. Doctor -->
            <button type="button" class="role-card-btn" onclick="selectRole('doctor')">
                <span class="role-num">2</span>
                <span class="role-icon">👨‍⚕️</span>
                <div class="role-info">
                    <div class="role-name">Doctor</div>
                    <div class="role-desc">Consultation schedule, patient history &amp; treatment records</div>
                </div>
                <span class="role-arrow">→</span>
            </button>

            <!-- 3. Patient -->
            <button type="button" class="role-card-btn" onclick="selectRole('patient')">
                <span class="role-num">3</span>
                <span class="role-icon">👤</span>
                <div class="role-info">
                    <div class="role-name">Patient</div>
                    <div class="role-desc">Book appointments, medical history &amp; consultation status</div>
                </div>
                <span class="role-arrow">→</span>
            </button>
        </div>

        <div class="role-modal-footer">
            <span id="roleModalFooterText">Need a new account?</span>
            <a href="javascript:void(0)" id="roleModalSwitchAction" onclick="switchModalMode()">Register here</a>
        </div>
    </div>
</div>

<script>
    var roleConfig = {
        admin: {
            name: 'Admin',
            code: 'ADMIN',
            icon: '🛡️',
            title: 'Admin Login',
            subtitle: 'Sign in to the SmartCare Admin Portal.',
            demoEmail: 'admin@smartcare.test',
            demoPass: 'Admin123!',
            demoTitle: 'Demo Admin credentials',
            dashboard: 'admin/dashboard'
        },
        doctor: {
            name: 'Doctor',
            code: 'DOCTOR',
            icon: '👨‍⚕️',
            title: 'Doctor Login',
            subtitle: 'Sign in to the SmartCare Doctor Portal.',
            demoEmail: 'doctor@smartcare.test',
            demoPass: 'Doctor123!',
            demoTitle: 'Demo Doctor credentials',
            dashboard: 'doctor/dashboard'
        },
        patient: {
            name: 'Patient',
            code: 'PATIENT',
            icon: '👤',
            title: 'Patient Login',
            subtitle: 'Sign in to book and manage appointments.',
            demoEmail: 'patient@smartcare.test',
            demoPass: 'Patient123!',
            demoTitle: 'Demo Patient credentials',
            dashboard: 'patient/dashboard'
        }
    };

    var activeRoleKey = 'patient';

    function initRoleFromUrl() {
        var roleParam = '';
        try {
            var urlParams = new URLSearchParams(window.location.search);
            roleParam = (urlParams.get('role') || '').toLowerCase();
        } catch (e) {
            roleParam = '';
        }

        if (roleConfig[roleParam]) {
            applyRole(roleParam);
        } else {
            // Default to patient without opening popup modal automatically
            applyRole('patient');
        }
    }

    function applyRole(roleKey) {
        activeRoleKey = roleKey;
        var config = roleConfig[roleKey] || roleConfig.patient;

        var formRole = document.getElementById('formRole');
        if (formRole) formRole.value = config.code;

        var roleBadgeIcon = document.getElementById('roleBadgeIcon');
        if (roleBadgeIcon) roleBadgeIcon.textContent = config.icon;

        var mainIcon = document.getElementById('mainIcon');
        if (mainIcon) mainIcon.textContent = config.icon;

        var roleBadgeText = document.getElementById('roleBadgeText');
        if (roleBadgeText) roleBadgeText.innerHTML = 'Role: <strong>' + config.name + '</strong>';

        var loginHeading = document.getElementById('loginHeading');
        if (loginHeading) loginHeading.textContent = config.title;

        var loginSub = document.getElementById('loginSub');
        if (loginSub) loginSub.textContent = config.subtitle;

        var demoTitle = document.getElementById('demoTitle');
        if (demoTitle) demoTitle.textContent = config.demoTitle;

        var demoEmail = document.getElementById('demoEmail');
        if (demoEmail) demoEmail.textContent = 'Email: ' + config.demoEmail;

        var demoPassword = document.getElementById('demoPassword');
        if (demoPassword) demoPassword.textContent = 'Password: ' + config.demoPass;
    }

    function autoFillDemo() {
        var config = roleConfig[activeRoleKey] || roleConfig.patient;
        var emailInput = document.getElementById('email');
        var passwordInput = document.getElementById('password');
        if (emailInput) emailInput.value = config.demoEmail;
        if (passwordInput) passwordInput.value = config.demoPass;
    }

    // Role Selection Modal Logic
    var currentModalMode = 'login';

    function openRoleModal(mode) {
        currentModalMode = (mode === 'register') ? 'register' : 'login';
        var overlay = document.getElementById('roleModalOverlay');
        if (!overlay) return;

        var title = document.getElementById('roleModalTitle');
        var subtitle = document.getElementById('roleModalSubtitle');
        var badge = document.getElementById('roleModalBadge');
        var footerText = document.getElementById('roleModalFooterText');
        var switchAction = document.getElementById('roleModalSwitchAction');

        if (currentModalMode === 'login') {
            if (badge) badge.textContent = 'Account Login';
            if (title) title.textContent = 'Choose Your Role to Login';
            if (subtitle) subtitle.textContent = 'Select your role to access your SmartCare dashboard:';
            if (footerText) footerText.textContent = 'Need a new account?';
            if (switchAction) switchAction.textContent = 'Register here';
        } else {
            if (badge) badge.textContent = 'Account Registration';
            if (title) title.textContent = 'Choose Your Role to Register';
            if (subtitle) subtitle.textContent = 'Select the account type you would like to create:';
            if (footerText) footerText.textContent = 'Already have an account?';
            if (switchAction) switchAction.textContent = 'Login here';
        }

        overlay.classList.add('active');
        overlay.setAttribute('aria-hidden', 'false');
        document.body.style.overflow = 'hidden';
    }

    function closeRoleModal() {
        var overlay = document.getElementById('roleModalOverlay');
        if (overlay) {
            overlay.classList.remove('active');
            overlay.setAttribute('aria-hidden', 'true');
            document.body.style.overflow = '';
        }
    }

    function handleBackdropClick(event) {
        if (event.target && event.target.id === 'roleModalOverlay') {
            closeRoleModal();
        }
    }

    function switchModalMode() {
        openRoleModal(currentModalMode === 'login' ? 'register' : 'login');
    }

    function selectRole(role) {
        closeRoleModal();
        if (currentModalMode === 'register') {
            window.location.href = 'register.jsp?role=' + encodeURIComponent(role);
        } else {
            try {
                if (window.location.protocol.indexOf('http') === 0) {
                    var newUrl = window.location.pathname + '?role=' + encodeURIComponent(role);
                    window.history.replaceState({ role: role }, '', newUrl);
                }
            } catch (err) {}
            applyRole(role);
        }
    }

    document.addEventListener('keydown', function(e) {
        var overlay = document.getElementById('roleModalOverlay');
        if (overlay && overlay.classList.contains('active')) {
            if (e.key === 'Escape') {
                closeRoleModal();
            } else if (e.key === '1') {
                selectRole('admin');
            } else if (e.key === '2') {
                selectRole('doctor');
            } else if (e.key === '3') {
                selectRole('patient');
            }
        }
    });

    // Form submission & authentication
    var loginForm = document.getElementById('loginForm');
    var message = document.getElementById('message');

    function showMessage(text, type) {
        if (!message) return;
        message.textContent = text;
        message.className = 'message ' + type;
        message.style.display = 'block';
    }

    if (loginForm) {
        loginForm.addEventListener('submit', function(event) {
            event.preventDefault();

            var emailInput = document.getElementById('email');
            var passInput = document.getElementById('password');
            var email = emailInput ? emailInput.value.trim().toLowerCase() : '';
            var password = passInput ? passInput.value : '';

            if (!email || !password) {
                showMessage('Please enter your email and password.', 'error');
                return;
            }

            // Valid demo seeds (supports both 123! and @123, plus .test and .com)
            var seeds = {
                'admin@smartcare.test': { name: 'SmartCare Administrator', role: 'ADMIN', passes: ['Admin123!', 'Admin@123'] },
                'admin@smartcare.com': { name: 'SmartCare Administrator', role: 'ADMIN', passes: ['Admin123!', 'Admin@123'] },
                'doctor@smartcare.test': { name: 'Dr. Priya Sharma', role: 'DOCTOR', passes: ['Doctor123!', 'Doctor@123'] },
                'doctor@smartcare.com': { name: 'Dr. Priya Sharma', role: 'DOCTOR', passes: ['Doctor123!', 'Doctor@123'] },
                'patient@smartcare.test': { name: 'Demo Patient', role: 'PATIENT', passes: ['Patient123!', 'Patient@123'] },
                'patient@smartcare.com': { name: 'Demo Patient', role: 'PATIENT', passes: ['Patient123!', 'Patient@123'] }
            };

            var user = null;
            if (seeds[email] && (seeds[email].passes.indexOf(password) !== -1)) {
                user = { name: seeds[email].name, email: email, role: seeds[email].role };
            } else {
                try {
                    var registeredUsers = JSON.parse(localStorage.getItem('smartcareUsers') || '[]');
                    for (var i = 0; i < registeredUsers.length; i++) {
                        var u = registeredUsers[i];
                        if (u && u.email && u.email.toLowerCase() === email && u.password === password) {
                            user = u;
                            break;
                        }
                    }
                } catch (err) {
                    user = null;
                }
            }

            if (!user) {
                showMessage('Invalid email or password. Please try again.', 'error');
                return;
            }

            // Save user session
            try {
                sessionStorage.setItem('smartcareCurrentUser', JSON.stringify({
                    name: user.name,
                    email: user.email,
                    role: user.role
                }));
            } catch (err) {}

            showMessage('Login successful! Welcome, ' + user.name + '. Redirecting...', 'success');

            // If running on Tomcat server (HTTP with context path), submit to LoginServlet
            // so server-side session (HttpSession) is set for AuthenticationFilter and DashboardServlet
            var isTomcat = (window.location.protocol.indexOf('http') === 0 && window.location.pathname.indexOf('/SmartCare') !== -1);
            if (isTomcat) {
                setTimeout(function() {
                    loginForm.submit();
                }, 600);
            } else {
                // Standalone / client preview mode redirect
                var targetPath = (user.role === 'ADMIN') ? 'admin/dashboard'
                               : (user.role === 'DOCTOR') ? 'doctor/dashboard'
                               : 'patient/dashboard';
                setTimeout(function() {
                    window.location.href = targetPath;
                }, 600);
            }
        });
    }

    // Initialize on load
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', initRoleFromUrl);
    } else {
        initRoleFromUrl();
    }
</script>

</body>
</html>
