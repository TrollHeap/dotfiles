import os
import shutil

HOME = os.path.expanduser("~")

excluded_paths = [
    os.path.join(HOME, ".config"),
    os.path.join(HOME, ".local"),
    os.path.join(HOME, ".cache"),
    os.path.join(HOME, ".nvm"),
    os.path.join(HOME, ".poetry"),
    os.path.join(HOME, ".pnpm"),
    os.path.join(HOME, ".vscode"),
]


def is_excluded(path):
    """Vérifie si le chemin est dans la liste d'exclusion (préfixe strict)"""
    for excl in excluded_paths:
        try:
            if os.path.commonpath([os.path.abspath(path), excl]) == os.path.abspath(excl):
                return True
        except ValueError:
            continue  # chemins sur disques différents
    return False


def get_folder_size(folder_path):
    total_size = 0
    for dirpath, dirnames, filenames in os.walk(folder_path):
        for file in filenames:
            file_path = os.path.join(dirpath, file)
            if os.path.exists(file_path):
                total_size += os.path.getsize(file_path)
    return total_size


def delete_folders_by_name(root_dir, folder_names):
    total_freed_space = 0
    if not os.path.exists(root_dir):
        print(f"Invalid or non-existent path: {root_dir}")
        return
    for dirpath, dirnames, _ in os.walk(root_dir):
        if is_excluded(dirpath):
            # print(f"Skipped: {dirpath}")
            continue
        for folder_name in folder_names:
            folder_path = os.path.join(dirpath, folder_name)
            if os.path.exists(folder_path) and os.path.isdir(folder_path):
                try:
                    folder_size = get_folder_size(folder_path)
                    shutil.rmtree(folder_path)
                    total_freed_space += folder_size
                    print(f"Deleted: {folder_path} ({folder_size / (1024 * 1024):.2f} MB freed)")
                except Exception as e:
                    print(f"Error deleting {folder_path}: {e}")
    print(f"Total space freed: {total_freed_space / (1024 * 1024):.2f} MB")


if __name__ == "__main__":
    # cible typique : ~/Developer ou un autre répertoire de projets
    root_directory = os.path.join(HOME, "Developer")
    folders_to_delete = [
        "node_modules", "venv", "dist", ".cache",
        ".pytest_cache", ".mypy_cache", "__pycache__", "build", ".DS_STORE", ".__pycache__"
    ]

    if os.path.exists(root_directory) and os.path.isdir(root_directory):
        print(f"==> CLEANING: {root_directory}")
        delete_folders_by_name(root_directory, folders_to_delete)
    else:
        print("The specified path does not exist or is not a valid directory.")
