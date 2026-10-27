package com.smartcare.model;
public class Appointment {
 private final long id,patientId; private final String patientName,patientEmail,doctor,department,date,time,reason; private String status;
 public Appointment(long id,long patientId,String patientName,String patientEmail,String doctor,String department,String date,String time,String reason){this.id=id;this.patientId=patientId;this.patientName=patientName;this.patientEmail=patientEmail;this.doctor=doctor;this.department=department;this.date=date;this.time=time;this.reason=reason;this.status="Pending";}
 public long getId(){return id;} public long getPatientId(){return patientId;} public String getPatientName(){return patientName;} public String getPatientEmail(){return patientEmail;} public String getDoctor(){return doctor;} public String getDepartment(){return department;} public String getDate(){return date;} public String getTime(){return time;} public String getReason(){return reason;} public String getStatus(){return status;} public void setStatus(String s){status=s;}
}
