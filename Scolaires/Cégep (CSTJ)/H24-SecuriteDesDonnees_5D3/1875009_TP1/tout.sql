-- Modify by OB (1875009) on april 6th 2024
-- Préparer la BD et les tables #0
DROP TABLE IF EXISTS `clients_tiers`;
DROP TABLE IF EXISTS `credits_logs`;
DROP TABLE IF EXISTS `inventaire_logs`;
DROP PROCEDURE IF EXISTS ReplaceTier;
DROP FUNCTION IF EXISTS TotalCredit;
DROP PROCEDURE IF EXISTS DepositCredit;
DROP FUNCTION IF EXISTS TotalBalanceCategory;
DROP FUNCTION IF EXISTS TotalBalanceSet;
DROP TRIGGER IF EXISTS CreditsLogsUpdate;
DROP TRIGGER IF EXISTS InventoryLogsUpdateBlades;
DROP TRIGGER IF EXISTS InventoryLogsUpdateRatchets;
DROP TRIGGER IF EXISTS InventoryLogsUpdateBits;
DROP TRIGGER IF EXISTS TournamentsUpdate;

-- Préparer la BD et les tables #1
INSERT INTO extras (extra_version, extra_usdcad, extra_matricule) VALUES
	(2, 1.36, '1875009');

-- Préparer la BD et les tables #2
CREATE TABLE clients_tiers (
    tier_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    tier_name ENUM('Bronze', 'Silver', 'Gold', 'Platinum', 'Black'),
    taux_credit DECIMAL(15,2) NOT NULL,
    rabais DECIMAL(15,2) NOT NULL
);

-- Préparer la BD et les tables #3
INSERT INTO clients_tiers (tier_name, taux_credit, rabais) VALUES
	('Bronze', 1, 0),
	('Silver', 1.1, 0.05),
	('Gold', 1.2, 0.1),
	('Platinum', 1.3, 0.15);

-- Préparer la BD et les tables #4
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

-- Préparer la BD et les tables #6
CALL ReplaceTier();

-- Préparer la BD et les tables #7
ALTER TABLE clients
	MODIFY COLUMN client_tier INT;

-- Préparer la BD et les tables #8
ALTER TABLE clients
	ADD FOREIGN KEY (client_tier)
    REFERENCES clients_tiers(tier_id)
    ON UPDATE CASCADE;

-- Préparer la BD et les tables #9
CREATE TABLE credits_logs (
    log_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    client_id INT,
    variation VARCHAR(50) NOT NULL,
    technician_name VARCHAR(255) NOT NULL DEFAULT 'XXXXXX XXXXXX',
    date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (client_id) REFERENCES clients(client_id)
);

-- Préparer la BD et les tables #10
CREATE TABLE inventaire_logs (
    log_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    part_table ENUM('blades', 'ratchets', 'bits'), 
    part_id INT NOT NULL,
    variation VARCHAR(50) NOT NULL,
    technician_name VARCHAR(255) NOT NULL DEFAULT 'XXXXXX XXXXXX',
    date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (part_id) REFERENCES clients(client_id)
);

-- Procédures et fonctions stockées #1
DELIMITER $$
CREATE FUNCTION TotalCredit()
RETURNS VARCHAR(255)
BEGIN
    DECLARE credit DECIMAL(15, 2);
    DECLARE totalCredit DECIMAL(15, 2) DEFAULT 0;
    DECLARE done INT DEFAULT FALSE;
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

-- Procédures et fonctions stockées #2
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

-- Procédures et fonctions stockées #3
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

-- Procédures et fonctions stockées #4
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

-- Déclancheurs #1
DELIMITER $$
CREATE TRIGGER CreditsLogsUpdate
AFTER UPDATE ON clients
FOR EACH ROW
BEGIN
	SAVEPOINT before_update;

    IF OLD.client_credit <> NEW.client_credit THEN
		IF OLD.client_credit < NEW.client_credit THEN
			INSERT INTO credits_logs (client_id, variation, technician_name, date)
			VALUES (NEW.client_id, CONCAT('+ ', (NEW.client_credit - OLD.client_credit), '$'), CURRENT_USER(), NOW());
		END IF;
		IF OLD.client_credit > NEW.client_credit THEN
			INSERT INTO credits_logs (client_id, variation, technician_name, date)
			VALUES (NEW.client_id, CONCAT('- ', (OLD.client_credit - NEW.client_credit), '$'), CURRENT_USER(), NOW());
		END IF;
    ELSE
        ROLLBACK TO before_update;
	END IF;
END$$
DELIMITER ;

-- Déclancheurs #2
DELIMITER $$
CREATE TRIGGER InventoryLogsUpdateBlades
AFTER UPDATE ON blades
FOR EACH ROW
BEGIN
	SAVEPOINT before_update;

    IF OLD.blade_quantity <> NEW.blade_quantity THEN
		IF OLD.blade_quantity < NEW.blade_quantity THEN
			INSERT INTO inventaire_logs (part_table, part_id, variation, technician_name, date)
			VALUES ('blades', NEW.blade_id, CONCAT('+ ', (NEW.blade_quantity - OLD.blade_quantity)), CURRENT_USER(), NOW());
		END IF;
		IF OLD.blade_quantity > NEW.blade_quantity THEN
			INSERT INTO inventaire_logs (part_table, part_id, variation, technician_name, date)
			VALUES ('blades', NEW.blade_id, CONCAT('- ', (OLD.blade_quantity - NEW.blade_quantity)), CURRENT_USER(), NOW());
		END IF;
    ELSE
        ROLLBACK TO before_update;
	END IF;
END$$
DELIMITER ;

-- Déclancheurs #3
DELIMITER $$
CREATE TRIGGER InventoryLogsUpdateRatchets
AFTER UPDATE ON ratchets
FOR EACH ROW
BEGIN
	SAVEPOINT before_update;
    
	IF OLD.ratchet_quantity <> NEW.ratchet_quantity THEN
		IF OLD.ratchet_quantity < NEW.ratchet_quantity THEN
			INSERT INTO inventaire_logs (part_table, part_id, variation, technician_name, date)
			VALUES ('ratchets', NEW.ratchet_id, CONCAT('+ ', (NEW.ratchet_quantity - OLD.ratchet_quantity)), CURRENT_USER(), NOW());
		END IF;
		IF OLD.ratchet_quantity > NEW.ratchet_quantity THEN
			INSERT INTO inventaire_logs (part_table, part_id, variation, technician_name, date)
			VALUES ('ratchets', NEW.ratchet_id, CONCAT('- ', (OLD.ratchet_quantity - NEW.ratchet_quantity)), CURRENT_USER(), NOW());
		END IF;
    ELSE
        ROLLBACK TO before_update;
	END IF;
END$$
DELIMITER ;

-- Déclancheurs #4
DELIMITER $$
CREATE TRIGGER InventoryLogsUpdateBits
AFTER UPDATE ON bits
FOR EACH ROW
BEGIN
	SAVEPOINT before_update;
    
    IF OLD.bit_quantity <> NEW.bit_quantity THEN
		IF OLD.bit_quantity < NEW.bit_quantity THEN
			INSERT INTO inventaire_logs (part_table, part_id, variation, technician_name, date)
			VALUES ('bits', NEW.bit_id, CONCAT('+ ', (NEW.bit_quantity - OLD.bit_quantity)), CURRENT_USER(), NOW());
		END IF;
		IF OLD.bit_quantity > NEW.bit_quantity THEN
			INSERT INTO inventaire_logs (part_table, part_id, variation, technician_name, date)
			VALUES ('bits', NEW.bit_id, CONCAT('- ', (OLD.bit_quantity - NEW.bit_quantity)), CURRENT_USER(), NOW());
		END IF;
    ELSE
        ROLLBACK TO before_update;
	END IF;
END$$
DELIMITER ;

-- Déclancheurs #5
DELIMITER $$
CREATE TRIGGER TournamentsUpdate
AFTER INSERT ON tournaments
FOR EACH ROW
BEGIN	
    SAVEPOINT before_update;
    
    IF EXISTS(SELECT client_id FROM clients WHERE clients.client_id = NEW.first_place_client_id OR clients.client_id = NEW.second_place_client_id OR clients.client_id = NEW.third_place_client_id) THEN
		UPDATE clients SET client_credit = client_credit + 100 WHERE clients.client_id = NEW.first_place_client_id;
		UPDATE clients SET client_credit = client_credit + 50 WHERE clients.client_id = NEW.second_place_client_id;
		UPDATE clients SET client_credit = client_credit + 25 WHERE clients.client_id = NEW.third_place_client_id;
	ELSE    
		ROLLBACK TO before_update;
	END IF;
END$$
DELIMITER ;