```bash
python -m venv pyenv
source ./pyenv/bin/activate

pip install -r requirements.txt                                                                        (pyenv)
```

install oras locally

```bash

version=1.1.0
download_root=https://github.com/oras-project/oras/releases/download
file=oras_${version}_linux_amd64.tar.gz
url=${download_root}/v${version}/${file}

mkdir tmp;

(cd tmp; wget "$url")
(cd tmp; tar -xzvf $file)
cp tmp/oras pyenv/bin
rm -rf tmp
```
