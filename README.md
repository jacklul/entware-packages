# Entware packages

Custom repository with extra packages.

Supported architectures: **[aarch64-3.10](https://jacklul.github.io/entware-packages/aarch64-3.10/Packages.html)**, **[armv7-3.2](https://jacklul.github.io/entware-packages/armv7-3.2/Packages.html)**, **[mipsel-3.4](https://jacklul.github.io/entware-packages/mipsel-3.4/Packages.html)**, **[mips-3.4](https://jacklul.github.io/entware-packages/mips-3.4/Packages.html)**, **[x64-3.2](https://jacklul.github.io/entware-packages/x64-3.2/Packages.html)**

## How to use

Add this repository to your `/opt/etc/opkg.conf`:

```bash
src/gz jacklul https://jacklul.github.io/entware-packages/[architecture]
# replace [architecture] with one of the supported architectures
```

Run `opkg update` and then you can install the packages through `opkg install` command.
