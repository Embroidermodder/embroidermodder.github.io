+++
title = "The Embroidermodder Project"
author = "The Embroidermodder Team"
abbrev = "home"
date = "2022-09-19"
weight = 0
+++

# The Embroidermodder Project and Team

The _Embroidermodder 2_ project is a collection of small software utilities for
manipulating, converting and creating embroidery files in all major embroidery
machine formats. The program _Embroidermodder 2_ itself is a larger graphical
user interface (GUI) which is at the heart of the project.

The tools and associated documents are:

* This manual.
* The website ([`www.libembroidery.org`](https://www.libembroidery.org)), which is maintained [here](https://github.com/Embroidermodder/embroidermodder.github.io).
* Mobile embroidery format viewers and tools (`iMobileViewer`, `MobileViewer`).
* The core library of functions (`libembroidery`) and its manual.
* The Python version of the library of functions (`libembroidery-python`) which is part of [libembroidery](https://github.com/Embroidermodder/libembroidery).
* The CLI (`embroider`) which is part of [libembroidery](https://github.com/Embroidermodder/libembroidery).
* Specs for an open hardware embroidery machine called Embroiderbot (not started yet) which is part of [libembroidery](https://github.com/Embroidermodder/libembroidery) and its manual.
* The GUI (`embroidermodder`), this repository.

They all tools to make the standard
user experience of working with an embroidery machine better without expensive
software which is locked to specific manufacturers and formats. But ultimately
we hope that the core _Embroidermodder 2_ is a practical, ever-present tool in
larger workshops, small cottage industry workshops and personal hobbyist's
bedrooms.

Embroidermodder 2 is licensed under the zlib license and we aim to keep all of
our tools open source and free of charge. If you would like to support the
project check out our [Open Collective](https://opencollective.com/embroidermodder) group. If you would like to help, please
join us on GitHub. This document is written as developer training as well
helping new users (see the last sections) so this is the place to learn how
to start changing the code.

The Embroidermodder Team is the collection of people who've submitted
patches, artwork and documentation to our three projects.
The team was established by Jonathan Greig and Josh Varga.
The full list is actively maintained below.

### Credits for Embroidermodder 2, libembroidery and all other related code

Please note that this file in not in alphabetical order. If you have contributed and wish to be added to this list, create a new credit section and increment the number. Fill it in with your information and submit it to us.

* Jonathan Greig `redteam316` (Core Developer, Artwork, Documentation, Designs, Commands)
* Josh Varga `JoshVarga` (Core Developer)
* Jens Diemer `jedie` (Documentation)
* Kim Howard `turbokim` (Bug Fixes)
* Martin Schneider `craftoid` (Documentation)
* Edward Greig `Metallicow` (Artwork, Bug Fixes, Commands) _"It is a sin to wear the band's shirt on concert night, Unless you buy it @t the show."_
* Sonia Entzinger (Translation)
* SushiTee `SushiTee` (Bug Fixes)
* Vathonie Lufh `x2nie` (BugFixes, Bindings)
* Nina Paley (Designs)
* Theodore Gray (Designs)
* Jens-Wolfhard Schicke-Uffmann `Drahflow` (Bug Fixes)
* Emmett Lauren Garlitz - Some Little Sandy Rd, Elkview, West by GOD Virginia `Oll Em` _"I have a nice cherry chess-top(Glass). But remember, I NEVER played on it."_
* Robin Swift `robin-swift` (Core Developer, Documentation)

## Path to Beta Release

Robin has been working on the development of the post-Qt version of the Embroidermodder 2 alpha for about a year
now on hobbyists hours and he feels it's getting close to the stage where other developers can take on clearly
defined challenges. Also the design of the software, which has mostly carried over from the other 3 core developers,
is also almost ready to be tested in this way. So with that he's making this clear statement of intent:

> *Embroidermodder 2.0.0 beta and regularly updated developer builds will be ready before March 2023.*
> 
> Robin Swift, writing November 2022

If you would like to get involved before this point the build and install advice is the next section of the manual,
but I'd advise you read this section first to get used to the scope of the problem.

### Problems to be fixed before the Beta Release

* Tools to find common problems in the source code and suggest fixes to the developers:
  * A translation miss: that is, for any language other than English a missing entry in the translation table should supply a clear warning to developers.
* Converting Qt C++ version to native GUI C throughout.
* OpenGL Rendering
  * ``Real`` rendering to see what the embroidery looks like.
  * Icons and toolbars.
  * Menu bar
* Libembroidery interfacing:
  * Get all classes to use the proper libembroidery types within them. So `Ellipse` has `EmbEllipse` as public data within it.
* Move calculations of rotation and scaling into `EmbVector` calls.
* Get undo history widget back (BUG).
* Switch website to a CMake build.
* GUI frontend for embroider features that aren't supported by embroidermodder: flag selector from a table
* Update all formats without color to check for edr or rgb files.
* EmbroideryFLOSS - Color picker that displays catalog numbers and names
* Setting for reverse scrolling direction (for zoom, vertical pan)
* Stitching simulation
* User designed custom fill
* Keyboard zooming, panning
* Advanced printing
* Libembroidery 1.0
* Better integrated help: I don't think the help should backend to a html file somewhere on the user's system. A better system would be a custom widget within the program that's searchable.
* New embroidermodder2.ico 16x16 logo that looks good at that scale.
* saving dst, pes, jef
* Settings dialog: notify when the user is switching tabs that the setting has been changed, adding apply button is what would make sense for this to happen.
* Update language translations
* Replace KDE4 thumbnailer.
* Import raster image
* Statistics from 1.0, needs histogram.
* SNAP/ORTHO/POLAR
* Cut/copy allow post-selection
* Layout into config
* Notify user of data loss if not saving to an object format.
* Add which formats to work with to preferences.
* Cannot open file with \# in the name when opening multiple files but works with opening a single file.
* Closing settings dialog with the X in the window saves settings rather than discarding them.
* Otto theme icons: units, render, selectors, what's this icon doesn't scale
* Layer manager and Layer switcher dock widget
* test that all formats read data in correct scale (format details should match other programs).
* Custom filter bug -- doesn't save changes in some cases.

For more details read on into the Design section.

So I've had a few pieces of web infrastructure fail me recently and I
think it's worth noting. An issue that affects us is an issue that can
effect people who use our software.

1. Googletests require a web connection to update and they update on each compilation.
2. Downloading and installing Qt has been a pain for some users (46Gb on possibly slow connections). I think it was davieboy64?
3. The documentation is, well better in that it's housed in the main repository, but I'm not a fan of the "write once build many" approach as it means trying to weigh up how 3 versions are going to render.
4. Github is giving me a server offline (500) error and is still giving a bad ping.
5. OpenGL rendering within the application. This will allow for Realistic Visualization - Bump Mapping/OpenGL/Gradients?
6. Initiation files. Ok this is changing slightly. embroidermodder should boot from the command line regardless of whether it is or is not installed (this helps with testing and running on machines without root). Therefore, it can create an initiation file but it won't rely on its existence to boot: this is what we currently do with settings.ini.
8. Get undo history widget back (BUG).
9. Switch website to a CMake build.
10. Mac Bundle, .tar.gz and .zip source archive.
11. NSIS installer for Windows, Debian package, RPM package
12. GUI frontend for embroider features that aren't supported by embroidermodder: flag selector from a table
13.  Update all formats without color to check for edr or rgb files.
14.  EmbroideryFLOSS - Color picker that displays catalog numbers and names
15.  Setting for reverse scrolling direction (for zoom, vertical pan)
16. Stitching simulation
17.  User designed custom fill
18.  Keyboard zooming, panning
19.  Advanced printing
20.  Libembroidery 1.0
21. Better integrated help: I don't think the help should backend to a html file somewhere on the user's system. A better system would be a custom widget within the program that's searchable.
22. New embroidermodder2.ico 16x16 logo that looks good at that scale.
23. saving dst, pes, jef
24. Settings dialog: notify when the user is switching tabs that the setting has been changed, adding apply button is what would make sense for this to happen.
25.  Update language translations
26.  Replace KDE4 thumbnailer.
27.  Import raster image
28.  Statistics from 1.0, needs histogram.
29.  SNAP/ORTHO/POLAR
30.  Cut/copy allow post-selection
31.  Layout into config
32.  Notify user of data loss if not saving to an object format.
33.  Add which formats to work with to preferences.
34.  Cannot open file with \# in the name when opening multiple files but works with opening a single file.
35.  Closing settings dialog with the X in the window saves settings rather than discarding them.
36. Otto theme icons: units, render, selectors, what's this icon doesn't  scale
37. Layer manager and Layer switcher dock widget
38. Test that all formats read data in correct scale (format details should match other programs).
39.  Custom filter bug -- doesn't save changes in some cases.
