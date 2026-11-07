-- table Clients
CREATE TABLE CLIENTS
(CodeC NUMBER CONSTRAINT pk_clients PRIMARY KEY,
NomC varchar2 (30) CONSTRAINT nn_clients_nomC not null,
PrenomC varchar2 (30) CONSTRAINT nn_clients_prenomC not null,
TelC varchar2 (15) CONSTRAINT nn_clients_telC not null,
MelC varchar2 (30) CONSTRAINT nn_clients_melC not null,
CONSTRAINT ck_clients_codeC CHECK (CodeC>0));


-- table Aeroports_dep
CREATE TABLE AEROPORTS_DEP
( CodeA NUMBER CONSTRAINT pk_aeroports PRIMARY KEY,
NomA varchar2 (30) CONSTRAINT nn_aeroports_dep_nomA not null,
CONSTRAINT ck_aeroports_dep_codeA CHECK (CodeA>0));


-- table Circuits
CREATE TABLE CIRCUITS
( CodeCI NUMBER CONSTRAINT pk_circuits PRIMARY KEY,
CONSTRAINT ck_circuits_codeCI CHECK (CodeCI>0),
NomCI varchar2 (30) constraint nn_circuits_nomCI not null,
PrixBase NUMBER(6,2) CONSTRAINT nn_circuits_prixBase not null, 
CONSTRAINT ck_circuits_prixBase check (PrixBase >0),
NbPersMax number CONSTRAINT nn_circuits_NbPersMax not null
CONSTRAINT ck_circuits_NbPersMax check (NbPersMax>0),
CodeCI_Est_Complete number CONSTRAINT nn_circuits_Complete not null,
CONSTRAINT fk_CIRCUITCOMPLETE
FOREIGN KEY (CodeCI_Est_Complete)
REFERENCES CIRCUITS (CodeCI)
ON DELETE CASCADE);


-- table Choix
CREATE TABLE CHOIX
( CodeC number,
CodeA number,
CodeCI number,
DateDepartC date,
OrdrePreference number CONSTRAINT nn_choix_ordrePreference not null,
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


-- table Reserver
CREATE TABLE RESERVER
(CodeC number,
CodeA number,
CodeCI number,
DateDepartR date CONSTRAINT nn_reserver_dateDepartR not null,
DateResa date CONSTRAINT nn_reserver_dateResa not null,
NbPers number CONSTRAINT nn_reserver_nbPers not null
CONSTRAINT ck_NbPers check (NbPers>0),
CONSTRAINT pk_RESERVER
PRIMARY KEY (CodeC, CodeA, CodeCI, DateDepartR),
CONSTRAINT fk_RESERVERC
FOREIGN KEY (CodeC)
REFERENCES CLIENTS ( CodeC)
ON DELETE CASCADE,
CONSTRAINT fk_RESERVERA
FOREIGN KEY (CodeA)
REFERENCES AEROPORTS_DEP (CodeA)
ON DELETE CASCADE,
CONSTRAINT fk_RESERVERCI
FOREIGN KEY (CodeCI)
REFERENCES CIRCUITS (CodeCI)
ON DELETE CASCADE);


-- table Majoration
CREATE TABLE MAJORATION
(CodeA number,
CodeCI number,
DateDepartM date CONSTRAINT nn_majoration_dateDepartM not null,
MontantMaj NUMBER(5,2) CONSTRAINT nn_majoration_montantMaj not null
CONSTRAINT ck_MontantMaj
check (MontantMaj>0),
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




-- table Hotels
CREATE TABLE HOTELS
(CodeH NUMBER CONSTRAINT pk_hotels PRIMARY KEY,
CONSTRAINT ck_hotels_codeH CHECK (CodeH>0),
NomH varchar2 (30) CONSTRAINT nn_hotels_nomH not null,
Categorie number CONSTRAINT nn_hotels_categorie not null
CONSTRAINT ck_Categorie check(Categorie>0),
VilleH varchar2 (30) CONSTRAINT nn_hotels_villeH not null,
TelH varchar2 (20),
MelH varchar2 (20));




-- table loger
CREATE TABLE LOGER
(CodeCI number,
CodeH number,
JourSe varchar2(10) CONSTRAINT nn_loger_jourSe not null,
CONSTRAINT pk_LOGER PRIMARY KEY (CodeCI, CodeH),
CONSTRAINT ck_loger_JourSe
check (JourSe in ('Lundi','Mardi','Mercredi','Jeudi','Vendredi','Samedi','Dimanche')),
CONSTRAINT fk_loger_codeCI FOREIGN KEY (CodeCI)
REFERENCES CIRCUITS (CodeCI) ON DELETE CASCADE,
CONSTRAINT fk_loger_codeH FOREIGN KEY (CodeH) 
REFERENCES HOTELS (CodeH) ON DELETE CASCADE);




-- table animations 
CREATE TABLE ANIMATIONS (
CodeAN  NUMBER CONSTRAINT pk_animations PRIMARY KEY,
NomAN  VARCHAR2(30) CONSTRAINT nn_animations_nomAN NOT NULL,
TypeAN  VARCHAR2(20) CONSTRAINT nn_animations_typeAN NOT NULL,
HeureDeb    DATE CONSTRAINT nn_animations_heureDeb NOT NULL,
JourSemaine VARCHAR2(10) CONSTRAINT nn_animations_jourSemaine NOT NULL,
CodeH   number CONSTRAINT nn_animations_codeH NOT NULL,
CONSTRAINT fk_animations_codeH
FOREIGN KEY (CodeH) REFERENCES HOTELS (CodeH) ON DELETE CASCADE,
CONSTRAINT ck_animations_typeAN
CHECK (TypeAN IN ('Concert', 'Danse folklorique', 'Danse', 'Cabaret', 'Karaoké')),
CONSTRAINT ck_animations_jourSemaine
CHECK (JourSemaine IN ('Lundi','Mardi','Mercredi','Jeudi','Vendredi','Samedi','Dimanche')),
CONSTRAINT ck_animations_codeAN CHECK (CodeAN > 0)
);






-- table activite
CREATE TABLE ACTIVITE 
(CodeAC NUMBER CONSTRAINT pk_activites PRIMARY KEY,
NomAC varchar2(30) CONSTRAINT nn_activite_nomAC not null,
TarifAC number(6,2) CONSTRAINT nn_activite_tarifAC not null,
CONSTRAINT ck_activite_tarifAC check (TarifAC >0),
CONSTRAINT ck_activite_codeAC check (codeAC>0));




-- table validite
CREATE TABLE VALIDITE
(CodeAC number,
DateDebut date,
DateFin date CONSTRAINT nn_validite_dateFin not null,
CONSTRAINT pk_validite PRIMARY KEY (CodeAC, DateDebut),
CONSTRAINT fk_validite_codeAC FOREIGN KEY (CodeAC)
REFERENCES ACTIVITE (CodeAC) ON DELETE CASCADE);


-- table REALISER
CREATE TABLE REALISER (
   CodeCI        number,
   CodeAC        number,
   DateDepartRe  DATE,
   JourSem       VARCHAR2(10) CONSTRAINT nn_realiser_jourSem NOT NULL,
   CONSTRAINT pk_realiser PRIMARY KEY (CodeCI, CodeAC, DateDepartRe),
   CONSTRAINT fk_realiser_codeCI FOREIGN KEY (CodeCI)
       REFERENCES CIRCUITS (CodeCI) ON DELETE CASCADE,
   CONSTRAINT fk_realiser_codeAC FOREIGN KEY (CodeAC)
       REFERENCES ACTIVITE (CodeAC) ON DELETE CASCADE,
   CONSTRAINT ck_realiser_jourSem CHECK (JourSem IN
       ('Lundi', 'Mardi', 'Mercredi', 'Jeudi',
        'Vendredi', 'Samedi', 'Dimanche'))
);




-- table SITES
CREATE TABLE SITES (
   CodeS  number CONSTRAINT pk_sites PRIMARY KEY,
   NomS        VARCHAR2(30)  CONSTRAINT nn_sites_nomS NOT NULL,
   TypeS       VARCHAR2(20)  CONSTRAINT nn_sites_typeS NOT NULL,
   DescripS    VARCHAR2(400) CONSTRAINT nn_sites_DescripS NOT NULL,
   CONSTRAINT ck_sites CHECK (CodeS > 0),
   CONSTRAINT ck_sites_typeS CHECK (TypeS IN
       ('historique', 'religieux', 'paysage', 'commerce', 'autre'))
);




-- table VISITER
CREATE TABLE VISITER (
   CodeCI       number,
   CodeS        number,
   JourSe2      VARCHAR2(10) CONSTRAINT nn_visiter_JourSe2 NOT NULL,
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
   CONSTRAINT ck_visiter_dureeVisite CHECK (DureeVisite > 0)
);




-- table MOIS
CREATE TABLE MOIS (
   CodeMois    NUMBER CONSTRAINT pk_mois PRIMARY KEY,
   LibelleMois VARCHAR2(20) CONSTRAINT nn_mois_libelleMois NOT NULL,
   CONSTRAINT ck_mois_codeMois   CHECK (CodeMois BETWEEN 1 AND 12),
   CONSTRAINT ck_mois_libelleMois CHECK (LibelleMois IN
       ('Janvier', 'Février', 'Mars', 'Avril', 'Mai', 'Juin', 'Juillet',
        'Août', 'Septembre', 'Octobre', 'Novembre', 'Décembre'))
);


-- table PAYS
CREATE TABLE PAYS (
   CodeP       NUMBER CONSTRAINT pk_pays PRIMARY KEY,
   NomP        VARCHAR2(30) CONSTRAINT nn_pays_nomP NOT NULL,
   AvisGen     VARCHAR2(40) CONSTRAINT nn_pays_avisGen NOT NULL,
   CONSTRAINT ck_pays_codeP CHECK (CodeP>0)
);




-- table AVIS
CREATE TABLE AVIS (
   CodeP       number,
   CodeMois    number,
   TempMin     NUMBER(5,2) CONSTRAINT nn_avis_tempMin NOT NULL,
   TempMax     NUMBER(5,2) CONSTRAINT nn_avis_tempMax NOT NULL,
   AvisMens    VARCHAR2(40) CONSTRAINT nn_avis_avisMens NOT NULL,
   TempMinMoy  NUMBER(5,2) CONSTRAINT nn_avis_tempMinMoy NOT NULL,
   TempMaxMoy  NUMBER(5,2) CONSTRAINT nn_avis_tempMaxMoy NOT NULL,
   CONSTRAINT pk_avis PRIMARY KEY (CodeP, CodeMois),
   CONSTRAINT fk_avis_codeP FOREIGN KEY (CodeP)
       REFERENCES PAYS (CodeP) ON DELETE CASCADE,
   CONSTRAINT fk_avis_codeMois FOREIGN KEY (CodeMois)
       REFERENCES MOIS (CodeMois) ON DELETE CASCADE,
   CONSTRAINT ck_avis_temp    CHECK (TempMax >= TempMin),
   CONSTRAINT ck_avis_tempmoy CHECK (TempMaxMoy >= TempMinMoy)
);




-- table Zone_Geo
CREATE TABLE Zone_Geo (
   CodeZ       NUMBER CONSTRAINT pk_zone_geo PRIMARY KEY,
   ZoneGeo     VARCHAR2(15) NOT NULL,
   CONSTRAINT ck_zone_geo_codeZ CHECK (CodeZ > 0),
   CONSTRAINT ck_zone_geo_zoneGeo CHECK (ZoneGeo IN
       ('Nord', 'Sud', 'Ouest', 'Est',
        'Nord-Ouest', 'Nord-Est', 'Sud-Est', 'Sud-Ouest'))
);




-- table SITUER
CREATE TABLE SITUER (
   CodeCI      number,
   CodeZ       number,
   CodeP       number,
   CONSTRAINT pk_situer PRIMARY KEY (CodeCI, CodeZ, CodeP),
   CONSTRAINT fk_situer_codeCI FOREIGN KEY (CodeCI)
       REFERENCES CIRCUITS (CodeCI) ON DELETE CASCADE,
   CONSTRAINT fk_situer_codeZ FOREIGN KEY (CodeZ)
       REFERENCES Zone_Geo (CodeZ) ON DELETE CASCADE,
   CONSTRAINT fk_situer_codeP FOREIGN KEY (CodeP)
       REFERENCES PAYS (CodeP) ON DELETE CASCADE
);




-- table GUIDES
CREATE TABLE GUIDES (
   CodeG        NUMBER CONSTRAINT pk_guides PRIMARY KEY,
   NomG         VARCHAR2(30) CONSTRAINT nn_guides_nomG NOT NULL,
   PrenomG      VARCHAR2(30) CONSTRAINT nn_guides_prenomG NOT NULL,
   DatePremier  DATE CONSTRAINT nn_guides_datePremier NOT NULL,
   CONSTRAINT ck_guides_codeG CHECK (codeG > 0)
);




-- table ACCOMPAGNE
CREATE TABLE ACCOMPAGNER (
   CodeG       number,
   CodeCI      number,
   DateDepartA  DATE    CONSTRAINT nn_accompagner_dateDepart NOT NULL,
   CONSTRAINT pk_accompagner PRIMARY KEY (CodeG, CodeCI, DateDepartA),
   CONSTRAINT fk_accompagner_codeG FOREIGN KEY (CodeG)
       REFERENCES GUIDES (CodeG) ON DELETE CASCADE,
   CONSTRAINT fk_accompagner_codeCI FOREIGN KEY (CodeCI)
       REFERENCES CIRCUITS (CodeCI) ON DELETE CASCADE
);




-- table LANGUE
CREATE TABLE LANGUE (
   CodeL       NUMBER CONSTRAINT pk_langue PRIMARY KEY,
   NomL        VARCHAR2(40) CONSTRAINT nn_langue_nomL NOT NULL,
   CONSTRAINT nn_langue_codeL CHECK (CodeL > 0)
);




-- table PRATIQUER
CREATE TABLE PRATIQUER (
   CodeG       number,
   CodeL       number,
   NiveauL     VARCHAR2(20) CONSTRAINT nn_pratiquer_niveauL NOT NULL,
   CONSTRAINT pk_pratiquer PRIMARY KEY (CodeG, CodeL),
   CONSTRAINT fk_pratiquer_codeG FOREIGN KEY (CodeG)
       REFERENCES GUIDES (CodeG) ON DELETE CASCADE,
   CONSTRAINT fk_pratiquer_codeL FOREIGN KEY (CodeL)
       REFERENCES LANGUE (CodeL) ON DELETE CASCADE,
   CONSTRAINT ck_pratiquer_niveauL CHECK (NiveauL IN
       ('excellent', 'bon', 'moyen', 'quelques notions', 'mots de base'))
);






-- Vue de la table animation permettant d’afficher heuredeb au format hh:mm
CREATE VIEW ANIMATIONS_H as
SELECT CODEAN, NOMAN, TYPEAN, to_char(HEUREDEB, 'HH24:MI') as HEUREDEB, JOURSEMAINE, CODEH
FROM ANIMATIONS A;