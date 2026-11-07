# Historique de développement — Direction Soleil

## Comment lire cet historique

Le Groupe 1 a réalisé ce projet du **26 octobre au 6 novembre 2026**. Le dépôt a été publié le **7 novembre**. La progression présentée ici a été **reconstituée après la réalisation du projet**, à partir de la feuille de temps du groupe, de véritables révisions Google Docs et des fichiers intermédiaires conservés.

Les nouveaux commits portent leur date réelle de création. Les dates dans leurs messages et dans ce journal sont celles du travail documenté. Ils archivent le travail collectif ; le compte qui les dépose ne revendique pas la réalisation personnelle de tous les éléments.

La branche part de la publication existante : les trois premiers commits restent conservés. Elle ajoute les sources historiques sans remplacer les livrables publics validés. Les archives de travail peuvent contenir des erreurs et des pistes abandonnées ; elles ne sont pas des versions à exécuter en production.

Les 18 étapes proposées ont été regroupées en 12 commits documentaires significatifs, selon les états effectivement conservés. Une activité attestée sans fichier de l'époque est décrite dans le journal, sans fabriquer de version intermédiaire.

## Sources et confidentialité

- Feuille de temps du Groupe 1 : consultée pour les activités et les attributions. Le classeur et son lien ne sont pas reproduits ici, car il contient des numéros étudiants.
- [Premier livrable de modélisation](historique/modelisation-2026-10-27.pdf) : dictionnaire, hypothèses, véritable schéma entité-association et premier schéma relationnel.
- Révisions de documents d'origine : identifiants, dates et portée de chaque copie décrits dans [les sources archivées](historique/README.md).
- Fichiers PBIX intermédiaires : copies conservées à l'identique, datation appuyée par leurs horodatages internes ZIP. Ces horodatages ne prouvent pas seuls la date de chaque action de développement.
- Les coordonnées neutralisées dans le jeu public restent neutralisées. Aucun numéro étudiant, email privé des contributeurs ou identifiant de connexion n'est ajouté.

## 26 octobre 2026 — Analyse et conception initiale

La feuille de temps renseigne les travaux de l'après-midi : construction du dictionnaire par Ny Toavimpahendrena, Tsinjo et Simon ; réflexion et début du MCD par Jesus, Adrien et Hyacinthe. Jesus y mentionne aussi des questions au client pendant une réunion.

**État conservé :** aucune version de fichier datée du 26 n'a été retrouvée. Le dictionnaire et le MCD visibles dans le livrable du 27 témoignent de la première phase, sans être présentés comme une capture du 26. Les deux activités sont donc regroupées dans cette entrée documentaire.

## 27 octobre 2026 — Correction et premier rendu

La feuille de temps décrit la correction du MCD (Jesus, Adrien et Hyacinthe), la révision des types et contraintes (Ny Toavimpahendrena et Simon) et la cohérence dictionnaire/MCD (Tsinjo). La mise en forme du premier rendu et le choix des outils de planification sont également documentés.

**Versions réelles :** révision 1118 du premier rendu à 15:42 UTC, texte du Script MLD modifié à 15:02 UTC et PDF du livrable du 27, dont le document a été modifié à 22:20 UTC. La révision précédente 28 du Script MLD était vide et n'a pas fait l'objet d'un commit artificiel. Le MCD est réellement présent page 6 du PDF.

## 28 octobre 2026 — Partie 2 : relationnel et requêtes

La feuille de temps signale la découverte du second sujet et la transcription de son modèle conceptuel en relations. Jesus, Adrien et Hyacinthe interviennent sur ce passage au relationnel ; le groupe se répartit les premières requêtes. Hyacinthe mentionne la correction des requêtes 10, 6 et 9, tandis que les autres membres ont leurs propres requêtes et tâches de planification.

**État conservé :** aucun état exact des requêtes du 28 n'a été retrouvé. Le Script MLD du 27 relève de la première partie et ne doit pas être présenté comme le nouveau modèle du 28. La première révision récupérée du rapport de la partie 2 date du 30 ; elle sera archivée à cette étape, sans inventer une version antérieure.

## 29 octobre 2026 — Schéma Oracle et préparation des données

Ny Toavimpahendrena et Tsinjo développent le script de création ; Adrien participe à ses corrections. Jesus renseigne les entités et associations ; Adrien et Hyacinthe préparent le jeu de données et sa cohérence. Simon travaille sur les requêtes supplémentaires.

**Version réelle :** révision 596 du script de création, 29 octobre à 15:50 UTC. Elle contient notamment des contraintes de jours en minuscules dans LOGER et ANIMATIONS. Cette archive conserve ses imperfections ; elle ne remplace pas `sql/01_creation_tables.sql`.

Les tableurs de population de cette journée ne sont pas disponibles comme versions datées vérifiables. Le jeu final ne sera donc pas présenté comme une capture du 29.

## 30 octobre 2026 — Importation et contrôles SQL

La feuille de temps attribue l'import et les tests à plusieurs membres du groupe : Jesus teste notamment les requêtes 1 à 5 et 10 ; Tsinjo travaille sur les contraintes et les requêtes 6 à 9 ; Ny Toavimpahendrena mentionne les tests et la vue ; Adrien et Hyacinthe participent aux imports et aux corrections. Le groupe commence aussi la rédaction du rapport.

**Changements retrouvés :** la révision 650 à 09:34 UTC corrige la casse des jours dans LOGER et ANIMATIONS. La version 840 à 13:19 UTC ajoute notamment la vue ANIMATIONS_H. Cette dernière remplace l'archive de travail du schéma dans ce commit. La révision 1464 du rapport à 15:46 UTC conserve l'état des requêtes, leurs résultats et justifications disponibles à cette date.

**Limite :** les tests évoqués sont les essais SQL documentés à l'époque, pas une suite de tests automatisés ni une nouvelle exécution Oracle pendant cette reconstruction.

## 2 novembre 2026 — Extractions et analyse décisionnelle

La feuille de temps documente les extractions et transformations (Ny Toavimpahendrena et Tsinjo), les KPI et la maquette Planning et remplissage (Jesus), les indicateurs Destinations et climat (Adrien), ainsi que les thèmes de Synthèse direction et les corrections du rapport (Hyacinthe).

**Versions réelles :** extraction TABLE_TEST1 modifiée à 15:51 UTC ; document d'indicateurs révision 184 à 15:40 UTC ; rapport révision 4584 à 14:55 UTC ; fichier PROJET.pbix conservé localement, dont les entrées ZIP portent le 2 novembre à 16:48 sans fuseau explicite. Il contient une page et TABLE_TEST1 (166 lignes). L'horodatage interne est un indice, pas une preuve d'auteur ou de toutes les dates de travail.

**Attention aux archives :** le script TABLE_TEST1 contient aussi un DROP TABLE, un SELECT et un fragment `ct` provenant du document d'origine. Il est conservé sans correction pour montrer l'état du travail et ne doit pas être exécuté en bloc. Le document KPI contient des propositions qui ne sont pas toutes des fonctionnalités finalement livrées.

## 3 novembre 2026 — Première extraction de Synthèse direction

Une révision réelle du document Synthèse direction (142, 03:27 UTC) crée TABLE_TEST2 et adapte TABLE_ZONES. Le texte explique la suppression de jointures avec CHOIX qui pouvaient multiplier les lignes. Il rapporte 116 réservations, 307 voyageurs et 266 229 euros : ce sont les résultats consignés pour ce jeu intermédiaire, pas ceux du jeu final enrichi.

Cette copie est archivée avant sa version plus complète du même jour pour rendre la modification SQL visible dans Git.

## 3 novembre 2026 — Construction des pages et consolidation

La feuille de temps décrit la construction de Planning et remplissage par Jesus, le développement de Synthèse direction par Hyacinthe et Ny Toavimpahendrena, et le début de Destinations et climat par Adrien. Tsinjo intègre les annexes et extractions au rendu ; Simon prépare la présentation.

**Diff retrouvé :** dans la révision 430 à 16:00 UTC, TABLE_TEST2 devient TABLE_PRINCIPALE ; l'extraction ajoute des informations climatiques, mensuelles et de guides. TABLE_DEPARTS apparaît avec une jointure externe conservant les départs sans réservation. La préparation des valeurs nulles dans Power Query est décrite. Le rapport évolue vers sa révision 6776 à 16:00 UTC.

**État conservé :** aucun PBIX enregistré précisément le 3 n'a été retrouvé. Le développement des pages ce jour-là est attesté par la feuille de temps ; leur première copie complète retrouvée est celle dont les entrées ZIP portent le 4.
