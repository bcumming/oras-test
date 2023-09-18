Set up the python environment:

```bash
python3 -m venv pyenv
source ./pyenv/bin/activate

pip install --upgrade pip
pip install -r requirements.txt
```

Install oras in the environment

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

Start local OCI registry:

```bash
docker run -d -p 5000:5000 --name oras-quickstart ghcr.io/project-zot/zot-linux-amd64:latest
```

Push a thing:

```bash
oras push --plain-http localhost:5000/hello-artifact:v1 --artifact-type application/vnd.acme.rocket.config artifact.txt:text/plain
```

This hangs for me, and adding the `--verbose` flag after `push` above shows it hangs on the first line `Preparing artifact.txt`.
