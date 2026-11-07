<h1 align="center">☀️ Direction Soleil</h1>

<p align="center">
  <strong>De la base de données Oracle aux tableaux de bord Power BI pour analyser l'activité d'une agence de voyages.</strong>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Oracle-SQL-C74634?style=for-the-badge" alt="Oracle SQL">
  <img src="https://img.shields.io/badge/PL%2FSQL-Base_de_données-C74634?style=for-the-badge" alt="PL/SQL">
  <img src="https://img.shields.io/badge/Power_BI-F2C811?style=for-the-badge&logo=powerbi&logoColor=black" alt="Power BI">
  <img src="https://img.shields.io/badge/Power_Query_·_DAX-Analyse-4479A1?style=for-the-badge" alt="Power Query et DAX">
</p>

## 🎓 Le projet

Direction Soleil est un projet universitaire réalisé en groupe en **Master 1 MIAGE à l'Université Toulouse Capitole**, en **2026**.

Le cas étudié est celui d'une agence de voyages qui organise des circuits avec différents aéroports et dates de départ, des hôtels, des activités et des guides. Le travail relie la **modélisation relationnelle**, l'**exploitation des données sous Oracle** et la **restitution dans Power BI**.

L'objectif est de répondre aux besoins de la direction et de l'exploitation : comprendre le chiffre d'affaires, suivre les réservations et les places disponibles, comparer les destinations et tenir compte de la saisonnalité et du climat.

> Il s'agit d'un cas pédagogique, avec des clients et guides fictifs. Les indicateurs illustrent le jeu d'étude ; ils ne décrivent pas les résultats d'une entreprise réelle.

## 🗓️ Progression du projet

Le groupe a travaillé du **26 octobre au 6 novembre 2026**, de la modélisation aux tableaux de bord et à la soutenance. Le [journal de développement](docs/historique-developpement.md) retrace les étapes, les contributions documentées et les versions réellement conservées.

Cet historique a été **reconstitué après la réalisation du projet** : les nouveaux commits conservent leur date de création, et leurs messages indiquent les dates historiques. Les [archives de travail](docs/historique/README.md) complètent les livrables finaux ; elles peuvent contenir des erreurs ou des pistes abandonnées.

Une extraction initiale de `TABLE_TEST1` a notamment été retrouvée dans ces archives. Elle documente la progression mais doit être revue avant exécution ; elle ne constitue pas une procédure d'actualisation validée du PBIX final.

## ✨ Réalisations

- 🗃️ **Modèle relationnel de 23 tables** : clients, circuits, réservations, départs, hôtels, activités, guides, pays et zones géographiques.
- 🔗 **Contraintes d'intégrité** : clés primaires et étrangères, contrôles de valeurs et champs obligatoires.
- 📥 **Alimentation de la base** : script d'import du jeu de données et ajustements de certaines colonnes Oracle.
- 🔎 **Requêtes métier** : dix requêtes demandées et cinq requêtes supplémentaires, notamment sur le chiffre d'affaires, les préférences des clients et les départs sans réservation.
- ⚙️ **Vue et déclencheur PL/SQL** : présentation des horaires d'animation et contrôle du cumul des voyageurs par circuit et date.
- 🔄 **Trois extractions pour Power BI** : activité commerciale, répartition géographique et départs proposés.
- 📊 **Trois pages de rapport** : synthèse direction, planning et remplissage, destinations et climat.

## 🔄 Démarche et gestion des données

1. Traduire le modèle conceptuel fourni dans le cadre du projet en un modèle logique relationnel.
2. Créer les tables Oracle et leurs contraintes, puis charger le jeu d'étude.
3. Écrire les requêtes pour répondre aux questions métier et préparer les extractions.
4. Importer les données dans Power BI et préparer les colonnes dans Power Query, notamment en remplaçant les nombres de voyageurs nuls par zéro pour les départs sans réservation.
5. Construire les mesures DAX et les visuels pour faciliter l'exploration des résultats.

| Extraction | Rôle |
|---|---|
| `TABLE_PRINCIPALE` | Réservations enrichies avec les circuits, tarifs, pays, informations climatiques et guides |
| `TABLE_ZONES` | Répartition du chiffre d'affaires et des voyageurs entre les zones d'un couple circuit-pays |
| `TABLE_DEPARTS` | Départs proposés, y compris ceux sans réservation, avec les volumes réservés et la capacité |

La préparation des données tient compte du niveau de détail des tables : une jointure avec plusieurs pays, zones ou guides peut multiplier les lignes. Les agrégations doivent donc être interprétées au bon niveau avant de comparer les indicateurs.

## 📊 Tableaux de bord

| Page | Questions abordées |
|---|---|
| **Synthèse direction** | Comment se répartissent le chiffre d'affaires et les voyageurs par pays, aéroport et zone géographique ? |
| **Planning et remplissage** | Quels départs sont peu remplis ou sans réservation ? Quelles places restent disponibles et comment sont réparties les affectations des guides ? |
| **Destinations et climat** | Quelle est la saisonnalité des réservations et quelles destinations présentent des périodes de forte chaleur ? |

Les captures et les explications des tableaux de bord figurent dans le [rapport, pages 32 à 35](docs/rapport.pdf). La [présentation de soutenance](docs/presentation.pdf) complète les exemples de requêtes.

## 🛠️ Technologies

| Besoin | Solution |
|---|---|
| Base relationnelle et requêtes | Oracle Database et SQL |
| Logique en base | PL/SQL, vue et trigger |
| Écriture et exécution des scripts | Oracle SQL Developer |
| Préparation des données | Power Query |
| Mesures et restitution | DAX et Power BI Desktop |

## 🧠 Notions travaillées

| Notion | Mise en pratique |
|---|---|
| Modélisation relationnelle | Traduction du modèle conceptuel et gestion des associations |
| Intégrité des données | Contraintes SQL et contrôle de capacité |
| Requêtes SQL | Jointures, sous-requêtes, regroupements et agrégations |
| Préparation des données | Extractions dédiées et traitement des valeurs nulles |
| Analyse décisionnelle | Choix des indicateurs, filtres et visualisations adaptés aux besoins métier |
| Travail en groupe | Rapport commun, scripts et soutenance |

## 📂 Organisation

| Dossier ou fichier | Contenu |
|---|---|
| `sql/01_creation_tables.sql` | Création des 23 tables et de leurs contraintes |
| `sql/02_import_donnees_sup.sql` | Chargement du jeu d'étude, avec coordonnées neutralisées pour la publication |
| `sql/03_vue_et_trigger.sql` | Vue `ANIMATIONS_H` et trigger sur `RESERVER` |
| `sql/04_requetes_obligatoires.sql` | Dix requêtes du cahier des charges |
| `sql/05_requetes_supplementaires.sql` | Cinq requêtes complémentaires |
| `sql/06_extractions_powerbi.sql` | Création de `TABLE_PRINCIPALE`, `TABLE_ZONES` et `TABLE_DEPARTS` |
| `powerbi/direction-soleil.pbix` | Rapport Power BI avec les données importées du rendu universitaire |
| `docs/rapport.pdf` | Rapport final : modèle, SQL, résultats et tableaux de bord |
| `docs/presentation.pdf` | Support de soutenance |
| `docs/publication.md` | Adaptations de la version publique et périmètre des vérifications |

Les scripts sont décompressés et directement consultables. Les livrables sont rangés dans leurs dossiers dédiés ; les archives originales et les fichiers de travail locaux ne sont pas versionnés.

## 🚀 Installation et utilisation

### Consulter le projet

```bash
git clone https://github.com/hyacinthe-waboe/projet-direction-soleil.git
cd projet-direction-soleil
```

Le rapport PDF permet de découvrir le projet sans installer Oracle ou Power BI. Pour explorer les visuels, ouvrir `powerbi/direction-soleil.pbix` dans une version compatible de **Power BI Desktop**, en conservant les données déjà importées.

### Recréer la base Oracle

Prévoir une base Oracle et un **schéma vide dédié aux essais**, avec les droits nécessaires pour créer tables, vue et trigger. Dans SQL Developer, utiliser **Exécuter un script (F5)** pour les blocs PL/SQL et les commandes SQL*Plus.

Exécuter les fichiers dans cet ordre :

1. `sql/01_creation_tables.sql` ;
2. `sql/02_import_donnees_sup.sql` ;
3. `sql/03_vue_et_trigger.sql` ;
4. `sql/04_requetes_obligatoires.sql` et `sql/05_requetes_supplementaires.sql` pour consulter les résultats ;
5. `sql/06_extractions_powerbi.sql` pour créer les tables d'extraction.

> ⚠️ Le script d'import supprime les lignes des 23 tables avant de les recharger et modifie certaines colonnes. Il effectue des opérations avec commit : l'exécuter uniquement dans une base de test. Les scripts de création ne sont pas prévus pour être relancés sur des objets déjà présents.

### Actualiser Power BI

Le fichier livré utilise une connexion Oracle locale (`localhost:1550/siip`) et le schéma `GR1_BDD`. Adapter les sources dans **Transformer les données** et les paramètres de connexion à sa propre installation ; saisir ses identifiants localement.

Le PBIX contient également une table historique `TABLE_PRINCIPALE_ANCIENS` et une source `TABLE_TEST1`. Le script de création de cette dernière n'est pas fourni dans l'archive. **Une actualisation complète du PBIX n'est donc pas reproductible avec les seuls six scripts** : conserver les données importées pour la consultation, ou compléter et vérifier ces sources avant actualisation.

## 🚧 Limites actuelles

- Les livrables correspondent au rendu universitaire ; le dépôt ne constitue pas un système de réservation déployable.
- Les extractions créent des instantanés : elles ne se mettent pas à jour automatiquement après une modification des tables sources.
- Le trigger contrôle la capacité par **circuit et date, tous aéroports confondus**, tandis que l'extraction des départs distingue aussi l'aéroport. Ce choix doit être revu avant une utilisation opérationnelle.
- Les jointures de `TABLE_PRINCIPALE` peuvent multiplier les lignes pour les circuits associés à plusieurs pays ou guides ; le calcul des totaux demande une vérification du niveau de détail.
- L'actualisation Power BI dépend de la configuration Oracle locale et de la source intermédiaire manquante décrite ci-dessus.
- La publication a fait l'objet d'une inspection statique des scripts, documents, sources Power Query et données importées. Les scripts n'ont pas été réexécutés sur une instance Oracle et les interactions Power BI n'ont pas été retestées pendant cette préparation.

## 🔐 Données et publication

Les noms de clients et de guides sont fictifs, selon confirmation de l'équipe à l'occasion de la publication. Par précaution, les **601 coordonnées clients et 133 coordonnées d'hôtels** du script d'import ont été remplacées par des téléphones de démonstration et des emails sous `example.invalid`. Les clés et données analytiques sont conservées.

Le PBIX et les deux PDF correspondent aux fichiers du rendu, sans modification. Voir la [note de publication](docs/publication.md) pour les détails.

## 👥 Équipe et cadre

Projet réalisé par le **Groupe 1 — M1 MIAGE FI**, à l'Université Toulouse Capitole :

- Jesus Teran Godoy ;
- Hyacinthe Waboe ;
- Tsinjo Randrianarison ;
- Adrien Theophile ;
- Ny Toavimpahendrena Rasamoelina ;
- Simon Edery.

## 📝 Licence

Projet académique collectif. Aucune licence de réutilisation n'est attribuée dans ce dépôt ; les droits des auteurs et des éventuels contenus tiers restent applicables.

<p align="center"><em>Un projet pour relier les données, les besoins métier et l'aide à la décision. ☀️</em></p>
