# Konsave + Google Drive (rclone) — Workflow de sauvegarde/restauration

## Installation

```sh
python3 -m pip install --user konsave
```

## Commandes courantes

* **Aide rapide** :
  `konsave -h`
* **Sauver config** :
  `konsave -s <nom>`
* **Appliquer un profil** :
  `konsave -a <nom>`
* **Lister profils** :
  `konsave -l`
* **Supprimer profil** :
  `konsave -r <nom>`
* **Exporter profil** :
  `konsave -e <nom>`
* **Importer profil** :
  `konsave -i <fichier.knsv>`

---

## Exemple d’usage

```sh
konsave -s work           # Sauve la config courante
konsave -a work           # Applique ce profil
konsave -e work           # Exporte "work.knsv"
konsave -i ~/work.knsv    # Importe le profil exporté
```

---

## Config avancée :

Modifie `~/.config/konsave/conf.yaml` pour ajouter/retirer des fichiers à sauvegarder.

## 1. **Sauvegarder et exporter ta configuration**

```sh
konsave -s kde-binary -f        # Sauvegarde le profil avec l’état actuel (force la mise à jour)
konsave -e kde-binary           # Exporte vers ~/kde-binary.knsv
```

---

## 2. **Uploader vers Google Drive avec rclone**

```sh
rclone copy -P ~/kde-binary.knsv gdrive:/
```

* `-P` affiche la progression.
* `gdrive` est le nom du remote défini dans rclone.

---

## 3. **Récupérer et restaurer depuis Google Drive**

```sh
rclone copy -P gdrive:/kde-binary.knsv ~/
konsave -i ~/kde-binary.knsv    # Importe le profil dans Konsave
```

---

## 4. **Initialiser rclone (à faire une fois par machine)**

```sh
rclone config
```

* Ajoute un remote `gdrive` de type `drive` (Google Drive).
* Suis l’assistant (Entrée sur client\_id/client\_secret, scope = 1, auto config = y, tout laisser par défaut).

---

## **Résumé schématique**

```
[Config locale] --(konsave -s)--> [Profil Konsave] --(konsave -e)--> [Fichier .knsv]
      |
      +--> [rclone copy -P .knsv gdrive:/] --> [Google Drive cloud backup]
      |
      +<-- [rclone copy -P gdrive:/ .knsv ~/ ] <--(konsave -i)--- [Restauration sur une autre machine]
```

---

## **Bonnes pratiques**

* **Toujours** exécuter `konsave -s <nom> -f` **avant** d’exporter.
* **Uploader après chaque changement important.**
* **Utiliser `-P`** avec rclone pour monitorer la progression.
* **Restauration =** download `.knsv` + import Konsave.

---

