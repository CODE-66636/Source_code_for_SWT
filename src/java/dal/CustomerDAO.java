/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

/**
 *
 * @author HP
 */
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import dal.DBContext;
import model.CustomerInformation;

public class CustomerDAO extends DBContext {

    public List<CustomerInformation> getCustomers(String search, int page, int pageSize) {
        List<CustomerInformation> list = new ArrayList<>();
        String sql = "SELECT * FROM Customer_Information WHERE first_name LIKE ? OR email LIKE ? OR last_name LIKE ? ORDER BY customer_information_ID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, "%" + search + "%");
            ps.setString(2, "%" + search + "%");
             ps.setString(3, "%" + search + "%");
            ps.setInt(4, (page - 1) * pageSize);
            ps.setInt(5, pageSize);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new CustomerInformation(
                    rs.getInt("customer_information_ID"),
                    rs.getString("first_name"),
                    rs.getString("last_name"),
                    rs.getString("phone_num"),
                    rs.getString("citizenship"),
                    rs.getString("email"),
                    null 
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public int getTotalCustomers(String search) {
        String sql = "SELECT COUNT(*) FROM Customer_Information WHERE first_name LIKE ? OR last_name LIKE ? OR email LIKE ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, "%" + search + "%");
            ps.setString(2, "%" + search + "%");
             ps.setString(3, "%" + search + "%");
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public CustomerInformation getCustomerById(int id) {
        String sql = "SELECT * FROM Customer_Information WHERE customer_information_ID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new CustomerInformation(
                    rs.getInt("customer_information_ID"),
                    rs.getString("first_name"),
                    rs.getString("last_name"),
                    rs.getString("phone_num"),
                    rs.getString("citizenship"),
                    rs.getString("email"),
                    null
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
