-- Procédures et fonctions stockées
-- DROP
DROP PROCEDURE IF EXISTS ReplaceTier;
DROP FUNCTION IF EXISTS TotalCredit;
DROP PROCEDURE IF EXISTS DepositCredit;
DROP FUNCTION IF EXISTS TotalBalanceCategory;
DROP FUNCTION IF EXISTS TotalBalanceSet;

-- Procédure et fonction stockée #1
-- STORED PROCEDURE
DELIMITER $$
CREATE PROCEDURE ReplaceTier()
BEGIN
	DECLARE affected_rows INT;
	DECLARE vClientID INT;
    DECLARE vTierID INT;
    DECLARE done INT DEFAULT FALSE;
    DECLARE selector CURSOR FOR SELECT clients.client_id, clients_tiers.tier_id FROM clients_tiers INNER JOIN clients ON clients_tiers.tier_name = clients.client_tier;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
    OPEN selector;
    read_loop: LOOP
        FETCH selector INTO vClientID, vTierID;
        
        IF done THEN
            LEAVE read_loop;
        END IF;
        
        START TRANSACTION;
        UPDATE clients SET client_tier = vTierID WHERE client_id = vClientID;
        
        SELECT ROW_COUNT() INTO affected_rows;
		IF affected_rows = 0 THEN
			ROLLBACK;
		ELSE
			COMMIT;
		END IF;
    END LOOP;
    CLOSE selector;
END$$
DELIMITER ;

-- Procédure et fonction stockée #2
-- STORED FUNCTION
DELIMITER $$
CREATE FUNCTION TotalCredit()
RETURNS VARCHAR(255)
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE credit DECIMAL(15, 2);
    DECLARE totalCredit DECIMAL(15, 2) DEFAULT 0;
    DECLARE selector CURSOR FOR SELECT client_credit FROM clients;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
    OPEN selector;
    read_loop: LOOP
        FETCH selector INTO credit;
        IF done THEN
            LEAVE read_loop;
        END IF;
        SET totalCredit = totalCredit + credit;
    END LOOP;
    CLOSE selector;
    
    RETURN CONCAT('Crédits total = ', totalCredit, '$');
END$$
DELIMITER ;

-- Procédure et fonction stockée #3
-- STORED PROCEDURE
DELIMITER $$
CREATE PROCEDURE DepositCredit(
IN clientID INT,
IN creditAmount DECIMAL(15,2)
)
BEGIN
    DECLARE affected_rows INT;
    DECLARE done INT DEFAULT FALSE;
    DECLARE vClientID INT;
    DECLARE vTauxCredit DECIMAL(15, 2);
    DECLARE selector CURSOR FOR SELECT clients.client_id, clients_tiers.taux_credit FROM clients_tiers INNER JOIN clients ON clients_tiers.tier_id = clients.client_tier;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
	OPEN selector;
    read_loop: LOOP
		FETCH selector INTO vClientID, vTauxCredit;
        IF done THEN
            LEAVE read_loop;
        END IF;
	
		START TRANSACTION;
		UPDATE clients SET client_credit = client_credit + (creditAmount * vTauxCredit) WHERE client_id = clientID AND client_id = vClientID;

		SELECT ROW_COUNT() INTO affected_rows;
		IF affected_rows = 0 THEN
			ROLLBACK;
		ELSE
			COMMIT;
		END IF;
	END LOOP;
    CLOSE selector;
END$$
DELIMITER ;

-- Procédure et fonction stockée #3
-- STORED PROCEDURE
DELIMITER $$
CREATE FUNCTION TotalBalanceCategory(
category ENUM('blades', 'rachets', 'bits', '')
)
RETURNS VARCHAR(100)
BEGIN
    DECLARE totalBalance DECIMAL(15,2);
    DECLARE interestRate DECIMAL(15,2);
    DECLARE response DECIMAL(15,2);
    
    SELECT extra_usdcad INTO interestRate FROM extras ORDER BY extra_version DESC LIMIT 1;
    
    IF category <> '' THEN
		CASE category
            WHEN 'blades' THEN
                SELECT COALESCE(SUM(blade_price * blade_quantity)) INTO totalBalance FROM blades;
            WHEN 'ratchets' THEN
                SELECT COALESCE(SUM(ratchet_price * ratchet_quantity)) INTO totalBalance FROM ratchets;
            WHEN 'bits' THEN
                SELECT COALESCE(SUM(bit_price * bit_quantity)) INTO totalBalance FROM bits;
        END CASE;
        
		SET response = totalBalance;
	ELSE
		SET response = (SELECT COALESCE(SUM(blade_price * blade_quantity)) FROM blades) + (SELECT COALESCE(SUM(ratchet_price * ratchet_quantity)) FROM ratchets) + (SELECT COALESCE(SUM(bit_price * bit_quantity)) FROM bits);
    END IF;
    
    RETURN CONCAT('Balance total : ', CAST((response * interestRate) AS DECIMAL(15,2)), ' CAD$ et ', CAST(response AS DECIMAL(15,2)),' $USD');
END$$
DELIMITER ;

-- Procédure et fonction stockée #4
-- STORED FUNCTION
DELIMITER $$
CREATE FUNCTION TotalBalanceSet(
setID INT,
clientID INT
)
RETURNS VARCHAR(100)
BEGIN
    DECLARE discount DECIMAL(15,2);
    DECLARE response DECIMAL(15,2);
    
    SELECT rabais INTO discount FROM clients_tiers INNER JOIN clients ON clients.client_tier = clients_tiers.tier_id WHERE clients.client_id = clientID;

	SET response = 
    (SELECT COALESCE(SUM(blade_price * blade_quantity)) FROM blades INNER JOIN sets_blades ON blades.blade_id = sets_blades.blade_id WHERE sets_blades.set_id = setID)
    +
    (SELECT COALESCE(SUM(ratchet_price * ratchet_quantity)) FROM ratchets INNER JOIN sets_ratchets ON ratchets.ratchet_id = sets_ratchets.ratchet_id WHERE sets_ratchets.set_id = setID)
    +
    (SELECT COALESCE(SUM(bit_price * bit_quantity)) FROM bits INNER JOIN sets_bits ON bits.bit_id = sets_bits.bit_id WHERE sets_bits.set_id = setID);
    
    RETURN CONCAT('Balance total du "set" #', setID, ' : ', CAST((response - (discount * 100)) AS DECIMAL(15,2)), '$');
END$$
DELIMITER ;