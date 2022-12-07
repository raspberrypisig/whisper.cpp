#!/usr/bin/env bash
set -x
cd ~
sudo apt install -y libcurlpp-dev libopenblas-dev cmake git
git clone https://github.com/ggerganov/whisper.cpp 
cd whisper.cpp
bash ./models/download-ggml-model.sh base.en
bash ./models/download-ggml-model.sh tiny.en
make
make command
cat<<EOF > whisper
#!/usr/bin/env bash
./command -m ./models/ggml-tiny.en.bin -ac 768 -t 4 -c 0
EOF
chmod +x whisper
