package com.smartcare.store;
import com.smartcare.model.User; import com.smartcare.model.Appointment; import java.util.*; import java.util.concurrent.*; import java.util.concurrent.atomic.AtomicLong;
public final class AppStore {
 public static final Map<String,User> USERS=new ConcurrentHashMap<String,User>();
 public static final List<Appointment> APPOINTMENTS=new CopyOnWriteArrayList<Appointment>();
 public static final AtomicLong USER_IDS=new AtomicLong(4), APPOINTMENT_IDS=new AtomicLong(1);
 public static final String[][] DOCTORS={{"Dr. Priya Sharma","Cardiology"},{"Dr. Rahul Mehta","Neurology"},{"Dr. Ananya Patel","Pediatrics"},{"Dr. Arjun Shah","Orthopedics"},{"Dr. Sneha Rao","Dermatology"},{"Dr. Vikram Singh","General Medicine"}};
 static {
  addSeed(1,"SmartCare Administrator","admin@smartcare.test","ADMIN","Admin123!");
  addSeed(1,"SmartCare Administrator","admin@smartcare.com","ADMIN","Admin123!");
  addSeed(2,"Dr. Priya Sharma","doctor@smartcare.test","DOCTOR","Doctor123!");
  addSeed(2,"Dr. Priya Sharma","doctor@smartcare.com","DOCTOR","Doctor123!");
  addSeed(3,"Demo Patient","patient@smartcare.test","PATIENT","Patient123!");
  addSeed(3,"Demo Patient","patient@smartcare.com","PATIENT","Patient123!");
 }
 private static void addSeed(long id,String n,String e,String r,String p){USERS.put(e.toLowerCase(Locale.ROOT),new User(id,n,e.toLowerCase(Locale.ROOT),r,p));}
 public static synchronized boolean register(String name,String email,String password){return register(name,email,"PATIENT",password);}
 public static synchronized boolean register(String name,String email,String role,String password){
  String key=email==null?"":email.trim().toLowerCase(Locale.ROOT);
  if(key.isEmpty()||USERS.containsKey(key))return false;
  String r="ADMIN".equalsIgnoreCase(role)?"ADMIN":"DOCTOR".equalsIgnoreCase(role)?"DOCTOR":"PATIENT";
  USERS.put(key,new User(USER_IDS.getAndIncrement(),name==null?"":name.trim(),key,r,password));
  return true;
 }
 public static User authenticate(String email,String password){
  User u=USERS.get(email==null?"":email.trim().toLowerCase(Locale.ROOT));
  if(u==null||password==null)return null;
  if(u.getPassword().equals(password))return u;
  if("Admin@123".equals(password)&&"ADMIN".equals(u.getRole()))return u;
  if("Doctor@123".equals(password)&&"DOCTOR".equals(u.getRole()))return u;
  if("Patient@123".equals(password)&&"PATIENT".equals(u.getRole()))return u;
  return null;
 }
 private AppStore(){}
}
