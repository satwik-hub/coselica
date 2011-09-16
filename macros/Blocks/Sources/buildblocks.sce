// This file is released under the 3-clause BSD license. See COPYING-BSD.

function buildblocks()
  macros_path = get_absolute_file_path("buildblocks.sce");
  blocks = ["CBS_Pulse"
            "CBS_SawTooth"
            "CBS_Trapezoid"
            "MBS_Clock"
            "MBS_Constant"
            "MBS_ExpSine"
            "MBS_Exponentials"
            "MBS_Pulse"
            "MBS_Ramp"
            "MBS_SawTooth"
            "MBS_Sine"
            "MBS_Step"]

  tbx_build_blocks(toolbox_dir, blocks, macros_path);
  tbx_build_pal(toolbox_dir, "Sources", "CoselicaBlocksSources.xpal", blocks)
endfunction

buildblocks();
clear buildblocks;