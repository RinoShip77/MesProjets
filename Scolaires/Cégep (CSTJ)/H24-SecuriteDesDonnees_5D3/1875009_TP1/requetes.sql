-- Test #1
-- Procédures et fonctions stockées
-- Tester la function pour afficher le crédit total de l'ensemble des clients
-- La requête devrait afficher "Crédits total = 4904.00$"
SELECT TotalCredit();

-- Test #2
-- Procédures et fonctions stockées
-- Tester la function pour ajouter du crédit à un client en tenant compte de son statut
-- Pour l'exemple, ce sera le client #4 se vera offrir 100$ (multiplier par le taux de son statut de 1.10, donc 110$) à son solde initiale de 709$
-- Le client #4 devrait maintenant avoir un solde de "819$"
CALL DepositCredit(4, 100);

-- Test #3
-- Procédures et fonctions stockées
	-- Test #3.1
		-- Tester la function pour afficher la balance total d'une catégorie ('blades', 'rachets', 'bits') en 'CAD' et en 'USD'
        -- La requête devrait afficher "Balance total : 4203.28 CAD$ et 3090.65 $USD"
		SELECT TotalBalanceCategory('blades');
    -- Test #3.2
		-- Tester la function pour afficher la balance total de l'ensemble de l'inventaire en 'CAD' et en 'USD'
		-- La requête devrait afficher "Balance total : 7283.00 CAD$ et 5355.15 $USD"
		SELECT TotalBalanceCategory('');

-- Test #4
-- Procédures et fonctions stockées
-- Tester la function pour afficher la balance total d'un set en fonction du rabais d'un client
-- Pour l'exemple, ce sera le total du set #1 (372$) avec le rabais du client #1 (0.10)
-- La requête devrait afficher 'Balance total du "set" #1 : 362.00$'
SELECT TotalBalanceSet(1, 1);

-- Test #5
-- Déclancheurs
-- Tester le déclancheur pour ajouter une nouvelle entré dans la table 'credits_logs' lors de la modification (ajout +/retrait -) du crédits d'un client
-- Pour l'exemple, ce sera un dépot de 500 crédits au client #1
-- La table 'credits_logs' devrait avoir une nouvelle ligne avec les données log_id => 1, client_id => 1, variation => + 500$, technician_name => [utilisateur]@[adresseIP] et date => [la date du jour]
UPDATE clients SET client_credit = client_credit + 500 WHERE client_id = 1;

-- Test #6
-- Déclancheurs
-- Tester le déclancheur pour ajouter une nouvelle entré dans la table 'inventaire_logs' lors de la modification (ajout +/retrait -) de la quantité d'une pièce (blade, ratchet ou bit)
-- Pour l'exemple, ce sera un retrait de 5 unités à la pièce #7 de la table 'ratchets'
-- La table 'inventaire_logs' devrait avoir une nouvelle ligne avec les données log_id => 1, part_table => 'ratchets', part_id => 7, variation => - 5, technician_name => [utilisateur]@[adresseIP] et date => [la date du jour]
UPDATE ratchets SET ratchet_quantity = ratchet_quantity - 5 WHERE ratchet_id = 7;

-- Test #7
-- Déclancheurs
-- Tester le déclancheur pour ajouter du crédit à trois client selon leur position (1er => 100$, 2ième => 50$, 3ième => 25$) lors d'une nouvelle entré dans la table 'tournaments'
-- Pour l'exemple, ce sera le client #11 (+ 100$), le #15 (+ 50$) et le #6 (+ 25$)
-- 1er : Le client #11 devrait maintenant avoir un solde de "235$" au lieu de 135$
-- 2ième : Le client #15 devrait maintenant avoir un solde de "413$" au lieu de 363$
-- 3ième : Le client #6 devrait maintenant avoir un solde de "514$" au lieu de 489$
INSERT INTO tournaments (tournament_name, first_place_client_id, second_place_client_id, third_place_client_id, tournament_date) VALUES
('test', 11, 15, 6, CURRENT_DATE());