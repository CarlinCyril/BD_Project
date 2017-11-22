CREATE TABLE Ville (
    nomVille char(20),
    pays char(20)
    CONSTRAINT pk_ville PRIMARY KEY (nomVille, pays)
);

CREATE TABLE Hotel (
    nomHotel char(20),
    nomVille char(20),
    pays char(20),
    CONSTRAINT pk_hotel PRIMARY KEY (nomHotel, nomVille, pays),
    CONSTRAINT fk_hotel_ville FOREIGN KEY (nomVille, pays) REFERENCES Ville(nomVille, pays)
);

CREATE TABLE LieuAVisiter (
    nomLieu char(50),
    nomVille char(20),
    pays char(20),
    CONSTRAINT pk_lieu_a_visiter PRIMARY KEY (nomLieu, nomVille, pays),
    CONSTRAINT fk_lieu_a_visiter_ville FOREIGN KEY (nomVille, pays) REFERENCES Ville(nomVille, pays)
);

CREATE TABLE Circuit (
    idCircuit char(5) PRIMARY KEY,
    descriptif char(50),
    villeDepart char(20), 
    paysDepart char(20),
    villeArrivee char(20),
    paysArrivee char(20),
    nbJoursTotal INTEGER,
    prixCircuit INTEGER,
    CONSTRAINT fk_circuit_ville_depart FOREIGN KEY (villeDepart, paysDepart) REFERENCES Ville(nomVille, pays),
    CONSTRAINT fk_circuit_ville_arrivee FOREIGN KEY (villeArrivee, paysArrivee) REFERENCES Ville(nomVille, pays)
);

CREATE TABLE DateCircuit (
    idCircuit char(5) REFERENCES Circuit(idCircuit),
    dateDepartCircuit date,
    nbPersonne INTEGER,
    CONSTRAINT pk_date_circuit PRIMARY KEY (idCircuit, dateDepartCircuit),
);

CREATE TABLE Etapes (
    idCircuit char(5) REFERENCES Circuit(idCircuit),
    ordre INTEGER,
    nomLieu char(20),
    nomVille char(20),
    pays char(20),
    CONSTRAINT pk_etapes PRIMARY KEY (idCircuit, ordre),
    CONSTRAINT fk_etapes_lieu FOREIGN KEY (nomLieu, nomVille, pays) REFERENCES LieuAVisiter(nomLieu, nomVille, pays)
);

CREATE TABLE Client (
    idClient NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nomClient char(20),
    typeClient char(20),
    anneeEnregistrement INTEGER
);

CREATE TABLE Simulation (
    idSimulation NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    idClient NUMBER REFERENCES Client(idCLient),
    dateDepart date,
    dateArrivee date,
    nbParticipants INTEGER
);

CREATE TABLE AssocSimulationHotel (
    nomHotel char(20),
    ville char(20),
    pays char(20),
    idSimulation NUMBER REFERENCES Simulation(idSimulation),
    CONSTRAINT pk_assoc_simulation_hotel PRIMARY KEY (nomHotel, ville, pays, idSimulation),
    CONSTRAINT fk_assoc_hotel FOREIGN KEY (nomHotel, ville, pays) REFERENCES Hotel(nomHotel, nomVille, pays)
);

CREATE TABLE AssocSimulationCircuit (
    idSimulation NUMBER REFERENCES Simulation(idSimulation),
    idCircuit char(5) REFERENCES Circuit(idCircuit),
    CONSTRAINT pk_assoc_simulation_circuit PRIMARY KEY (idSimulation, idCircuit)
);

CREATE TABLE AssocSimulationVille (
    idSimulation NUMBER REFERENCES Simulation(idSimulation),
    ville char(20),
    pays char(20),
    CONSTRAINT fk_assoc_ville FOREIGN KEY (ville, pays) REFERENCES Ville(nomVille, pays)
);
