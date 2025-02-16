/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author ADMIN
 */
public class Profile {

    private int profileID;
    private String firstName;
    private String lastName;
    private String phone;
    private String citizenship;
    private String email;
    private int accountID;
    private int hotelID;

    public Profile() {
    }

    public Profile(int profileID, String firstName, String lastName, String phone, String citizenship, String email, int accountID, int hotelID) {
        this.profileID = profileID;
        this.firstName = firstName;
        this.lastName = lastName;
        this.phone = phone;
        this.citizenship = citizenship;
        this.email = email;
        this.accountID = accountID;
        this.hotelID = hotelID;
        this.normalizeName();
    }

    public int getProfileID() {
        return profileID;
    }

    public void setProfileID(int profileID) {
        this.profileID = profileID;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getCitizenship() {
        return citizenship;
    }

    public void setCitizenship(String citizenship) {
        this.citizenship = citizenship;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public int getAccountID() {
        return accountID;
    }

    public void setAccountID(int accountID) {
        this.accountID = accountID;
    }

    public int getHotelID() {
        return hotelID;
    }

    public void setHotelID(int hotelID) {
        this.hotelID = hotelID;
    }

    private void normalizeName() {
        this.firstName = capitalizeName(this.firstName);
        this.lastName = capitalizeName(this.lastName);
    }

    private String capitalizeName(String name) {
        if (name == null || name.trim().isEmpty()) {
            return "";
        }

        String[] words = name.toLowerCase().trim().split("\\s+");
        StringBuilder formattedName = new StringBuilder();

        for (String word : words) {
            if (!word.isEmpty()) {
                formattedName.append(Character.toUpperCase(word.charAt(0)))
                        .append(word.substring(1))
                        .append(" ");
            }
        }

        return formattedName.toString().trim();
    }

    @Override
    public String toString() {
        return "Profile{" + "profileID=" + profileID
                + ", firstName=" + firstName
                + ", lastName=" + lastName
                + ", phone=" + phone
                + ", citizenship=" + citizenship
                + ", email=" + email
                + ", accountID=" + accountID
                + ", hotelID=" + hotelID + '}';
    }

}
