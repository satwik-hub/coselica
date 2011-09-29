// ============================================================================
// Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2011 - DIGITEO - Bruno JOFRET
//
//  This file is distributed under the same license as the Scilab package.
// ============================================================================
//
// <-- ENGLISH IMPOSED -->
//
// <-- Short Description -->
// Blocks must have valid dimensions for their settings.
// Some dimensions were not coherents between theirs "set" and "define" method.
blocks = ["CBMV_Add"
          "CBMV_CrossProduct"
          "CBMV_DotProduct"
          "CBMV_ElementwiseProduct"
          "CBM_Add3"
          "CBM_Atan2"
          "CBM_Sum"
          "CBM_TwoInputs"
          "CBM_TwoOutputs"
          "MBM_Abs"
          "MBM_Acos"
          "MBM_Add"
          "MBM_Asin"
          "MBM_Atan"
          "MBM_Cos"
          "MBM_Cosh"
          "MBM_Division"
          "MBM_Exp"
          "MBM_Feedback"
          "MBM_Gain"
          "MBM_Log"
          "MBM_Log10"
          "MBM_Max"
          "MBM_Min"
          "MBM_Product"
          "MBM_Sign"
          "MBM_Sin"
          "MBM_Sinh"
          "MBM_Sqrt"
          "MBM_Tan"
          "MBM_Tanh"];
notTested = [];

for j = 1:size(blocks,"*")
    interfunction = blocks(j);

// Not tested blocks (Xcos customs)
    if or(interfunction == notTested) then
        continue;
    end
    [status, message] = xcosValidateBlockSet(blocks(j));
    if status == %f
        disp(message);
    end
    assert_checktrue(status);
end