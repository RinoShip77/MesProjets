-- Préparer la BD et les tables
-- DROP
DROP TABLE IF EXISTS `clients_tiers`;
DROP TABLE IF EXISTS `credits_logs`;
DROP TABLE IF EXISTS `inventaire_logs`;

-- Préparer la BD et les tables #1
-- CREATE TABLE
CREATE TABLE clients_tiers (
    tier_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    tier_name ENUM('Bronze', 'Silver', 'Gold', 'Platinum', 'Black'),
    taux_credit DECIMAL(15,2) NOT NULL,
    rabais DECIMAL(15,2) NOT NULL
);
CREATE TABLE credits_logs (
    log_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    client_id INT,
    variation VARCHAR(50) NOT NULL,
    technician_name VARCHAR(255) NOT NULL DEFAULT 'XXXXXX XXXXXX',
    date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (client_id) REFERENCES clients(client_id)
);
CREATE TABLE inventaire_logs (
    log_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    part_table ENUM('blades', 'rachets', 'bits'), 
    part_id INT NOT NULL,
    variation VARCHAR(50) NOT NULL,
    technician_name VARCHAR(255) NOT NULL DEFAULT 'XXXXXX XXXXXX',
    date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (part_id) REFERENCES clients(client_id)
);

-- Préparer la BD et les tables #2
-- INSERT INTO
INSERT INTO extras (extra_version, extra_usdcad, extra_matricule) VALUES
	(2, 1.35, '1875009');
INSERT INTO clients_tiers (tier_name, taux_credit, rabais) VALUES
	('Bronze', 1, 0),
	('Silver', 1.1, 0.05),
	('Gold', 1.2, 0.1),
	('Platinum', 1.3, 0.15);


-- Préparer la BD et les tables #3
-- ALTER TABLE
CALL ReplaceTier(); -- Call a procedure to add the foreign key
ALTER TABLE clients
	MODIFY COLUMN client_tier INT;
ALTER TABLE clients
	ADD FOREIGN KEY (client_tier)
    REFERENCES clients_tiers(tier_id)
    ON UPDATE CASCADE;