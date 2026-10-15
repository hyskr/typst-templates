#!/usr/bin/env python3
"""将选定模板安装到 Typst 的 @local 命名空间。"""

import argparse
import os
from pathlib import Path
import shutil
import sys
import tomllib


ROOT = Path(__file__).resolve().parents[1]


def package_path():
    if os.environ.get("TYPST_PACKAGE_PATH"):
        return Path(os.environ["TYPST_PACKAGE_PATH"]).expanduser()
    if sys.platform == "darwin":
        data_dir = Path.home() / "Library/Application Support"
    elif os.name == "nt":
        data_dir = Path(os.environ["APPDATA"])
    else:
        data_dir = Path(os.environ.get("XDG_DATA_HOME", Path.home() / ".local/share"))
    return data_dir / "typst/packages"


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("templates", nargs="*", help="模板目录名；省略时安装全部模板")
    parser.add_argument("--list", action="store_true", help="显示可选模板")
    args = parser.parse_args()
    packages = {}
    for manifest in sorted((ROOT / "templates").glob("*/typst.toml")):
        metadata = tomllib.loads(manifest.read_text(encoding="utf-8"))["package"]
        packages[manifest.parent.name] = (manifest.parent, metadata)

    if args.list:
        for name, (_, metadata) in packages.items():
            print(f"{name:20} {metadata['version']:8} {metadata['description']}")
        return

    for name in args.templates or packages:
        if name not in packages:
            parser.error(f"没有模板 {name!r}，使用 --list 查看可选模板")
        source, metadata = packages[name]
        destination = package_path() / "local" / metadata["name"] / metadata["version"]
        if destination.exists():
            shutil.rmtree(destination)
        destination.parent.mkdir(parents=True, exist_ok=True)
        shutil.copytree(source, destination)
        print(f"已安装 @local/{metadata['name']}:{metadata['version']}")
        print(f"  {destination}")


if __name__ == "__main__":
    main()
