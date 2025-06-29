# Snapper (Snapshots Btrfs) : Gestion et Bonnes Pratiques Fedora

## Objectif

- Snapshots système automatiques et manuels (type Time Machine local)
- Rollback rapide après upgrade foiré ou modification dangereuse
- (⚠️ Snapper ≠ sauvegarde externe ni cloud)
---

## 1. Pré-requis

- `/` et idéalement `/home` sur Btrfs (pas ext4/xfs)
- Vérifie :
  ```sh
  findmnt /
  # TYPE doit être btrfs

---

## 2. Installer Snapper

```sh
sudo dnf install snapper python3-dnf-plugin-snapper
```

---

## 3. Initialiser la configuration

```sh
sudo snapper -c root create-config /
sudo snapper -c home create-config /home   # (optionnel)
```

---

## 4. Activer les snapshots automatiques

```sh
sudo systemctl enable --now snapper-timeline.timer
sudo systemctl enable --now snapper-cleanup.timer
```

* Snapshots à chaque upgrade :

  ```sh
  sudo dnf install python3-dnf-plugin-snapper
  ```

---

## 5. Usage courant

### Lister les snapshots

```sh
sudo snapper -c root list
```

### Créer un snapshot manuel

```sh
sudo snapper -c root create --description "avant_modif_X"
```

### Restaurer un fichier

```sh
sudo cp /.snapshots/<id>/snapshot/etc/hosts /etc/hosts
# Remplace <id> par l’identifiant du snapshot à utiliser
```

---

## 6. Points clés d’administration

* Les snapshots sont dans `/.snapshots/` (accès root nécessaire)
* Snapper purge les vieux snapshots via `snapper-cleanup.timer`
* Les snapshots ne protègent **que si ton disque fonctionne** (perte physique = tout perdu)

---

## 7. Limite

* Snapper ≠ sauvegarde hors machine.
* Pour backup externe/versionné : utilise [restic](https://restic.net), [borg](https://borgbackup.readthedocs.io/), [Back In Time](https://github.com/bit-team/backintime), ou rsync.

---

## 8. Routine de contrôle (Exercice à faire régulièrement)

```sh
sudo snapper -c root list
sudo snapper -c root create --description "test"
ls /.snapshots/
```

* **Valide la présence des snapshots et leur accessibilité**

---

## 9. Schéma de flux (ascii)

```
[Fedora Btrfs]
     |
   Snapper (snapshots locaux, rollback rapide)
     |
     +----> [Backup distant/versionné : restic, borg, etc. — à configurer à part]
```

---

## 10. Pour aller plus loin

* Pour restauration complète d’un état système :

  ```sh
  sudo snapper -c root rollback <id>
  ```
* Pour automatiser la sauvegarde externe :
  Voir [restic](https://restic.net/docs.html) ou [borg](https://borgbackup.readthedocs.io/en/stable/quickstart.html)

---

## 11. Résumé

* **Snapper = snapshots locaux, rapides, pratiques**
* **Sauvegarde externe/versionnée = restic/borg/rsync**
* **Les deux sont complémentaires, jamais concurrents**

````

---

**Action minimale à refaire régulièrement :**

```sh
sudo snapper -c root list
sudo snapper -c root create --description "check"
ls /.snapshots/
````

> **Aucune sécurité réelle sans backup externe (restic/borg). Snapper = confort local, pas protection totale.**

---
