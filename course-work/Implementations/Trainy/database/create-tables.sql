CREATE TABLE dbo.Users (
    user_id INT IDENTITY(1,1) PRIMARY KEY,
    first_name NVARCHAR(100) NOT NULL,
    last_name NVARCHAR(100) NOT NULL,
    email NVARCHAR(255) UNIQUE NOT NULL,
    password_hash NVARCHAR(500) NOT NULL,
    phone NVARCHAR(20),
    role NVARCHAR(20) DEFAULT 'user',
    created_at DATETIME2 DEFAULT SYSUTCDATETIME()
);
GO

CREATE TABLE dbo.Station (
    station_id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(100) NOT NULL,
    city NVARCHAR(100),
    region NVARCHAR(100),
    latitude DECIMAL(9,6),
    longitude DECIMAL(9,6),
    created_at DATETIME2 DEFAULT SYSUTCDATETIME()
);
GO

CREATE TABLE dbo.Route (
    route_id INT IDENTITY(1,1) PRIMARY KEY,
    start_station_id INT REFERENCES Station(station_id),
    end_station_id INT REFERENCES Station(station_id),
    distance_km DECIMAL(8,2),
    route_code NVARCHAR(50),
    created_at DATETIME2 DEFAULT SYSUTCDATETIME()
);
GO

CREATE TABLE dbo.RouteStation (
    route_station_id INT IDENTITY(1,1) PRIMARY KEY,
    route_id INT NOT NULL REFERENCES Route(route_id),
    station_id INT NOT NULL REFERENCES Station(station_id),
    stop_order INT NOT NULL,
    arrival_time TIME,
    departure_time TIME
);
GO

CREATE TABLE dbo.Train (
    train_id INT IDENTITY(1,1) PRIMARY KEY,
    train_number NVARCHAR(50) UNIQUE,
    capacity INT,
    type NVARCHAR(50),
    manufacturer NVARCHAR(100),
    status NVARCHAR(20) DEFAULT 'active',
    created_at DATETIME2 DEFAULT SYSUTCDATETIME()
);
GO

CREATE TABLE dbo.Reservation (
    reservation_id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT REFERENCES Users(user_id),
    train_id INT REFERENCES Train(train_id),
    route_id INT REFERENCES Route(route_id),
    departure_date DATETIME2,
    arrival_date DATETIME2,
    status NVARCHAR(20) DEFAULT 'pending',
    created_at DATETIME2 DEFAULT SYSUTCDATETIME()
);
GO

CREATE TABLE dbo.Ticket (
    ticket_id INT IDENTITY(1,1) PRIMARY KEY,
    reservation_id INT REFERENCES Reservation(reservation_id),
    seat_number NVARCHAR(10),
    class NVARCHAR(20),
    price DECIMAL(10,2),
    issue_date DATETIME2 DEFAULT SYSUTCDATETIME(),
    status NVARCHAR(20) DEFAULT 'active'
);
GO

CREATE TABLE dbo.Payment (
    payment_id INT IDENTITY(1,1) PRIMARY KEY,
    reservation_id INT REFERENCES Reservation(reservation_id),
    amount DECIMAL(10,2),
    payment_method NVARCHAR(50),
    transaction_id NVARCHAR(100),
    payment_date DATETIME2 DEFAULT SYSUTCDATETIME(),
    status NVARCHAR(20) DEFAULT 'pending'
);
GO
