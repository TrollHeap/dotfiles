# Konsave – Sauvegarder & Appliquer ses Customisations Linux

## Installation

```sh
python3 -m pip install --user konsave
```

---

## Commandes courantes

Nom utilisé actuellement `kde-binary`

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

---

**Supporte tout DE, focus KDE.**
**Un seul binaire, simple, reproductible.**
