-- Création de la base de données
/* Pour des commentaires sur plusieurs lignes ou paragraphes */
CREATE DATABASE MarketingDB;
USE MarketingDB;

-- Modèle de données pour un système de gestion marketing

-- Table des clients : contient les informations personnelles des clients
CREATE TABLE Clients (
    client_id INT PRIMARY KEY AUTO_INCREMENT, -- Identifiant unique du client
    nom VARCHAR(100), -- Nom de famille du client
    prenom VARCHAR(100), -- Prénom du client
    email VARCHAR(150) UNIQUE, -- Adresse email du client, unique
    telephone VARCHAR(20), -- Numéro de téléphone du client
    date_inscription DATE -- Date d'inscription du client
);

-- Table des campagnes marketing : gère les campagnes promotionnelles
CREATE TABLE Campagnes (
    campagne_id INT PRIMARY KEY AUTO_INCREMENT, -- Identifiant unique de la campagne
    nom VARCHAR(150), -- Nom de la campagne
    type VARCHAR(50), -- Type de la campagne (email, publicité, etc.)
    date_debut DATE, -- Date de début de la campagne
    date_fin DATE, -- Date de fin de la campagne
    budget DECIMAL(15, 2) -- Budget alloué à la campagne
);

-- Table des canaux de communication : liste des canaux utilisés pour les campagnes
CREATE TABLE Canaux (
    canal_id INT PRIMARY KEY AUTO_INCREMENT, -- Identifiant unique du canal
    nom VARCHAR(100), -- Nom du canal (email, réseaux sociaux, etc.)
    description TEXT -- Description du canal
);

-- Table des produits : informations sur les produits commercialisés
CREATE TABLE Produits (
    produit_id INT PRIMARY KEY AUTO_INCREMENT, -- Identifiant unique du produit
    nom VARCHAR(100), -- Nom du produit
    description TEXT, -- Description du produit
    prix DECIMAL(10, 2), -- Prix du produit
    categorie VARCHAR(50) -- Catégorie du produit
);

-- Table des ventes : enregistre les transactions de vente
CREATE TABLE Ventes (
    vente_id INT PRIMARY KEY AUTO_INCREMENT, -- Identifiant unique de la vente
    client_id INT, -- Référence au client ayant effectué l'achat
    produit_id INT, -- Référence au produit vendu
    date_vente DATE, -- Date de la vente
    quantite INT, -- Quantité vendue
    montant_total DECIMAL(15, 2), -- Montant total de la vente
    FOREIGN KEY (client_id) REFERENCES Clients(client_id), -- Clé étrangère vers Clients
    FOREIGN KEY (produit_id) REFERENCES Produits(produit_id) -- Clé étrangère vers Produits
);

-- Table des interactions marketing : trace les interactions entre les clients et les campagnes
CREATE TABLE Interactions (
    interaction_id INT PRIMARY KEY AUTO_INCREMENT, -- Identifiant unique de l'interaction
    client_id INT, -- Référence au client
    campagne_id INT, -- Référence à la campagne
    canal_id INT, -- Référence au canal de communication
    date_interaction DATE, -- Date de l'interaction
    type_interaction VARCHAR(50), -- Type d'interaction (clic, ouverture, etc.)
    resultat VARCHAR(100), -- Résultat de l'interaction
    FOREIGN KEY (client_id) REFERENCES Clients(client_id), -- Clé étrangère vers Clients
    FOREIGN KEY (campagne_id) REFERENCES Campagnes(campagne_id), -- Clé étrangère vers Campagnes
    FOREIGN KEY (canal_id) REFERENCES Canaux(canal_id) -- Clé étrangère vers Canaux
);

-- Table des feedbacks clients : recueille les retours des clients sur les campagnes
CREATE TABLE Feedbacks (
    feedback_id INT PRIMARY KEY AUTO_INCREMENT, -- Identifiant unique du feedback
    client_id INT, -- Référence au client
    campagne_id INT, -- Référence à la campagne
    commentaire TEXT, -- Commentaire du client
    note INT CHECK (note BETWEEN 1 AND 5), -- Note de satisfaction (entre 1 et 5)
    date_feedback DATE, -- Date du feedback
    FOREIGN KEY (client_id) REFERENCES Clients(client_id), -- Clé étrangère vers Clients
    FOREIGN KEY (campagne_id) REFERENCES Campagnes(campagne_id) -- Clé étrangère vers Campagnes
);

-- Table des segments de clients : regroupe les clients selon des critères marketing
CREATE TABLE Segments (
    segment_id INT PRIMARY KEY AUTO_INCREMENT, -- Identifiant unique du segment
    nom VARCHAR(100), -- Nom du segment
    description TEXT -- Description des caractéristiques du segment
);

-- Table d'affectation des clients aux segments : associe les clients à des segments spécifiques
CREATE TABLE Client_Segment (
    client_id INT, -- Référence au client
    segment_id INT, -- Référence au segment
    date_affectation DATE, -- Date d'affectation du client au segment
    PRIMARY KEY (client_id, segment_id), -- Clé primaire composite
    FOREIGN KEY (client_id) REFERENCES Clients(client_id), -- Clé étrangère vers Clients
    FOREIGN KEY (segment_id) REFERENCES Segments(segment_id) -- Clé étrangère vers Segments
);

-- Table des performances des campagnes : suit les indicateurs de performance des campagnes
CREATE TABLE Performances_Campagnes (
    performance_id INT PRIMARY KEY AUTO_INCREMENT, -- Identifiant unique de la performance
    campagne_id INT, -- Référence à la campagne
    indicateur VARCHAR(100), -- Nom de l'indicateur de performance (ROI, CTR, etc.)
    valeur DECIMAL(15, 2), -- Valeur mesurée de l'indicateur
    date_mesure DATE, -- Date de la mesure
    FOREIGN KEY (campagne_id) REFERENCES Campagnes(campagne_id) -- Clé étrangère vers Campagnes
);




