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

function [x,y,typ]=CBN_Hysteresis(job,arg1,arg2)
x=[];y=[];typ=[];
select job
  case 'plot' then
    uOn=arg1.graphics.exprs(1);
    uOff=arg1.graphics.exprs(2);
    yOn=arg1.graphics.exprs(3);
    yOff=arg1.graphics.exprs(4);
    y_start=arg1.graphics.exprs(5);
    standard_draw(arg1,%f,_MBI_SISO_dp);
  case 'getinputs' then
    [x,y,typ]=_MBI_SISO_ip(arg1);
  case 'getoutputs' then
    [x,y,typ]=_MBI_SISO_op(arg1);
  case 'getorigin' then
    [x,y]=standard_origin(arg1);
  case 'set' then
    x=arg1;
    graphics=arg1.graphics;exprs=graphics.exprs;
    model=arg1.model;
    while %t do
      [ok,uOn,uOff,yOn,yOff,y_start,exprs]=...
        getvalue(['';'CBN_Hysteresis';'';'Switch output between two constants with hysteresis';''],...
        [' uOn [-] : Switch on when u >= uOn';' uOff [-] : Switch off when u <= uOff';' yOn [-] : Output when switched on';' yOff [-] : Output when switched off';' y_start [-] : Start value of output'],...
        list('vec',1,'vec',1,'vec',1,'vec',1,'vec',1),exprs);
      if ~ok then break, end
      model.equations.parameters(2)=list(uOn,uOff,yOn,yOff,y_start)
      graphics.exprs=exprs;
      x.graphics=graphics;x.model=model;
      break
    end
  case 'define' then
    model=scicos_model();
    uOn=1;
    uOff=0;
    yOn=1;
    yOff=0;
    y_start=0;
    model.sim='Coselica';
    model.blocktype='c';
    model.dep_ut=[%t %f];
    mo=modelica();
      mo.model='Coselica.Blocks.Nonlinear.Hysteresis';
      mo.inputs=['u'];
      mo.outputs=['y'];
      mo.parameters=list(['uOn','uOff','yOn','yOff','y_start'],...
                         list(uOn,uOff,yOn,yOff,y_start),...
                         [0,0,0,0,0]);
    model.equations=mo;
    model.in=ones(size(mo.inputs,'*'),1);
    model.out=ones(size(mo.outputs,'*'),1);
    exprs=[sci2exp(uOn);sci2exp(uOff);sci2exp(yOn);sci2exp(yOff);sci2exp(y_start)];
    gr_i=[...
          'if orient then';...
          '  xx=orig(1);yy=orig(2);';...
          '  ww=sz(1);hh=sz(2);';...
          'else';...
          '  xx=orig(1)+sz(1);yy=orig(2);';...
          '  ww=-sz(1);hh=sz(2);';...
          'end';...
          'if orient then';...
          '  xrect(orig(1)+sz(1)*0,orig(2)+sz(2)*1,sz(1)*1,sz(2)*1);';...
          'else';...
          '  xrect(orig(1)+sz(1)*(1-0-1),orig(2)+sz(2)*1,sz(1)*1,sz(2)*1);';...
          'end';...
          'e=gce();';...
          'e.visible=""on"";';...
          'e.foreground=color(0,0,191);';...
          'e.background=color(255,255,255);';...
          'e.fill_mode=""on"";';...
          'e.thickness=0.25;';...
          'e.line_style=1;';...
          'if orient then';...
          '  xstringb(orig(1)+sz(1)*-0.25,orig(2)+sz(2)*1.05,""""+model.label+"""",sz(1)*1.5,sz(2)*0.2,""fill"");';...
          'else';...
          '  xstringb(orig(1)+sz(1)*(1--0.25-1.5),orig(2)+sz(2)*1.05,""""+model.label+"""",sz(1)*1.5,sz(2)*0.2,""fill"");';...
          'end';...
          'e=gce();';...
          'e.visible=""on"";';...
          'e.foreground=color(0,0,0);';...
          'e.background=color(0,0,255);';...
          'e.font_foreground=color(0,0,255);';...
          'e.fill_mode=""off"";';...
          'xpoly(xx+ww*[0.1;0.06;0.14;0.1],yy+hh*[0.95;0.84;0.84;0.95]);';...
          'e=gce();';...
          'e.visible=""on"";';...
          'e.foreground=color(192,192,192);';...
          'e.background=color(192,192,192);';...
          'e.fill_mode=""on"";';...
          'e.thickness=0.25;';...
          'e.line_style=1;';...
          'xpoly(xx+ww*[0.1;0.1],yy+hh*[0.84;0.355]);';...
          'e=gce();';...
          'e.visible=""on"";';...
          'e.foreground=color(192,192,192);';...
          'e.thickness=0.25;';...
          'e.line_style=1;';...
          'xpoly(xx+ww*[0.96;0.85;0.85;0.96],yy+hh*[0.355;0.395;0.315;0.355]);';...
          'e=gce();';...
          'e.visible=""on"";';...
          'e.foreground=color(192,192,192);';...
          'e.background=color(192,192,192);';...
          'e.fill_mode=""on"";';...
          'e.thickness=0.25;';...
          'e.line_style=1;';...
          'xpoly(xx+ww*[0.105;0.92],yy+hh*[0.355;0.355]);';...
          'e=gce();';...
          'e.visible=""on"";';...
          'e.foreground=color(192,192,192);';...
          'e.thickness=0.25;';...
          'e.line_style=1;';...
          'xpoly(xx+ww*[0.105;0.705],yy+hh*[0.355;0.355]);';...
          'e=gce();';...
          'e.visible=""on"";';...
          'e.foreground=color(0,0,0);';...
          'e.thickness=0.25;';...
          'e.line_style=1;';...
          'xpoly(xx+ww*[0.425;0.505;0.425],yy+hh*[0.395;0.355;0.32]);';...
          'e=gce();';...
          'e.visible=""on"";';...
          'e.foreground=color(0,0,0);';...
          'e.thickness=0.25;';...
          'e.line_style=1;';...
          'xpoly(xx+ww*[0.705;0.705],yy+hh*[0.755;0.355]);';...
          'e=gce();';...
          'e.visible=""on"";';...
          'e.foreground=color(0,0,0);';...
          'e.thickness=0.25;';...
          'e.line_style=1;';...
          'xpoly(xx+ww*[0.665;0.705;0.75],yy+hh*[0.515;0.61;0.515]);';...
          'e=gce();';...
          'e.visible=""on"";';...
          'e.foreground=color(0,0,0);';...
          'e.thickness=0.25;';...
          'e.line_style=1;';...
          'xpoly(xx+ww*[0.255;0.905],yy+hh*[0.755;0.755]);';...
          'e=gce();';...
          'e.visible=""on"";';...
          'e.foreground=color(0,0,0);';...
          'e.thickness=0.25;';...
          'e.line_style=1;';...
          'xpoly(xx+ww*[0.48;0.405;0.48],yy+hh*[0.795;0.755;0.715]);';...
          'e=gce();';...
          'e.visible=""on"";';...
          'e.foreground=color(0,0,0);';...
          'e.thickness=0.25;';...
          'e.line_style=1;';...
          'xpoly(xx+ww*[0.205;0.255;0.305],yy+hh*[0.645;0.555;0.645]);';...
          'e=gce();';...
          'e.visible=""on"";';...
          'e.foreground=color(0,0,0);';...
          'e.thickness=0.25;';...
          'e.line_style=1;';...
          'xpoly(xx+ww*[0.255;0.255],yy+hh*[0.755;0.355]);';...
          'e=gce();';...
          'e.visible=""on"";';...
          'e.foreground=color(0,0,0);';...
          'e.thickness=0.25;';...
          'e.line_style=1;';...
          'if orient then';...
          '  xstringb(orig(1)+sz(1)*0.04,orig(2)+sz(2)*0.04,""""+string(uOff)+"""",sz(1)*0.415,sz(2)*0.215,""fill"");';...
          'else';...
          '  xstringb(orig(1)+sz(1)*(1-0.04-0.415),orig(2)+sz(2)*0.04,""""+string(uOff)+"""",sz(1)*0.415,sz(2)*0.215,""fill"");';...
          'end';...
          'e=gce();';...
          'e.visible=""on"";';...
          'e.foreground=color(0,0,0);';...
          'e.background=color(192,192,192);';...
          'e.font_foreground=color(192,192,192);';...
          'e.fill_mode=""off"";';...
          'if orient then';...
          '  xstringb(orig(1)+sz(1)*0.51,orig(2)+sz(2)*0.04,""""+string(uOn)+"""",sz(1)*0.445,sz(2)*0.215,""fill"");';...
          'else';...
          '  xstringb(orig(1)+sz(1)*(1-0.51-0.445),orig(2)+sz(2)*0.04,""""+string(uOn)+"""",sz(1)*0.445,sz(2)*0.215,""fill"");';...
          'end';...
          'e=gce();';...
          'e.visible=""on"";';...
          'e.foreground=color(0,0,0);';...
          'e.background=color(192,192,192);';...
          'e.font_foreground=color(192,192,192);';...
          'e.fill_mode=""off"";';...
          'if orient then';...
          '  xrect(orig(1)+sz(1)*0.045,orig(2)+sz(2)*0.255,sz(1)*0.415,sz(2)*0.215);';...
          'else';...
          '  xrect(orig(1)+sz(1)*(1-0.045-0.415),orig(2)+sz(2)*0.255,sz(1)*0.415,sz(2)*0.215);';...
          'end';...
          'e=gce();';...
          'e.visible=""on"";';...
          'e.foreground=color(192,192,192);';...
          'e.background=color(0,0,0);';...
          'e.fill_mode=""off"";';...
          'e.thickness=0.25;';...
          'e.line_style=1;';...
          'xpoly(xx+ww*[0.255;0.255],yy+hh*[0.355;0.255]);';...
          'e=gce();';...
          'e.visible=""on"";';...
          'e.foreground=color(192,192,192);';...
          'e.thickness=0.25;';...
          'e.line_style=1;';...
          'if orient then';...
          '  xrect(orig(1)+sz(1)*0.51,orig(2)+sz(2)*0.255,sz(1)*0.445,sz(2)*0.215);';...
          'else';...
          '  xrect(orig(1)+sz(1)*(1-0.51-0.445),orig(2)+sz(2)*0.255,sz(1)*0.445,sz(2)*0.215);';...
          'end';...
          'e=gce();';...
          'e.visible=""on"";';...
          'e.foreground=color(192,192,192);';...
          'e.background=color(0,0,0);';...
          'e.fill_mode=""off"";';...
          'e.thickness=0.25;';...
          'e.line_style=1;';...
          'xpoly(xx+ww*[0.705;0.705],yy+hh*[0.355;0.255]);';...
          'e=gce();';...
          'e.visible=""on"";';...
          'e.foreground=color(192,192,192);';...
          'e.thickness=0.25;';...
          'e.line_style=1;';...
         ];

    x=standard_define([2 2],model,exprs,list(gr_i,0));
    x.graphics.in_implicit=['I'];
    x.graphics.in_style=[RealInputStyle()];
    x.graphics.out_implicit=['I'];
    x.graphics.out_style=[RealOutputStyle()];
  end
endfunction
