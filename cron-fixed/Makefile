include $(TOPDIR)/rules.mk

PKG_NAME:=cron-fixed
PKG_VERSION:=4.1
PKG_RELEASE:=1

PKG_SOURCE:=cron_$(PKG_VERSION).shar
PKG_SOURCE_URL:=ftp://ftp.isc.org/isc/cron
PKG_HASH:=c445837756fb988f2c95db8dc55d7937d14bca0cdfa292de81322ca2556ec39a

include $(INCLUDE_DIR)/package.mk

PKG_UNPACK=cd $(PKG_BUILD_DIR) && cat $(DL_DIR)/$(PKG_SOURCE) | sh -x

define Package/cron-fixed
	SECTION:=utils
	CATEGORY:=Utilities
	TITLE:=Vixie cron
	URL:=ftp://ftp.isc.org/isc/cron
	MAINTAINER:=Jack'lul, https://jacklul.github.io
	ALTERNATIVES:= \
		200:/opt/bin/crontab:/opt/bin/crontab-vixie \
		200:/opt/bin/run-parts:/opt/bin/run-parts-vixie
endef

define Package/cron-fixed/description
 Standart Vixie cron, with cron.d addition. This fork handles situations where UID 0 user is not called root.
endef

define Package/cron-fixed/conffiles
/opt/etc/crontab
endef

define Package/cron-fixed/install
	$(INSTALL_DIR) $(1)/opt/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/crontab $(1)/opt/bin/crontab-vixie
	$(INSTALL_BIN) ./files/run-parts $(1)/opt/bin/run-parts-vixie
	$(INSTALL_DIR) $(1)/opt/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/cron $(1)/opt/sbin
	$(INSTALL_DIR) $(1)/opt/etc/cron.d
	$(INSTALL_CONF) ./files/crontab $(1)/opt/etc
	$(INSTALL_DIR) \
		$(1)/opt/var/{run,spool} \
		$(1)/opt/etc/cron.{1min,5mins,hourly,daily,weekly,monthly}
	$(INSTALL_DIR) $(1)/opt/etc/init.d
	$(INSTALL_BIN) ./files/S10cron $(1)/opt/etc/init.d/
endef

$(eval $(call BuildPackage,cron-fixed))
