function varargout = manipulador(varargin)
% MANIPULADOR MATLAB code for manipulador.fig
%      MANIPULADOR, by itself, creates a new MANIPULADOR or raises the existing
%      singleton*.
%
%      H = MANIPULADOR returns the handle to a new MANIPULADOR or the handle to
%      the existing singleton*.
%
%      MANIPULADOR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MANIPULADOR.M with the given input arguments.
%
%      MANIPULADOR('Property','Value',...) creates a new MANIPULADOR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before manipulador_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to manipulador_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help manipulador

% Last Modified by GUIDE v2.5 31-Jan-2019 22:04:47

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @manipulador_OpeningFcn, ...
                   'gui_OutputFcn',  @manipulador_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before manipulador is made visible.
function manipulador_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to manipulador (see VARARGIN)

% Choose default command line output for manipulador
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes manipulador wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = manipulador_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
poyect_robotica;
close manipulador;


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
movil;
close manipulador;


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc;
a=get(handles.control1,'Value');
b=get(handles.control2,'Value');
c=get(handles.control3,'Value');
d=get(handles.rampa,'Value');
e=get(handles.circulo,'Value');
f=get(handles.ocho,'Value');
g=get(handles.cuadrado,'Value');
if a==1
    t=1;
    tkint=2;
    assignin('base','tipo_control',t); 
elseif b==1
    t=2;
    tkint=300;
    assignin('base','tipo_control',t);
elseif c==1
    t=3;
    tkint=300;
    assignin('base','tipo_control',t);
end

if e==1
    t3=1;
    tkint=150;
    assignin('base','tipo_tray',t3); 
elseif f==1
    t3=2;
    tkint=150;
    assignin('base','tipo_tray',t3);
elseif g==1
    t3=3;
    assignin('base','tipo_tray',t3);
    tkint=100;
end

if d==1
    sim('manipulador_sim');
else
    sim('manipulador_tray');
end
clc;

for k = 1:tkint:length(t)
    axes(handles.axes2);
    brazo(q0(k),q1(k));
    plot(xdato(1:k),ydato(1:k),':k','LineWidth',2);hold on;grid on;
    plot(xdato(k),ydato(k),'ko');
    plot(xddato(1:k),yddato(1:k),'r');
    plot(xddato(k),yddato(k),'.r');
    hold off;
    axis([-0.8 0.8 -0.8 0.8]);
    xlabel('eje x (m)');ylabel('eje y (m)');
    title('Vista superior del manipulador');
    MM = getframe();
    axes(handles.axes3);
    plot(t(1:k),xddato(1:k)-xdato(1:k),'b');grid on;
    xlabel('t (s)');ylabel('ex (m)');
    title('Error en x');
    MM1 = getframe();
    axes(handles.axes4);
    plot(t(1:k),yddato(1:k)-ydato(1:k),'b');grid on;
    xlabel('t (s)');ylabel('ey (m)');
    title('Error en y');
    MM2 = getframe();
    axes(handles.axes5);
    plot(t(1:k),q0(1:k),':b','LineWidth',2);grid on;hold on;
    plot(t(1:k),q0d(1:k),'r');
    hold off;
    xlabel('t (s)');ylabel('q0 (rad)');
    title('Valor del angulo q0');
    legend('Angulo del manipulador','Angulo deseado');
    MM3 = getframe();
    axes(handles.axes6);
    plot(t(1:k),q1(1:k),':b','LineWidth',2);grid on;hold on;
    plot(t(1:k),q1d(1:k),'r');
    xlabel('t (s)');ylabel('q1 (rad)');
    hold off;
    title('Valor del angulo q1');
    legend('Angulo del manipulador','Angulo deseado');
    MM4 = getframe();
    texto1=sprintf('T: %f s',t(k));
    set(handles.text2, 'String', texto1);
    texto2=sprintf('Angulo q0: %.2f',q0(k));
    set(handles.text3, 'String', texto2);
    texto3=sprintf('Angulo q1: %.2f',q1(k));
    set(handles.text4, 'String', texto3);
    texto4=sprintf('Posicion en x: %.2f',xdato(k));
    set(handles.text5, 'String', texto4);
    texto5=sprintf('Error en q0: %f',q0d(k)-q0(k));
    set(handles.text6, 'String', texto5);
    texto6=sprintf('Error en q1: %f',q1d(k)-q1(k));
    set(handles.text7, 'String', texto6);
    texto7=sprintf('Posicion en y: %.2f',ydato(k));
    set(handles.text8, 'String', texto7);
end


% --- Executes on button press in Manipulador.
function Manipulador_Callback(hObject, eventdata, handles)
% hObject    handle to Manipulador (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=get(handles.control1,'Value');
b=get(handles.control2,'Value');
c=get(handles.control3,'Value');
d=get(handles.rampa,'Value');
e=get(handles.circulo,'Value');
f=get(handles.ocho,'Value');
g=get(handles.cuadrado,'Value');
if a==1
    t=1;
    tkint=2;
    assignin('base','tipo_control',t); 
elseif b==1
    t=2;
    tkint=300;
    assignin('base','tipo_control',t);
elseif c==1
    t=3;
    tkint=300;
    assignin('base','tipo_control',t);
end

if e==1
    t3=1;
    tkint=150;
    assignin('base','tipo_tray',t3); 
elseif f==1
    t3=2;
    tkint=150;
    assignin('base','tipo_tray',t3);
elseif g==1
    t3=3;
    assignin('base','tipo_tray',t3);
    tkint=100;
end
sim('manipulador_tray');
cd('C:\Users\Juan Esteban\Desktop\arte');
init_lib;
robot1 = load_robot('STAUBLI','TP80');

z22d = 0;
p = size(xdato);
z = -0.5*ones(p);
tkint=50;
for k = 1:tkint:length(t)
    q = [q0(k) q1(k) 0 0 0 0];
    drawrobot3d(robot1,q);
     plot3(xdato(1:k)+0.32,ydato(1:k)+0.05,z(1:k),'--','LineWidth',2,'color',[0.4 0.5 0.8]);
     hold on
    plot3(xddato(1:k)+0.32,yddato(1:k)+0.05,z(1:k),'--','LineWidth',2);
    MM5=getframe();
end
    
