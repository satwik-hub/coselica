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
// Test MMR_IdealGearR2T

[a, coselicaMacrosPath] = libraryinfo(whereis(getCoselicaVersion));

try
    ilib_verbose(0);
    assert_checktrue(importXcosDiagram(coselicaMacrosPath + "/../../tests/unit_tests/Mechanics/Rotational/MMR_IdealGearR2T.zcos"));
    xcos_simulate(scs_m, 4);

    phi_a = res.values(:,2);
    s_b = res.values(:,1);
    bearingR = 1;
    bearingT = 1;
    ratio = 0.5;
    assert_checkalmostequal((phi_a-bearingR), ratio*(s_b-bearingT));

catch
   disp(lasterror())
   assert_checktrue(%f);
end
