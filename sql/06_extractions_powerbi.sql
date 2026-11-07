-- A executer dans l ordre : TABLE_PRINCIPALE, TABLE_ZONES, TABLE_DEPARTS. Tables non recreables si deja presentes.

-- 2.3.1. Requête d'extraction - TABLE_PRINCIPALE
CREATE TABLE TABLE_PRINCIPALE AS
SELECT c.CodeCI, c.NomCI,
       r.CodeC, r.CodeA, ad.NomA,
       r.DateDepartR AS DateDepartCI,
       r.DateResa AS DateReservationCI,
       r.NbPers,
       c.PrixBase, m.MontantMaj,
       p.CodeP, p.NomP,
       r.NbPers * (c.PrixBase + m.MontantMaj) AS CACI,
       c.NbPersMax,
       mo.CodeMois, mo.LibelleMois,
       av.TempMin, av.TempMax,
       av.TempMinMoy, av.TempMaxMoy, av.AvisMens,
       ac.DateDepartA, g.NomG, g.PrenomG
FROM CIRCUITS c, RESERVER r,
     AEROPORTS_DEP ad, MAJORATION m,
     AVIS av, MOIS mo, ACCOMPAGNER ac, GUIDES g,
     (SELECT DISTINCT s.CodeCI, p.CodeP, p.NomP
      FROM SITUER s, PAYS p
      WHERE s.CodeP = p.CodeP) p
WHERE c.CodeCI = r.CodeCI
AND r.CodeA = ad.CodeA
AND m.CodeCI = r.CodeCI
AND m.CodeA = r.CodeA
AND m.DateDepartM = r.DateDepartR
AND p.CodeCI = c.CodeCI
AND p.CodeP = av.CodeP
AND mo.CodeMois = av.CodeMois
AND mo.CodeMois = EXTRACT(MONTH FROM r.DateDepartR)
AND ac.DateDepartA = r.DateDepartR
AND c.CodeCI = ac.CodeCI
AND ac.CodeG = g.CodeG;

-- 2.3.2. Requête d'extraction - TABLE_ZONES
CREATE TABLE TABLE_ZONES AS
SELECT t.NomP, z.ZoneGeo,
       SUM(t.CACI / nz.NbZones) AS CA_Reparti,
       SUM(t.NbPers / nz.NbZones) AS Voyageurs_Repartis
FROM TABLE_PRINCIPALE t, SITUER s, ZONE_GEO z,
     (SELECT CodeCI, CodeP, COUNT(*) AS NbZones
      FROM SITUER
      GROUP BY CodeCI, CodeP) nz
WHERE t.CodeCI = s.CodeCI
AND t.CodeP = s.CodeP
AND s.CodeZ = z.CodeZ
AND s.CodeCI = nz.CodeCI
AND s.CodeP = nz.CodeP
GROUP BY t.NomP, z.ZoneGeo;

-- 2.3.3. Requête d'extraction - TABLE_DEPARTS
CREATE TABLE TABLE_DEPARTS AS
SELECT m.CodeCI, c.NomCI,
       m.CodeA, a.NomA,
       m.DateDepartM AS DateDepart,
       c.NbPersMax,
       m.MontantMaj,
       COUNT(r.CodeC) AS NbReservations,
       SUM(r.NbPers) AS NbVoyageurs
FROM MAJORATION m
JOIN CIRCUITS c
  ON m.CodeCI = c.CodeCI
JOIN AEROPORTS_DEP a
  ON m.CodeA = a.CodeA
LEFT JOIN RESERVER r
  ON r.CodeCI = m.CodeCI
 AND r.CodeA = m.CodeA
 AND r.DateDepartR = m.DateDepartM
GROUP BY m.CodeCI, c.NomCI,
         m.CodeA, a.NomA,
         m.DateDepartM,
         c.NbPersMax,
         m.MontantMaj;

