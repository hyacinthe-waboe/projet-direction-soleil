-- 2.2.1. Chiffre d'affaires total par départ
SELECT CI.NomCI, A.NomA, R.DateDepartR, SUM(R.NbPers) AS TotalVoyageurs,
       SUM(R.NbPers * (CI.PrixBase + M.MontantMaj)) AS ChiffreAffaires
FROM CIRCUITS CI, AEROPORTS_DEP A, MAJORATION M, Reserver R
WHERE CI.CodeCI = R.CodeCI
AND A.CodeA = R.CodeA
AND M.CodeCI = R.CodeCI
AND M.CodeA = R.CodeA
AND M.DateDepartM = R.DateDepartR
GROUP BY CI.CodeCI, CI.NomCI, A.CodeA, A.NomA, R.DateDepartR
ORDER BY ChiffreAffaires DESC;

-- 2.2.2. Arbitrage de prix entre présélections d'un même circuit
SELECT C.CodeC, C.NomC, C.PrenomC, CI.NomCI,
       A.NomA, CH.DateDepartC, CH.OrdrePreference,
       CI.PrixBase + M.MontantMaj AS PrixTotal
FROM CLIENTS C, CIRCUITS CI, CHOIX CH,
     AEROPORTS_DEP A, MAJORATION M
WHERE C.CodeC = CH.CodeC
AND CI.CodeCI = CH.CodeCI
AND A.CodeA = CH.CodeA
AND M.CodeCI = CH.CodeCI
AND M.CodeA = CH.CodeA
AND M.DateDepartM = CH.DateDepartC
AND EXISTS (
    SELECT *
    FROM CHOIX CH2
    WHERE CH2.CodeC = CH.CodeC
    AND CH2.CodeCI = CH.CodeCI
    AND (CH2.DateDepartC <> CH.DateDepartC
    OR CH2.CodeA <> CH.CodeA)
)
ORDER BY C.CodeC, CI.NomCI, PrixTotal DESC;

-- 2.2.3. Animations accessibles pendant les séjours
SELECT DISTINCT CI.NomCI, H.NomH, L.JourSe, A.NomAN,
       TO_CHAR(A.HeureDeb, 'HH24:MI') AS Heure
FROM CIRCUITS CI, LOGER L, HOTELS H, ANIMATIONS A
WHERE CI.CodeCI = L.CodeCI
AND L.CodeH = H.CodeH
AND H.CodeH = A.CodeH
AND L.JourSe = A.JourSemaine
ORDER BY CI.NomCI, L.JourSe;

-- 2.2.4. Départs proposés sans réservation
SELECT CI.NomCI, A.NomA, M.DateDepartM,
       CI.PrixBase + M.MontantMaj AS PrixTotal
FROM CIRCUITS CI, AEROPORTS_DEP A, MAJORATION M
WHERE CI.CodeCI = M.CodeCI
AND A.CodeA = M.CodeA
AND NOT EXISTS (
    SELECT *
    FROM RESERVER R
    WHERE R.CodeCI = M.CodeCI
    AND R.CodeA = M.CodeA
    AND R.DateDepartR = M.DateDepartM
)
ORDER BY CI.NomCI, M.DateDepartM;

-- 2.2.5. Départs prévus pendant les mois les plus chauds
SELECT DISTINCT CI.NomCI, P.NomP,
       A.NomA, M.DateDepartM, AV.TempMaxMoy
FROM CIRCUITS CI, SITUER S, PAYS P, AVIS AV,
     MAJORATION M, AEROPORTS_DEP A
WHERE CI.CodeCI = S.CodeCI
AND S.CodeP = P.CodeP
AND P.CodeP = AV.CodeP
AND CI.CodeCI = M.CodeCI
AND M.CodeA = A.CodeA
AND AV.CodeMois = EXTRACT(MONTH FROM M.DateDepartM)
AND AV.TempMaxMoy >= 35
ORDER BY AV.TempMaxMoy DESC, CI.NomCI;

