-- Users
INSERT INTO Users (first_name, last_name, email, password_hash) VALUES
('Ivan', 'Petrov', 'ivan@example.com', 'hash1'),
('Maria', 'Dimitrova', 'maria@example.com', 'hash2');

INSERT INTO Station (name, city, region) VALUES
('Sofia Central', 'Sofia', 'Sofia'),
('Plovdiv Central', 'Plovdiv', 'Plovdiv'),
('Varna Central', 'Varna', 'Varna');

INSERT INTO Route (start_station_id, end_station_id, distance_km, route_code)
VALUES (1, 2, 150, 'SOF-PDV');

INSERT INTO RouteStation (route_id, station_id, stop_order)
VALUES (1, 1, 1), (1, 2, 2);

INSERT INTO Train (train_number, capacity, type, manufacturer)
VALUES ('T100', 300, 'Express', 'Siemens');

EXEC dbo.sp_CreateReservation 
    @user_id = 1,
    @train_id = 1,
    @route_id = 1,
    @departure_date = '2025-11-10 08:00',
    @arrival_date = '2025-11-10 10:00',
    @seat_number = 'A1',
    @class = '1st',
    @base_price = 25.00;

INSERT INTO Payment (reservation_id, amount, payment_method, transaction_id, status)
VALUES (1, 37.50, 'Stripe', 'txn_001', 'paid');
