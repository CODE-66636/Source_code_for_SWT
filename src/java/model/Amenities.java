/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

public class Amenities {
    private int amenitiesID;
    private String name;

    public Amenities() {
    }

    public Amenities(int amenitiesID, String name) {
        this.amenitiesID = amenitiesID;
        this.name = name;
    }

    public int getAmenitiesID() {
        return amenitiesID;
    }

    public void setAmenitiesID(int amenitiesID) {
        this.amenitiesID = amenitiesID;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
