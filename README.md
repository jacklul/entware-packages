# Entware packages

Custom repository with extra packages.

## How to use

Add this repository to your `/opt/etc/opkg.conf`:

```bash
src/gz jacklul https://jacklul.github.io/entware-packages/[architecture]
# replace [architecture] with one of the supported architectures
```

Run `opkg update` and then you can install the packages through `opkg install` command.
