package=libcurl
$(package)_version=8.0.1
$(package)_dependencies=openssl
$(package)_download_path=https://curl.haxx.se/download
$(package)_file_name=curl-$($(package)_version).tar.xz
$(package)_sha256_hash=0a381cd82f4d00a9a334438b8ca239afea5bfefcfa9a1025f2bf118e79e0b5f0
$(package)_config_opts=--disable-shared --enable-static --prefix=$(host_prefix) --host=$(HOST) --with-openssl
$(package)_config_opts+=--disable-manual --disable-ntlm-wb --with-random=/dev/urandom --disable-curldebug --disable-libcurl-option --disable-ldap --disable-ldaps
$(package)_config_opts+=CFLAGS="$($(package)_cflags) $($(package)_cppflags) -fPIC"
$(package)_conf_tool=./configure

define $(package)_set_vars
  $(package)_config_env+=LD_LIBRARY_PATH="$(host_prefix)/lib" PKG_CONFIG_LIBDIR="$(host_prefix)/lib/pkgconfig" CPPFLAGS="-I$(host_prefix)/include" LDFLAGS="-L$(host_prefix)/lib"
endef

define $(package)_config_cmds
  echo '=== config for $(package):' && \
  echo '$($(package)_config_env) $($(package)_conf_tool) $($(package)_config_opts)' && \
  echo '=== ' && \
  $($(package)_config_env) $($(package)_conf_tool) $($(package)_config_opts)
endef

define $(package)_build_cmds
  $(MAKE)
endef

define $(package)_stage_cmds
  echo 'Staging dir: $($(package)_staging_dir)$(host_prefix)' && \
  $(MAKE) DESTDIR=$($(package)_staging_dir) install
endef
