from pathlib import Path
from PIL import Image
from pillow_heif import register_heif_opener


def convert_heic_to_jpg_in_folder(folder_path: str):
    """
    Convertit tous les fichiers .heic en .jpg dans le dossier donné,
    puis supprime les .heic si la conversion est réussie.
    """
    register_heif_opener()
    folder = Path(folder_path).expanduser()
    converted = 0
    errors = 0

    for heic_file in folder.glob("*.HEIC"):
        try:
            img = Image.open(heic_file)
            jpg_path = heic_file.with_suffix(".jpg")
            img.convert("RGB").save(jpg_path, "JPEG")
            heic_file.unlink()
            converted += 1
        except Exception as e:
            print(f"❌ Erreur conversion {heic_file.name} : {e}")
            errors += 1

    print(f"✅ Conversion terminée : {converted} fichiers convertis, {errors} erreurs.")


# Exemple d'utilisation
convert_heic_to_jpg_in_folder("~/Pictures/iphone/Photos-1-001")
