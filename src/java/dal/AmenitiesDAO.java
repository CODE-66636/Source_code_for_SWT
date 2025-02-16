/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import model.Amenities;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author HP
 */
public class AmenitiesDAO extends DBContext {

    public List<Amenities> getAllAmenities() {
        List<Amenities> list = new ArrayList<>();
        String query = "SELECT * FROM Amenities";
        try (PreparedStatement ps = connection.prepareStatement(query); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new Amenities(rs.getInt("amenities_ID"), rs.getString("name")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    public List<Amenities> searchAmenities(String keyword) {
        List<Amenities> list = new ArrayList<>();
        String sql = "SELECT * FROM Amenities WHERE name LIKE ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, "%" + keyword + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Amenities(rs.getInt("amenities_ID"), rs.getString("name")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
