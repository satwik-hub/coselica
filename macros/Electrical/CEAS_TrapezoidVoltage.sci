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

function [x,y,typ]=CEAS_TrapezoidVoltage(job,arg1,arg2)
x=[];y=[];typ=[];
select job
  case 'plot' then
    V=arg1.graphics.exprs(1);
    rising=arg1.graphics.exprs(2);
    width=arg1.graphics.exprs(3);
    falling=arg1.graphics.exprs(4);
    period=arg1.graphics.exprs(5);
    nperiod=arg1.graphics.exprs(6);
    offset=arg1.graphics.exprs(7);
    startTime=arg1.graphics.exprs(8);
    standard_draw(arg1,%f,_MEAI_OnePort_dp);
  case 'getinputs' then
    [x,y,typ]=_MEAI_OnePort_ip(arg1);
  case 'getoutputs' then
    [x,y,typ]=_MEAI_OnePort_op(arg1);
  case 'getorigin' then
    [x,y]=standard_origin(arg1);
  case 'set' then
    x=arg1;
    graphics=arg1.graphics;exprs=graphics.exprs;
    model=arg1.model;
    while %t do
      [ok,V,rising,width,falling,period,nperiod,offset,startTime,exprs]=...
        getvalue(['';'CEAS_TrapezoidVoltage';'';'Trapezoidal voltage source';''],...
        [' V [V] : Amplitude of trapezoid';' rising [s] : Rising duration of trapezoid (>=0)';' width [s] : Width duration of trapezoid (>=0)';' falling [s] : Falling duration of trapezoid (>=0)';' period [s] : Time for one period (>0)';' nperiod [-] : Number of periods (< 0 means infinite number of periods)';' offset [V] : Voltage offset';' startTime [s] : Time offset'],...
        list('vec',1,'vec',1,'vec',1,'vec',1,'vec',1,'vec',1,'vec',1,'vec',1),exprs);
      if ~ok then break, end
      model.equations.parameters(2)=list(V,rising,width,falling,period,nperiod,offset,startTime)
      graphics.exprs=exprs;
      x.graphics=graphics;x.model=model;
      break
    end
  case 'define' then
    model=scicos_model();
    V=1;
    rising=0;
    width=0.5;
    falling=0;
    period=1;
    nperiod=-1;
    offset=0;
    startTime=0;
    model.sim='Coselica';
    model.blocktype='c';
    model.dep_ut=[%t %f];
    mo=modelica();
      mo.model='Coselica.Electrical.Analog.Sources.TrapezoidVoltage';
      mo.inputs=['p'];
      mo.outputs=['n'];
      mo.parameters=list(['V','rising','width','falling','period','nperiod','offset','startTime'],...
                         list(V,rising,width,falling,period,nperiod,offset,startTime),...
                         [0,0,0,0,0,0,0,0]);
    model.equations=mo;
    model.in=ones(size(mo.inputs,'*'),1);
    model.out=ones(size(mo.outputs,'*'),1);
    exprs=[sci2exp(V);sci2exp(rising);sci2exp(width);sci2exp(falling);sci2exp(period);sci2exp(nperiod);sci2exp(offset);sci2exp(startTime)];
    gr_i=[...
          'if orient then';...
          '  xx=orig(1);yy=orig(2);';...
          '  ww=sz(1);hh=sz(2);';...
          'else';...
          '  xx=orig(1)+sz(1);yy=orig(2);';...
          '  ww=-sz(1);hh=sz(2);';...
          'end';...
          'if orient then';...
          '  xarc(orig(1)+sz(1)*0.25,orig(2)+sz(2)*0.75,sz(1)*0.5,sz(2)*0.5,0,360*64);';...
          'else';...
          '  xarc(orig(1)+sz(1)*(1-0.25-0.5),orig(2)+sz(2)*0.75,sz(1)*0.5,sz(2)*0.5,0,360*64);';...
          'end';...
          'e=gce();';...
          'e.visible=""on"";';...
          'e.foreground=color(0,0,0);';...
          'e.background=color(255,255,255);';...
          'e.fill_mode=""on"";';...
          'e.thickness=0.25;';...
          'e.line_style=1;';...
          'if orient then';...
          '  xstringb(orig(1)+sz(1)*-0.25,orig(2)+sz(2)*0.9,""""+model.label+"""",sz(1)*1.5,sz(2)*0.2,""fill"");';...
          'else';...
          '  xstringb(orig(1)+sz(1)*(1--0.25-1.5),orig(2)+sz(2)*0.9,""""+model.label+"""",sz(1)*1.5,sz(2)*0.2,""fill"");';...
          'end';...
          'e=gce();';...
          'e.visible=""on"";';...
          'e.foreground=color(0,0,0);';...
          'e.background=color(0,0,255);';...
          'e.font_foreground=color(0,0,255);';...
          'e.fill_mode=""off"";';...
          'xpoly(xx+ww*[0.05;0.95],yy+hh*[0.5;0.5]);';...
          'e=gce();';...
          'e.visible=""on"";';...
          'e.foreground=color(0,0,0);';...
          'e.thickness=0.25;';...
          'e.line_style=1;';...
          'xpoly(xx+ww*[0.095;0.2;0.35;0.505;0.65;0.755;0.9],yy+hh*[0.15;0.15;0.85;0.85;0.15;0.15;0.85]);';...
          'e=gce();';...
          'e.visible=""on"";';...
          'e.foreground=color(192,192,192);';...
          'e.thickness=0.25;';...
          'e.line_style=1;';...
         ];

    x=standard_define([2 2],model,exprs,list(gr_i,0));
    x.graphics.in_implicit=['I'];
    x.graphics.in_style=[ElecInputStyle()];
    x.graphics.out_implicit=['I'];
    x.graphics.out_style=[ElecOutputStyle()];
  end
endfunction
