// Coselica Toolbox for Xcos
// Copyright (C) 2011 - DIGITEO - Bruno JOFRET
// Copyright (C) 2009  Dirk Reusch, Kybernetik Dr. Reusch
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program. If not, see <http://www.gnu.org/licenses/>.

function [x,y,typ]=CMR_BearingFriction(job,arg1,arg2)
    x=[];y=[];typ=[];
    select job
    case "set" then
        x=arg1;
        graphics=arg1.graphics;exprs=graphics.exprs;
        model=arg1.model;
        while %t do
            [ok,Tau_prop,Tau_Coulomb,Tau_Stribeck,fexp,mode_start,exprs]=...
            getvalue(["CMR_BearingFriction";__("Coulomb friction with Stribeck effect in bearings")],...
            [__("Tau_prop [N.m/(rad/s)] : Angular velocity dependent friction");...
            __("Tau_Coulomb [N.m] : Constant fricton: Coulomb torque");...
            __("Tau_Stribeck [N.m] : Stribeck effect");...
            __("fexp [1/(rad/s)] : Exponential decay of Stribeck effect");
            __("mode_start [-] : Initial sliding mode (-1=Backward, 0=Sticking, 1=Forward, 2=Free)")],...
            list("vec",1,"vec",1,"vec",1,"vec",1,"vec",1),exprs);
            if ~ok then break, end
            model.equations.parameters(2)=list(Tau_prop,Tau_Coulomb,Tau_Stribeck,fexp,mode_start)
            graphics.exprs=exprs;
            x.graphics=graphics;x.model=model;
            break
        end
    case "define" then
        model=scicos_model();
        Tau_prop=1;
        Tau_Coulomb=5;
        Tau_Stribeck=10;
        fexp=2;
        mode_start=0;
        model.sim="CMR_BearingFriction";
        model.blocktype="c";
        model.dep_ut=[%t %f];
        mo=modelica();
        mo.model="CMR_BearingFriction";
        mo.inputs=["flange_a"];
        mo.outputs=["flange_b","bearing"];
        mo.parameters=list(["Tau_prop","Tau_Coulomb","Tau_Stribeck","fexp","mode_start"],...
        list(Tau_prop,Tau_Coulomb,Tau_Stribeck,fexp,mode_start),...
        [0,0,0,0,0]);
        model.equations=mo;
        model.in=ones(size(mo.inputs,"*"),1);
        model.out=ones(size(mo.outputs,"*"),1);
        exprs=[sci2exp(Tau_prop);sci2exp(Tau_Coulomb);sci2exp(Tau_Stribeck);sci2exp(fexp);sci2exp(mode_start)];
        gr_i = [];
        x=standard_define([2 2],model,exprs,list(gr_i,0));
        x.graphics.in_implicit=["I"];
        x.graphics.in_style=[RotInputStyle()];
        x.graphics.out_implicit=["I","I"];
        x.graphics.out_style=[RotOutputStyle(), RotOutputStyle()];
    end
endfunction
