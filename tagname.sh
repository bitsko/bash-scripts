#!/usr/bin/env bash
# Author__="JeanLucPons"
# Project_="VanitySearch"
# Author__="novoworks"
# Project_="novo"
Author__="RadiantBlockchain"
Project_="radiant-node"
Website_="https://api.github.com/repos/"
Website2="/releases/latest"
Get_Url_="${Website_}${Author__}/${Project_}${Website2}"
Tag_Name="$(jq .tag_name<<<$(curl -s ""$Get_Url_""))"
Version_="${Tag_Name//v/}"
Version2="${Tag_Name//\"/}"
TarGzDl_="${Version2}.tar.gz"
TarGzDlA="https://github.com/${Author__}/${Project_}"
TarGzDlB="/archive/refs/tags/${TarGzDl_}"
TarGzDlC="${TarGzDlA}${TarGzDlB}"
curl -LO -X GET "$TarGzDlC" || wget "$TarGzDlC"
gunzip -t "${TarGzDl_}"
gunzip -c "${TarGzDl_}" | tar -t > /dev/null
if ! gunzip -t "${TarGzDl_}"
then
	echo "extraction failed, tar.gz invalid"
	exit 1
fi
if ! gunzip -c "${TarGzDl_}" | tar -t > /dev/null
then
	echo "extraction failed, tar invalid"
	exit 1
fi
tar -zxvf "${TarGzDl_}"
