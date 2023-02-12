# gohugo.io static Host

## Install gohugo.io

Follow instructions on this [page](https://gohugo.io/getting-started/installing/)

## Launch HUGO on development mode (default)
```
make dev
```
Test it on : http://localhost:1313


## Build docker image
```
make image
```

## Run locally
```
make run
docker run -d -p 80:8080 <name>:<tag>
```

## Debug docker image
```
make run
docker run -d -p 80:8080 <name>:<tag>
```

