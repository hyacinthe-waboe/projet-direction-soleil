
-- Vue de presentation des horaires d animation
CREATE VIEW ANIMATIONS_H as
SELECT CodeAN, NomAN, TypeAN, TO_CHAR(HEUREDEB, 'HH24:MI') as HeureDEB, JourSemaine, CodeH
FROM ANIMATIONS;

-- Verification du cumul des voyageurs par circuit et date
CREATE OR REPLACE TRIGGER trg_reserver_nbpers
AFTER INSERT OR UPDATE ON RESERVER

DECLARE
    -- Nombre de départs dépassant leur capacité
    v_depasse NUMBER;

BEGIN
    -- Recherche les départs dont le total de voyageurs
    -- dépasse la capacité maximale autorisée
    SELECT COUNT(*) INTO v_depasse
    FROM (
        SELECT r.CodeCI, r.DateDepartR
        FROM RESERVER r, CIRCUITS c
        WHERE r.CodeCI = c.CodeCI

        -- Regroupe les réservations par circuit et date,
        -- tous aéroports confondus
        GROUP BY r.CodeCI, r.DateDepartR, c.NbPersMax

        -- Compare les voyageurs inscrits
        -- à la capacité maximale du circuit
        HAVING SUM(r.NbPers) > c.NbPersMax
    );

    -- Si un départ dépasse sa capacité,
    -- une erreur empêche la réservation
    IF v_depasse > 0 THEN
        RAISE_APPLICATION_ERROR(-20001,
            'Capacité maximale du circuit dépassée');
    END IF;

END;
/
