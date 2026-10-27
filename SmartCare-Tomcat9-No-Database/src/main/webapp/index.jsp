
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SmartCare | Your Health, Our Priority</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        html { scroll-behavior: smooth; }
        body { font-family: Arial, sans-serif; color: #0f172a; line-height: 1.6; }
        a { text-decoration: none; color: inherit; }
        .navbar {
            display: flex; justify-content: space-between; align-items: center;
            padding: 18px 7%; background: white; border-bottom: 1px solid #e2e8f0;
            position: sticky; top: 0; z-index: 10;
        }
        .logo { font-size: 25px; font-weight: 800; color: #2563eb; }
        .logo span { color: #0d9488; }
        nav { display: flex; align-items: center; gap: 22px; }
        nav a { font-size: 14px; font-weight: 600; }
        nav a:hover { color: #2563eb; }
        .btn {
            display: inline-block; border: none; border-radius: 9px;
            padding: 11px 17px; cursor: pointer; font-weight: 700;
        }
        .primary { background: #2563eb; color: white; }
        .primary:hover { background: #1d4ed8; }
        .outline { border: 1px solid #2563eb; color: #2563eb; }
        .hero {
            padding: 75px 9%; display: grid; grid-template-columns: 1.1fr .9fr;
            align-items: center; gap: 45px;
            background: linear-gradient(120deg, #eff6ff, #f0fdfa);
        }
        .eyebrow { color: #0d9488; font-weight: 800; letter-spacing: 2px; font-size: 12px; }
        h1 { font-size: clamp(42px, 5vw, 64px); line-height: 1.1; margin: 17px 0; }
        h1 span, h2 span { color: #2563eb; }
        .hero p { color: #64748b; max-width: 500px; margin-bottom: 25px; }
        .hero-buttons { display: flex; gap: 12px; flex-wrap: wrap; }
        .hero-art {
            min-height: 320px; display: grid; place-items: center;
            background: radial-gradient(circle, #99f6e4, #dbeafe 65%, transparent 66%);
        }
        .doctor { text-align: center; font-size: 105px; }
        .doctor-caption {
            background: white; padding: 12px 20px; border-radius: 12px;
            box-shadow: 0 10px 30px #0f172a18; font-weight: bold; color: #2563eb;
        }
        .stats {
            display: grid; grid-template-columns: repeat(4, 1fr);
            padding: 28px 8%; text-align: center; gap: 20px;
        }
        .stats strong { display: block; color: #2563eb; font-size: 29px; }
        .stats p { font-size: 13px; color: #64748b; }
        .sample { text-align: center; color: #94a3b8; font-size: 11px; padding: 0 10px 15px; }
        .section { padding: 70px 8%; }
        .soft { background: #f8fafc; }
        .heading { text-align: center; margin-bottom: 35px; }
        .heading h2 { font-size: 36px; margin: 8px 0; }
        .heading p { color: #64748b; }
        .grid { display: grid; grid-template-columns: repeat(4, 1fr); gap: 18px; }
        .card {
            padding: 23px; background: white; border: 1px solid #e2e8f0;
            border-radius: 15px; transition: .2s;
        }
        .card:hover { transform: translateY(-4px); box-shadow: 0 12px 30px #0f172a10; }
        .symbol {
            width: 45px; height: 45px; display: grid; place-items: center;
            border-radius: 12px; background: #dbeafe; color: #2563eb; font-size: 23px;
        }
        .card h3 { margin: 13px 0 5px; font-size: 16px; }
        .card p { font-size: 13px; color: #64748b; }
        .search {
            max-width: 700px; margin: 0 auto 28px; display: flex; gap: 10px;
        }
        .search input {
            flex: 1; min-width: 0; padding: 13px; border: 1px solid #cbd5e1;
            border-radius: 9px; font-size: 14px;
        }
        .doctor-grid { grid-template-columns: repeat(3, 1fr); }
        .doctor-card { display: flex; gap: 14px; align-items: flex-start; }
        .avatar {
            flex-shrink: 0; width: 48px; height: 48px; display: grid;
            place-items: center; border-radius: 50%; background: #ccfbf1;
            color: #0f766e; font-size: 22px;
        }
        .doctor-card h3 { margin: 0; }
        .tag { color: #0d9488; font-size: 12px; font-weight: bold; }
        .doctor-card .fee { margin-top: 10px; color: #2563eb; font-weight: bold; }
        .services { grid-template-columns: repeat(3, 1fr); }
        footer {
            padding: 40px 8%; background: #0f172a; color: #cbd5e1;
            display: grid; grid-template-columns: repeat(3, 1fr); gap: 25px;
        }
        footer h3 { color: white; margin-bottom: 10px; }
        footer p, footer a { display: block; font-size: 13px; margin: 5px 0; }
        .copyright {
            grid-column: 1 / -1; border-top: 1px solid #334155;
            padding-top: 15px; font-size: 12px; color: #94a3b8;
        }
        .menu { display: none; background: none; border: none; font-size: 25px; cursor: pointer; }
        @media(max-width: 900px) {
            nav { gap: 12px; }
            .navbar { padding: 16px 4%; }
            .hero { padding: 55px 6%; }
            .grid { grid-template-columns: repeat(2, 1fr); }
        }
        @media(max-width: 680px) {
            .menu { display: block; }
            nav {
                display: none; position: absolute; top: 65px; left: 0; right: 0;
                background: white; padding: 20px; flex-direction: column;
                align-items: stretch; border-bottom: 1px solid #e2e8f0;
            }
            nav.open { display: flex; }
            nav a { padding: 5px; }
            .hero { grid-template-columns: 1fr; text-align: center; }
            .hero p { margin: 0 auto 25px; }
            .hero-buttons { justify-content: center; }
            .hero-art { min-height: 220px; }
            .doctor { font-size: 75px; }
            .stats { grid-template-columns: repeat(2, 1fr); }
            .heading h2 { font-size: 29px; }
            .doctor-grid, .services { grid-template-columns: 1fr; }
            .search { flex-direction: column; }
            footer { grid-template-columns: 1fr; }
            .copyright { grid-column: auto; }
        }
        @media(max-width: 390px) {
            .grid { grid-template-columns: 1fr; }
            .hero-buttons .btn { width: 100%; }
        }

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
        .role-modal-overlay.active {
            display: grid; opacity: 1;
        }
        .role-modal {
            background: #ffffff; width: 100%; max-width: 500px;
            border-radius: 20px; padding: 32px 28px;
            box-shadow: 0 25px 60px -15px rgba(15, 23, 42, 0.35);
            position: relative;
            transform: scale(0.95) translateY(10px);
            transition: transform 0.25s cubic-bezier(0.16, 1, 0.3, 1);
        }
        .role-modal-overlay.active .role-modal {
            transform: scale(1) translateY(0);
        }
        .role-modal-close {
            position: absolute; top: 18px; right: 18px;
            width: 34px; height: 34px; border-radius: 50%;
            border: none; background: #f1f5f9; color: #64748b;
            font-size: 22px; display: grid; place-items: center;
            cursor: pointer; line-height: 1; transition: .2s;
        }
        .role-modal-close:hover {
            background: #fee2e2; color: #dc2626;
        }
        .role-badge {
            display: inline-block; padding: 4px 12px; border-radius: 20px;
            font-size: 11px; font-weight: 800; letter-spacing: 1.5px;
            text-transform: uppercase; background: #dbeafe; color: #2563eb;
            margin-bottom: 8px;
        }
        .role-modal-header h2 {
            font-size: 24px; color: #0f172a; margin: 4px 0 6px;
        }
        .role-modal-header p {
            color: #64748b; font-size: 13.5px; margin-bottom: 22px;
        }
        .role-cards-grid {
            display: flex; flex-direction: column; gap: 12px;
        }
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
        .role-card-btn:hover .role-num {
            background: #2563eb; color: #ffffff;
        }
        .role-icon {
            font-size: 28px; line-height: 1; flex-shrink: 0;
        }
        .role-info {
            flex: 1; min-width: 0;
        }
        .role-name {
            font-size: 16px; font-weight: 700; color: #0f172a; margin-bottom: 2px;
        }
        .role-desc {
            font-size: 12px; color: #64748b; line-height: 1.4;
        }
        .role-arrow {
            font-size: 18px; font-weight: 700; color: #94a3b8; transition: .2s;
        }
        .role-card-btn:hover .role-arrow {
            color: #2563eb; transform: translateX(4px);
        }
        .role-modal-footer {
            margin-top: 20px; padding-top: 15px; border-top: 1px solid #e2e8f0;
            text-align: center; font-size: 13px; color: #64748b;
        }
        .role-modal-footer a {
            color: #2563eb; font-weight: 700; margin-left: 5px;
        }
        .role-modal-footer a:hover { text-decoration: underline; }
    </style>
</head>
<body>

<header class="navbar">
    <a href="index.jsp" class="logo">✚ Smart<span>Care</span></a>
    <button class="menu" onclick="document.getElementById('nav').classList.toggle('open')"
            aria-label="Toggle navigation">☰</button>
    <nav id="nav">
        <a href="#home">Home</a>
        <a href="#departments">Departments</a>
        <a href="#doctors">Find a Doctor</a>
        <a href="#services">Services</a>
        <a href="#contact">Contact</a>
        <button type="button" class="btn outline" onclick="openRoleModal('login')">Login</button>
        <button type="button" class="btn primary" onclick="openRoleModal('register')">Register</button>
    </nav>
</header>

<main>
    <section class="hero" id="home">
        <div>
            <span class="eyebrow">CARE THAT COMES FIRST</span>
            <h1>Your Health,<br><span>Our Priority.</span></h1>
            <p>Find trusted doctors, explore medical departments, and make your healthcare journey simpler with SmartCare.</p>
            <div class="hero-buttons">
                <button type="button" class="btn primary" onclick="openRoleModal('login')">Book an Appointment ↗</button>
                <a class="btn outline" href="#doctors">Find a Doctor</a>
            </div>
        </div>
        <div class="hero-art">
            <div>
                <div class="doctor">👨‍⚕️</div>
                <div class="doctor-caption">Compassionate Care, Every Day</div>
            </div>
        </div>
    </section>

    <section class="stats">
        <div><strong>50+</strong><p>Experienced Doctors*</p></div>
        <div><strong>12</strong><p>Medical Departments*</p></div>
        <div><strong>10K+</strong><p>Patients Served*</p></div>
        <div><strong>24/7</strong><p>Emergency Information</p></div>
    </section>
    <p class="sample">*Sample figures for demonstration only; replace with verified hospital information.</p>

    <section class="section" id="departments">
        <div class="heading">
            <span class="eyebrow">OUR SPECIALTIES</span>
            <h2>Care for every <span>need</span></h2>
            <p>Explore our medical departments.</p>
        </div>
        <div class="grid">
            <article class="card"><div class="symbol">♡</div><h3>Cardiology</h3><p>Heart and cardiovascular care.</p></article>
            <article class="card"><div class="symbol">◉</div><h3>Neurology</h3><p>Brain and nervous system care.</p></article>
            <article class="card"><div class="symbol">✚</div><h3>Orthopedics</h3><p>Bones, joints and mobility.</p></article>
            <article class="card"><div class="symbol">✿</div><h3>Dermatology</h3><p>Skin and hair health.</p></article>
            <article class="card"><div class="symbol">☻</div><h3>Pediatrics</h3><p>Healthcare for children.</p></article>
            <article class="card"><div class="symbol">✦</div><h3>Dentistry</h3><p>Dental and oral health.</p></article>
            <article class="card"><div class="symbol">❀</div><h3>Gynecology</h3><p>Women's healthcare.</p></article>
            <article class="card"><div class="symbol">＋</div><h3>General Medicine</h3><p>Everyday health and prevention.</p></article>
        </div>
    </section>

    <section class="section soft" id="doctors">
        <div class="heading">
            <span class="eyebrow">MEET OUR TEAM</span>
            <h2>Find the right <span>doctor</span></h2>
            <p>Search our sample doctor directory by name or specialization.</p>
        </div>
        <div class="search">
            <input type="search" id="doctorSearch" placeholder="Search Cardiology, Neurology..." aria-label="Search doctors">
            <button class="btn primary" onclick="searchDoctors()">Search Doctors</button>
        </div>
        <div class="grid doctor-grid" id="doctorGrid">
            <article class="card doctor-card" data-search="ananya sharma cardiology heart">
                <div class="avatar">✚</div><div><h3>Dr. Ananya Sharma</h3><p class="tag">Cardiology</p><p>MBBS, MD · 10 years</p><p class="fee">₹800 / consultation</p></div>
            </article>
            <article class="card doctor-card" data-search="rahul mehta neurology brain">
                <div class="avatar">✚</div><div><h3>Dr. Rahul Mehta</h3><p class="tag">Neurology</p><p>MBBS, DM · 8 years</p><p class="fee">₹700 / consultation</p></div>
            </article>
            <article class="card doctor-card" data-search="priya patel orthopedics bones">
                <div class="avatar">✚</div><div><h3>Dr. Priya Patel</h3><p class="tag">Orthopedics</p><p>MBBS, MS · 7 years</p><p class="fee">₹600 / consultation</p></div>
            </article>
            <article class="card doctor-card" data-search="amit verma dermatology skin">
                <div class="avatar">✚</div><div><h3>Dr. Amit Verma</h3><p class="tag">Dermatology</p><p>MBBS, MD · 6 years</p><p class="fee">₹500 / consultation</p></div>
            </article>
            <article class="card doctor-card" data-search="neha joshi pediatrics children">
                <div class="avatar">✚</div><div><h3>Dr. Neha Joshi</h3><p class="tag">Pediatrics</p><p>MBBS, DCH · 9 years</p><p class="fee">₹600 / consultation</p></div>
            </article>
            <article class="card doctor-card" data-search="kiran desai general medicine">
                <div class="avatar">✚</div><div><h3>Dr. Kiran Desai</h3><p class="tag">General Medicine</p><p>MBBS, MD · 11 years</p><p class="fee">₹500 / consultation</p></div>
            </article>
        </div>
        <p id="noDoctors" style="display:none;text-align:center;color:#64748b;margin-top:20px;">No matching sample doctors found.</p>
    </section>

    <section class="section" id="services">
        <div class="heading">
            <span class="eyebrow">WHY SMARTCARE</span>
            <h2>Healthcare, made <span>simpler</span></h2>
        </div>
        <div class="grid services">
            <article class="card"><div class="symbol">▦</div><h3>Appointment Booking</h3><p>Start an appointment request through the patient login.</p></article>
            <article class="card"><div class="symbol">♧</div><h3>Patient Portal</h3><p>A central place for your healthcare journey.</p></article>
            <article class="card"><div class="symbol">▤</div><h3>Medical Records</h3><p>Designed for future secure report and prescription features.</p></article>
        </div>
    </section>
</main>

<footer id="contact">
    <div><h3>✚ SmartCare</h3><p>Your Health, Our Priority.</p></div>
    <div><h3>Quick Links</h3><a href="#departments">Departments</a><a href="#doctors">Find a Doctor</a><a href="javascript:void(0)" onclick="openRoleModal('login')">Login</a><a href="javascript:void(0)" onclick="openRoleModal('register')">Register</a></div>
    <div><h3>Contact</h3><p>Hospital information desk</p><p>Replace this section with verified hospital contact details.</p><p>For emergencies, contact your local emergency service.</p></div>
    <div class="copyright">© 2026 SmartCare — College project demonstration.</div>
</footer>

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
    function searchDoctors() {
        var query = document.getElementById('doctorSearch').value.trim().toLowerCase();
        var cards = document.querySelectorAll('#doctorGrid .doctor-card');
        var visible = 0;
        for (var i = 0; i < cards.length; i++) {
            var card = cards[i];
            var searchData = card.getAttribute('data-search') || '';
            var match = searchData.indexOf(query) !== -1;
            card.style.display = match ? 'flex' : 'none';
            if (match) visible++;
        }
        var noDoctors = document.getElementById('noDoctors');
        if (noDoctors) noDoctors.style.display = visible ? 'none' : 'block';
    }
    var doctorSearchInput = document.getElementById('doctorSearch');
    if (doctorSearchInput) doctorSearchInput.addEventListener('input', searchDoctors);

    let currentModalMode = 'login';

    function openRoleModal(mode) {
        currentModalMode = (mode === 'register') ? 'register' : 'login';
        const overlay = document.getElementById('roleModalOverlay');
        const title = document.getElementById('roleModalTitle');
        const subtitle = document.getElementById('roleModalSubtitle');
        const badge = document.getElementById('roleModalBadge');
        const footerText = document.getElementById('roleModalFooterText');
        const switchAction = document.getElementById('roleModalSwitchAction');

        if (currentModalMode === 'login') {
            badge.textContent = 'Account Login';
            title.textContent = 'Choose Your Role to Login';
            subtitle.textContent = 'Select your role to access your SmartCare dashboard:';
            footerText.textContent = 'Need a new account?';
            switchAction.textContent = 'Register here';
        } else {
            badge.textContent = 'Account Registration';
            title.textContent = 'Choose Your Role to Register';
            subtitle.textContent = 'Select the account type you would like to create:';
            footerText.textContent = 'Already have an account?';
            switchAction.textContent = 'Login here';
        }

        overlay.classList.add('active');
        overlay.setAttribute('aria-hidden', 'false');
        document.body.style.overflow = 'hidden';
    }

    function closeRoleModal() {
        const overlay = document.getElementById('roleModalOverlay');
        if (overlay) {
            overlay.classList.remove('active');
            overlay.setAttribute('aria-hidden', 'true');
            document.body.style.overflow = '';
        }
    }

    function handleBackdropClick(event) {
        if (event.target.id === 'roleModalOverlay') {
            closeRoleModal();
        }
    }

    function switchModalMode() {
        openRoleModal(currentModalMode === 'login' ? 'register' : 'login');
    }

    function selectRole(role) {
        closeRoleModal();
        const target = (currentModalMode === 'register') ? 'register.jsp' : 'login.jsp';
        window.location.href = target + '?role=' + encodeURIComponent(role);
    }

    document.addEventListener('keydown', function(e) {
        const overlay = document.getElementById('roleModalOverlay');
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
</script>
</body>
</html>
