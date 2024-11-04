CREATE TABLE IF NOT EXISTS PENALTY(
    PenaltyID INT PRIMARY KEY,
    PenaltyDate TIMESTAMP,
    ReturnTime TIMESTAMP,
    Amount FLOAT,
    Reason varChar(100),
    Status BOOLEAN,
    UserID INT,
    FOREIGN KEY (UserID) REFERENCES CUSTOMER(CustomerID)


);
