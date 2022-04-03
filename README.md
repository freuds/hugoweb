# gohugo.io static Host

## Install gohugo.io

Follow instructions on this [page](https://gohugo.io/getting-started/installing/)

## Launch HUGO on development mode (default)
```
hugo -D server
```
Test it on : http://localhost:1313


## Build image
```
docker build -f Dockerfile . -t <name>:<tag>
```

## Run locally
```
docker run -d -p 80:8080 <name>:<tag>
```

