export AML_LIBS_BUILD_DIR=$(shell pwd)
export AML_LIBS_STAGING_DIR=$(STAGING_DIR)
export AML_LIBS_TARGET_DIR=$(TARGET_DIR)

all:
	mkdir -p $(AML_LIBS_STAGING_DIR)/usr/lib/aml_libs
	mkdir -p $(AML_LIBS_STAGING_DIR)/usr/lib/libplayer
	-$(MAKE) -C amadec all
	-$(MAKE) -C audio_codec all
	-$(MAKE) -C amavutils all
	-$(MAKE) -C amcodec all

install:
	-$(MAKE) -C amadec install
	-$(MAKE) -C amavutils install
	-$(MAKE) -C amcodec install
	-$(MAKE) -C audio_codec install
	cp -rf $(AML_LIBS_STAGING_DIR)/usr/lib/aml_libs/*.so $(AML_LIBS_TARGET_DIR)/usr/lib
	cp -rf $(AML_LIBS_STAGING_DIR)/usr/lib/aml_libs/*.so $(AML_LIBS_STAGING_DIR)/usr/lib/libplayer
	mkdir -p $(AML_LIBS_TARGET_DIR)/lib/firmware/amlogic/amadec
	install -m 0644 amadec/$(FW)/*.bin $(AML_LIBS_TARGET_DIR)/lib/firmware/amlogic/amadec
	cd $(AML_LIBS_TARGET_DIR)/lib/firmware; ln -sf amlogic/amadec/* .; cd $(AML_LIBS_BUILD_DIR)
	cp -rf audio_codec/libeac3/libeac3.so $(AML_LIBS_TARGET_DIR)/usr/lib

clean:
	-$(MAKE) -C amadec clean
	-$(MAKE) -C amavutils clean
	-$(MAKE) -C amcodec clean
	-$(MAKE) -C audio_codec clean
