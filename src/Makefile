# lmerge
# Makefile for lmerge
# File:/src/Makefile
# Date:2023.02.18
# By MIT License
# Copyright(C) 2021-2023 Ziyao.All rights reserved.

LUA_NAME	?= lua5.4

# Tools
INSTALL		= install

# Files
SRC		:= lmerge.lua

# Installing Target
INSTALL_DIR	= /usr/local/bin
INSTALL_FILE	= ${INSTALL_DIR}/lmerge

default: install

install:
	sed -e "s/lua5.4/$(LUA_NAME)/" $(SRC) > $(SRC).tmp
	install -Dm 755 ${SRC}.tmp ${INSTALL_FILE}
