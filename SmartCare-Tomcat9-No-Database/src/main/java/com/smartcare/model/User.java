package com.smartcare.model;
public class User {
 private final long id; private final String name,email,role,password;
 public User(long id,String name,String email,String role,String password){this.id=id;this.name=name;this.email=email;this.role=role;this.password=password;}
 public long getId(){return id;} public String getName(){return name;} public String getEmail(){return email;} public String getRole(){return role;} public String getPassword(){return password;}
}
