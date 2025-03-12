include $(TOPDIR)/rules.mk

PKG_NAME:=watchyourlan
PKG_VERSION:=v2.0.4
PKG_REV:=638e57b10777774489b855e1546b833dc9c3a2ed
PKG_RELEASE:=1

PKG_SOURCE_URL:=https://github.com/aceberg/WatchYourLAN
PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=$(PKG_REV)
PKG_MIRROR_HASH:=skip

include ../goenv.mk
include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/golang.mk

define Package/watchyourlan/Default
	SECTION:=net
	CATEGORY:=Network
	DEPENDS:=+arp-scan
	TITLE:=watchyourlan
	URL:=https://github.com/aceberg/WatchYourLAN
	MAINTAINER:=Jack'lul, https://jacklul.github.io
endef

define Package/watchyourlan
	$(call Package/watchyourlan/Default)
	VARIANT:=hf
endef

define Package/watchyourlan_nohf
	$(call Package/watchyourlan/Default)
	VARIANT:=nohf
	DEPENDS:=@(TARGET_armv7_2_6||TARGET_armv7_3_2)
endef

define Package/watchyourlan/description
 Lightweight network IP scanner with web GUI
endef

Package/watchyourlan_nohf/description=$(Package/watchyourlan/description)

define Build/Deps
	# install dependencies
	( cd $(PKG_BUILD_DIR); \
		go mod download \
	)
endef

Hooks/Compile/Pre += Build/Deps

GO_TARGET:=./cmd/WatchYourLAN

define Package/watchyourlan/install
	$(INSTALL_DIR) $(1)/opt/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/bin/WatchYourLAN $(1)/opt/sbin/watchyourlan
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) ./files/S85watchyourlan $(1)/opt/etc/init.d
	$(INSTALL_DIR) $(1)/opt/etc/watchyourlan
endef

Package/watchyourlan_nohf/install=$(Package/watchyourlan/install)

$(eval $(call BuildPackage,watchyourlan))
$(eval $(call BuildPackage,watchyourlan_nohf))
