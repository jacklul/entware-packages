#
# Copyright (C) 2009-2016 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=transmission-old
PKG_VERSION:=4.0.5
PKG_RELEASE:=1

PKG_SOURCE:=transmission-$(PKG_VERSION).tar.xz
PKG_SOURCE_URL:=https://github.com/transmission/transmission/releases/download/$(PKG_VERSION)/
PKG_HASH:=fd68ff114a479200043c30c7e69dba4c1932f7af36ca4c5b5d2edcb5866e6357

PKG_MAINTAINER:=Daniel Golle <daniel@makrotopia.org>
PKG_LICENSE:=GPL-2.0-or-later
PKG_LICENSE_FILES:=COPYING
PKG_CPE_ID:=cpe:/a:transmissionbt:transmission

PKG_INSTALL:=1
PKG_BUILD_DEPENDS:=libb64 libdht
PKG_BUILD_PARALLEL:=1
PKG_BUILD_FLAGS:=gc-sections lto
PKG_CONFIG_DEPENDS:= \
	CONFIG_LIBCURL_GNUTLS \
	CONFIG_LIBCURL_MBEDTLS \
	CONFIG_LIBCURL_OPENSSL \
	CONFIG_LIBCURL_WOLFSSL \
	CONFIG_LIBCURL_NOSSL
PKG_UNPACK=xzcat $(DL_DIR)/$(PKG_SOURCE) | $(TAR) -C $(PKG_BUILD_DIR) --strip-components=1 -xf -

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/cmake.mk
include $(INCLUDE_DIR)/nls.mk

define Package/transmission-old
  SUBMENU:=BitTorrent
  SECTION:=net
  CATEGORY:=Network
  TITLE:=BitTorrent client
  URL:=https://www.transmissionbt.com
  DEPENDS:=+libatomic +libcurl +libdeflate +libevent2 \
	   +libevent2-pthreads +libminiupnpc +libnatpmp +libpthread +libpsl \
	   +librt +libutp +zlib +LIBCURL_NOSSL:libmbedtls \
	   +LIBCURL_GNUTLS:libmbedtls +LIBCURL_MBEDTLS:libmbedtls
  USERID:=transmission=224:transmission=224
  PROVIDES:=transmission-daemon transmission-cli transmission-remote transmission-web
  MAINTAINER:=Jack'lul, https://jacklul.github.io
endef

define Package/transmission-old/description
 Transmission is a simple BitTorrent client.
 It features a very simple, intuitive interface
 on top on an efficient, cross-platform back-end.
endef

define Package/transmission-old/conffiles
/opt/etc/transmission/settings.json
endef

TARGET_CXXFLAGS += -DHAVE_SIZE_T
TARGET_LDFLAGS += -latomic -Wl,--as-needed

CMAKE_OPTIONS += \
	-DENABLE_CLI:BOOL=YES \
	-DENABLE_GTK:BOOL=NO \
	-DENABLE_QT:BOOL=NO \
	-DENABLE_MAC:BOOL=NO \
	-DENABLE_TESTS:BOOL=NO \
	-DENABLE_NLS:BOOL=NO \
	-DENABLE_UTP:BOOL=YES \
	-DRUN_CLANG_TIDY:BOOL=NO \
	-DUSE_SYSTEM_EVENT2:BOOL=YES \
	-DUSE_SYSTEM_DEFLATE:BOOL=YES \
	-DUSE_SYSTEM_DHT:BOOL=YES \
	-DUSE_SYSTEM_MINIUPNPC:BOOL=YES \
	-DUSE_SYSTEM_NATPMP:BOOL=YES \
	-DUSE_SYSTEM_UTP:BOOL=YES \
	-DUSE_SYSTEM_B64:BOOL=YES \
	-DUSE_SYSTEM_PSL:BOOL=YES \
	-DWITH_INOTIFY:BOOL=YES \
	-DWITH_KQUEUE:BOOL=NO \
	-DWITH_SYSTEMD:BOOL=NO \
	-DB64_INCLUDE_DIR=$(STAGING_DIR)/opt/include \
	-DB64_LIBRARY=$(STAGING_DIR)/opt/lib/libb64.a \
	-DDHT_INCLUDE_DIR=$(STAGING_DIR)/opt/include \
	-DDHT_LIBRARY=$(STAGING_DIR)/opt/lib/libdht.a \
	-DUTP_INCLUDE_DIR=$(STAGING_DIR)/opt/include \
	-DUTP_LIBRARY=$(STAGING_DIR)/opt/lib/libutp.so \
	$(if $(CONFIG_LIBCURL_NOSSL),-DWITH_CRYPTO=mbedtls) \
	$(if $(CONFIG_LIBCURL_GNUTLS),-DWITH_CRYPTO=mbedtls) \
	$(if $(CONFIG_LIBCURL_MBEDTLS),-DWITH_CRYPTO=mbedtls) \
	$(if $(CONFIG_LIBCURL_OPENSSL),-DWITH_CRYPTO=openssl) \
	$(if $(CONFIG_LIBCURL_WOLFSSL),-DWITH_CRYPTO=wolfssl)

define Package/transmission-old/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/opt/bin/transmission-daemon \
			$(PKG_INSTALL_DIR)/opt/bin/transmission-remote \
			$(PKG_INSTALL_DIR)/opt/bin/transmission-cli \
			$(PKG_INSTALL_DIR)/opt/bin/transmission-create \
			$(PKG_INSTALL_DIR)/opt/bin/transmission-edit \
			$(PKG_INSTALL_DIR)/opt/bin/transmission-show \
			$(1)/opt/bin/

	$(INSTALL_DIR) $(1)/opt/etc/init.d/
	$(INSTALL_BIN) files/S88transmission $(1)/opt/etc/init.d/

	$(INSTALL_DIR) $(1)/opt/etc/transmission/{blocklists,resume,torrents,watchdir}
	$(INSTALL_CONF) files/settings.json $(1)/opt/etc/transmission/

	$(INSTALL_DIR) $(1)/opt/etc/sysctl.d/
	$(INSTALL_CONF) files/transmission.sysctl $(1)/opt/etc/sysctl.d/20-transmission.conf

	$(INSTALL_DIR) $(1)/opt/share/transmission
	$(CP) $(PKG_INSTALL_DIR)/opt/share/transmission/public_html $(1)/opt/share/transmission/
endef

$(eval $(call BuildPackage,transmission-old))
