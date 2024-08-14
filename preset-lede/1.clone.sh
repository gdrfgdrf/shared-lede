#!/usr/bin/env bash

# download base code
CODE_DIR=_firmware_code
git clone --depth 1 https://github.com/coolsnowwolf/lede.git $CODE_DIR
mv ./$CODE_DIR/* ./

# download app codes
SUPPLY_DIR=_supply_packages

cat /dev/null > feeds.conf.default

echo "src-git packages https://github.com/openwrt/packages.git^openwrt-23.05" >> feeds.conf.default
echo "src-git packages_lienol https://github.com/Lienol/openwrt-packages.git^23.05" >> feeds.conf.default
echo "src-git luci https://github.com/Lienol/openwrt-luci^23.05" >> feeds.conf.default
echo "src-git luci_lede https://github.com/coolsnowwolf/luci.git;openwrt-23.05" >> feeds.conf.default
echo "src-git-full routing https://git.openwrt.org/feed/routing.git^openwrt-23.05" >> feeds.conf.default
echo "src-git-full telephony https://git.openwrt.org/feed/telephony.git^openwrt-23.05" >> feeds.conf.default
echo "src-git lienol https://github.com/Lienol/openwrt-package.git^23.05" >> feeds.conf.default
echo "src-git other https://github.com/Lienol/openwrt-package.git^23.05" >> feeds.conf.default
echo "src-link supply $PWD/$SUPPLY_DIR" >> feeds.conf.default

echo "============================================================================="

cat feeds.conf.default

echo "============================================================================="

ls -a
pwd

mkdir $SUPPLY_DIR && cd $SUPPLY_DIR
git clone --depth 1 https://github.com/kenzok8/openwrt-packages.git
git clone --depth 1 https://github.com/kenzok8/small.git
git clone --depth 1 https://github.com/Ausaci/luci-app-nat6-helper.git

ls -a
pwd

echo "start updating feeds"
../scripts/feeds update -a

echo "start installing feeds"
../scripts/feeds install -a
exit 0
