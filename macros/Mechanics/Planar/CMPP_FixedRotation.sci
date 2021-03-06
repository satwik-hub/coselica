// Coselica Toolbox for Xcos
// Copyright (C) 2011 - DIGITEO - Bruno JOFRET
// Copyright (C) 2009-2011  Dirk Reusch, Kybernetik Dr. Reusch
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

function [x,y,typ]=CMPP_FixedRotation(job,arg1,arg2)
    x=[];y=[];typ=[];
    select job
     case 'set' then
      x=arg1;
      graphics=arg1.graphics;exprs=graphics.exprs;
      model=arg1.model;
      while %t do
          [ok,r,angle,exprs]=..
              getvalue(['CMPP_FixedRotation';__('Fixed translation followed by a fixed rotation of frame_b with respect to frame_a')],..
                       [__('r [m] : Vector from frame_a to frame_b resolved in frame_a');...
                        __('angle [rad] : Angle to rotate frame_a into frame_b')],..
                       list('vec',2,'vec',1),exprs);
          if ~ok then break, end
          model.in=[1];
          model.out=[1];
          model.equations.parameters(2)=list(r,angle)
          graphics.exprs=exprs;
          x.graphics=graphics;x.model=model;
          break
      end
     case 'define' then
      r=[0,0];
      angle=0;
      exprs=[strcat(sci2exp(r));strcat(sci2exp(angle))];
      model=scicos_model();
      model.sim='Coselica';
      model.blocktype='c';
      model.dep_ut=[%t %f];
      model.in=[1];
      model.out=[1];
      mo=modelica();
      mo.model='Coselica.Mechanics.Planar.Parts.FixedRotation';
      mo.inputs=['frame_a'];
      mo.outputs=['frame_b'];
      mo.parameters=list(['r','angle'],..
                         list(r,angle),..
                         [0,0]);
      model.equations=mo;
      gr_i=[];
      x=standard_define([2 2],model,exprs,list(gr_i,0));
      x.graphics.in_implicit=['I'];
      x.graphics.in_style=[PlanInputStyle()];
      x.graphics.out_implicit=['I'];
      x.graphics.out_style=[PlanOutputStyle()];
    end
endfunction
