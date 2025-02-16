/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Timestamp;
import java.sql.Date;

/**
 *
 * @author Asus
 */
public class Account {
    int account_ID;
    String username;
    String password;
    Date registration_date;
    Timestamp last_login;
    String status;
    String email;
    int role_ID;

    public Account() {
    }

    public Account(int account_ID, String username, String password, Date registration_date, Timestamp last_login, String status, String email, int role_ID) {
        this.account_ID = account_ID;
        this.username = username;
        this.password = password;
        this.registration_date = registration_date;
        this.last_login = last_login;
        this.status = status;
        this.email = email;
        this.role_ID = role_ID;
    }
    
    
    
    public int getAccount_ID() {
        return account_ID;
    }

    public void setAccount_ID(int account_ID) {
        this.account_ID = account_ID;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Date getRegistration_date() {
        return registration_date;
    }

    public void setRegistration_date(Date registration_date) {
        this.registration_date = registration_date;
    }

    public Timestamp getLast_login() {
        return last_login;
    }

    public void setLast_login(Timestamp last_login) {
        this.last_login = last_login;
    }
    

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public int getRole_ID() {
        return role_ID;
    }

    public void setRole_ID(int role_ID) {
        this.role_ID = role_ID;
    }
    
}
