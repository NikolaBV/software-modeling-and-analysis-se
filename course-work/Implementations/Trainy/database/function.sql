CREATE FUNCTION dbo.fn_CalculatePrice (
    @class NVARCHAR(20),
    @basePrice DECIMAL(10,2)
)
RETURNS DECIMAL(10,2)
AS
BEGIN
    DECLARE @multiplier DECIMAL(3,2) = 1.0;

    IF @class = '1st' SET @multiplier = 1.5;
    IF @class = '2nd' SET @multiplier = 1.0;

    RETURN ROUND(@basePrice * @multiplier, 2);
END;
GO
