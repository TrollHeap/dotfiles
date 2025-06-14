# Ventoy – Procédure d’installation et d’utilisation (Fedora/Linux)

## 1. **Télécharger Ventoy (release officielle)**

```sh
wget https://github.com/ventoy/Ventoy/releases/download/v1.0.99/ventoy-1.0.99-linux.tar.gz
tar -xzf ventoy-1.0.99-linux.tar.gz
cd ventoy-1.0.99
```

> **⚠️** *Adapte la version si nécessaire. Toujours vérifier sur [le GitHub officiel](https://github.com/ventoy/Ventoy/releases).*

---

## 2. **Brancher la clé USB & identifier le device**

```sh
lsblk
# Repère bien le device (ex: /dev/sdb)
# JAMAIS une partition (/dev/sdb1) – seulement le disque
```

---

## 3. **Installer Ventoy sur la clé**

> **⚠️ Cela efface entièrement la clé.**

```sh
sudo ./Ventoy2Disk.sh -i /dev/sdX
# Remplace /dev/sdX par ta clé (ex: /dev/sdb)
# Confirme avec 'y' si demandé
```

---

## 4. **Copier les ISO**

* **Monter la clé si besoin**
* **Copie directe des fichiers ISO :**

```sh
cp Fedora-40.iso /run/media/$USER/Ventoy/
cp Ubuntu-24.04.iso /run/media/$USER/Ventoy/
# Autant d’ISOs que tu veux
```

---

## 5. **Sécuriser les écritures, démonter proprement**

**Avant de débrancher la clé :**

```sh
sync
umount /run/media/$USER/Ventoy
```

* `sync` : force l’écriture réelle sur la clé (évite toute corruption)
* `umount` : démonte la clé proprement (aucun fichier en attente)

---

## 6. **Booter sur la clé**

* Redémarre, choisis la clé dans le boot menu.
* Ventoy s’affiche → Sélectionne l’ISO à lancer.

---

## **Résumé schématique**

```plaintext
[Ventoy écrit sur clé] → [Copie ISO(s)] → [sync + umount] → [Boot → Sélection ISO]
```

---

## **Bonus / Utilisation avancée**

* **Mettre à jour Ventoy :**

  ```sh
  sudo ./Ventoy2Disk.sh -u /dev/sdX
  ```
* **Interface graphique (optionnelle) :**

  ```sh
  sudo ./VentoyGUI.x86_64
  # Qt5/6 requis, CLI recommandé
  ```

---

## **Conseils & vérifs**

* **Toujours faire `sync` puis `umount` avant de retirer la clé.**
* **Toujours vérifier le bon device avec `lsblk` ou `sudo fdisk -l`.**
* **Ajout/Suppression d’ISO :** simple copie/suppression, puis `sync` et `umount`.
* **Voir options avancées :**

  ```sh
  ./Ventoy2Disk.sh --help
  ```

---

**En cas de doute sur le device :** *arrête tout, vérifie à nouveau*.

