/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Asus
 */
public class Room {

    int room_ID;
    String name;
    double price;
    int quantity;
    double area;
    int bed_quantity;
    String description;
    int hotel_ID;
    int roomType_ID;

    public int getRoom_ID() {
        return room_ID;
    }

    public void setRoom_ID(int room_ID) {
        this.room_ID = room_ID;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getArea() {
        return area;
    }

    public void setArea(double area) {
        this.area = area;
    }

    public int getBed_quantity() {
        return bed_quantity;
    }

    public void setBed_quantity(int bed_quantity) {
        this.bed_quantity = bed_quantity;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getHotel_ID() {
        return hotel_ID;
    }

    public void setHotel_ID(int hotel_ID) {
        this.hotel_ID = hotel_ID;
    }

    public int getRoomType_ID() {
        return roomType_ID;
    }

    public void setRoomType_ID(int roomType_ID) {
        this.roomType_ID = roomType_ID;
    }

}
