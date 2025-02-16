/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Asus
 */
public class Room_type {
    int roomType_ID;
    String name;
    String description;

    public int getRoomType_ID() {
        return roomType_ID;
    }

    public Room_type(int roomType_ID, String name, String description) {
        this.roomType_ID = roomType_ID;
        this.name = name;
        this.description = description;
    }

    public Room_type() {
    }
    
    

    public void setRoomType_ID(int roomType_ID) {
        this.roomType_ID = roomType_ID;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
    
}
