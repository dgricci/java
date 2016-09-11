% Environnement Java 8
% Didier Richard
% rév. 0.0.1 du 10/09/2016

---

# Building #

```bash
$ docker build -t dgricci/java:0.0.1 -t dgricci/java:latest .
```

## Behind a proxy (e.g. 10.0.4.2:3128) ##

```bash
$ docker build \
    --build-arg http_proxy=http://10.0.4.2:3128/ \
    --build-arg https_proxy=http://10.0.4.2:3128/ \
    -t dgricci/java:0.0.1 -t dgricci/java:latest .
```

# Use #

See `dgricci/jessie` README for handling permissions with dockers volumes.

```bash
$ docker run -it --rm -e USER_ID=$UID -e USER_NAME=$USER dgricci/java java -version
openjdk version "1.8.0_102"
OpenJDK Runtime Environment (build 1.8.0_102-8u102-b14.1-1~bpo8+1-b14)
OpenJDK 64-Bit Server VM (build 25.102-b14, mixed mode)
```

__Et voilà !__


_fin du document[^pandoc_gen]_

[^pandoc_gen]: document généré via $ `pandoc -V fontsize=10pt -V geometry:"top=2cm, bottom=2cm, left=1cm, right=1cm" -s -N --toc -o java.pdf README.md`{.bash}
