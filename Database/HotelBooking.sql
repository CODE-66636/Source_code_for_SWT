USE master;
GO
IF DB_ID('SWP391_HotelBooking') IS NOT NULL
BEGIN
    DROP DATABASE SWP391_HotelBooking;
    PRINT 'Database SWP391_HotelBooking has been deleted.';
END
GO
CREATE DATABASE SWP391_HotelBooking;
GO
GO
USE SWP391_HotelBooking;
GO

CREATE TABLE Hotel (
    hotel_ID INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(255) NOT NULL,
    hotline NVARCHAR(15),
    address NVARCHAR(500),
    email NVARCHAR(255),
    description NVARCHAR(MAX)
);

CREATE TABLE Blog (
    blog_ID INT IDENTITY(1,1) PRIMARY KEY,
    type NVARCHAR(100),
	publication_date DATE,
    title NVARCHAR(255),
    content NVARCHAR(MAX),
	extend_ID INT,
	FOREIGN KEY (blog_ID) REFERENCES Blog(blog_ID)
);

CREATE TABLE Image (
	image_ID INT IDENTITY(1,1) PRIMARY KEY,
    image_name NVARCHAR(255),
	link NVARCHAR(255),
);

CREATE TABLE Hotel_has_image (
	image_ID INT,
	hotel_ID INT,
    FOREIGN KEY (hotel_ID) REFERENCES Hotel(hotel_ID),
    FOREIGN KEY (image_ID) REFERENCES Image(image_ID)
);


CREATE TABLE Blog_has_image (
	image_ID INT,
	blog_ID INT,
    FOREIGN KEY (blog_ID) REFERENCES Blog(blog_ID),
    FOREIGN KEY (image_ID) REFERENCES Image(image_ID)
);


CREATE TABLE Room_type (
    roomType_ID INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(50),
    description NVARCHAR(500)
);

CREATE TABLE Room (
    room_ID INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(100), 
	price DECIMAL(10, 2),
    quantity INT,
    area FLOAT,
    bed_quantity INT,
    description NVARCHAR(500),
    hotel_ID INT,
    FOREIGN KEY (hotel_ID) REFERENCES Hotel(hotel_ID),
	roomType_ID INT,
    FOREIGN KEY (roomType_ID) REFERENCES Room_type(roomType_ID)
);

CREATE TABLE Room_has_image (
	image_ID INT,
	room_ID INT,
    FOREIGN KEY (room_ID) REFERENCES Room(room_ID),
    FOREIGN KEY (image_ID) REFERENCES Image(image_ID)
);

CREATE TABLE Amenities (
    amenities_ID INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(50)
);

CREATE TABLE Room_has_amenities (
    room_ID INT,
    amenities_ID INT,
    PRIMARY KEY (room_ID, amenities_ID),
    FOREIGN KEY (room_ID) REFERENCES Room(room_ID),
    FOREIGN KEY (amenities_ID) REFERENCES Amenities(amenities_ID)
);

CREATE TABLE Service (
    service_ID INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(100),
    suppliers NVARCHAR(100),
    price DECIMAL(10, 2),
    description NVARCHAR(500),
    hotel_ID INT,
    FOREIGN KEY (hotel_ID) REFERENCES Hotel(hotel_ID)
);

CREATE TABLE Voucher (
    voucher_ID INT IDENTITY(1,1) PRIMARY KEY,
	voucher_code NVARCHAR(20),
    start_date DATE,
    end_date DATE,
    description NVARCHAR(500),
    percentage DECIMAL(5, 2)
);

CREATE TABLE Service_apply_voucher (
    service_ID INT,
    voucher_ID INT,
    PRIMARY KEY (service_ID, voucher_ID),
    FOREIGN KEY (service_ID) REFERENCES Service(service_ID),
    FOREIGN KEY (voucher_ID) REFERENCES Voucher(voucher_ID)
);

CREATE TABLE Room_apply_voucher (
    room_ID INT,
    voucher_ID INT,
    PRIMARY KEY (room_ID, voucher_ID),
    FOREIGN KEY (room_ID) REFERENCES Room(room_ID),
    FOREIGN KEY (voucher_ID) REFERENCES Voucher(voucher_ID)
);

CREATE TABLE Role (
    role_ID INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(50)
);


CREATE TABLE Account (
    account_ID INT IDENTITY(1,1) PRIMARY KEY,
    username NVARCHAR(50) NOT NULL,
    password NVARCHAR(50) NOT NULL,
    registration_date DATE,
    last_login DATETIME,  
    status NVARCHAR(50),
	email NVARCHAR(100),
	role_ID INT,
	FOREIGN KEY (role_ID) REFERENCES Role(role_ID),
);

CREATE TABLE Feedback (
    feedback_ID INT IDENTITY(1,1) PRIMARY KEY,
    rate INT CHECK (rate BETWEEN 1 AND 5),
    content NVARCHAR(500),
	account_ID INT,         
    hotel_ID INT,        
    FOREIGN KEY (account_ID) REFERENCES Account(account_ID),
    FOREIGN KEY (hotel_ID) REFERENCES Hotel(hotel_ID)
);

CREATE TABLE Customer_Information (
    customer_information_ID INT IDENTITY(1,1) PRIMARY KEY,
    first_name NVARCHAR(100),
    last_name NVARCHAR(100),
    phone_num NVARCHAR(15),
    citizenship NVARCHAR(100),
    email NVARCHAR(100),
    account_ID INT,  
    FOREIGN KEY (account_ID) REFERENCES Account(account_ID)  
);

CREATE TABLE [Order] (
    order_ID INT IDENTITY(1,1) PRIMARY KEY,
    start_date DATE,
    end_date DATE,
    create_at DATE,
    total_amount DECIMAL(10, 2),
    total_paid DECIMAL(10, 2),
    status NVARCHAR(50),
	customer_information_ID INT,
	FOREIGN KEY (customer_information_ID) REFERENCES Customer_Information(customer_information_ID)  
);

CREATE TABLE Order_room (
	checkin DATE,
	checkout DATE,
    order_ID INT,
    room_ID INT,
    quantity INT,
    status NVARCHAR(50),
    PRIMARY KEY (order_ID, room_ID),
    FOREIGN KEY (order_ID) REFERENCES [Order](order_ID),
    FOREIGN KEY (room_ID) REFERENCES Room(room_ID)
);

CREATE TABLE Order_service (
    order_ID INT,
    service_ID INT,
    quantity INT,
    status NVARCHAR(50),
    PRIMARY KEY (order_ID, service_ID),
    FOREIGN KEY (order_ID) REFERENCES [Order](order_ID),
    FOREIGN KEY (service_ID) REFERENCES Service(service_ID)
);

CREATE TABLE Order_use_voucher (
    order_ID INT,
    voucher_ID INT,
    PRIMARY KEY (order_ID, voucher_ID),
    FOREIGN KEY (order_ID) REFERENCES [Order](order_ID),
    FOREIGN KEY (voucher_ID) REFERENCES Voucher(voucher_ID)
);

CREATE TABLE Payment (
    payment_ID INT IDENTITY(1,1) PRIMARY KEY,
    payment_date DATE,
    payment_method NVARCHAR(50),
    amount DECIMAL(10, 2),
    status NVARCHAR(50),
    order_ID INT,
    FOREIGN KEY (order_ID) REFERENCES [Order](order_ID)
);

CREATE TABLE Feature (
    feature_ID INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(100),
    link NVARCHAR(255)
);

CREATE TABLE Feature_require_role (
    feature_ID INT,
    role_ID INT,
    PRIMARY KEY (feature_ID, role_ID),
    FOREIGN KEY (feature_ID) REFERENCES Feature(feature_ID),
    FOREIGN KEY (role_ID) REFERENCES Role(role_ID)
);

CREATE TABLE Profile (
    profile_ID INT IDENTITY(1,1) PRIMARY KEY,
    first_name NVARCHAR(50),
    last_name NVARCHAR(50),
    phone_num NVARCHAR(15),
    citizenship NVARCHAR(50),
    email NVARCHAR(100),
    account_ID INT UNIQUE, 
    FOREIGN KEY (account_ID) REFERENCES Account(account_ID),
	hotel_ID INT,
	FOREIGN KEY (hotel_ID) REFERENCES Hotel(hotel_ID)
);



PRINT 'Database SWP391_HotelBooking created successfully.';
GO
