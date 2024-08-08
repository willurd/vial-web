# vial-web

## Building

```bash
# Grab this repo
git clone https://github.com/vial-kb/vial-web.git
cd vial-web
# Grab companion repos
git clone https://github.com/vial-kb/vial-gui.git
git clone https://github.com/vial-kb/via-keymap-precompiled.git
```

### From Source

```bash
./fetch-emsdk.sh
./fetch-deps.sh
./build-deps.sh
cd src
./build.sh
```

## With Docker

```bash
docker compose up --build
```
