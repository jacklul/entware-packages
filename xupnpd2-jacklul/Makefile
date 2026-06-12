include $(TOPDIR)/rules.mk

PKG_NAME:=xupnpd2-jacklul
PKG_VERSION:=2026-06-12
PKG_REV:=d8d7378af04e8b3a0a242c66bbe4057c25a9f595
PKG_RELEASE:=1

PKG_SOURCE_URL:=https://github.com/jacklul/xupnpd2.git
PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=$(PKG_REV)
PKG_MIRROR_HASH:=skip

include $(INCLUDE_DIR)/package.mk

define Package/xupnpd2-jacklul
	SECTION:=multimedia
	CATEGORY:=Multimedia
	DEPENDS:=+libsqlite3 +liblua5.3 +libuuid +libstdcpp +libopenssl
	TITLE:=eXtensible UPnP agent
	URL:=https://github.com/jacklul/xupnpd2
	MAINTAINER:=Jack'lul, https://jacklul.github.io
	PROVIDES:=xupnpd2
endef

define Package/xupnpd2-jacklul/description
 (github.com/jacklul/xupnpd2) This program is a light DLNA Media Server which provides ContentDirectory:1
 service for sharing IPTV unicast streams over local area network (with udpxy
 for multicast to HTTP unicast conversion). The program shares UTF8-encoded M3U
 playlists with links over local area network as content of the directory.
 You can watch HDTV broadcasts (multicast or unicast) and listen Internet
 Radio in IP network without transcoding and PC.
endef

define Package/xupnpd2-jacklul/conffiles
/opt/etc/xupnpd2/xupnpd.cfg
/opt/etc/xupnpd2/xupnpd.lua
endef

define Build/Configure
	# Discard header files present in the repository
	rm -fr $(PKG_BUILD_DIR)/uuid $(PKG_BUILD_DIR)/sqlite3 $(PKG_BUILD_DIR)/lua5.3 $(PKG_BUILD_DIR)/openssl
endef

define Package/xupnpd2-jacklul/install
	$(INSTALL_DIR) $(1)/opt/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/xupnpd $(1)/opt/sbin/xupnpd2
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) ./files/S94xupnpd2 $(1)/opt/etc/init.d
	$(INSTALL_DIR) $(1)/opt/etc/xupnpd2
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/xupnpd.{cfg,lua} $(1)/opt/etc/xupnpd2
	$(INSTALL_DIR) $(1)/opt/share/xupnpd2/media
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/media/example.m3u \
		$(1)/opt/share/xupnpd2/media
	$(CP) $(PKG_BUILD_DIR)/www $(1)/opt/share/xupnpd2
endef

$(eval $(call BuildPackage,xupnpd2-jacklul))
