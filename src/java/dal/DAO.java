/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.Account;
import model.Blog;
import model.D_Feedback;
import model.Hotel;
import model.Room;
import model.Room_type;
import java.lang.reflect.Array;
import model.Profile;
import java.sql.PreparedStatement;
import model.Image;
import model.Thao_Room;
import java.sql.SQLException;
import model.Amenity;

/**
 *
 * @author Asus
 */
public class DAO extends DBContext {

    public Account getAccount(String username, String password) {
        String sql = "SELECT * FROM Account WHERE username = ? AND password = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, username);
            st.setString(2, password);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    return new Account(
                            rs.getInt("account_ID"),
                            rs.getString("username"),
                            rs.getString("password"),
                            rs.getDate("registration_date"),
                            rs.getTimestamp("last_login"),
                            rs.getString("status"),
                            rs.getString("email"),
                            rs.getInt("role_ID")
                    );
                }
            } catch (Exception e) {
            }
        } catch (Exception e) {
        }
        return null;
    }

    public boolean isUserNameExist(String username) {
        String sql = "SELECT * FROM [dbo].[Account] WHERE username = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, username);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    return true;
                }
            } catch (Exception e) {
            }
        } catch (Exception e) {
        }
        return false;
    }

    public boolean isEmailExist(String email) {
        String sql = "SELECT * FROM [dbo].[Account] WHERE email=?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, email);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    return true;
                }
            } catch (Exception e) {
            }
        } catch (Exception e) {
        }
        return false;
    }

    public void registration(Account account) {
        String sql = """
                     INSERT INTO [dbo].[Account]
                                ([username]
                                ,[password]
                                ,[registration_date]
                                ,[last_login]
                                ,[status]
                                ,[email]
                                ,[role_ID])
                          VALUES(?,?,?,?,?,?,?)""";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, account.getUsername());
            st.setString(2, account.getPassword());
            st.setDate(3, account.getRegistration_date());
            st.setTimestamp(4, account.getLast_login());
            st.setString(5, account.getStatus());
            st.setString(6, account.getEmail());
            st.setInt(7, account.getRole_ID());

            st.executeUpdate();
        } catch (Exception e) {
        }
    }

    public void addProfile(Profile p) {
        String sql = """
                     INSERT INTO [dbo].[Profile]
                                ([first_name]
                                ,[last_name]
                                ,[phone_num]
                                ,[citizenship]
                                ,[email]
                                ,[account_ID]
                                ,[hotel_ID])
                          VALUES(?,?,?,?,?,?,?)
                     """;
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, p.getFirstName());
            st.setString(2, p.getLastName());
            st.setString(3, p.getPhone());
            st.setString(4, p.getCitizenship());
            st.setString(5, p.getEmail());
            st.setInt(6, p.getAccountID());
            st.setNull(7, java.sql.Types.INTEGER);

            st.executeUpdate();
        } catch (Exception e) {
        }
    }

    public Map<Integer, Hotel> D_getHotelsList() {
        Map<Integer, Hotel> list = new HashMap<>();
        try {
            String sql = "select* from Hotel";
            Statement st = connection.createStatement();
            ResultSet rs = st.executeQuery(sql);
            while (rs.next()) {
                Hotel hotel = new Hotel();
                hotel.setHotel_ID(rs.getInt("hotel_ID"));
                hotel.setName(rs.getString("name"));
                hotel.setHotline(rs.getString("hotline"));
                hotel.setEmail(rs.getString("email"));
                hotel.setAddress(rs.getString("address"));
                hotel.setDescription(rs.getString("description"));
                list.put(hotel.getHotel_ID(), hotel);
            }
            st.close();
            rs.close();
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return list;
    }

    public Map<Integer, Account> D_getAccountsList() {
        Map<Integer, Account> list = new HashMap<>();
        try {
            String sql = "select* from Account";
            Statement st = connection.createStatement();
            ResultSet rs = st.executeQuery(sql);
            while (rs.next()) {
                Account account = new Account();
                account.setAccount_ID(rs.getInt("account_ID"));
                account.setUsername(rs.getString("username"));
                account.setPassword(rs.getString("password"));
                account.setRegistration_date(rs.getDate("registration_date"));
                account.setLast_login(rs.getTimestamp("last_login"));
                account.setStatus(rs.getString("status"));
                account.setEmail(rs.getString("email"));
                account.setRole_ID(rs.getInt("role_ID"));
                list.put(account.getAccount_ID(), account);
            }
            st.close();
            rs.close();
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return list;
    }

    public Map<Integer, Blog> D_getBlogsByType(String type) {
        Map<Integer, Blog> list = new HashMap<>();
        try {
            String sql = "select* from Blog\n"
                    + "where type = N'" + type + "'\n"
                    + "order by publication_date desc";
            Statement st = connection.createStatement();
            ResultSet rs = st.executeQuery(sql);
            while (rs.next()) {
                Blog blog = new Blog();
                blog.setBlog_ID(rs.getInt("blog_ID"));
                blog.setType(rs.getString("type"));
                blog.setTitle(rs.getString("title"));
                blog.setPublication_date(rs.getDate("publication_date").toString());
                blog.setContent(rs.getString("content"));
                list.put(blog.getBlog_ID(), blog);
            }
            st.close();
            rs.close();
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return list;
    }

    public Map<Integer, Blog> D_getSubContent(int extend_ID) {
        Map<Integer, Blog> list = new HashMap<>();
        try {
            String sql = "select* from Blog \n"
                    + "where extend_ID = " + extend_ID + "\n"
                    + "order by publication_date desc";
            Statement st = connection.createStatement();
            ResultSet rs = st.executeQuery(sql);
            while (rs.next()) {
                Blog blog = new Blog();
                blog.setBlog_ID(rs.getInt("blog_ID"));
                blog.setType(rs.getString("type"));
                blog.setTitle(rs.getString("title"));
                blog.setPublication_date(rs.getDate("publication_date").toString());
                blog.setContent(rs.getString("content"));
                list.put(blog.getBlog_ID(), blog);
            }
            st.close();
            rs.close();
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return list;
    }

    public Map<Integer, Blog> D_getBlogList() {
        Map<Integer, Blog> list = new HashMap<>();
        try {
            String sql = "select* from Blog order by publication_date desc";
            Statement st = connection.createStatement();
            ResultSet rs = st.executeQuery(sql);
            while (rs.next()) {
                Blog blog = new Blog();
                blog.setBlog_ID(rs.getInt("blog_ID"));
                blog.setType(rs.getString("type"));
                blog.setTitle(rs.getString("title"));
                blog.setPublication_date(rs.getDate("publication_date").toString());
                blog.setContent(rs.getString("content"));
                list.put(blog.getBlog_ID(), blog);
            }
            st.close();
            rs.close();
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return list;
    }

    public Map<Integer, Room_type> D_getRoomTypeList() {
        Map<Integer, Room_type> list = new HashMap<>();
        try {
            String sql = "select* from Room_type";
            Statement st = connection.createStatement();
            ResultSet rs = st.executeQuery(sql);
            while (rs.next()) {
                Room_type room_type = new Room_type();
                room_type.setRoomType_ID(rs.getInt("roomType_ID"));
                room_type.setName(rs.getString("name"));
                room_type.setDescription(rs.getString("description"));
                list.put(room_type.getRoomType_ID(), room_type);
            }
            st.close();
            rs.close();
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return list;
    }

    public Map<Integer, D_Feedback> D_getFeedbackList() {
        Map<Integer, D_Feedback> list = new HashMap<>();
        try {
            String sql = "SELECT \n"
                    + "    f.feedback_ID, \n"
                    + "    a.username, \n"
                    + "    h.name AS hotelname, \n"
                    + "    f.rate, \n"
                    + "    f.content\n"
                    + "FROM \n"
                    + "    Feedback f\n"
                    + "JOIN \n"
                    + "    Account a ON f.account_ID = a.account_ID\n"
                    + "JOIN \n"
                    + "    Hotel h ON f.hotel_ID = h.hotel_ID\n"
                    + "ORDER BY \n"
                    + "    f.rate DESC;";
            Statement st = connection.createStatement();
            ResultSet rs = st.executeQuery(sql);
            while (rs.next()) {
                D_Feedback feedback = new D_Feedback();
                feedback.setFeedback_ID(rs.getInt("feedback_ID"));
                feedback.setUsername(rs.getString("username"));
                feedback.setHotelname(rs.getString("hotelname"));
                feedback.setRate(rs.getInt("rate"));
                feedback.setContent(rs.getString("content"));
                list.put(feedback.getFeedback_ID(), feedback);
            }
            st.close();
            rs.close();
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return list;
    }

    public Map<Integer, List<Room>> D_getRoomOfHotel() {
        Map<Integer, List<Room>> list = new HashMap<>();
        DAO dao = new DAO();
        Map<Integer, Hotel> hotels = dao.D_getHotelsList();
        List<Integer> keys = new ArrayList<>(hotels.keySet());
        for (Integer key : keys) {
            List<Room> rooms = new ArrayList<>();
            try {
                String sql = "select* from Room where hotel_ID = " + key + " order by price asc";
                Statement st = connection.createStatement();
                ResultSet rs = st.executeQuery(sql);
                while (rs.next()) {
                    Room room = new Room();
                    room.setRoom_ID(rs.getInt("room_ID"));
                    room.setHotel_ID(rs.getInt("hotel_ID"));
                    room.setRoomType_ID(rs.getInt("roomType_ID"));
                    room.setQuantity(rs.getInt("quantity"));
                    room.setBed_quantity(rs.getInt("bed_quantity"));
                    room.setName(rs.getString("name"));
                    room.setDescription(rs.getString("description"));
                    room.setPrice(rs.getDouble("price"));
                    room.setArea(rs.getDouble("area"));
                    rooms.add(room);
                }
                st.close();
                rs.close();
            } catch (Exception e) {
                System.out.println(e.getMessage());
            }
            list.put(key, rooms);
        }
        return list;
    }
    

    public List<Amenity> Thao_getAllAmenities() {
        List<Amenity> amenities = new ArrayList<>();
        String query = "SELECT * FROM Amenities";

        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Amenity amenity = new Amenity(
                        rs.getInt("amenities_ID"),
                        rs.getString("name")
                );
                amenities.add(amenity);
            }
        } catch (SQLException e) {
            System.out.println("Error in getAllAmenities: " + e.getMessage());
        }
        return amenities;
    }

    public List<Amenity> Thao_getAmenitiesByRoomId(int roomId) {
        List<Amenity> amenities = new ArrayList<>();
        String query = "SELECT a.* FROM Amenities a "
                + "JOIN Room_has_amenities rha ON a.amenities_ID = rha.amenities_ID "
                + "WHERE rha.room_ID = ?";

        System.out.println("Executing query for roomId: " + roomId); // Debug log

        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setInt(1, roomId);
            ResultSet rs = ps.executeQuery();

            int count = 0; // Debug counter
            while (rs.next()) {
                count++;
                Amenity amenity = new Amenity(
                        rs.getInt("amenities_ID"),
                        rs.getString("name")
                );
                amenities.add(amenity);
                // Debug log
                System.out.println("Found amenity: ID=" + amenity.getAmenityId() + ", Name=" + amenity.getName());
            }
            System.out.println("Total amenities found: " + count); // Debug log

        } catch (SQLException e) {
            System.out.println("Error in getAmenitiesByRoomId: " + e.getMessage());
            e.printStackTrace();
        }
        return amenities;
    }

    public List<Hotel> Thao_getAllHotels() {
        List<Hotel> list = new ArrayList<>();
        String query = "SELECT * FROM Hotel";
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Hotel hotel = new Hotel(
                        rs.getInt("hotel_ID"),
                        rs.getString("name"),
                        rs.getString("hotline"),
                        rs.getString("address"),
                        rs.getString("email"),
                        rs.getString("description")
                );
                list.add(hotel);
            }
        } catch (SQLException e) {
            System.out.println("Error in getAllHotels: " + e.getMessage());
        }
        return list;
    }

    public List<Hotel> Thao_searchHotelsByName(String searchName) {
        List<Hotel> list = new ArrayList<>();
        String query = "SELECT * FROM Hotel WHERE name LIKE ?";
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setString(1, "%" + searchName + "%");
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Hotel hotel = new Hotel(
                        rs.getInt("hotel_ID"),
                        rs.getString("name"),
                        rs.getString("hotline"),
                        rs.getString("address"),
                        rs.getString("email"),
                        rs.getString("description")
                );
                list.add(hotel);
            }
        } catch (SQLException e) {
            System.out.println("Error in searchHotelsByName: " + e.getMessage());
        }
        return list;
    }

    public Hotel Thao_getHotelById(int hotelId) {
        String query = "SELECT * FROM Hotel WHERE hotel_ID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setInt(1, hotelId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return new Hotel(
                        rs.getInt("hotel_ID"),
                        rs.getString("name"),
                        rs.getString("hotline"),
                        rs.getString("address"),
                        rs.getString("email"),
                        rs.getString("description")
                );
            }
        } catch (SQLException e) {
            System.out.println("Error in getHotelById: " + e.getMessage());
        }
        return null;
    }

    public List<Hotel> Thao_getHotelsByCity(String city) {
        List<Hotel> list = new ArrayList<>();
        String query = "SELECT * FROM Hotel WHERE address LIKE ?";
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setString(1, "%" + city + "%");
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Hotel hotel = new Hotel(
                        rs.getInt("hotel_ID"),
                        rs.getString("name"),
                        rs.getString("hotline"),
                        rs.getString("address"),
                        rs.getString("email"),
                        rs.getString("description")
                );
                list.add(hotel);
            }
        } catch (SQLException e) {
            System.out.println("Error in getHotelsByCity: " + e.getMessage());
        }
        return list;
    }

    public List<Image> Thao_getImagesByHotelId(int hotelId) {
        List<Image> images = new ArrayList<>();
        String query = "SELECT i.* FROM Image i "
                + "JOIN Hotel_has_image hi ON i.image_ID = hi.image_ID "
                + "WHERE hi.hotel_ID = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setInt(1, hotelId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Image image = new Image();
                image.setImageId(rs.getInt("image_ID"));
                image.setImageName(rs.getString("image_name"));
                image.setLink(rs.getString("link"));
                images.add(image);
                // Debug log
                System.out.println("Found hotel image: ID=" + image.getImageId()
                        + ", Name=" + image.getImageName()
                        + ", Link=" + image.getLink());
            }
        } catch (SQLException e) {
            System.out.println("Error in getImagesByHotelId: " + e.getMessage());
            e.printStackTrace();
        }
        return images;
    }

    public List<Image> Thao_getImagesByRoomId(int roomId) {
        List<Image> images = new ArrayList<>();
        String query = "SELECT i.* FROM Image i "
                + "JOIN Room_has_image rhi ON i.image_ID = rhi.image_ID "
                + "WHERE rhi.room_ID = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setInt(1, roomId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Image image = new Image();
                image.setImageId(rs.getInt("image_ID"));
                image.setImageName(rs.getString("image_name"));
                image.setLink(rs.getString("link"));
                images.add(image);
                // Debug log
                System.out.println("Found image: ID=" + image.getImageId()
                        + ", Name=" + image.getImageName()
                        + ", Link=" + image.getLink());
            }
        } catch (SQLException e) {
            System.out.println("Error in getImagesByRoomId: " + e.getMessage());
            e.printStackTrace();
        }
        return images;
    }

    public List<Thao_Room> Thao_getRoomsByHotelId(int hotelId) {
        List<Thao_Room> rooms = new ArrayList<>();
        String query = "SELECT * FROM Room WHERE hotel_ID = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setInt(1, hotelId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Thao_Room room = new Thao_Room();
                room.setName(rs.getString("name"));
                room.setRoomId(rs.getInt("room_ID"));
                room.setPrice(rs.getDouble("price"));
                room.setQuantity(rs.getInt("quantity"));
                room.setArea(rs.getFloat("area"));
                room.setBedQuantity(rs.getInt("bed_quantity"));
                room.setDescription(rs.getString("description"));
                room.setHotelId(rs.getInt("hotel_ID"));
                rooms.add(room);
            }
        } catch (SQLException e) {
            System.out.println("Error in getRoomsByHotelId: " + e.getMessage());
        }
        return rooms;
    }

    public Thao_Room Thao_getRoomById(int roomId) {
        Thao_Room room = null;
        String query = "SELECT r.*, rt.name as roomType_name, rt.description as roomType_description "
                + "FROM Room r "
                + "LEFT JOIN Room_type rt ON r.room_ID = rt.roomType_ID "
                + "WHERE r.room_ID = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setInt(1, roomId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                room = new Thao_Room();
                room.setRoomId(rs.getInt("room_ID"));
                room.setName(rs.getString("name"));
                room.setPrice(rs.getDouble("price"));
                room.setQuantity(rs.getInt("quantity"));
                room.setArea(rs.getFloat("area"));
                room.setBedQuantity(rs.getInt("bed_quantity"));
                room.setDescription(rs.getString("description"));
                room.setHotelId(rs.getInt("hotel_ID"));

                // Thêm thông tin room type nếu có
                if (rs.getString("roomType_name") != null) {
                    Room_type roomType = new Room_type();
                    roomType.setName(rs.getString("name"));
                    roomType.setDescription(rs.getString("description"));
                    room.setRoomType(roomType);

                }

            }
        } catch (SQLException e) {
            System.out.println("Error in getRoomById: " + e.getMessage());
        }
        return room;
    }

    public List<Thao_Room> Thao_getSimilarRooms(int currentRoomId, int hotelId) {
        List<Thao_Room> rooms = new ArrayList<>();
        String query = "SELECT TOP 4 r.* FROM Room r "
                + "WHERE r.hotel_ID = ? "
                + "AND r.room_ID != ? "
                + "ORDER BY r.price"; // Có thể thay đổi logic sắp xếp tùy ý

        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setInt(1, hotelId);
            ps.setInt(2, currentRoomId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Thao_Room room = new Thao_Room();
                room.setRoomId(rs.getInt("room_ID"));
                room.setName(rs.getString("name"));
                room.setPrice(rs.getDouble("price"));
                room.setQuantity(rs.getInt("quantity"));
                room.setArea(rs.getFloat("area"));
                room.setBedQuantity(rs.getInt("bed_quantity"));
                room.setDescription(rs.getString("description"));
                room.setHotelId(rs.getInt("hotel_ID"));
                rooms.add(room);
            }
        } catch (SQLException e) {
            System.out.println("Error in getSimilarRooms: " + e.getMessage());
        }
        return rooms;
    }

    public Room_type Thao_getRoomTypeByRoomId(int roomId) {
        String query = "SELECT rt.* FROM Room_type rt "
                + "JOIN Room r ON r.roomType_ID = rt.roomType_ID "
                + // Sửa điều kiện JOIN
                "WHERE r.room_ID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setInt(1, roomId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Room_type(
                        rs.getInt("roomType_ID"),
                        rs.getString("name"),
                        rs.getString("description")
                );
            }
        } catch (SQLException e) {
            System.out.println("Error in getRoomTypeByRoomId: " + e.getMessage());
        }
        return null;
    }

    public static void main(String[] args) {
        DAO dao = new DAO();
        System.out.println("" + dao.D_getAccountsList());
    }
}
