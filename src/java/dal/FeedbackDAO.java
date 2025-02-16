/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;
import java.sql.*;
import java.util.*;
import model.Feedback;
/**
 *
 * @author HP
 */
public class FeedbackDAO extends DBContext {
    public List<Feedback> getFeedbacks(int page, int pageSize, String search) {
        List<Feedback> list = new ArrayList<>();
        int start = (page - 1) * pageSize;
        String sql = "SELECT f.*, a.username FROM Feedback f " +
                     "JOIN Account a ON f.account_ID = a.account_ID " +
                     "WHERE f.content LIKE ? ORDER BY f.feedback_ID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, "%" + search + "%");
            ps.setInt(2, start);
            ps.setInt(3, pageSize);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Feedback fb = new Feedback();
                fb.setFeedbackID(rs.getInt("feedback_ID"));
                fb.setRate(rs.getInt("rate"));
                fb.setContent(rs.getString("content"));
                fb.setAccountID(rs.getInt("account_ID"));
                fb.setHotelID(rs.getInt("hotel_ID"));
                fb.setUsername(rs.getString("username"));
                list.add(fb);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
    
    public int getTotalFeedbacks(String search) {
        String sql = "SELECT COUNT(*) FROM Feedback WHERE content LIKE ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, "%" + search + "%");
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
}
