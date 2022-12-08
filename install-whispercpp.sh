#!/usr/bin/env bash
set -x
cd ~
sudo apt install -y libsdl2-dev libcurlpp-dev libopenblas-dev cmake git wget
git clone https://github.com/ggerganov/whisper.cpp 
cd whisper.cpp
bash ./models/download-ggml-model.sh tiny.en
make
make command
mkdir examples/command2
wget -O examples/command2/command2.cpp https://github.com/raspberrypisig/whisper.cpp/raw/master/examples/command2/command2.cpp
wget -O examples/command2/rhasspy.cpp https://github.com/raspberrypisig/whisper.cpp/raw/master/examples/command2/rhasspy.cpp
wget -O examples/command2/rhasspy.h https://github.com/raspberrypisig/whisper.cpp/raw/master/examples/command2/rhasspy.h
cp Makefile Makefile.orig
sed -ri '/command\:/!{p;d;};n;n;a command2: examples/command2/command2.cpp examples/command2/rhasspy.cpp ggml.o whisper.o\n\t$(CXX) $(CXXFLAGS) -I./examples/command2 examples/command2/command2.cpp examples/command2/rhasspy.cpp ggml.o whisper.o -o command2 $(CC_SDL) $(LDFLAGS)\n' Makefile
make command2

cat<<EOF > whisper
#!/usr/bin/env bash
./command -m ./models/ggml-tiny.en.bin -ac 768 -t 4 -c 0
EOF
chmod +x whisper

cat<<EOF > whisper2
#!/usr/bin/env bash
./command2 -m ./models/ggml-tiny.en.bin -ac 768 -t 4 -c 0
EOF
chmod +x whisper2



