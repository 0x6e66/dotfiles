import argparse
import os
import shutil

BLOCKLIST = [".git", "update.py", "README.md"]
HOMEDIR = os.environ.get("HOME")


def main():
    args = parse_args()
    if args.update_target:
        handle_dir(args.update_target, ".")


def parse_args():
    parser = argparse.ArgumentParser()
    parser.add_argument("update_target", choices=["homedir", "repo"])

    return parser.parse_args()


def handle_dir(update_target: str, directory):
    for file_or_dir in os.listdir(directory):
        if file_or_dir in BLOCKLIST: continue

        file_or_dir = os.path.join(directory, file_or_dir)

        if os.path.isfile(file_or_dir):
            handle_file(update_target, file_or_dir)
        elif os.path.isdir(file_or_dir):
            handle_dir(update_target, file_or_dir)


def handle_file(update_target, file_path):
    homedir_file = os.path.join(os.environ.get("HOME"), file_path)

    if update_target == "repo":
        os.remove(file_path)
        shutil.copy(homedir_file, file_path)
    elif update_target == "homedir":
        os.remove(homedir_file)
        shutil.copy(file_path, homedir_file)


if __name__ == "__main__":
    main()
