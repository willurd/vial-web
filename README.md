# vial-web

## Building

```bash
# Grab this repo
git clone https://github.com/vial-kb/vial-web.git
cd vial-web
# Grab companion repos
git clone https://github.com/vial-kb/vial-gui.git
git clone https://github.com/vial-kb/via-keymap-precompiled.git
./fetch-emsdk.sh
./fetch-deps.sh
./build-deps.sh
cd src
./build.sh
```

## Setting up a Docker container for development

**Build the container:**

This is an ubuntu image with the system dependencies preinstalled.

```bash
docker build \
  -t local/vial-web         `# Name the container.` \
  .                         `# Path to build.`
```

**Run the container:**

```bash
docker run \
  -d                            `# Run in detached mode.` \
  -i                            `# Keep STDIN open even if not attached.` \
  -t                            `# Allocate a pseudo-TTY.` \
  -p 8000:8000                  `# Open a port for the web server.` \
  local/vial-web
```

**Get the container ID:**



**Get the IP address of the container:**

```bash
docker inspect \
  -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' local/vial-web
```

**SSH into the container:**

```bash
cd /root/vial-web

git clone https://github.com/vial-kb/vial-web.git
cd vial-web
git clone https://github.com/vial-kb/vial-gui.git
git clone https://github.com/vial-kb/via-keymap-precompiled.git
./fetch-emsdk.sh
./fetch-deps.sh
./build-deps.sh
cd src
./build.sh
```

**Run the web server:**

```bash
cp http-server-cors.py src/build
cd src/build
python http-server-cors.py
```
