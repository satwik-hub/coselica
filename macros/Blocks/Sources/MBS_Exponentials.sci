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

function [x,y,typ]=MBS_Exponentials(job,arg1,arg2)
x=[];y=[];typ=[];
select job
  case 'plot' then
    outMax=arg1.graphics.exprs(1);
    riseTime=arg1.graphics.exprs(2);
    riseTimeConst=arg1.graphics.exprs(3);
    fallTimeConst=arg1.graphics.exprs(4);
    offset=arg1.graphics.exprs(5);
    startTime=arg1.graphics.exprs(6);
    standard_draw(arg1,%f,_MBI_SO_dp);
  case 'getinputs' then
    [x,y,typ]=_MBI_SO_ip(arg1);
  case 'getoutputs' then
    [x,y,typ]=_MBI_SO_op(arg1);
  case 'getorigin' then
    [x,y]=standard_origin(arg1);
  case 'set' then
    x=arg1;
    graphics=arg1.graphics;exprs=graphics.exprs;
    model=arg1.model;
    while %t do
      [ok,outMax,riseTime,riseTimeConst,fallTimeConst,offset,startTime,exprs]=...
        scicos_getvalue(['';'MBS_Exponentials';'';'Generate a rising and falling exponential signal';''],...
        [' outMax [-] : Height of output for infinite riseTime';' riseTime [s] : Rise time';' riseTimeConst [s] : Rise time constant';' fallTimeConst [s] : Fall time constant';' offset [-] : Offset of output signal';' startTime [s] : Output = offset for time < startTime'],...
        list('vec',1,'vec',1,'vec',1,'vec',1,'vec',1,'vec',1),exprs);
      if ~ok then break, end
      model.equations.parameters(2)=list(outMax,riseTime,riseTimeConst,fallTimeConst,offset,startTime)
      graphics.exprs=exprs;
      x.graphics=graphics;x.model=model;
      break
    end
  case 'define' then
    model=scicos_model();
    outMax=1;
    riseTime=0.5;
    riseTimeConst=0.1;
    fallTimeConst=0.5;
    offset=0;
    startTime=0;
    model.sim='MBS_Exponentials';
    model.blocktype='c';
    model.dep_ut=[%t %f];
    mo=modelica();
      mo.model='MBS_Exponentials';
      mo.inputs=[];
      mo.outputs=['y'];
      mo.parameters=list(['outMax','riseTime','riseTimeConst','fallTimeConst','offset','startTime'],...
                         list(outMax,riseTime,riseTimeConst,fallTimeConst,offset,startTime),...
                         [0,0,0,0,0,0]);
    model.equations=mo;
    model.in=ones(size(mo.inputs,'*'),1);
    model.out=ones(size(mo.outputs,'*'),1);
    exprs=[sci2exp(outMax); sci2exp(riseTime); sci2exp(riseTimeConst); ...
           sci2exp(fallTimeConst); sci2exp(offset); sci2exp(startTime)];
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
          'if orient then';...
          '  xstringb(orig(1)+sz(1)*-0.25,orig(2)+sz(2)*1.05,""""+model.label+"""",sz(1)*1.5,sz(2)*0.2,""fill"");';...
          'else';...
          '  xstringb(orig(1)+sz(1)*(1--0.25-1.5),orig(2)+sz(2)*1.05,""""+model.label+"""",sz(1)*1.5,sz(2)*0.2,""fill"");';...
          'end';...
          'e=gce();';...
          'e.visible=""on"";';...
          'e.foreground=color(0,0,0);';...
          'e.background=color(0,0,255);';...
          'e.fill_mode=""off"";';...
          'xpoly(xx+ww*[0.05;0.84],yy+hh*[0.15;0.15]);';...
          'e=gce();';...
          'e.visible=""on"";';...
          'e.foreground=color(192,192,192);';...
          'e.thickness=0.25;';...
          'xpoly(xx+ww*[0.95;0.84;0.84;0.95],yy+hh*[0.15;0.19;0.11;0.15]);';...
          'e=gce();';...
          'e.visible=""on"";';...
          'e.foreground=color(192,192,192);';...
          'e.background=color(192,192,192);';...
          'e.fill_mode=""on"";';...
          'e.thickness=0.25;';...
          'xpoly(xx+ww*[0.1;0.114;0.1285;0.146;0.1635;0.1815;0.2025;0.2235;0.2485;0.277;0.3085;0.344;0.3865;0.4395;0.45;0.4606;0.47475;0.4889;0.50303;0.5207;0.5384;0.5595;0.581;0.6055;0.634;0.6655;0.7045;0.754;0.8],yy+hh*[0.15;0.2235;0.2895;0.362;0.425;0.4796;0.5359;0.5835;0.63;0.6725;0.7105;0.743;0.7715;0.796;0.8;0.7375;0.6635;0.599;0.54225;0.4815;0.43;0.379;0.337;0.2975;0.263;0.2335;0.2075;0.186;0.173]);';...
          'e=gce();';...
          'e.visible=""on"";';...
          'e.foreground=color(0,0,0);';...
          'e.thickness=0.25;';...
          'xpoly(xx+ww*[0.1;0.06;0.14;0.1],yy+hh*[0.95;0.84;0.84;0.95]);';...
          'e=gce();';...
          'e.visible=""on"";';...
          'e.foreground=color(192,192,192);';...
          'e.background=color(192,192,192);';...
          'e.fill_mode=""on"";';...
          'e.thickness=0.25;';...
          'xpoly(xx+ww*[0.1;0.1],yy+hh*[0.84;0.1]);';...
          'e=gce();';...
          'e.visible=""on"";';...
          'e.foreground=color(192,192,192);';...
          'e.thickness=0.25;';...
          'if orient then';...
          '  xstringb(orig(1)+sz(1)*-0.25,orig(2)+sz(2)*-0.25,""riseTime=""+string(riseTime)+"""",sz(1)*1.5,sz(2)*0.2,""fill"");';...
          'else';...
          '  xstringb(orig(1)+sz(1)*(1--0.25-1.5),orig(2)+sz(2)*-0.25,""riseTime=""+string(riseTime)+"""",sz(1)*1.5,sz(2)*0.2,""fill"");';...
          'end';...
          'e=gce();';...
          'e.visible=""on"";';...
          'e.foreground=color(0,0,0);';...
          'e.background=color(0,0,0);';...
          'e.fill_mode=""off"";';...
         ];
    x=standard_define([2 2],model,exprs,list(gr_i,0));
    x.graphics.in_implicit=[];
    x.graphics.out_implicit=['I'];
    x.graphics.out_style=[RealOutputStyle()];
  end
endfunction
