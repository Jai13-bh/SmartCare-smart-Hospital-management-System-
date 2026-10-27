<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Book Appointment | SmartCare</title>
<style>
*{box-sizing:border-box;margin:0;padding:0}
body{font-family:Arial,sans-serif;background:#f1f7fb;color:#243247}
header{background:#075985;color:white;padding:20px 5%;display:flex;justify-content:space-between;align-items:center;gap:12px;flex-wrap:wrap}
header a{color:white;text-decoration:none;background:#0e7490;padding:10px 15px;border-radius:8px}
.container{max-width:850px;margin:35px auto;padding:0 20px}
.intro{margin-bottom:25px}
.intro p{color:#64748b;margin-top:8px;line-height:1.6}
form{background:white;padding:28px;border-radius:16px;box-shadow:0 5px 22px #0f172a0b}
.grid{display:grid;grid-template-columns:1fr 1fr;gap:18px}
.field{margin-bottom:18px}
label{display:block;font-weight:bold;font-size:14px;margin-bottom:8px}
input,select,textarea{width:100%;padding:12px;border:1px solid #cbd5e1;border-radius:8px;font-size:15px;background:white}
input:focus,select:focus,textarea:focus{outline:2px solid #7dd3fc;border-color:#0284c7}
.full{grid-column:1/-1}
button{width:100%;padding:14px;background:#0284c7;color:white;border:0;border-radius:9px;font-size:16px;font-weight:bold;cursor:pointer}
button:hover{background:#0369a1}
#message{margin-top:16px;padding:12px;border-radius:8px;display:none}
.success{background:#dcfce7;color:#166534}
.error{background:#fee2e2;color:#991b1b}
.note{font-size:13px;color:#64748b;margin-top:15px;line-height:1.5}
footer{text-align:center;color:#64748b;padding:25px}
@media(max-width:600px){.grid{grid-template-columns:1fr}form{padding:20px}.full{grid-column:auto}}
</style>
</head>
<body>
<header>
  <h2>🏥 SmartCare Hospital</h2>
  <a href="${pageContext.request.contextPath}/patient/dashboard">Patient Dashboard</a>
</header>

<main class="container">
  <section class="intro">
    <h1>Book an Appointment</h1>
    <p>Complete the form below to schedule a visit with one of our doctors.</p>
  </section>

  <form id="appointmentForm">
    <div class="grid">
      <div class="field">
        <label for="patient">Patient Name</label>
        <input id="patient" name="patient" type="text" placeholder="Enter your full name" maxlength="100" required>
      </div>

      <div class="field">
        <label for="email">Email Address</label>
        <input id="email" name="email" type="email" placeholder="you@example.com" maxlength="150" required>
      </div>

      <div class="field">
        <label for="phone">Phone Number</label>
        <input id="phone" name="phone" type="tel" placeholder="Enter phone number" maxlength="20" required>
      </div>

      <div class="field">
        <label for="department">Department</label>
        <select id="department" name="department" required>
          <option value="">Select department</option>
          <option value="Cardiology">Cardiology</option>
          <option value="Neurology">Neurology</option>
          <option value="Pediatrics">Pediatrics</option>
          <option value="Orthopedics">Orthopedics</option>
          <option value="Dermatology">Dermatology</option>
          <option value="General Medicine">General Medicine</option>
        </select>
      </div>

      <div class="field">
        <label for="doctor">Choose Doctor</label>
        <select id="doctor" name="doctor" required>
          <option value="">Select doctor</option>
        </select>
      </div>

      <div class="field">
        <label for="date">Appointment Date</label>
        <input id="date" name="date" type="date" required>
      </div>

      <div class="field">
        <label for="time">Appointment Time</label>
        <select id="time" name="time" required>
          <option value="">Select time</option>
          <option>09:00 AM</option>
          <option>10:00 AM</option>
          <option>11:00 AM</option>
          <option>12:00 PM</option>
          <option>02:00 PM</option>
          <option>03:00 PM</option>
          <option>04:00 PM</option>
        </select>
      </div>

      <div class="field full">
        <label for="reason">Reason for Visit</label>
        <textarea id="reason" name="reason" rows="3" maxlength="500" placeholder="Briefly describe the reason for your visit"></textarea>
      </div>

      <div class="field full">
        <button type="submit">Confirm Appointment</button>
      </div>
    </div>

    <div id="message" role="status" aria-live="polite"></div>
    <p class="note">Demo mode: appointment information is saved in this browser only. No real booking or hospital confirmation is made.</p>
  </form>
</main>

<footer>© 2026 SmartCare Hospital Management System</footer>

<script>
const doctorOptions={
  "Cardiology":["Dr. Priya Sharma","Dr. Amit Verma"],
  "Neurology":["Dr. Rahul Mehta","Dr. Neha Joshi"],
  "Pediatrics":["Dr. Ananya Patel","Dr. Riya Shah"],
  "Orthopedics":["Dr. Arjun Shah","Dr. Karan Desai"],
  "Dermatology":["Dr. Sneha Rao","Dr. Pooja Nair"],
  "General Medicine":["Dr. Vikram Singh","Dr. Meera Iyer"]
};

const department=document.getElementById("department");
const doctor=document.getElementById("doctor");
const dateInput=document.getElementById("date");
const message=document.getElementById("message");

const today=new Date();
const localToday=[
  today.getFullYear(),
  String(today.getMonth()+1).padStart(2,"0"),
  String(today.getDate()).padStart(2,"0")
].join("-");
dateInput.min=localToday;

department.addEventListener("change",function(){
  doctor.innerHTML='<option value="">Select doctor</option>';
  (doctorOptions[this.value]||[]).forEach(name=>{
    const option=document.createElement("option");
    option.value=name;
    option.textContent=name;
    doctor.appendChild(option);
  });
});

function showMessage(text,type){
  message.textContent=text;
  message.className=type;
  message.style.display="block";
}

document.getElementById("appointmentForm").addEventListener("submit",function(e){
  e.preventDefault();

  if(dateInput.value<localToday){
    showMessage("Please select today or a future date.","error");
    return;
  }

  const appointment={
    id:Date.now(),
    patient:document.getElementById("patient").value.trim(),
    email:document.getElementById("email").value.trim(),
    phone:document.getElementById("phone").value.trim(),
    department:department.value,
    doctor:doctor.value,
    date:dateInput.value,
    time:document.getElementById("time").value,
    reason:document.getElementById("reason").value.trim(),
    status:"Pending"
  };

  if(!appointment.patient||!appointment.email||!appointment.phone||
     !appointment.department||!appointment.doctor||
     !appointment.date||!appointment.time){
    showMessage("Please complete all required fields.","error");
    return;
  }

  try{
    const appointments=JSON.parse(
      localStorage.getItem("smartcareAppointments")||"[]"
    );
    appointments.push(appointment);
    localStorage.setItem(
      "smartcareAppointments",JSON.stringify(appointments)
    );

    showMessage(
      "Demo appointment saved successfully! Status: Pending. You can view it on the dashboards.",
      "success"
    );
    this.reset();
    doctor.innerHTML='<option value="">Select doctor</option>';
    dateInput.min=localToday;
  }catch(error){
    showMessage(
      "Unable to save the appointment. Check your browser storage settings.",
      "error"
    );
  }
});
</script>
</body>
</html>
