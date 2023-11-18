# Entware-packages

Custom repository with extra packages.

### Supported architectures:

- **[armv7-3.2](https://jacklul.github.io/Entware-packages/armv7-3.2/Packages.html)**

### How to use

Add to `/opt/etc/opkg.conf`:

```bash
src/gz jacklul https://jacklul.github.io/Entware-packages/ARCHITECTURE
```

and then run `opkg update` and you can install the packages through `opkg install` command.
