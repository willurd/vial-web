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

```bash
# Build the container.
docker build -t vial-web-image .

# Run the container.
docker run -dit --name vial-web-container -p 2222:22 -p 8000:8000 -v D:\\dev\\vial-web:/home/vialuser/vial-web vial-web-image

# You now have an image who's /home/vialuser/vial-web folder is mounted to your local vial-web repo clone.

# SSH into the container:
ssh -p 2222 vialuser@localhost # password: vialpass
cd /home/vialuser/vial-web

# Every command after this point is within the container.

# Set up dependencies:
echo 'source "/home/vialuser/vial-web/emsdk/emsdk_env.sh"' >> $HOME/.bash_profile

sed -i 's/\r$//' ./version.sh
chmod +x ./version.sh

sed -i 's/\r$//' ./fetch-emsdk.sh
chmod +x ./fetch-emsdk.sh
./fetch-emsdk.sh

sed -i 's/\r$//' ./fetch-deps.sh
chmod +x ./fetch-deps.sh
./fetch-deps.sh

sed -i 's/\r$//' ./build-deps.sh
chmod +x ./build-deps.sh
./build-deps.sh

git config --add safe.directory '*'

cd src
sed -i 's/\r$//' ./build.sh
chmod +x ./build.sh
./build.sh

# Run the web server:
cp http-server-cors.py src/build
cd src/build
python http-server-cors.py &
cd ../..

# After every change:
cd src
./build.sh
```
