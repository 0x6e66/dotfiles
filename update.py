import argparse
import os
import shutil

blocklist = [".git", "update.py", "README.md"]

def parse_args():
    parser = argparse.ArgumentParser()
    parser.add_argument("direction", choices=["homedir", "repo"])

    return parser.parse_args()

def update(dir: str):
    for file_or_dir in os.listdir("."):
        if file_or_dir in blocklist: continue

        homedir_file_or_dir = os.path.join(os.environ.get("HOME"), file_or_dir)

        copy_func = None
        remove_func = None

        if os.path.isdir(file_or_dir):
            remove_func=shutil.rmtree
            copy_func=shutil.copytree
        elif os.path.isfile(file_or_dir):
            remove_func=os.remove
            copy_func=shutil.copy

        if dir == "homedir":
            if os.path.exists(homedir_file_or_dir):
                remove_func(homedir_file_or_dir)
            copy_func(file_or_dir, homedir_file_or_dir)
        elif dir == "repo":
            if os.path.exists(file_or_dir):
                remove_func(file_or_dir)
            copy_func(homedir_file_or_dir, file_or_dir)


if __name__ == "__main__":
    args = parse_args()
    if args.direction:
        update(args.direction)