# Note de publication

Préparation du dépôt public le 7 novembre 2026 à partir de l'archive `G1 M1 MIAGE - ProjetFinal.zip`.

## Fichiers conservés

Les deux PDF et le fichier PBIX sont conservés à l'identique, avec des noms de fichiers simplifiés. Les six scripts SQL sont décompressés dans `sql/`. Les documents d'audit, anciennes versions et autres fichiers présents sur la machine ne font pas partie de ce dépôt.

## Coordonnées neutralisées

Le script `02_import_donnees_sup.sql` a été adapté pour la publication : les téléphones et emails de 601 clients et 133 hôtels sont remplacés par des valeurs de démonstration, sans modification des identifiants ni des valeurs utilisées pour les analyses. Les emails utilisent le suffixe `example.invalid` et les téléphones sont des identifiants de démonstration commençant par `000`.

Les noms de clients et de guides ont été confirmés fictifs par Hyacinthe Waboe lors de la préparation du dépôt. Les noms de l'équipe restent attribués dans les livrables.

## Vérifications et limites

- Inventaire de l'archive et contrôle des six scripts SQL.
- Recherche de secrets et de coordonnées dans les scripts, le texte des PDF, les sources Power Query et les tables importées du PBIX.
- Contrôle de l'absence de téléphones et emails dans les colonnes du modèle Power BI ; présence de noms fictifs dans les tables clients et guides.
- Identification des sources Oracle locales, de la table `TABLE_TEST1` sans script de création fourni et de la table historique `TABLE_PRINCIPALE_ANCIENS`.
- Identification des différences de granularité entre le trigger de capacité et les extractions.

Ces vérifications statiques ne remplacent pas une exécution Oracle, une validation exhaustive de chaque mesure DAX ou un test des interactions dans Power BI Desktop. Les livrables d'origine sont présentés comme un rendu universitaire, avec leurs limites documentées dans le README.
