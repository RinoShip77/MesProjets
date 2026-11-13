-- Déclancheurs
-- DROP
DROP TRIGGER IF EXISTS CreditsLogsUpdate;
DROP TRIGGER IF EXISTS InventoryLogsUpdateBlades;
DROP TRIGGER IF EXISTS InventoryLogsUpdateRatchets;
DROP TRIGGER IF EXISTS InventoryLogsUpdateBits;
DROP TRIGGER IF EXISTS TournamentsUpdate;

-- Déclancheur #1
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

-- Déclancheur #2
-- TRIGGER #2.1
DELIMITER $$
CREATE TRIGGER InventoryLogsUpdateBlades
AFTER UPDATE ON blades
FOR EACH ROW
BEGIN
	SAVEPOINT before_update;

    IF OLD.blade_quantity <> NEW.blade_quantity THEN
		IF OLD.blade_quantity < NEW.blade_quantity THEN
			INSERT INTO inventaire_logs (part_table, part_id, variation, technician_name, date)
			VALUES ('blades', NEW.blade_id, CONCAT('+ ', (NEW.blade_quantity - OLD.blade_quantity), '$'), CURRENT_USER(), NOW());
		END IF;
		IF OLD.blade_quantity > NEW.blade_quantity THEN
			INSERT INTO inventaire_logs (part_table, part_id, variation, technician_name, date)
			VALUES ('blades', NEW.blade_id, CONCAT('- ', (OLD.blade_quantity - NEW.blade_quantity), '$'), CURRENT_USER(), NOW());
		END IF;
    ELSE
        ROLLBACK TO before_update;
	END IF;
END$$
DELIMITER ;

-- TRIGGER #2.2
DELIMITER $$
CREATE TRIGGER InventoryLogsUpdateRatchets
AFTER UPDATE ON ratchets
FOR EACH ROW
BEGIN
	SAVEPOINT before_update;
    
	IF OLD.ratchet_quantity <> NEW.ratchet_quantity THEN
		IF OLD.ratchet_quantity < NEW.ratchet_quantity THEN
			INSERT INTO inventaire_logs (part_table, part_id, variation, technician_name, date)
			VALUES ('ratchets', NEW.ratchet_id, CONCAT('+ ', (NEW.ratchet_quantity - OLD.ratchet_quantity), '$'), CURRENT_USER(), NOW());
		END IF;
		IF OLD.ratchet_quantity > NEW.ratchet_quantity THEN
			INSERT INTO inventaire_logs (part_table, part_id, variation, technician_name, date)
			VALUES ('ratchets', NEW.ratchet_id, CONCAT('- ', (OLD.ratchet_quantity - NEW.ratchet_quantity), '$'), CURRENT_USER(), NOW());
		END IF;
    ELSE
        ROLLBACK TO before_update;
	END IF;
END$$
DELIMITER ;

-- TRIGGER #2.3
DELIMITER $$
CREATE TRIGGER InventoryLogsUpdateBits
AFTER UPDATE ON bits
FOR EACH ROW
BEGIN
	SAVEPOINT before_update;
    
    IF OLD.bit_quantity <> NEW.bit_quantity THEN
		IF OLD.bit_quantity < NEW.bit_quantity THEN
			INSERT INTO inventaire_logs (part_table, part_id, variation, technician_name, date)
			VALUES ('bits', NEW.bit_id, CONCAT('+ ', (NEW.bit_quantity - OLD.bit_quantity), '$'), CURRENT_USER(), NOW());
		END IF;
		IF OLD.bit_quantity > NEW.bit_quantity THEN
			INSERT INTO inventaire_logs (part_table, part_id, variation, technician_name, date)
			VALUES ('bits', NEW.bit_id, CONCAT('- ', (OLD.bit_quantity - NEW.bit_quantity), '$'), CURRENT_USER(), NOW());
		END IF;
    ELSE
        ROLLBACK TO before_update;
	END IF;
END$$
DELIMITER ;

-- Déclancheur #3
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