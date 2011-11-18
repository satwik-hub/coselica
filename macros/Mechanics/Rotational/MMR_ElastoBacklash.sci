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

function [x,y,typ]=MMR_ElastoBacklash(job,arg1,arg2)
x=[];y=[];typ=[];
select job
  case 'plot' then
    b=arg1.graphics.exprs(1);
    c=arg1.graphics.exprs(2);
    phi_rel0=arg1.graphics.exprs(3);
    d=arg1.graphics.exprs(4);
    standard_draw(arg1,%f,_MMRI_Rigid_dp);
  case 'getinputs' then
    [x,y,typ]=_MMRI_Rigid_ip(arg1);
  case 'getoutputs' then
    [x,y,typ]=_MMRI_Rigid_op(arg1);
  case 'getorigin' then
    [x,y]=standard_origin(arg1);
  case 'set' then
    x=arg1;
    graphics=arg1.graphics;exprs=graphics.exprs;
    model=arg1.model;
    while %t do
      [ok,b,c,phi_rel0,d,exprs]=...
        getvalue(['';'MMR_ElastoBacklash';'';'Backlash connected in series to linear spring and damper (backlash is modeled with elasticity)';''],...
        [' b [rad] : Total backlash',' c [N.m/rad] : Spring constant (c > 0 required)',' phi_rel0 [rad] : Unstretched spring angle',' d [N.m.s/rad] : Damping constant'],...
        list('vec',1,'vec',1,'vec',1,'vec',1),exprs);
      if ~ok then break, end
      model.equations.parameters(2)=list(b,c,phi_rel0,d)
      graphics.exprs=exprs;
      x.graphics=graphics;x.model=model;
      break
    end
  case 'define' then
    model=scicos_model();
    b=0;
    c=100000;
    phi_rel0=0;
    d=0;
    model.sim='MMR_ElastoBacklash';
    model.blocktype='c';
    model.dep_ut=[%t %f];
    mo=modelica();
      mo.model='MMR_ElastoBacklash';
      mo.inputs=['flange_a'];
      mo.outputs=['flange_b'];
      mo.parameters=list(['b','c','phi_rel0','d'],...
                         list(b,c,phi_rel0,d),...
                         [0,0,0,0]);
    model.equations=mo;
    model.in=ones(size(mo.inputs,'*'),1);
    model.out=ones(size(mo.outputs,'*'),1);
    exprs=[sci2exp(b);sci2exp(c);sci2exp(phi_rel0);sci2exp(d)];
    gr_i=[...
          'if orient then';...
          '  xx=orig(1);yy=orig(2);';...
          '  ww=sz(1);hh=sz(2);';...
          'else';...
          '  xx=orig(1)+sz(1);yy=orig(2);';...
          '  ww=-sz(1);hh=sz(2);';...
          'end';...
          'xpoly(xx+ww*[0.1;0.21;0.26;0.33;0.4;0.46;0.5;0.6],yy+hh*[0.66;0.66;0.5;0.805;0.5;0.8;0.65;0.65]);';...
          'e=gce();';...
          'e.visible=""on"";';...
          'e.foreground=color(0,0,0);';...
          'e.thickness=0.25;';...
          'if orient then';...
          '  xrect(orig(1)+sz(1)*0.2,orig(2)+sz(2)*0.4,sz(1)*0.25,sz(2)*0.3);';...
          'else';...
          '  xrect(orig(1)+sz(1)*(1-0.2-0.25),orig(2)+sz(2)*0.4,sz(1)*0.25,sz(2)*0.3);';...
          'end';...
          'e=gce();';...
          'e.visible=""on"";';...
          'e.foreground=color(0,0,0);';...
          'e.background=color(192,192,192);';...
          'e.fill_mode=""on"";';...
          'e.thickness=0.25;';...
          'xpoly(xx+ww*[0.24;0.5],yy+hh*[0.1;0.1]);';...
          'e=gce();';...
          'e.visible=""on"";';...
          'e.foreground=color(0,0,0);';...
          'e.thickness=0.25;';...
          'xpoly(xx+ww*[0.24;0.5],yy+hh*[0.4;0.4]);';...
          'e=gce();';...
          'e.visible=""on"";';...
          'e.foreground=color(0,0,0);';...
          'e.thickness=0.25;';...
          'xpoly(xx+ww*[0.45;0.6],yy+hh*[0.25;0.25]);';...
          'e=gce();';...
          'e.visible=""on"";';...
          'e.foreground=color(0,0,0);';...
          'e.thickness=0.25;';...
          'xpoly(xx+ww*[0.1;0.2],yy+hh*[0.25;0.25]);';...
          'e=gce();';...
          'e.visible=""on"";';...
          'e.foreground=color(0,0,0);';...
          'e.thickness=0.25;';...
          'xpoly(xx+ww*[0.1;0.1],yy+hh*[0.66;0.25]);';...
          'e=gce();';...
          'e.visible=""on"";';...
          'e.foreground=color(0,0,0);';...
          'e.thickness=0.25;';...
          'xpoly(xx+ww*[0.6;0.6],yy+hh*[0.65;0.25]);';...
          'e=gce();';...
          'e.visible=""on"";';...
          'e.foreground=color(0,0,0);';...
          'e.thickness=0.25;';...
          'xpoly(xx+ww*[0.05;0.1],yy+hh*[0.5;0.5]);';...
          'e=gce();';...
          'e.visible=""on"";';...
          'e.foreground=color(0,0,0);';...
          'e.thickness=0.25;';...
          'xpoly(xx+ww*[0.95;0.9],yy+hh*[0.5;0.5]);';...
          'e=gce();';...
          'e.visible=""on"";';...
          'e.foreground=color(0,0,0);';...
          'e.thickness=0.25;';...
          'xpoly(xx+ww*[0.6;0.8;0.8],yy+hh*[0.5;0.5;0.35]);';...
          'e=gce();';...
          'e.visible=""on"";';...
          'e.foreground=color(0,0,0);';...
          'e.thickness=0.25;';...
          'xpoly(xx+ww*[0.7;0.7;0.9;0.9],yy+hh*[0.44;0.3;0.3;0.5]);';...
          'e=gce();';...
          'e.visible=""on"";';...
          'e.foreground=color(0,0,0);';...
          'e.thickness=0.25;';...
          'if orient then';...
          '  xstringb(orig(1)+sz(1)*0.005,orig(2)+sz(2)*-0.15,""b=""+string(b)+"""",sz(1)*0.995,sz(2)*0.2,""fill"");';...
          'else';...
          '  xstringb(orig(1)+sz(1)*(1-0.005-0.995),orig(2)+sz(2)*-0.15,""b=""+string(b)+"""",sz(1)*0.995,sz(2)*0.2,""fill"");';...
          'end';...
          'e=gce();';...
          'e.visible=""on"";';...
          'e.foreground=color(0,0,0);';...
          'e.background=color(0,0,0);';...
          'e.fill_mode=""off"";';...
          'if orient then';...
          '  xstringb(orig(1)+sz(1)*0,orig(2)+sz(2)*0.8,""""+model.label+""=""+string(c)+"""",sz(1)*1,sz(2)*0.3,""fill"");';...
          'else';...
          '  xstringb(orig(1)+sz(1)*(1-0-1),orig(2)+sz(2)*0.8,""""+model.label+""=""+string(c)+"""",sz(1)*1,sz(2)*0.3,""fill"");';...
          'end';...
          'e=gce();';...
          'e.visible=""on"";';...
          'e.foreground=color(0,0,0);';...
          'e.background=color(0,0,255);';...
          'e.fill_mode=""off"";';...
         ];
    x=standard_define([2 2],model,exprs,list(gr_i,0));
    x.graphics.in_implicit=['I'];
    x.graphics.in_style=[RotInputStyle()];
    x.graphics.out_implicit=['I'];
    x.graphics.out_style=[RotOutputStyle()];
  end
endfunction
