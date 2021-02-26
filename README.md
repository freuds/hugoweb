# freuds.me Host

## Clone repository
```
git clone https://github.com/freuds/hugoweb.git
```

## Launch HUGO on development mode (default)
```
hugo -D server
```
Test it on : http://localhost:1313


## Build image
```
docker build -f docker/Dockerfile . -t <name>:<tag>
```

## Run locally
```
docker run -d -p 80:8080 <name>:<tag>
```

