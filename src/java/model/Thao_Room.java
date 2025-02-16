/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author thanh
 */
public class Thao_Room {

    private int roomId;
    private String name;
    private double price;
    private int quantity;
    private float area;
    private int bedQuantity;
    private String description;
    private int hotelId;
    private Room_type roomType;

    public Thao_Room() {
    }

    public Thao_Room(int roomId, double price, int quantity, float area, int bedQuantity,
            String description, int hotelId, Room_type roomType, String name) {
        this.roomId = roomId;
        this.price = price;
        this.quantity = quantity;
        this.area = area;
        this.bedQuantity = bedQuantity;
        this.description = description;
        this.hotelId = hotelId;
        this.roomType = roomType;
        this.name = name;
    }

    public String getName() {
        return name;
    }

    // Getters and Setters
    public void setName(String name) {
        this.name = name;
    }

    public Room_type getRoomType() {
        return roomType;
    }

    public void setRoomType(Room_type roomType) {
        this.roomType = roomType;
    }

    public int getRoomId() {
        return roomId;
    }

    public void setRoomId(int roomId) {
        this.roomId = roomId;
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

    public float getArea() {
        return area;
    }

    public void setArea(float area) {
        this.area = area;
    }

    public int getBedQuantity() {
        return bedQuantity;
    }

    public void setBedQuantity(int bedQuantity) {
        this.bedQuantity = bedQuantity;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getHotelId() {
        return hotelId;
    }

    public void setHotelId(int hotelId) {
        this.hotelId = hotelId;
    }

    // toString method for debugging
    @Override
    public String toString() {
        return "Room{"
                + "roomId=" + roomId
                + ", price=" + price
                + ", quantity=" + quantity
                + ", area=" + area
                + ", bedQuantity=" + bedQuantity
                + ", description='" + description + '\''
                + ", hotelId=" + hotelId
                + ", roomType=" + roomType
                + '}';
    }
}
