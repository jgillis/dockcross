make manylinux2014-x86
docker tag docker.io/dockcross/manylinux2014-x86:latest ghcr.io/jgillis/manylinux2014-x86:production
make manylinux2014-x64
docker tag docker.io/dockcross/manylinux2014-x64:latest ghcr.io/jgillis/manylinux2014-x64:production

# !! Do not run `docker build ` -- there a preprocessor instructions in the Dockerfile that are ignored by docker.
