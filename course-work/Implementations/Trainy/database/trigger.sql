CREATE TRIGGER trg_Payment_Confirm
ON dbo.Payment
AFTER INSERT
AS
BEGIN
    UPDATE r
    SET r.status = 'confirmed'
    FROM Reservation r
    INNER JOIN inserted i ON r.reservation_id = i.reservation_id
    WHERE i.status = 'paid';
END;
GO
