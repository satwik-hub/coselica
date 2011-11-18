// Coselica Toolbox for Xcos
// Copyright (C) 2011 - DIGITEO - Bruno JOFRET
// Copyright (C) 2009, 2010  Dirk Reusch, Kybernetik Dr. Reusch
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

function [x,y,typ]=MEAI_IdealClosingSwitch(job,arg1,arg2)
x=[];y=[];typ=[];
select job
  case 'plot' then
    Ron=arg1.graphics.exprs(1);
    Goff=arg1.graphics.exprs(2);
    standard_draw(arg1,%f,_MEAI_Switch_dp);
  case 'getinputs' then
    [x,y,typ]=_MEAI_Switch_ip(arg1);
  case 'getoutputs' then
    [x,y,typ]=_MEAI_Switch_op(arg1);
  case 'getorigin' then
    [x,y]=standard_origin(arg1);
  case 'set' then
    x=arg1;
    graphics=arg1.graphics;exprs=graphics.exprs;
    model=arg1.model;
    while %t do
      [ok,Ron,Goff,exprs]=...
        getvalue(['';'MEAI_IdealClosingSwitch';'';'Ideal electrical closer';''],...
        [' Ron [Ohm] : Closed switch resistance';' Goff [S] : Opened switch conductance'],...
        list('vec',1,'vec',1),exprs);
      if ~ok then break, end
      model.equations.parameters(2)=list(Ron,Goff)
      graphics.exprs=exprs;
      x.graphics=graphics;x.model=model;
      break
    end
  case 'define' then
    model=scicos_model();
    Ron=0.00001;
    Goff=0.00001;
    model.sim='Coselica';
    model.blocktype='c';
    model.dep_ut=[%t %f];
    mo=modelica();
      mo.model='Modelica.Electrical.Analog.Ideal.IdealClosingSwitch';
      mo.inputs=['p','control'];
      mo.outputs=['n'];
      mo.parameters=list(['Ron','Goff'],...
                         list(Ron,Goff),...
                         [0,0]);
    model.equations=mo;
    model.in=ones(size(mo.inputs,'*'),1);
    model.out=ones(size(mo.outputs,'*'),1);
    exprs=[sci2exp(Ron);sci2exp(Goff)];
    gr_i=[...
          'if orient then';...
          '  xx=orig(1);yy=orig(2);';...
          '  ww=sz(1);hh=sz(2);';...
          'else';...
          '  xx=orig(1)+sz(1);yy=orig(2);';...
          '  ww=-sz(1);hh=sz(2);';...
          'end';...
          'if orient then';...
          '  xarc(orig(1)+sz(1)*0.28,orig(2)+sz(2)*0.52,sz(1)*0.04,sz(2)*0.04,0,360*64);';...
          'else';...
          '  xarc(orig(1)+sz(1)*(1-0.28-0.04),orig(2)+sz(2)*0.52,sz(1)*0.04,sz(2)*0.04,0,360*64);';...
          'end';...
          'e=gce();';...
          'e.visible=""on"";';...
          'e.foreground=color(0,0,255);';...
          'e.background=color(0,0,0);';...
          'e.fill_mode=""off"";';...
          'e.thickness=0.25;';...
          'e.line_style=1;';...
          'xpoly(xx+ww*[0.05;0.28],yy+hh*[0.5;0.5]);';...
          'e=gce();';...
          'e.visible=""on"";';...
          'e.foreground=color(0,0,255);';...
          'e.thickness=0.25;';...
          'e.line_style=1;';...
          'xpoly(xx+ww*[0.315;0.7],yy+hh*[0.51;0.75]);';...
          'e=gce();';...
          'e.visible=""on"";';...
          'e.foreground=color(0,0,255);';...
          'e.thickness=0.25;';...
          'e.line_style=1;';...
          'xpoly(xx+ww*[0.7;0.95],yy+hh*[0.5;0.5]);';...
          'e=gce();';...
          'e.visible=""on"";';...
          'e.foreground=color(0,0,255);';...
          'e.thickness=0.25;';...
          'e.line_style=1;';...
          'if orient then';...
          '  xstringb(orig(1)+sz(1)*0,orig(2)+sz(2)*0,""""+model.label+"""",sz(1)*1,sz(2)*0.15,""fill"");';...
          'else';...
          '  xstringb(orig(1)+sz(1)*(1-0-1),orig(2)+sz(2)*0,""""+model.label+"""",sz(1)*1,sz(2)*0.15,""fill"");';...
          'end';...
          'e=gce();';...
          'e.visible=""on"";';...
          'e.foreground=color(0,0,0);';...
          'e.background=color(0,0,255);';...
          'e.font_foreground=color(0,0,255);';...
          'e.fill_mode=""off"";';...
          'xpoly(xx+ww*[0.5;0.5],yy+hh*[0.755;0.63]);';...
          'e=gce();';...
          'e.visible=""on"";';...
          'e.foreground=color(0,0,255);';...
          'e.thickness=0.25;';...
          'e.line_style=1;';...
         ];

    x=standard_define([2 2],model,exprs,list(gr_i,0));
    x.graphics.in_implicit=['I','I'];
    x.graphics.in_style=[ElecInputStyle(), RealInputStyle()];
    x.graphics.out_implicit=['I'];
    x.graphics.out_style=[ElecOutputStyle()];
  end
endfunction
