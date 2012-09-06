# Copyright 2005-2009, Google, Inc.

# This extension enables placing a model in Google Earth relative to the ocean floor,
# instead of relative to ground (sea level).

# Permission to use, copy, modify, and distribute this software for
# any purpose and without fee is hereby granted, provided that the above
# copyright notice appear in all copies.

# THIS SOFTWARE IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR
# IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
# WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.
#-----------------------------------------------------------------------------
require 'sketchup.rb'
require 'extensions.rb'
require 'LangHandler.rb'

$_strings = LanguageHandler.new("OnlyTwoCents.strings")

_extension = SketchupExtension.new $_strings.GetString("Bookcase & Cabinet Modeling"), "store/Main.rb"
_extension.version = '1.0'
_extension .description=$_strings.GetString("Adds the ability to model on the bookcases.")

Sketchup.register_extension _extension, false

