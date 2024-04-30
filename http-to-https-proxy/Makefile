include $(TOPDIR)/rules.mk

PKG_NAME:=http-to-https-proxy
PKG_VERSION:=v0.3
PKG_REV:=00c082feb138f5845185943182831ee5b115ab08
PKG_RELEASE:=1

PKG_SOURCE_URL:=https://github.com/yeokm1/http-to-https-proxy
PKG_SOURCE_PROTO:=git
PKG_SOURCE_VERSION:=$(PKG_REV)
PKG_MIRROR_HASH:=skip

include ../../golan/goenv.mk
include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/golang.mk

define Package/http-to-https-proxy/Default
	SECTION:=net
	CATEGORY:=Network
	SUBMENU:=Web Servers/Proxies
	TITLE:=http-to-https-proxy
	URL:=https://github.com/yeokm1/http-to-https-proxy
	MAINTAINER:=Jack'lul, https://jacklul.github.io
endef

define Package/http-to-https-proxy
	$(call Package/http-to-https-proxy/Default)
	VARIANT:=hf
endef

define Package/http-to-https-proxy_nohf
	$(call Package/http-to-https-proxy/Default)
	VARIANT:=nohf
	DEPENDS:=@(TARGET_armv7_2_6||TARGET_armv7_3_2)
endef

define Package/http-to-https-proxy/description
 A proxy that upgrades HTTP connections to HTTPS for systems which cannot make HTTPS requests.
endef

Package/http-to-https-proxy_nohf/description=$(Package/http-to-https-proxy/description)

define Build/Deps
	# install dependencies
	( cd $(PKG_BUILD_DIR); \
		go mod download \
	)
endef

Hooks/Compile/Pre += Build/Deps

define Package/http-to-https-proxy/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/bin/http-to-https-proxy $(1)/opt/bin/http-to-https-proxy
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) ./files/S25http-to-https-proxy $(1)/opt/etc/init.d
endef

Package/http-to-https-proxy_nohf/install=$(Package/http-to-https-proxy/install)

$(eval $(call BuildPackage,http-to-https-proxy))
$(eval $(call BuildPackage,http-to-https-proxy_nohf))
