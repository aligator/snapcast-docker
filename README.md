Can be used together with https://github.com/aligator/mopidy-docker.

```yaml
version: "3.3"
services:
  snapcast:
    build: .
    ports:
      - 1704:1704
      - 1705:1705
      - 1780:1780
    environment:
      OWNER: 1000
      GROUP: 1000
    volumes:
      - snapcast:/tmp/snapcast
volumes:
  snapcast:
```