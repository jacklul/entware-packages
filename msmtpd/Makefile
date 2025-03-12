include $(TOPDIR)/rules.mk

PKG_NAME:=msmtpd
PKG_VERSION:=1.8.28
PKG_RELEASE:=1

PKG_SOURCE:=msmtp-$(PKG_VERSION).tar.xz
PKG_SOURCE_URL:=https://marlam.de/msmtp/releases
PKG_HASH:=3a57f155f54e4860f7dd42138d9bea1af615b99dfab5ab4cd728fc8c09a647a4

PKG_INSTALL:=1
PKG_BUILD_PARALLEL:=1
PKG_UNPACK=xzcat $(DL_DIR)/$(PKG_SOURCE) | $(TAR) -C $(PKG_BUILD_DIR) --strip-components=1 -xf -

include $(INCLUDE_DIR)/package.mk
include $(INCLUDE_DIR)/nls.mk

CONFIGURE_ARGS += \
	--disable-rpath \
	--without-libintl-prefix \
	--without-libgsasl \
	--without-libidn \
	--without-libsecret \
	--without-macosx-keyring \
	--without-tls

define Package/msmtpd
	SECTION:=mail
	CATEGORY:=Mail
	DEPENDS:=$(INTL_DEPENDS)
	TITLE:=Minimal SMTP server
	URL:=https://marlam.de/msmtp
	MAINTAINER:=Jack'lul, https://jacklul.github.io
endef

define Package/msmtpd/description
 Msmtpd is a minimal SMTP server that pipes mails to msmtp or some other
 program for delivery. It can be used with system services that expect
 an SMTP server on the local host.
endef

define Package/msmtpd/install
	$(INSTALL_DIR) $(1)/opt/sbin
	$(CP) $(PKG_INSTALL_DIR)/opt/bin/msmtpd $(1)/opt/sbin/
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) ./files/S90msmtpd $(1)/opt/etc/init.d
endef

$(eval $(call BuildPackage,msmtpd))
