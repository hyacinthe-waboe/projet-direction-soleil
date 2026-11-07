-- 2.1.1. Requête 1
SELECT cl.nomC, cl.prenomC, r.dateDepartR, c.nomCI, ad.nomA, c.prixBase + m.montantMaj AS montant_total_du_circuit
FROM Circuits c, Majoration m, Aeroports_Dep ad, Reserver r, Clients cl
WHERE c.codeCI = m.codeCI
AND m.codeA = ad.codeA
AND ad.codeA = r.codeA
AND r.codeC = cl.codeC
AND r.codeCI = c.codeCI
AND r.dateDepartR = m.dateDepartM
AND LOWER(c.nomCI) = 'les saveurs tunisiennes'
AND LOWER (ad.nomA) = 'toulouse'
AND r.dateDepartR = TO_DATE('08/07/2026', 'DD/MM/YYYY')
AND LOWER (cl.prenomC) = 'medhi'
AND LOWER (cl.nomC) = 'terraner';

-- 2.1.2. Requête 2
SELECT  DISTINCT c.CodeCI, c.NomCI
FROM circuits c, Situer s, Pays p
WHERE c.CodeCI = s.CodeCI
AND s.CodeP = p.CodeP
AND UPPER(p.NomP) = 'MAROC'
AND c.codeCI IN (
    SELECT l.codeci
    FROM Hotels h, loger l
    WHERE h.codeH = l.codeH
    AND UPPER(h.NomH) = 'LION D''OR'
)
AND c.codeCI IN (
    SELECT l2.codeci
    FROM Hotels h2, loger l2
    WHERE h2.codeH = l2.codeH
    AND UPPER(h2.NomH) = 'EDEN'
);

-- 2.1.3. Requête 3
SELECT P.NomP, M.LibelleMois, A.TempMaxMoy
FROM PAYS P, MOIS M, AVIS A
WHERE P.CodeP = A.CodeP
AND M.CodeMois = A.CodeMois
AND A.TempMaxMoy = (
    SELECT MAX(A2.TempMaxMoy)
    FROM AVIS A2
    WHERE A2.CodeP = P.CodeP
);

-- 2.1.4. Requête 4
SELECT c.NomCI, a.NomA, r.DateDepartR,
COUNT(*) AS NbReservations,
c.NbPersMax -  (
           SELECT SUM(r2.NbPers)
           FROM RESERVER r2
           WHERE r2.CodeCI = c.CodeCI
           AND r2.DateDepartR = r.DateDepartR
       ) AS PlacesDisponibles

FROM CIRCUITS c, AEROPORTS_DEP a, RESERVER r
WHERE c.CodeCI = r.CodeCI
AND a.CodeA = r.CodeA
GROUP BY c.CodeCI, c.NomCI, c.NbPersMax,
a.CodeA, a.NomA, r.DateDepartR
ORDER BY c.NomCI, a.NomA, r.DateDepartR;

-- 2.1.5. Requête 5
SELECT g.nomG, g.prenomG
FROM guides g, accompagner a
WHERE g.codeG = a.codeG
GROUP BY g.codeG, g.nomG, g.prenomG
HAVING COUNT(DISTINCT a.codeCI ) >= ALL (
SELECT COUNT(DISTINCT a2.codeCI)
     FROM accompagner a2
GROUP BY a2.codeG );

-- 2.1.6. Requête 6
SELECT COUNT( DISTINCT c.codec) as "Nombre de clients"
FROM clients c, reserver r
WHERE c.codec = r.codec
AND TO_CHAR( r.DateResa, 'yyyy') = '2025'
AND c.codec NOT IN (
   SELECT ch.codec
   FROM choix ch
   WHERE r.DateDepartR = ch.DateDepartC
   AND r.codeA = ch.codeA
   AND r.codeCI = ch.codeCI
);

-- 2.1.7. Requête 7
SELECT g.nomg, g.prenomg
FROM guides g
WHERE NOT EXISTS (
    SELECT 1
    FROM pays p, situer s
    WHERE p.codeP = s.codeP
    AND LOWER(p.nomp) = 'maroc'
    AND NOT EXISTS (
        SELECT 1
        FROM circuits c, accompagner a
        WHERE c.codeCI = a.codeCI
        AND c.codeCI = s.codeCI
        AND a.codeG = g.codeG
        AND TO_CHAR( a.dateDepartA, 'yyyy') = TO_CHAR(SYSDATE, 'yyyy') ));

-- 2.1.8. Requête 8
SELECT p.nomP, COUNT(DISTINCT r.codeci) AS nbCircuits, c.nomc, c.prenomc, c.telc, c.melc
FROM clients c, reserver r, circuits ci, situer s, pays p
WHERE c.codec = r.codec
AND r.codeci = ci.codeci
AND ci.codeci = s.codeci
AND s.codep = p.codep
AND r.dateDepartR <= SYSDATE
GROUP BY c.codec, c.nomc, c.prenomc, c.telc, c.melc, p.codep, p.nomP
HAVING COUNT(DISTINCT r.codeci)  =
    (
        SELECT MAX(COUNT(DISTINCT r2.codeci))
        FROM reserver r2, circuits ci2, situer s2, pays p2
        WHERE r2.codeci = ci2.codeci
        AND ci2.codeci = s2.codeci
        AND s2.codep = p2.codep
        AND p.codep = p2.codep
        AND r2.dateDepartR <= SYSDATE
        GROUP BY r2.codeC
     )
ORDER BY p.nomP ASC;

-- 2.1.9. Requête 9
SELECT DISTINCT c.NomCI
FROM circuits c, majoration m, aeroports_dep a, situer s, pays p
WHERE c.CodeCI = m.CodeCI
AND m.CodeA = a.CodeA
AND c.CodeCI = s.CodeCI
AND s.CodeP = p.CodeP
AND LOWER(a.NomA) = 'toulouse'
AND LOWER(p.NomP) = 'tunisie'
AND m.datedepartm NOT IN (
   SELECT r.dateDepartR
   FROM reserver r
   WHERE r.CodeCI = c.CodeCI
   GROUP BY r.dateDepartR
   HAVING SUM(r.NbPers) >= c.NbPersMax
)
AND NOT EXISTS (
   SELECT 1
   FROM situer s2, visiter v
   WHERE s2.CodeCI = v.CodeCI
   AND s2.CodeP = p.CodeP
   AND NOT EXISTS (
       SELECT 1
       FROM visiter v2
       WHERE v2.CodeCI = c.CodeCI
       AND v2.CodeS = v.CodeS
   )
);

-- 2.1.10. Requête 10
SELECT P.nomp
FROM Pays P, Situer S
WHERE P.codep = S.codep
GROUP BY P.codep, P.nomp
HAVING COUNT( DISTINCT S.codeci) > (
    SELECT COUNT( DISTINCT S.codeci)
    FROM Pays P, Situer S
    WHERE P.codep = S.codep
    AND LOWER(P.nomp) = 'grèce');

