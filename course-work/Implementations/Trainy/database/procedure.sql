CREATE PROCEDURE dbo.sp_CreateReservation
    @user_id INT,
    @train_id INT,
    @route_id INT,
    @departure_date DATETIME2,
    @arrival_date DATETIME2,
    @seat_number NVARCHAR(10),
    @class NVARCHAR(20),
    @base_price DECIMAL(10,2)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @price DECIMAL(10,2) = dbo.fn_CalculatePrice(@class, @base_price);

    INSERT INTO Reservation (user_id, train_id, route_id, departure_date, arrival_date, status)
    VALUES (@user_id, @train_id, @route_id, @departure_date, @arrival_date, 'pending');

    DECLARE @res_id INT = SCOPE_IDENTITY();

    INSERT INTO Ticket (reservation_id, seat_number, class, price)
    VALUES (@res_id, @seat_number, @class, @price);
END;
GO
