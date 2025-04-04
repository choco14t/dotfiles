#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Open with Profile for Floorp
# @raycast.mode silent

# Optional parameters:
# @raycast.icon ⌨️
# @raycast.packageName Floorp
# @raycast.argument1 { "type": "text", "placeholder": "Profile", "optional": true }

# Documentation:
# @raycast.description Open Firefox with input profile.
# @raycast.author choco14t
# @raycast.authorURL https://github.com/choco14t

profile=$1

# Using &>/dev/null to avoid print out error below
# UNSUPPORTED (log once): POSSIBLE ISSUE: unit 1 GLD_TEXTURE_INDEX_2D is unloadable and bound to sampler type (Float) - using zero texture because texture unloadable
/Applications/Floorp.app/Contents/MacOS/floorp -P $profile &>/dev/null
