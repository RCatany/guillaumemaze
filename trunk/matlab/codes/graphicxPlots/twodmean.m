% TWODMEAN Plot a 2D field together with its means in both directions
%
% [sb,hl,gca] = twodmean(X,Y,FIELD(Y,X),[SHOW COLORBAR 0/1,CMAP,CAXIS])
%
% sb = [sb1 sb2 sb3]
% hl = [tt xl yl]
%
% Copyright (c) 2004 Guillaume Maze. 
% http://codes.guillaumemaze.org

%
% This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or any later version.
% This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
% You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.
%
function varargout = twodmean(Cx,Cy,C,varargin)

clf;hold on

left=.10;
bott=.25;
widt=.68;
heig=.60;

clear ccol
cx = sort(Cx); cx = cx(~isnan(cx));
cy = sort(Cy); cy = cy(~isnan(cy));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sb1=subplot('position',[left bott widt heig]);
pp=pcolor(Cx,Cy,C);
shading flat;
box on;
grid on
if nargin>=5
  colormap(varargin{2});
else
  colormap(jet);
end
if nargin>=6
  caxis(varargin{3});
end
axis tight;
set(gca,'xlim',sort([cx(1) cx(end)]));
set(gca,'ylim',sort([cy(1) cy(end)]));
%set(gca,'xticklabel',[]);
%set(gca,'yticklabel',[]);
set(gca,'fontsize',10)
set(gca,'xaxislocation','top')
set(gca,'yaxislocation','left')
xt=get(gca,'xtick'); 
set(gca,'xtick',xt(1:end-1));
tt=title(' ');
gca1=gca;
if nargin>=4 & varargin{1}==1
%	ccol = colorbar;
	ccol = colorbar('location','westoutside');
	sb1P =get(sb1,'position') ;
	ccolP=get(ccol,'position');
%	set(ccol,'position',[ccolP(1)+ccolP(3)/4+left*1/8 ccolP(2) ccolP(3)/2 sb1P(4)]);		
%	set(sb1 ,'position',[sb1P(1) ccolP(2) sb1P(3:4)]);
	set(ccol,'position',[ccolP(3) ccolP(2) ccolP(3)/2 sb1P(4)]);
	set(sb1 ,'position',[5*ccolP(3) bott sb1P(3) heig]);
%	[ccolP ;sb1P]
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if ~exist('ccol')
   sb2=subplot('position',[left bott-.15 widt .15]);
else
   ccolP = get(ccol,'position');
   sb1P  = get(sb1,'position');
   sb2   = subplot('position',[sb1P(1) bott-.15 sb1P(3) .15]);
end
hold on
C(isinf(C))=NaN;
plot(Cx,nanmean(C,1));
grid on
box on
set(gca,'xlim',sort([cx(1) cx(end)]));
set(gca,'fontsize',10)
set(gca,'yaxislocation','left')
xl=xlabel(' ');
gca2=gca;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sb1P  = get(sb1,'position');
sb3=subplot('position',[sb1P(1)+sb1P(3) bott (1-sb1P(3))/2.5 heig]);
%sb3=subplot('position',[left+widt bott (1-widt)/2 heig]);

plot(nanmean(C,2),Cy);
grid on,
box on
set(gca,'ylim',sort([cy(1) cy(end)]));
set(gca,'yaxislocation','right')
set(gca,'xaxislocation','top')
set(gca,'fontsize',10)
yl=ylabel(' ');
gca3=gca;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if nargin>=4 & varargin{1}==1
  out2 = [tt xl yl ccol];
else
  out2 = [tt xl yl];
end
switch nargout
 case 1
  varargout(1) = {[sb1 sb2 sb3]};
 case 2
  varargout(1) = {[sb1 sb2 sb3]};
  varargout(2) = {out2};
 case 3
  varargout(1) = {[sb1 sb2 sb3]};
  varargout(2) = {out2};
  varargout(3) = {[gca1 gca2 gca3]};
 case 4
  varargout(1) = {[sb1 sb2 sb3]};
  varargout(2) = {out2};
  varargout(3) = {[gca1 gca2 gca3]};
  varargout(4) = {pp};
end
  