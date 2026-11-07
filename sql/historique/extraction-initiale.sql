CREATE TABLE table_test1 AS
SELECT c.codeCI, c.nomCI, c.prixBase, c.nbPersMax, r.dateResa as dateReservationCI, r.nbPers, r.dateDepartR as dateDepartCI, cl.codeC, 
cl.nomC, cl.prenomC, a.codeA, a.nomA, m.montantMaj, p.codeP, p.nomP, p.avisGen, z.codeZ, z.zoneGeo,
av.tempMin, av.tempMax,av.tempMinMoy, av.tempMaxMoy,mois.libelleMois, ch.ordrePreference,r.nbPers * (c.PrixBase + m.MontantMaj) AS CACI
FROM circuits c, reserver r, clients cl, aeroports_dep a, majoration m, situer s, pays p, zone_geo z, avis av, mois, 
choix ch
WHERE c.codeCI = r.codeCI
AND cl.codeC = r.codeC
AND a.codeA = r.codeA
AND m.codeCI = c.codeCI
AND m.codeA = a.codeA
AND c.codeCI = s.codeCI
AND s.codeP = p.codeP
AND s.codeZ = z.codeZ
AND av.codeP = p.codeP
AND av.codeMois = mois.codeMois
AND r.dateDepartR = m.dateDepartM
AND extract (month from r.dateDepartR) = mois.codeMois
AND ch.codeA = a.codeA
AND ch.codeC = cl.codeC
AND ch.codeCI = c.codeCI
;


DROP table table_test1;
SELECT *
FROM table_test1;


ct