#!/bin/sh

# 定义变量
REPO_API_URL="https://api.github.com/repos/vernesong/OpenClash/contents/dev?ref=package"
RAW_FILE_PREFIX="https://testingcf.jsdelivr.net/gh/vernesong/OpenClash@refs/heads/package/dev"

# 调用 OpenClash 自带脚本更新 GeoIP Dat 数据库
echo "--------------------[ 更新 GeoIP Dat 数据库 ]-------------"
echo "开始更新 GeoIP Dat 数据库..."
/usr/share/openclash/openclash_geoip.sh
if [ $? -ne 0 ]; then
  echo "GeoIP Dat 数据库更新失败，请检查日志。"
  exit 1
fi
echo "GeoIP Dat 数据库更新完成！"
echo 

# 调用 OpenClash 自带脚本更新 GeoIP MMDB 数据库
echo "--------------------[ 更新 GeoIP MMDB 数据库 ]------------"
echo "开始更新 GeoIP MMDB 数据库..."
/usr/share/openclash/openclash_ipdb.sh
if [ $? -ne 0 ]; then
  echo "GeoIP MMDB 数据库更新失败，请检查日志。"
  exit 1
fi
echo "GeoIP MMDB 数据库更新完成！"
echo 

# 调用 OpenClash 自带脚本更新 GeoSite 数据库
echo "--------------------[ 更新 GeoSite 数据库 ]---------------"
echo "开始更新 GeoSite 数据库..."
/usr/share/openclash/openclash_geosite.sh
if [ $? -ne 0 ]; then
  echo "GeoSite 数据库更新失败，请检查日志。"
  exit 1
fi
echo "GeoSite 数据库更新完成！"
echo 

# 调用 OpenClash 自带脚本更新 GeoASN 数据库
echo "--------------------[ 更新 GeoASN 数据库 ]----------------"
echo "开始更新 GeoASN 数据库..."
/usr/share/openclash/openclash_geoasn.sh
if [ $? -ne 0 ]; then
  echo "GeoASN 数据库更新失败，请检查日志。"
  exit 1
fi
echo "GeoASN 数据库更新完成！"
echo 

# 调用 OpenClash 自带脚本更新大陆 IP白名单
echo "--------------------[ 更新大陆 IP白名单 ]--------------------"
echo "开始更新大陆 IP 白名单..."
/usr/share/openclash/openclash_chnroute.sh
if [ $? -ne 0 ]; then
  echo "大陆 IP 白名单更新失败，请检查日志。"
  exit 1
fi
echo "大陆 IP 白名单更新完成！"
echo 

# 调用 OpenClash 自带脚本更新订阅
echo "--------------------[ 更新订阅 ]--------------------------"
echo "正在更新订阅..."
echo 
/usr/share/openclash/openclash.sh
if [ $? -ne 0 ]; then
  echo "订阅更新失败，请检查日志。"
  exit 1
fi
echo 
echo "订阅更新完成！"
echo 

sleep 3
echo "--------------------[ 启动插件 ]--------------------------"
echo "启动 OpenClash ..."
# 设置 OpenClash 开机自启
uci set openclash.config.enable='1'
# 提交配置
uci commit openclash
# 启动 OpenClash
/etc/init.d/openclash restart >/dev/null 2>&1
echo "OpenClash 启动完成！"
echo 
echo "脚本运行完毕！"
