# lmerge

``lmerge`` is a simple script to merge several Lua sources and even resource
files into a single Lua script.

## Installation

Enter ``src`` directory and run

```Shell
$ make install
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

## Resouce File

Files marked with ``-r`` or ``--resource`` are Resouce Files, which can be used
by ``lmerge[FILENAME]``, where ``lmerge`` is a table stored in ``_G``.

## License

By MIT License. Copyright (c) 2021 Ziyao.

Dedicated to my beloved AtomAlpaca.
