import os
import re
import hashlib
import argparse
import shutil

SUFFIX_RE = re.compile(r'^(.*) \((\d+)\)(\.[^.]+)$')


def sha256sum(filepath, blocksize=65536):
    h = hashlib.sha256()
    with open(filepath, 'rb') as f:
        for block in iter(lambda: f.read(blocksize), b''):
            h.update(block)
    return h.hexdigest()


def find_duplicates(root, exts):
    hashes = {}
    dups = []
    for dirpath, _, filenames in os.walk(root):
        for name in filenames:
            if exts and not any(name.lower().endswith(e) for e in exts):
                continue
            path = os.path.join(dirpath, name)
            try:
                filehash = sha256sum(path)
                if filehash in hashes:
                    dups.append((path, hashes[filehash]))
                else:
                    hashes[filehash] = path
            except Exception as e:
                print(f"Erreur lecture {path}: {e}")
    return dups


def find_and_rename_suffix_copies(root, dryrun, exts):
    """Renomme les fichiers 'foo (1).jpg' en 'foo.jpg' si ce dernier n'existe pas"""
    renames = []
    for dirpath, _, filenames in os.walk(root):
        base_names = set(filenames)
        for name in filenames:
            m = SUFFIX_RE.match(name)
            if m and (not exts or any(name.lower().endswith(e) for e in exts)):
                orig = m.group(1) + m.group(3)
                orig_path = os.path.join(dirpath, orig)
                suffix_path = os.path.join(dirpath, name)
                if not os.path.exists(orig_path):
                    renames.append((suffix_path, orig_path))
    # Effectuer les renommages
    for src, dst in renames:
        if dryrun:
            print(f"[DRY-RUN] Renommer: {src} -> {dst}")
        else:
            os.rename(src, dst)
            print(f"Renommé: {src} -> {dst}")


def main(root, dryrun, trash, exts):
    dups = find_duplicates(root, exts)
    if not dups:
        print("Aucun duplicata détecté.")
    else:
        print(f"{len(dups)} duplicatas trouvés.")
        for dup, original in dups:
            if dryrun:
                print(f"[DRY-RUN] {dup} (duplicata de {original})")
            else:
                if trash:
                    os.makedirs(trash, exist_ok=True)
                    dest = os.path.join(trash, os.path.relpath(dup, root))
                    os.makedirs(os.path.dirname(dest), exist_ok=True)
                    shutil.move(dup, dest)
                    print(f"Déplacé: {dup} → {dest}")
                else:
                    os.remove(dup)
                    print(f"Supprimé: {dup}")
    # Maintenant, gestion des fichiers avec suffixes inutiles
    print("\n--- Renommage des copies inutiles ---")
    find_and_rename_suffix_copies(root, dryrun, exts)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description="Détecte et nettoie les photos dupliquées et renomme les copies inutiles.")
    parser.add_argument("root", help="Dossier racine à scanner")
    parser.add_argument("--dry-run", action="store_true", help="Simulation : aucun fichier supprimé ou renommé")
    parser.add_argument("--trash", metavar="DOSSIER", help="Déplacer au lieu de supprimer")
    parser.add_argument("--ext", nargs="*", default=[".jpg", ".jpeg", ".png", ".gif"],
                        help="Extensions à traiter (défaut: images usuelles)")
    args = parser.parse_args()
    main(args.root, args.dry_run, args.trash, args.ext)
