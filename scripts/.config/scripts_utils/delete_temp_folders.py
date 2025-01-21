import os
import shutil

excluded_paths = [
    "/Users/binary/Library/",
    "/Users/binary/.vscode/",
    "/Users/binary/.poetry",
    "/Users/binary/.nvm",
    "/Users/binary/.pnpm",
    "/Users/binary/.local/",
]


def get_folder_size(folder_path):
    """
    Returns the total size of a folder in bytes.
    """
    total_size = 0
    for dirpath, dirnames, filenames in os.walk(folder_path):
        for file in filenames:
            file_path = os.path.join(dirpath, file)
            if os.path.exists(file_path):
                total_size += os.path.getsize(file_path)
    return total_size


def delete_ds_store_files(root_dir):
    """
    Deletes all .DS_Store files in the specified directory and its subdirectories.
    """
    total_removed = 0
    for dirpath, _, filenames in os.walk(root_dir):
        for file in filenames:
            if file == ".DS_Store":
                file_path = os.path.join(dirpath, file)
                try:
                    os.remove(file_path)
                    total_removed += 1
                    print(f"Deleted: {file_path}")
                except Exception as e:
                    print(f"Error deleting {file_path}: {e}")
    print(f"Total .DS_Store files removed: {total_removed}")


def delete_folders_by_name(root_dir, folder_names):
    total_freed_space = 0

    if not os.path.exists(root_dir):
        print(f"Invalid or non-existent path: {root_dir}")
        return

    for dirpath, dirnames, filenames in os.walk(root_dir):
        if any(os.path.commonpath([excluded, dirpath]) == excluded for excluded in excluded_paths):
            print(f"Skipped: {dirpath}")
            continue  # Skip excluded paths
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
    # Specify the target path
    root_directory = "/Users/binary/Developer"

    # Folders to delete
    folders_to_delete = [
        "node_modules",
        "venv",
        "dist",
        ".cache",
        ".pytest_cache",
        ".mypy_cache",
        "__pycache__",
        "build",
    ]

    if os.path.exists(root_directory) and os.path.isdir(root_directory):
        delete_folders_by_name(root_directory, folders_to_delete)
        delete_ds_store_files(root_directory)
    else:
        print("The specified path does not exist or is not a valid directory.")
