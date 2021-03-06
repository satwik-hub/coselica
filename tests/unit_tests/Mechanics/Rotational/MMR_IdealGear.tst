// ============================================================================
// Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2013 - Scilab Enterprises - Charlotte HECQUET
//
//  This file is distributed under the same license as the Scilab package.
// ============================================================================
//
// <-- ENGLISH IMPOSED -->
//
// <-- Short Description -->
// Test MMR_IdealGear

[a, coselicaMacrosPath] = libraryinfo(whereis(getCoselicaVersion));

try
    ilib_verbose(0);
    assert_checktrue(importXcosDiagram(coselicaMacrosPath + "/../../tests/unit_tests/Mechanics/Rotational/MMR_IdealGear.zcos"));
    xcos_simulate(scs_m, 4);

    wheelB_speed = res.values(:,1);
    bearing = res.values(:,2);
    wheelA_speed = res.values(:,3);
    
    assert_checktrue(wheelB_speed - (1/0.5*(wheelA_speed-bearing)+bearing) < 1d-9);

catch
   disp(lasterror())
   assert_checktrue(%f);
end
