// This file is released under the 3-clause BSD license. See COPYING-BSD.

function buildmacros()
  macros_path = get_absolute_file_path("buildmacros.sce");
  tbx_build_macros(TOOLBOX_NAME+"_MP_", macros_path);
endfunction

function buildblocks()
  macros_path = get_absolute_file_path("buildmacros.sce");
  sources_blocks = ["CMP_World"
                   ]
  forces_blocks = ["CMPF_WorldForce"
                   "CMPF_WorldTorque"
                   "CMPF_FrameForce"
                   "CMPF_LineForce"
                   "CMPF_LineForceWithMass"
                  ]
  joints_blocks = ["CMPJ_FreeMotion"
                   "CMPJ_Prismatic"
                   "CMPJ_Revolute"
                   "CMPJ_ActuatedRevolute"
                   "CMPJ_RollingWheel"
                   "CMPJ_ActuatedRollingWhee"
                   "CMPJ_ActuatedPrismatic"
                  ]
  loopjoints_blocks = ["CMPL_Prismatic"
                    "CMPL_Revolute"
                    "CMPL_ActuatedPrismatic"
                    "CMPL_ActuatedRevolute"
                      ]
  parts_blocks = ["CMPP_Fixed"
                  "CMPP_FixedTranslation"
                  "CMPP_FixedRotation"
                  "CMPP_Body"
                  "CMPP_BodyShape"
                  "CMPP_PointMass"
                 ]
  absolutesensors_blocks = [ "CMPS_AbsPosition"
                    "CMPS_AbsVelocity"
                    "CMPS_AbsAcceleration"
                    "CMPS_GenSensor"
                    "CMPS_AbsAngle"
                    "CMPS_AbsAngularVelocity"
                    "CMPS_AbsAngularAccelerat"
                    "CMPS_AbsPosition2"
                    "CMPS_AbsVelocity2"
                    "CMPS_AbsAcceleration2"
                   ]
  relativesensors_blocks = ["CMPS_Distance"
                    "CMPS_CutForce"
                    "CMPS_CutForce2"
                    "CMPS_CutTorque"
                    "CMPS_Power"
                    "CMPS_RelPosition"
                    "CMPS_RelVelocity"
                    "CMPS_RelAcceleration"
                    "CMPS_GenRelSensor"
                    "CMPS_Angle"
                    "CMPS_RelAngularVelocity"
                    "CMPS_RelAngularAccelerat"
                    "CMPS_RelPosition2"
                    "CMPS_RelVelocity2"
                    "CMPS_RelAcceleration2"
                   ]
  blocks = [sources_blocks
            forces_blocks
            joints_blocks
            loopjoints_blocks
            parts_blocks
            absolutesensors_blocks
            relativesensors_blocks
           ]
  tbx_build_blocks(toolbox_dir, blocks, macros_path);
endfunction

buildmacros();
getd(get_absolute_file_path("buildmacros.sce"));
buildblocks();
clear buildmacros; // remove buildmacros on stack