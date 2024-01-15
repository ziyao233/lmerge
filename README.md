# lmerge

``lmerge`` is a simple script to merge several Lua sources and even resource
files into a single Lua script.

## Installation

Enter ``src`` directory and run

```Shell
$ make install
```

This script only runs with a Lua 5.4 interpreter. If the interpreter on your
system is not called `lua5.4`, specify its name with LUA_NAME when installing.

```shell
	$ make install LUA_NAME=lua54
```

You may want to run the command as root. The installing target is specified
by ``INSTALL\_DIR``, which could be overriden on command line.

## Usage

```
lmerge [OPTIONS] SOURCES
```

OPTIONS:

- ``-m``: Specify the script containing the entry point

- ``-r``, ``--resource``: Specify a resource file (refer to Resource File)

- ``-o``: Specify the path of output

- ``-s``, ``--submodule``: Enable support for automatically converting paths of
submodules into module names

- ``--module``: Make lmerge output a Lua module, rather than a executable script

- ``-n modulePath moduleName``, ``--name modulePath moduleName``: Specify the
name of module modulePath, which could be used in ``require()``

- ``-l``, ``--list``: Specify a file list.

- `-i`, `--lua`: Specify name of the Lua interpreter, this will affect the
sharp-bang line

## Resouce File

Files marked with ``-r`` or ``--resource`` are Resouce Files, which can be used
by ``lmerge[FILEPATH]``, where ``lmerge`` is a table stored in ``_G``.

Table ``lmerge`` exists ***ONLY*** with at least one resource file specified.

``lmerge.resource(path)`` returns the content of resource file ``path``.

## File List

A file list is a text file containing a series of resource file paths, source
files and aliases.

### Grammar

- ``PATH``: Specify a source file.

- ``!RESOURCE_PATH``: Specify a resource file

- ``PATH:ALIAS``: Set the module name of ``PATH`` to ``ALIAS``

## License

By MIT License. Copyright (c) 2021 Ziyao.

Dedicated to my beloved AtomAlpaca.
