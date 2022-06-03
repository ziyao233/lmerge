#!/usr/bin/env lua
--[[
	lmerge
	File:/src/lmerge.lua
	Date:2022.06.03
	By MIT License.
	Copyright(C) 2021 Suote127.All rights reserved.
]]

local table = require("table");

local conf = {
		inputFileList		= {},
		resourceFileList	= {},
		name			= {},
	     };
	
local get_module_name = function(fileName)
	return string.match(fileName,"(.+)%..-$");
end

local get_max_equ_length = function(str)
	local max = 2;
	for s in string.gmatch(str,"[=]+")
	do
		max = math.max(max,#s);
	end
	return max;
end

local spawn_module = function(output,fileName,src)
	local name = conf.name[fileName] or get_module_name(fileName);
	local equs = string.rep("=",get_max_equ_length(src)+1);
	local temp = string.format("\npackage.preload[\"%s\"] = assert(load([%s[\n%s\n]%s]));\n",
				   name,equs,src,equs);

	output:write(temp);

	return;
end

local spawn_resource = function(output,fileName)
	local file = assert(io.open(fileName,"r"));

	local src  = file:read("a");
	local equs = string.rep("=",get_max_equ_length(src)+1);
	local temp = string.format("\n_G.lmerge[ [[%s]] ] = [%s[\n%s\n]%s];\n",
				   conf.name[fileName] or fileName,equs,src,equs);
	output:write(temp);

	return;
end

-- Analysis the command argument
local i = 1;
local target = conf.inputFileList;
while arg[i]
do
	if arg[i] == '-o'	-- The output file
	then
		conf.outputFileName = arg[i+1];
		i = i + 1;
	elseif arg[i] == '-m'	-- The main file
	then
		conf.mainFileName = arg[i+1];
		i = i + 1;
	elseif arg[i] == '-ishb' or
	       arg[i] == '--ignore-sharp-bang'	-- Ignore the sharp-bang line
	then
		conf.ignoreSharpBang = true;
	elseif arg[i] == "-r" or
	       arg[i] == "--resource"
	then
		table.insert(conf.resourceFileList,arg[i + 1]);
		i = i + 1;
	elseif arg[i] == "-s" or
	       arg[i] == "--submodule"		-- Support for converting submodule
	then
		conf.submodule = true;
	elseif arg[i] == "--module"
	then
		conf.ignoreSharpBang = true;
		conf.submodule = true;
		conf.noSharpBang = true;
	elseif arg[i] == "-nshb" or
	       arg[i] == "--no-sharp-bang"
	then
		conf.noSharpBang = true;
	elseif arg[i] == "-n" or
	       arg[i] == "--name"
	then
		conf.name[arg[i + 1]] = arg[i + 2];
		i = i + 2;
	else
		table.insert(target,arg[i]);
	end
	i = i + 1;
end

local sourceFile = {};
for _,fileName in pairs(conf.inputFileList)
do
	local modName = get_module_name(fileName);
	local file = assert(io.open(fileName,"r"));
	sourceFile[fileName] = file:read("a");
	if conf.ignoreSharpBang
	then
		local pattern<const> = "#!.-\n"
		sourceFile[fileName] = string.gsub(sourceFile[fileName],pattern,"");
	end
	file:close();
end

local output = assert(io.open(conf.outputFileName,"w"));
if not conf.noSharpBang or conf.module
then
	output:write("#!/usr/bin/env lua\n");
end
if #conf.resourceFileList ~= 0
then
	output:write([[
_G.lmerge = {resource = function(name) return _G.lmerge[name] end}]] .. "\n"
		    );
end

for _,fileName in pairs(conf.resourceFileList)
do
	spawn_resource(output,fileName);
end

for fileName,src in pairs(sourceFile)
do
	if fileName ~= conf.mainFileName
	then
		local tmp = conf.submodule and
			    string.gsub(fileName,"[/\\]",".") or
			    fileName;
		spawn_module(output,tmp,src);
	end
end

if conf.mainFileName
then
	output:write(sourceFile[conf.mainFileName]);
end

output:close();

return;
