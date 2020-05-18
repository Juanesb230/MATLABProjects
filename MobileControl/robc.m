function [robout1,robout2] = robc(x,y,phi,k,c)

% ROBOT MOVIL PIONNER
% Dibuja un robot movil en la posicion (x,y) con orientacion phi[rad]
% k: factor de escala del robot
% c: color del robot (rojo por defecto) - entre comillas ('')!!!         
%                     ______ 
%        ____________|______|
%      /                    |\
%     /                     | \
%    |                      |  |
%    |                  o   |  | 3u   }7u
%    |                      |  |
%     \                     | /
%      \____________________|/ 2u
%                10u |______|
%                       3u

if nargin < 5, c = 'r'; end
if nargin < 4, k = 0.1; end

%***** Matrices de rotacion y de traslacion
R = [cos(phi) -sin(phi);sin(phi) cos(phi)];
T = [x;y];

%***** Robot centrado en (0,0) y con phi = 0º
x1 = k*[-6.5; 1.5];
x2 = k*[-6.5; -1.5];
x3 = k*[-4.5; -3.5];
x4 = k*[1.5; -3.5];
x5 = k*[3.5; -1.5];
x6 = k*[3.5; 1.5];
x7 = k*[1.5; 3.5];
x8 = k*[-4.5; 3.5];

Rix1 = k*[1.5;4.5];
Rix2 = k*[1.5;3.5];
Rix3 = k*[-1.5;3.5];
Rix4 = k*[-1.5;4.5];

Ei1 = k*[-0.5;4.5];
Ei2 = k*[-0.5;3.5];
Ei3 = k*[0.5;4.5];
Ei4 = k*[0.5;3.5];

Rdx1 = k*[1.5;-4.5];
Rdx2 = k*[1.5;-3.5];
Rdx3 = k*[-1.5;-3.5];
Rdx4 = k*[-1.5;-4.5];

Ed1 = k*[-0.5;-3.5];
Ed2 = k*[-0.5;-4.5];
Ed3 = k*[0.5;-3.5];
Ed4 = k*[0.5;-4.5];

%***** Rota y traslada el robot
x1 = (R*x1)+T;
x2 = (R*x2)+T;
x3 = (R*x3)+T;
x4 = (R*x4)+T;
x5 = (R*x5)+T;
x6 = (R*x6)+T;
x7 = (R*x7)+T;
x8 = (R*x8)+T;

Rix1 = (R*Rix1)+T;
Rix2 = (R*Rix2)+T;
Rix3 = (R*Rix3)+T;
Rix4 = (R*Rix4)+T;

Ei1 = (R*Ei1)+T;
Ei2 = (R*Ei2)+T;
Ei3 = (R*Ei3)+T;
Ei4 = (R*Ei4)+T;
 
Rdx1 = (R*Rdx1)+T;
Rdx2 = (R*Rdx2)+T;
Rdx3 = (R*Rdx3)+T;
Rdx4 = (R*Rdx4)+T;

Ed1 = (R*Ed1)+T;
Ed2 = (R*Ed2)+T;
Ed3 = (R*Ed3)+T;
Ed4 = (R*Ed4)+T;

% ***** Dibuja el robot
% plot(x,y,'o');
H01 = line([x1(1) x2(1)],[x1(2) x2(2)]);
set(H01,'Color',c);
H02 = line([x3(1) x2(1)],[x3(2) x2(2)]);
set(H02,'Color',c);
H03 = line([x3(1) x4(1)],[x3(2) x4(2)]);
set(H03,'Color',c);
H04 = line([x5(1) x4(1)],[x5(2) x4(2)]);
set(H04,'Color',c);
H05 = line([x5(1) x6(1)],[x5(2) x6(2)]);
set(H05,'Color',c);
H06 = line([x7(1) x6(1)],[x7(2) x6(2)]);
set(H06,'Color',c);
H07 = line([x7(1) x8(1)],[x7(2) x8(2)]);
set(H07,'Color',c);
H08 = line([x1(1) x8(1)],[x1(2) x8(2)]);
set(H08,'Color',c);

% ***** Dibuja las ruedas
H09 = line([Rix1(1) Rix2(1)],[Rix1(2) Rix2(2)]);
set(H09,'Color','k');
H10 = line([Rix3(1) Rix2(1)],[Rix3(2) Rix2(2)]);
set(H10,'Color','k');
H11 = line([Rix3(1) Rix4(1)],[Rix3(2) Rix4(2)]);
set(H11,'Color','k');
H12 = line([Rix1(1) Rix4(1)],[Rix1(2) Rix4(2)]);
set(H12,'Color','k');

H13 = line([Rdx1(1) Rdx2(1)],[Rdx1(2) Rdx2(2)]);
set(H13,'Color','k');
H14 = line([Rdx3(1) Rdx2(1)],[Rdx3(2) Rdx2(2)]);
set(H14,'Color','k');
H15 = line([Rdx3(1) Rdx4(1)],[Rdx3(2) Rdx4(2)]);
set(H15,'Color','k');
H16 = line([Rdx1(1) Rdx4(1)],[Rdx1(2) Rdx4(2)]);
set(H16,'Color','k');

% ***** Dibuja los ejes
% H17 = line([Ei1(1) Ei2(1)],[Ei1(2) Ei2(2)]);
% set(H17,'Color','r');
% H18 = line([Ei3(1) Ei4(1)],[Ei3(2) Ei4(2)]);
% set(H18,'Color','r');
% 
% H19 = line([Ed1(1) Ed2(1)],[Ed1(2) Ed2(2)]);
% set(H19,'Color','r');
% H20 = line([Ed3(1) Ed4(1)],[Ed3(2) Ed4(2)]);
% set(H20,'Color','r');

axis equal

% ***** Pinta el robot
xp = [x1(1) x2(1) x3(1) x4(1) x5(1) x6(1) x7(1) x8(1) x1(1)];
yp = [x1(2) x2(2) x3(2) x4(2) x5(2) x6(2) x7(2) x8(2) x1(2)];
xq = [x4(1) x5(1) x6(1) x7(1) x4(1)];
yq = [x4(2) x5(2) x6(2) x7(2) x4(2)];

h1 = fill(xp,yp,c); hold on;
h2 = fill(xq,yq,'k'); %set(h2,'FaceColor',[0.753,0.753,0.753]);

% ***** Pinta las ruedas
xwi = [Rix1(1) Rix2(1) Rix3(1) Rix4(1) Rix1(1)];
ywi = [Rix1(2) Rix2(2) Rix3(2) Rix4(2) Rix1(2)];
xwd = [Rdx1(1) Rdx2(1) Rdx3(1) Rdx4(1) Rdx1(1)];
ywd = [Rdx1(2) Rdx2(2) Rdx3(2) Rdx4(2) Rdx1(2)];

h3 = fill(xwi,ywi,'k'); hold on;
h4 = fill(xwd,ywd,'k'); hold on;

robout1 = [h1 h2 h3 h4];
robout2 = [H01 H02 H03 H04 H05 H06 H07 H08 H09 H10 H11 H12 H13 H14 H15 H16];

% RGBValue % ShortName % LongName
% [1 1 0]       y       yellow
% [1 0 1]       m       magenta 
% [0 1 1]       c       cyan
% [1 0 0]       r       red
% [0 1 0]       g       green
% [0 0 1]       b       blue
% [1 1 1]       w       white
% [0 0 0]       k       black
