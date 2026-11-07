-- 4.1.1. Table CLIENTS
CREATE TABLE CLIENTS
(CodeC NUMBER CONSTRAINT pk_clients PRIMARY KEY, -- code d'un client
NomC varchar2 (30) CONSTRAINT nn_clients_nomC NOT NULL, -- nom d'un client
PrenomC varchar2 (30) CONSTRAINT nn_clients_prenomC NOT NULL, -- prénom d'un client
TelC varchar2 (15) CONSTRAINT nn_clients_telC NOT NULL, -- téléphone d'un client
MelC varchar2 (30) CONSTRAINT nn_clients_melC NOT NULL, -- adresse email d'un client
CONSTRAINT ck_clients_codeC CHECK (CodeC>0));

-- 4.1.2. Table AEROPORTS_DEP
CREATE TABLE AEROPORTS_DEP
( CodeA NUMBER CONSTRAINT pk_aeroports PRIMARY KEY, -- code d'un aéroport
NomA varchar2 (30) CONSTRAINT nn_aeroports_dep_nomA not null, -- nom d'un aéroport
CONSTRAINT ck_aeroports_dep_codeA CHECK (CodeA>0));

-- 4.1.3. Table CIRCUITS
CREATE TABLE CIRCUITS
( CodeCI NUMBER CONSTRAINT pk_circuits PRIMARY KEY, -- code d'un circuit
CONSTRAINT ck_circuits_codeCI CHECK (CodeCI>0),
NomCI varchar2 (30) constraint nn_circuits_nomCI not null, -- nom d'un circuit
PrixBase NUMBER(6,2) CONSTRAINT nn_circuits_prixBase not null, -- le prix suit un format 0,00€
CONSTRAINT ck_circuits_prixBase check (PrixBase >0), -- prix de base > 0
NbPersMax number CONSTRAINT nn_circuits_NbPersMax not null, -- nombre de personnes maximale dans un circuit
CONSTRAINT ck_circuits_NbPersMax check (NbPersMax>0), -- nombre maximum de personnes acceptées par le circuit
CodeCI_Est_Complete number, -- un circuit ne complète pas forcément un autre circuit donc pas de contraintes NOT NULL
CONSTRAINT fk_CIRCUITCOMPLETE
FOREIGN KEY (CodeCI_Est_Complete) -- code du circuit complétant un autre circuit
REFERENCES CIRCUITS (CodeCI)
ON DELETE CASCADE);

-- 4.1.4. Table CHOIX
CREATE TABLE CHOIX
( CodeC number, -- code d'un client
CodeA number, -- code d'un aéroport
CodeCI number, -- code d'un circuit
DateDepartC date, -- date de départ du circuit
OrdrePreference number CONSTRAINT nn_choix_ordrePreference not null, -- 1, 2 ou 3
CONSTRAINT ck_OrdrePreference
check (OrdrePreference in (1,2,3)),
CONSTRAINT pk_CHOIX
PRIMARY KEY (CodeC, CodeA, CodeCI, dateDepartC),
CONSTRAINT fk_CHOIXC
FOREIGN KEY ( CodeC)
REFERENCES CLIENTS ( CodeC)
ON DELETE CASCADE ,
CONSTRAINT fk_CHOIXA
FOREIGN KEY (CodeA)
REFERENCES AEROPORTS_DEP (CodeA)
ON DELETE CASCADE,
CONSTRAINT fk_CHOIXCI
FOREIGN KEY (CodeCI)
REFERENCES CIRCUITS (CodeCI)
ON DELETE CASCADE );

-- 4.1.5. Table RESERVER
CREATE TABLE RESERVER
(CodeC number, -- code d'un client
CodeA number, -- code d'un aéroport
CodeCI number, -- code d'un circuit
DateDepartR date CONSTRAINT nn_reserver_dateDepartR not null, -- date de départ du circuit
DateResa date CONSTRAINT nn_reserver_dateResa not null, -- date de réservation du circuit
NbPers number CONSTRAINT nn_reserver_nbPers not null, -- nombre de personnes accompagnant le client pour le circuit
CONSTRAINT ck_NbPers check (NbPers>0), -- nombre de personnes > 0
CONSTRAINT pk_RESERVER
PRIMARY KEY (CodeC, CodeA, CodeCI, DateDepartR),
CONSTRAINT fk_RESERVERC FOREIGN KEY (CodeC)
REFERENCES CLIENTS ( CodeC) ON DELETE CASCADE,
CONSTRAINT fk_RESERVERA FOREIGN KEY (CodeA)
REFERENCES AEROPORTS_DEP (CodeA) ON DELETE CASCADE,
CONSTRAINT fk_RESERVERCI FOREIGN KEY (CodeCI)
REFERENCES CIRCUITS (CodeCI) ON DELETE CASCADE);

-- 4.1.6. Table MAJORATION
CREATE TABLE MAJORATION
(CodeA number, -- code d'un aéroport
CodeCI number, -- code d'un circuit
DateDepartM date CONSTRAINT nn_majoration_dateDepartM not null, -- date de départ du circuit
MontantMaj NUMBER(5,2) CONSTRAINT nn_majoration_montantMaj not null, -- montant de la majoration en fonction de l'aéroport et la date de départ
CONSTRAINT ck_MontantMaj
check (MontantMaj>0), -- montant de majoration > 0 suivant le format 0,00€
CONSTRAINT pk_MAJORATION
PRIMARY KEY ( CodeA, CodeCI, DateDepartM),
CONSTRAINT fk_MAJORATIONA
FOREIGN KEY (CodeA)
REFERENCES AEROPORTS_DEP (CodeA)
ON DELETE CASCADE,
CONSTRAINT fk_MAJORATIONCI
FOREIGN KEY (CodeCI)
REFERENCES CIRCUITS (CodeCI)
ON DELETE CASCADE );

-- 4.1.7. Table HOTELS
CREATE TABLE HOTELS
(CodeH NUMBER CONSTRAINT pk_hotels PRIMARY KEY, -- code d'un hotel
CONSTRAINT ck_hotels_codeH CHECK (CodeH>0),
NomH varchar2 (30) CONSTRAINT nn_hotels_nomH not null, -- nom de l'hotel
Categorie number CONSTRAINT nn_hotels_categorie not null, -- nombre d'étoiles associé à l'hôtel
CONSTRAINT ck_Categorie check(Categorie>0), -- nombre d'étoiles > 0
VilleH varchar2 (30) CONSTRAINT nn_hotels_villeH not null,
-- le téléphone ou l'adresse email doit être mentionné
TelH varchar2 (20), -- téléphone de l'hotel
MelH varchar2 (20)); -- adresse email de l'hotel

-- 4.1.8. Table LOGER
CREATE TABLE LOGER
(CodeCI number, -- code d'un circuit
CodeH number, -- code d'un hotel
JourSe varchar2(10) CONSTRAINT nn_loger_jourSe not null, -- jour de la semaine
CONSTRAINT pk_LOGER PRIMARY KEY (CodeCI, CodeH),
CONSTRAINT ck_loger_JourSe
check (JourSe in ('Lundi','Mardi','Mercredi','Jeudi','Vendredi','Samedi','Dimanche')),
CONSTRAINT fk_loger_codeCI FOREIGN KEY (CodeCI)
REFERENCES CIRCUITS (CodeCI) ON DELETE CASCADE,
CONSTRAINT fk_loger_codeH FOREIGN KEY (CodeH)
REFERENCES HOTELS (CodeH) ON DELETE CASCADE);

-- 4.1.9. Table ANIMATIONS
CREATE TABLE ANIMATIONS (
CodeAN  NUMBER CONSTRAINT pk_animations PRIMARY KEY, -- code d'une animation
NomAN  VARCHAR2(30) CONSTRAINT nn_animations_nomAN NOT NULL, -- nom d'une animation
TypeAN  VARCHAR2(20) CONSTRAINT nn_animations_typeAN NOT NULL, -- type d'une animation
HeureDeb    DATE CONSTRAINT nn_animations_heureDeb NOT NULL, -- heure de début de l'animation
JourSemaine VARCHAR2(10) CONSTRAINT nn_animations_jourSemaine NOT NULL, -- jour de la semaine
CodeH   number CONSTRAINT nn_animations_codeH NOT NULL, -- code de l'hotel qui propose l'animation
CONSTRAINT fk_animations_codeH
FOREIGN KEY (CodeH) REFERENCES HOTELS (CodeH) ON DELETE CASCADE,
CONSTRAINT ck_animations_typeAN
CHECK (TypeAN IN ('Concert', 'Danse folklorique', 'Danse', 'Cabaret', 'Karaoké')), -- énumération des types d'animations disponibles
CONSTRAINT ck_animations_jourSemaine
CHECK (JourSemaine IN ('Lundi', 'Mardi', 'Mercredi', 'Jeudi', 'Vendredi', 'Samedi', 'Dimanche')),
CONSTRAINT ck_animations_codeAN CHECK (CodeAN > 0)
);

-- 4.1.10. Table ACTIVITE
CREATE TABLE ACTIVITE
(CodeAC NUMBER CONSTRAINT pk_activites PRIMARY KEY, -- code d'une activité
NomAC varchar2(30) CONSTRAINT nn_activite_nomAC not null, -- nom de l'activité
TarifAC number(6,2) CONSTRAINT nn_activite_tarifAC not null, -- valeur monétaire au format 0,00€
CONSTRAINT ck_activite_tarifAC check (TarifAC >0), -- tarif de l'activité > 0
CONSTRAINT ck_activite_codeAC check (codeAC>0));

-- 4.1.11. Table VALIDITE
CREATE TABLE VALIDITE (
 -- code d'une activité
 CodeAC number,
 -- date de début de validité d'une activité
 DateDebut date,
 -- date de fin de validité d'une activité
 DateFin date CONSTRAINT nn_validite_dateFin not null,
 -- clé primaire : une activité a une seule période par date de début
 CONSTRAINT pk_validite PRIMARY KEY (CodeAC, DateDebut),
 -- l'activité doit exister
 CONSTRAINT fk_validite_codeAC FOREIGN KEY (CodeAC)
    REFERENCES ACTIVITE (CodeAC) ON DELETE CASCADE,
 -- la date de fin est postérieure ou égale à la date de début
 CONSTRAINT ck_validite_dates CHECK (DateFin >= DateDebut));

-- 4.1.12. Table REALISER
CREATE TABLE REALISER (
   CodeCI        number, -- code d'un circuit
   CodeAC        number, -- code d'une activité
   DateDepartRe  DATE, -- date de départ du circuit
   JourSem       VARCHAR2(10) CONSTRAINT nn_realiser_jourSem NOT NULL, -- jour de la semaine associé à la réalisation d'une activité pour un circuit
   CONSTRAINT pk_realiser PRIMARY KEY (CodeCI, CodeAC, DateDepartRe),
   CONSTRAINT fk_realiser_codeCI FOREIGN KEY (CodeCI)
       REFERENCES CIRCUITS (CodeCI) ON DELETE CASCADE,
   CONSTRAINT fk_realiser_codeAC FOREIGN KEY (CodeAC)
       REFERENCES ACTIVITE (CodeAC) ON DELETE CASCADE,
   CONSTRAINT ck_realiser_jourSem CHECK (JourSem IN
       ('Lundi', 'Mardi', 'Mercredi', 'Jeudi',
        'Vendredi', 'Samedi', 'Dimanche'))
);

-- 4.1.13. Table SITES
CREATE TABLE SITES (
   CodeS  number CONSTRAINT pk_sites PRIMARY KEY, -- code du site touristique
   NomS        VARCHAR2(30)  CONSTRAINT nn_sites_nomS NOT NULL, -- nom d'un site touristique
   TypeS       VARCHAR2(20)  CONSTRAINT nn_sites_typeS NOT NULL, -- type d'un site touristique
   DescripS    VARCHAR2(400) CONSTRAINT nn_sites_DescripS NOT NULL, -- description d'un site touristique
   CONSTRAINT ck_sites CHECK (CodeS > 0),
   CONSTRAINT ck_sites_typeS CHECK (TypeS IN
       ('historique', 'religieux', 'paysage', 'commerce', 'autre')) -- énumération des types de sites touristiques disponibles
);

-- 4.1.14. Table VISITER
CREATE TABLE VISITER (
   CodeCI       number, -- code du circuit
   CodeS        number, -- code du site touristique
   JourSe2      VARCHAR2(10) CONSTRAINT nn_visiter_JourSe2 NOT NULL, -- jour de la semaine
   HeureVisite  DATE CONSTRAINT nn_visiter_heureVisite NOT NULL, -- HH:MM
   DureeVisite  number CONSTRAINT nn_visiter_dureeVisite NOT NULL, -- en minutes
   CONSTRAINT pk_visiter PRIMARY KEY (CodeCI, CodeS, JourSe2, HeureVisite),
   CONSTRAINT fk_visiter_codeCI FOREIGN KEY (CodeCI)
       REFERENCES CIRCUITS (CodeCI) ON DELETE CASCADE,
   CONSTRAINT fk_visiter_codeS FOREIGN KEY (CodeS)
       REFERENCES SITES (CodeS) ON DELETE CASCADE,
   CONSTRAINT ck_visiter_jourSe2 CHECK (JourSe2 IN
       ('Lundi', 'Mardi', 'Mercredi', 'Jeudi',
        'Vendredi', 'Samedi', 'Dimanche')),
   CONSTRAINT ck_visiter_dureeVisite CHECK (DureeVisite > 0) -- durée de visite > 0
);

-- 4.1.15. Table MOIS
CREATE TABLE MOIS (
   CodeMois    NUMBER CONSTRAINT pk_mois PRIMARY KEY, -- code du mois
   LibelleMois VARCHAR2(20) CONSTRAINT nn_mois_libelleMois NOT NULL, -- nom du mois
   CONSTRAINT ck_mois_codeMois   CHECK (CodeMois BETWEEN 1 AND 12), -- codeMois = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12 }
   CONSTRAINT ck_mois_libelleMois CHECK (LibelleMois IN
       ('Janvier', 'Février', 'Mars', 'Avril', 'Mai', 'Juin', 'Juillet',
        'Août', 'Septembre', 'Octobre', 'Novembre', 'Décembre'))
);

-- 4.1.16. Table PAYS
CREATE TABLE PAYS (
   CodeP       NUMBER CONSTRAINT pk_pays PRIMARY KEY, -- code du pays
   NomP        VARCHAR2(30) CONSTRAINT nn_pays_nomP NOT NULL, -- nom du pays
   AvisGen     VARCHAR2(40) CONSTRAINT nn_pays_avisGen NOT NULL, -- avis général du pays
   CONSTRAINT ck_pays_codeP CHECK (CodeP>0)
);

-- 4.1.17. Table AVIS
CREATE TABLE AVIS (
   CodeP       number, -- code du pays
   CodeMois    number, -- code du mois
   TempMin     NUMBER(5,2) CONSTRAINT nn_avis_tempMin NOT NULL, -- température minimale d'un pays pour un mois donné
   TempMax     NUMBER(5,2) CONSTRAINT nn_avis_tempMax NOT NULL, -- température maximale d'un pays pour un mois donné
   AvisMens    VARCHAR2(40) CONSTRAINT nn_avis_avisMens NOT NULL, -- avis mensuel de la température d'un pays
   TempMinMoy  NUMBER(5,2) CONSTRAINT nn_avis_tempMinMoy NOT NULL, -- température minimale moyenne sur les 10 dernières années
   TempMaxMoy  NUMBER(5,2) CONSTRAINT nn_avis_tempMaxMoy NOT NULL, -- température maximale moyenne sur les 10 dernières années
   CONSTRAINT pk_avis PRIMARY KEY (CodeP, CodeMois),
   CONSTRAINT fk_avis_codeP FOREIGN KEY (CodeP)
       REFERENCES PAYS (CodeP) ON DELETE CASCADE,
   CONSTRAINT fk_avis_codeMois FOREIGN KEY (CodeMois)
       REFERENCES MOIS (CodeMois) ON DELETE CASCADE,
   CONSTRAINT ck_avis_temp    CHECK (TempMax >= TempMin), -- la température maximale d'un pays est supérieure ou égale à sa température minimale
   CONSTRAINT ck_avis_tempmoy CHECK (TempMaxMoy >= TempMinMoy) -- la température maximale moyenne d'un pays sur les 10 dernières années est
   -- supérieure ou égale à la température minimale du pays sur les 10 dernières années
);

-- 4.1.18. Table Zone_Geo
CREATE TABLE Zone_Geo (
   CodeZ       NUMBER CONSTRAINT pk_zone_geo PRIMARY KEY, -- code d'une zone géographique
   ZoneGeo     VARCHAR2(15) NOT NULL, -- nom de la zone géographique
   CONSTRAINT ck_zone_geo_codeZ CHECK (CodeZ > 0),
   CONSTRAINT ck_zone_geo_zoneGeo CHECK (ZoneGeo IN
       ('Nord', 'Sud', 'Ouest', 'Est',
        'Nord-Ouest', 'Nord-Est', 'Sud-Est', 'Sud-Ouest')) -- valeurs prises par le nom de la zone géographique
);

-- 4.1.19. Table SITUER
CREATE TABLE SITUER (
   CodeCI      number, -- code du circuit
   CodeZ       number, -- code de la zone géographique
   CodeP       number, -- code du pays
   CONSTRAINT pk_situer PRIMARY KEY (CodeCI, CodeZ, CodeP),
   CONSTRAINT fk_situer_codeCI FOREIGN KEY (CodeCI)
       REFERENCES CIRCUITS (CodeCI) ON DELETE CASCADE,
   CONSTRAINT fk_situer_codeZ FOREIGN KEY (CodeZ)
       REFERENCES Zone_Geo (CodeZ) ON DELETE CASCADE,
   CONSTRAINT fk_situer_codeP FOREIGN KEY (CodeP)
       REFERENCES PAYS (CodeP) ON DELETE CASCADE
);

-- 4.1.20. Table GUIDES
CREATE TABLE GUIDES (
   CodeG        NUMBER CONSTRAINT pk_guides PRIMARY KEY, -- code du guide
  NomG         VARCHAR2(30) CONSTRAINT nn_guides_nomG NOT NULL, -- nom du guide
   PrenomG      VARCHAR2(30) CONSTRAINT nn_guides_prenomG NOT NULL, -- prenom du guide
  DatePremier  DATE CONSTRAINT nn_guides_datePremier NOT NULL, -- date d'entrée du guide au sein de la société
   CONSTRAINT ck_guides_codeG CHECK (codeG > 0)
);

-- 4.1.21. Table ACCOMPAGNER
CREATE TABLE ACCOMPAGNER (
   CodeG       number, -- code du guide
   CodeCI      number, -- code du circuit
  DateDepartA  DATE    CONSTRAINT nn_accompagner_dateDepart NOT NULL, -- date de départ du circuit
   CONSTRAINT pk_accompagner PRIMARY KEY (CodeG, CodeCI, DateDepartA),
   CONSTRAINT fk_accompagner_codeG FOREIGN KEY (CodeG)
       REFERENCES GUIDES (CodeG) ON DELETE CASCADE,
   CONSTRAINT fk_accompagner_codeCI FOREIGN KEY (CodeCI)
       REFERENCES CIRCUITS (CodeCI) ON DELETE CASCADE
);

-- 4.1.22. Table LANGUE
CREATE TABLE LANGUE (
   CodeL       NUMBER CONSTRAINT pk_langue PRIMARY KEY, -- code de la langue
   NomL        VARCHAR2(40) CONSTRAINT nn_langue_nomL NOT NULL, -- nom de la langue
   CONSTRAINT nn_langue_codeL CHECK (CodeL > 0)
);

-- 4.1.23. Table PRATIQUER
CREATE TABLE PRATIQUER (
   CodeG       number, -- code du guide
   CodeL       number, -- code de la langue
  NiveauL     VARCHAR2(20) CONSTRAINT nn_pratiquer_niveauL NOT NULL, -- niveau de langue du guide pour une langue donnée
   CONSTRAINT pk_pratiquer PRIMARY KEY (CodeG, CodeL),
   CONSTRAINT fk_pratiquer_codeG FOREIGN KEY (CodeG)
       REFERENCES GUIDES (CodeG) ON DELETE CASCADE,
   CONSTRAINT fk_pratiquer_codeL FOREIGN KEY (CodeL)
       REFERENCES LANGUE (CodeL) ON DELETE CASCADE,
   CONSTRAINT ck_pratiquer_niveauL CHECK (NiveauL IN
       ('excellent', 'bon', 'moyen', 'quelques notions', 'mots de base')) -- valeurs prises par le niveau de langue
);

