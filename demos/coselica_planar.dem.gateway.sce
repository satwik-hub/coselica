//
// Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2010-2010 - DIGITEO - Bruno JOFRET
// Copyright (C) 2012-2012 - Scilab Enterprises - Bruno JOFRET
//
// This file must be used under the terms of the CeCILL.
// This source file is licensed as described in the file COPYING, which
// you should have received as part of this distribution.  The terms
// are also available at
// http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt
//
//
function subdemolist = demo_gateway()
  demopath = get_absolute_file_path("coselica_planar.dem.gateway.sce");

  subdemolist = ["Crankshaft"                         , "Crankshaft.dem.sce"
                 "4 Bars"                             , "Fourbars.dem.sce"
                 "Simple Pendulum"                    , "SimplePendulum.dem.sce"
                 "Cart with Pendulum"                 , "CartWithPendulum.dem.sce"
                 "Spyrograph"                         , "Spyrograph.dem.sce"
                 "7 Element pendulum"                 , "SevenPendulumWithFriction.dem.sce"
                 "Projectile Motion with Air Friction", "ProjectileMotionWithAirFriction.dem.sce"
                ];

  subdemolist(:,2) = demopath + subdemolist(:,2);

endfunction

subdemolist = demo_gateway();
clear demo_gateway; // remove demo_gateway on stack
