package=libsnark
$(package)_version=0.1
$(package)_download_path=https://github.com/scipr-lab/$(package)/archive/
$(package)_file_name=$(package)-$($(package)_git_commit).tar.gz
$(package)_download_file=$($(package)_git_commit).tar.gz
$(package)_sha256_hash=21b02d48a5448fe8bd0ba3a890f38604930500617d20d339500fab6e340bc2cf
#$(package)_sha256_hash=b5ec84a836d0d305407d5f39c8176bae2bb448abe802a8d11ba0f88f17e6d358
# if there reports sha256sum: WARNING: 1 computed checksum did NOT match
# solution:
# open zcash/depends/work/download/libsnark-0.1/.libsnark-69f312f149cc4bd8def8e2fed26a7941ff41251d.tar.gz.hash
# repalce sha256_hash with above
$(package)_git_commit=69f312f149cc4bd8def8e2fed26a7941ff41251d

$(package)_dependencies=crypto++ libgmp xbyak ate-pairing
$(package)_patches=1_fix_Wl_flag.patch

define $(package)_preprocess_cmds
    patch -p1 < $($(package)_patch_dir)/1_fix_Wl_flag.patch
endef

define $(package)_build_cmds
  CXXFLAGS="-fPIC -DNO_PT_COMPRESSION=1" $(MAKE) lib DEPINST=$(host_prefix) CURVE=ALT_BN128 NO_PROCPS=1 NO_GTEST=1 NO_DOCS=1 STATIC=1 NO_SUPERCOP=1
endef

define $(package)_stage_cmds
  $(MAKE) install STATIC=1 DEPINST=$(host_prefix) PREFIX=$($(package)_staging_dir)$(host_prefix) CURVE=ALT_BN128 NO_SUPERCOP=1
endef
