# lmerge
# Makefile for lmerge
# File:/src/Makefile
# Date:2021.11.06
# By MIT License
# Copyright(C) 2021 Suote127.All rights reserved.

# Tools
CP		:= cp
CHMOD		:= chmod

# Files
SRC		:= lmerge.lua

# Installing Target
INSTALL_DIR	:= /bin
INSTALL_FILE	:= ${INSTALL_DIR}/lmerge

default: install

install:
	$(CP) $(SRC) $(INSTALL_FILE) 
	$(CHMOD) 777 $(INSTALL_FILE)
