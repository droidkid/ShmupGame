# Shoot em up!

A Work in progress Shmup made using

- Heaps.io
- GmFk (WIP library I want to reuse for future games)
- Ldtk & CastleDB
- Art resources crourtesy of KenneyNL

This game was mostly created while exploring Heaps.io and Ldtk.
I ended up moving up a lot of code I think will be useful into GMFK.

## Dependencies

Make sure to install dependencies (atleast ldtk-haxe-api) from git.

```bash
haxelib git heaps https://github.com/HeapsIO/heaps.git
haxelib git deepnightLibs https://github.com/deepnight/deepnightLibs.git
sudo haxelib git ldtk-haxe-api https://github.com/deepnight/ldtk-haxe-api
```

GMFK is not published in haxelib yet, so you'll have to set the dev path to the downloaded gmfk.

1. Download [Gmfk](https://github.com/droidkid/gmfk)
2. Setup haxelib to point to Gmfk
`$ haxelib dev gmfk ../path/to/gmfk`

## Building and Running.

```
haxe compile.hxml 
python -m http.server # To serve the game on localhost:8000
```