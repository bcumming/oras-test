# Some notes

## artifact types

https://github.com/opencontainers/artifacts/blob/main/artifact-authors.md#visualizing-artifacts

For our images, we need an artifact type.
I would suggest:
`application/vnd.cscs.uenv.config`

## logging in

when working interactively from the prompt:
```
cat TOKEN | oras login jfrog.svc.cscs.ch --username bcumming --password-stdin
```

in the pipeline:
```
oras_u=$(echo ${creds_json} | jq -r '.container_registry.username')
oras_p=$(echo ${creds_json} | jq -r '.container_registry.password')

echo ${oras_p} | oras login jfrog.svc.cscs.ch --username ${oras_u} --password-stdin
```

## pushing

```
rego=jfrog.svc.cscs.ch/uenv
repo=build/${CLUSTER_NAME}/${PIPELINE}/${TARGET}

oras push ${rego}/${build} --artifact-type application/vnd.cscs.uenv.config store.sqfs

oras copy ${rego}/build/${cluster}/${build_id}/${id} ${rego}/deploy/$cluster/$...
```

# Getting started

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
