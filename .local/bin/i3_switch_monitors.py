#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import i3 as i3_py
import subprocess
from i3ipc import Connection


# Create the Connection object that can be used to send commands and subscribe
# to events.
i3 = Connection()
i3.command(f"move workspace to output down")
#workspaces = i3_py.get_workspaces()
#for workspace in workspaces:
#    if workspace["focused"] == True:
#        workspace_name = workspace["name"]
#        workspace_name = workspace_name.split(":")[0]
#        print(f"[workspace={workspace_name}] move workspace to output down")
#        i3.command(f"move workspace to output down")
#        #subprocess.run(["i3-msg", f"move workspace to output down"])
#        pass
