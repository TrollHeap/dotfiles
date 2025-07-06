# Docker : Résoudre l'erreur "permission denied"

## 1. Vérifier les permissions du socket Docker

Vérifie les permissions du socket Docker :

```sh
ls -l /var/run/docker.sock
````

### Résultat attendu :

```sh
srw-rw---- 1 root docker 0 /var/run/docker.sock
```

---

## 2. Ajouter l'utilisateur au groupe Docker

Ajoute ton utilisateur au groupe `docker` :

```sh
sudo usermod -aG docker $USER
```

---

## 3. Se déconnecter et se reconnecter

**⚠️** Déconnecte-toi(Logout) et reconnecte-toi pour appliquer les modifications de groupe.

---

## 4. Vérifier l'accès Docker sans `sudo`

Teste Docker sans `sudo` :

```sh
docker info
```

Si tout fonctionne, tu n'as plus besoin de `sudo` pour utiliser Docker.

---

## 5. Redémarrer Docker (si nécessaire)

Si le problème persiste, redémarre Docker :

```sh
sudo systemctl restart docker
```

---

**Résumé :**

* Ajoute ton utilisateur au groupe `docker` avec `sudo usermod -aG docker $USER`.
* Déconnecte-toi (Logout) et reconnecte-toi.
* Teste avec `docker info` pour vérifier si Docker fonctionne sans `sudo`.

