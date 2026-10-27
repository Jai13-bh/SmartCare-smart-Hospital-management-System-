<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register | SmartCare</title>
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
        .brand {
            position: absolute; top: 25px; left: 7%;
            font-size: 25px; font-weight: 800; color: #2563eb;
        }
        .brand span { color: #0d9488; }
        .register-card {
            width: 100%; max-width: 480px; padding: 32px;
            background: white; border: 1px solid #e2e8f0;
            border-radius: 20px; box-shadow: 0 18px 50px #0f172a12;
            position: relative;
        }
        .header-top {
            display: flex; justify-content: space-between; align-items: center; margin-bottom: 16px;
        }
        .icon {
            width: 46px; height: 46px; display: grid; place-items: center;
            background: #dbeafe; color: #2563eb; border-radius: 13px;
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
        .subtitle { color: #64748b; font-size: 13.5px; margin-bottom: 22px; }
        label { display: block; font-size: 12px; font-weight: 700; margin-bottom: 14px; }
        input {
            display: block; width: 100%; margin-top: 7px; padding: 12px;
            border: 1px solid #cbd5e1; border-radius: 9px; outline: none;
            font-size: 14px;
        }
        input:focus { border-color: #2563eb; box-shadow: 0 0 0 3px #2563eb18; }
        .btn {
            display: block; width: 100%; border: 0; border-radius: 9px;
            padding: 13px; background: #2563eb; color: white;
            font-size: 14px; font-weight: 700; cursor: pointer; margin-top: 6px;
            transition: .2s;
        }
        .btn:hover { background: #1d4ed8; }
        .message { margin-bottom: 15px; padding: 12px; border-radius: 8px; font-size: 13px; display: none; }
        .error { display: block; background: #fef2f2; color: #b91c1c; border: 1px solid #fecaca; }
        .success { display: block; background: #ecfdf5; color: #047857; border: 1px solid #a7f3d0; }
        .bottom { text-align: center; font-size: 13px; color: #64748b; margin-top: 20px; }
        .bottom a, .back { color: #2563eb; font-weight: 700; cursor: pointer; }
        .back { display: block; text-align: center; font-size: 13px; margin-top: 15px; }
        .note { font-size: 11px; color: #64748b; margin-top: 14px; line-height: 1.5; }

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
            .brand { top: 16px; left: 20px; font-size: 22px; }
            .register-card { padding: 24px 19px; margin-top: 55px; }
        }
    </style>
</head>
<body>

<a class="brand" href="index.jsp">✚ Smart<span>Care</span></a>

<main class="register-card">
    <div class="header-top">
        <div class="icon" id="mainIcon">👤</div>
        <div class="active-role-container">
            <div class="role-pill">
                <span id="roleBadgeIcon">👤</span>
                <span id="roleBadgeText">Role: <strong>Patient</strong></span>
            </div>
            <button type="button" class="btn-change-role" onclick="openRoleModal('register')">Change</button>
        </div>
    </div>

    <h1 id="registerHeading">Create your account</h1>
    <p class="subtitle" id="registerSub">Register to get started with SmartCare.</p>

    <%
        String errorMessage = (String) request.getAttribute("errorMessage");
    %>
    <% if (errorMessage != null && errorMessage.trim().length() > 0) { %>
        <div class="message error" style="display:block;"><%= errorMessage %></div>
    <% } %>

    <div id="message" class="message" role="status" aria-live="polite"></div>

    <form id="registerForm" method="post" action="register">
        <input type="hidden" name="role" id="formRole" value="PATIENT">

        <label for="name">Full name
            <input type="text" id="name" name="name" required maxlength="120"
                   placeholder="Enter your full name" autocomplete="name">
        </label>

        <label for="email">Email address
            <input type="email" id="email" name="email" required
                   placeholder="you@example.com" autocomplete="email">
        </label>

        <label for="password">Password
            <input type="password" id="password" name="password" required minlength="8"
                   placeholder="Minimum 8 characters" autocomplete="new-password">
        </label>

        <label for="confirmPassword">Confirm password
            <input type="password" id="confirmPassword" name="confirmPassword" required minlength="8"
                   placeholder="Re-enter your password" autocomplete="new-password">
        </label>

        <button type="submit" class="btn" id="submitBtn">Create account →</button>
    </form>

    <p class="note">
        SmartCare Hospital Management demonstration mode.
    </p>

    <p class="bottom">
        Already have an account? <a href="javascript:void(0)" onclick="openRoleModal('login')">Login</a>
    </p>
    <a class="back" href="index.jsp">← Back to homepage</a>
</main>

<!-- Role Selection Popup Modal -->
<div id="roleModalOverlay" class="role-modal-overlay" aria-hidden="true" onclick="handleBackdropClick(event)">
    <div class="role-modal" role="dialog" aria-modal="true" aria-labelledby="roleModalTitle">
        <button type="button" class="role-modal-close" onclick="closeRoleModal()" aria-label="Close modal">&times;</button>
        
        <div class="role-modal-header">
            <span class="role-badge" id="roleModalBadge">Account Registration</span>
            <h2 id="roleModalTitle">Choose Your Role to Register</h2>
            <p id="roleModalSubtitle">Select the account type you would like to create:</p>
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
            <span id="roleModalFooterText">Already have an account?</span>
            <a href="javascript:void(0)" id="roleModalSwitchAction" onclick="switchModalMode()">Login here</a>
        </div>
    </div>
</div>

<script>
    var roleConfig = {
        admin: {
            name: 'Admin',
            code: 'ADMIN',
            icon: '🛡️',
            title: 'Register as Admin',
            subtitle: 'Create a hospital administration account.'
        },
        doctor: {
            name: 'Doctor',
            code: 'DOCTOR',
            icon: '👨‍⚕️',
            title: 'Register as Doctor',
            subtitle: 'Create a medical practitioner account.'
        },
        patient: {
            name: 'Patient',
            code: 'PATIENT',
            icon: '👤',
            title: 'Register as Patient',
            subtitle: 'Create a patient account to book appointments.'
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
            // Default to patient role cleanly without auto-opening popup
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

        var registerHeading = document.getElementById('registerHeading');
        if (registerHeading) registerHeading.textContent = config.title;

        var registerSub = document.getElementById('registerSub');
        if (registerSub) registerSub.textContent = config.subtitle;
    }

    // Role Selection Modal Logic
    var currentModalMode = 'register';

    function openRoleModal(mode) {
        currentModalMode = (mode === 'login') ? 'login' : 'register';
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
        if (currentModalMode === 'login') {
            window.location.href = 'login.jsp?role=' + encodeURIComponent(role);
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

    var form = document.getElementById('registerForm');
    var message = document.getElementById('message');

    function showMessage(text, type) {
        if (!message) return;
        message.textContent = text;
        message.className = 'message ' + type;
        message.style.display = 'block';
    }

    if (form) {
        form.addEventListener('submit', function(event) {
            event.preventDefault();

            var nameInput = document.getElementById('name');
            var emailInput = document.getElementById('email');
            var passInput = document.getElementById('password');
            var confirmInput = document.getElementById('confirmPassword');

            var name = nameInput ? nameInput.value.trim() : '';
            var email = emailInput ? emailInput.value.trim().toLowerCase() : '';
            var password = passInput ? passInput.value : '';
            var confirmPassword = confirmInput ? confirmInput.value : '';
            var role = (roleConfig[activeRoleKey] ? roleConfig[activeRoleKey].code : 'PATIENT');

            if (!name) {
                showMessage('Please enter your full name.', 'error');
                return;
            }

            if (!email || email.indexOf('@') === -1 || email.indexOf('.') === -1) {
                showMessage('Please enter a valid email address.', 'error');
                return;
            }

            if (password.length < 8) {
                showMessage('Password must contain at least 8 characters.', 'error');
                return;
            }

            if (password !== confirmPassword) {
                showMessage('Passwords do not match.', 'error');
                return;
            }

            // Check if email already belongs to a seed account
            var reservedEmails = [
                'admin@smartcare.test', 'admin@smartcare.com',
                'doctor@smartcare.test', 'doctor@smartcare.com',
                'patient@smartcare.test', 'patient@smartcare.com'
            ];
            if (reservedEmails.indexOf(email) !== -1) {
                showMessage('An account with this email already exists.', 'error');
                return;
            }

            // Check localStorage for duplicate
            try {
                var users = JSON.parse(localStorage.getItem('smartcareUsers') || '[]');
                var exists = false;
                for (var i = 0; i < users.length; i++) {
                    if (users[i] && users[i].email && users[i].email.toLowerCase() === email) {
                        exists = true;
                        break;
                    }
                }
                if (exists) {
                    showMessage('An account with this email already exists in this browser.', 'error');
                    return;
                }

                users.push({
                    name: name,
                    email: email,
                    password: password,
                    role: role
                });
                localStorage.setItem('smartcareUsers', JSON.stringify(users));
            } catch (error) {
                // Ignore localStorage errors
            }

            showMessage('Registration successful! Redirecting to login...', 'success');

            // If running on Tomcat server, submit form natively so RegisterServlet persists in AppStore
            var isTomcat = (window.location.protocol.indexOf('http') === 0 && window.location.pathname.indexOf('/SmartCare') !== -1);
            if (isTomcat) {
                setTimeout(function() {
                    form.submit();
                }, 800);
            } else {
                // Standalone / client preview mode redirect
                setTimeout(function() {
                    window.location.href = 'login.jsp?role=' + encodeURIComponent(activeRoleKey) + '&registered=1';
                }, 800);
            }
        });
    }

    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', initRoleFromUrl);
    } else {
        initRoleFromUrl();
    }
</script>

</body>
</html>
