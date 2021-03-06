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

function [x,y,typ]=CMR_Brake(job,arg1,arg2)
    x=[];y=[];typ=[];
    select job
     case 'set' then
      x=arg1;
      graphics=arg1.graphics;exprs=graphics.exprs;
      model=arg1.model;
      while %t do
          [ok,mue_pos,peak,cgeo,fn_max,mode_start,exprs]=...
              getvalue(['CMR_Brake';__('Brake based on Coulomb friction ')],...
                       [__('mue_pos [-] : mue > 0, positive sliding friction coefficient (w_rel>=0)');...
                        __('peak [-] : peak >= 1, peak*mue_pos = maximum value of mue for w_rel==0');...
                        __('cgeo [-] : cgeo >= 0, Geometry constant containing friction distribution assumption');...
                        __('fn_max [N] : fn_max >= 0, Maximum normal force');...
                        __('mode_start [-] : Initial sliding mode (-1=Backward, 0=Sticking, 1=Forward, 2=Free)')],...
                       list('vec',1,'vec',1,'vec',1,'vec',1,'vec',1),exprs);
          if ~ok then break, end
          model.equations.parameters(2)=list(mue_pos,peak,cgeo,fn_max,mode_start)
          graphics.exprs=exprs;
          x.graphics=graphics;x.model=model;
          break
      end
     case 'define' then
      model=scicos_model();
      mue_pos=0.5;
      peak=1;
      cgeo=1;
      fn_max=1;
      mode_start=0;
      model.sim='CMR_Brake';
      model.blocktype='c';
      model.dep_ut=[%t %f];
      mo=modelica();
      mo.model='CMR_Brake';
      mo.inputs=['flange_a','f_normalized'];
      mo.outputs=['flange_b','bearing'];
      mo.parameters=list(['mue_pos','peak','cgeo','fn_max','mode_start'],...
                         list(mue_pos,peak,cgeo,fn_max,mode_start),...
                         [0,0,0,0,0]);
      model.equations=mo;
      model.in=ones(size(mo.inputs,'*'),1);
      model.out=ones(size(mo.outputs,'*'),1);
      exprs=[sci2exp(mue_pos);sci2exp(peak);sci2exp(cgeo);sci2exp(fn_max);sci2exp(mode_start)];
      gr_i=[];
      x=standard_define([2 2],model,exprs,list(gr_i,0));
      x.graphics.in_implicit=['I','I'];
      x.graphics.in_style=[RotInputStyle(), RealInputStyle()];
      x.graphics.out_implicit=['I','I'];
      x.graphics.out_style=[RotOutputStyle(), RotOutputStyle()];
    end
endfunction
