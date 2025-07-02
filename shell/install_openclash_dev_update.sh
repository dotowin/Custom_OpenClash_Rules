#!/bin/sh

# 定义变量
REPO_API_URL="https://api.github.com/repos/vernesong/OpenClash/contents/dev?ref=package"
RAW_FILE_PREFIX="https://testingcf.jsdelivr.net/gh/vernesong/OpenClash@refs/heads/package/dev"

# 清空屏幕并显示欢迎信息
clear
echo "##########################################################"
echo "#                Custom_OpenClash_Rules                  #"
echo "# https://github.com/Aethersailor/Custom_OpenClash_Rules #"
echo "##########################################################"
sleep 1
echo "OpenClash dev 一键安装/更新脚本开始运行..."
echo "即将安装/升级插件和内核至最新 dev 版本，并更新所有数据库、白名单、订阅至最新版"
sleep 1

# 开始更新 Meta 内核
echo "开始更新 Meta 内核..."
/usr/share/openclash/openclash_core.sh
if [ $? -ne 0 ]; then
  echo "Meta 内核更新失败，请检查日志。"
  exit 1
fi
echo "Meta 内核更新完成！"

# 开始更新 GeoIP 数据库
echo "开始更新 GeoIP Dat 数据库..."
/usr/share/openclash/openclash_geoip.sh
if [ $? -ne 0 ]; then
  echo "GeoIP Dat 数据库更新失败，请检查日志。"
  exit 1
fi
echo "GeoIP Dat 数据库更新完成！"

# 开始更新 IP 数据库
echo "开始更新 GeoIP MMDB 数据库..."
/usr/share/openclash/openclash_ipdb.sh
if [ $? -ne 0 ]; then
  echo "GeoIP MMDB 数据库更新失败，请检查日志。"
  exit 1
fi
echo "GeoIP MMDB 数据库更新完成！"

# 开始更新 GeoSite 数据库
echo "开始更新 GeoSite 数据库..."
/usr/share/openclash/openclash_geosite.sh
if [ $? -ne 0 ]; then
  echo "GeoSite 数据库更新失败，请检查日志。"
  exit 1
fi
echo "GeoSite 数据库更新完成！"

# 开始更新 GeoASN 数据库
echo "开始更新 GeoASN 数据库..."
/usr/share/openclash/openclash_geoasn.sh
if [ $? -ne 0 ]; then
  echo "GeoASN 数据库更新失败，请检查日志。"
  exit 1
fi
echo "GeoASN 数据库更新完成！"

# 开始更新大陆白名单
echo "开始更新大陆白名单..."
/usr/share/openclash/openclash_chnroute.sh
if [ $? -ne 0 ]; then
  echo "大陆白名单更新失败，请检查日志。"
  exit 1
fi
echo "大陆白名单更新完成！"

# 开始更新订阅
echo "正在更新订阅..."
/usr/share/openclash/openclash.sh
if [ $? -ne 0 ]; then
  echo "订阅更新失败，请检查日志。"
  exit 1
fi
echo "订阅更新完成！"

sleep 3
echo "启动 OpenClash ..."
uci set openclash.config.enable='1'
uci commit openclash
/etc/init.d/openclash restart >/dev/null 2>&1
echo "脚本运行完毕！"
