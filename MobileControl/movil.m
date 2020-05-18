function varargout = movil(varargin)
% MOVIL MATLAB code for movil.fig
%      MOVIL, by itself, creates a new MOVIL or raises the existing
%      singleton*.
%
%      H = MOVIL returns the handle to a new MOVIL or the handle to
%      the existing singleton*.
%
%      MOVIL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MOVIL.M with the given input arguments.
%
%      MOVIL('Property','Value',...) creates a new MOVIL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before movil_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to movil_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help movil

% Last Modified by GUIDE v2.5 20-Jan-2019 15:01:09

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @movil_OpeningFcn, ...
                   'gui_OutputFcn',  @movil_OutputFcn, ...
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


% --- Executes just before movil is made visible.
function movil_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to movil (see VARARGIN)

% Choose default command line output for movil
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes movil wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = movil_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in inicio.
function inicio_Callback(hObject, eventdata, handles)
% hObject    handle to inicio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
poyect_robotica;
close movil;


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in manipulador.
function manipulador_Callback(hObject, eventdata, handles)
% hObject    handle to manipulador (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
manipulador;
close movil;


% --- Executes on button press in grafica.


% hObject    handle to grafica (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in grafica.
function grafica_Callback(hObject, eventdata, handles)
% hObject    handle to grafica (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc;
detener=0;
a=get(handles.posicion,'Value');
b=get(handles.trayectoria,'Value');
c=get(handles.circulo,'Value');
d=get(handles.ocho,'Value');
e=get(handles.cuadrado,'Value');
f=str2double(get(handles.x_posicion, 'String'));
g=str2double(get(handles.y_posicion, 'String'));
h=str2double(get(handles.tiempo, 'String'));
assignin('base','T',h);
assignin('base','x0',f);
assignin('base','y0',g);
if b==1
    tkint=200;
    if c==1
        t=1;
        assignin('base','tipo_trayectoria',t);
    elseif d==1
        t=2;
        assignin('base','tipo_trayectoria',t);
    elseif e==1
        t=3;
        assignin('base','tipo_trayectoria',t);
    end
    sim('movil_tray');
elseif a==1
    tkint=10;
    t=4;
    assignin('base','tipo_trayectoria',t);
    sim('robmovil_sim_15a');
end

clc;
for k = 1:tkint:length(t)
    axes(handles.axes2);
    robc(xdato(k),ydato(k),fidato(k),0.3,'y');
    plot(xdato(1:k),ydato(1:k),':k','LineWidth',2); hold on; grid on;
    plot(xdato(k),ydato(k),'ko');
    plot(xddato(1:k),yddato(1:k),':r','LineWidth',1);
    plot(xddato(k),yddato(k),'.r');
    hold off;
    axis([-10 10 -10 10]);
    xlabel('eje x (m)');ylabel('eje y (m)');
    title('Movimiento del robot');
    MM = getframe();
    axes(handles.axes4);
    plot(t(1:k),xddato(1:k)-xdato(1:k),'b');grid on;
    xlabel('t (s)');ylabel('ex (m)');
    title('Error en x');
    MM1=getframe();
    axes(handles.axes6);
    plot(t(1:k),yddato(1:k)-ydato(1:k),'b');grid on;
    xlabel('t (s)');ylabel('ey (m)');
    title('Error en y');
    MM2=getframe();
    axes(handles.axes7);
    plot(t(1:k),fiddato(1:k)-fidato(1:k),'b');grid on;
    xlabel('t (s)');ylabel('efi (rad)');
    title('Error en fi');
    MM3=getframe();
    axes(handles.axes3);
    plot(t(1:k),uref(1:k),':b','LineWidth',3);grid on;hold on;
    plot(t(1:k),udim(1:k),'-.r','LineWidth',2);
    plot(t(1:k),u(1:k),'c');
    hold off;
    xlabel('t (s)');ylabel('u (m/s)');
    title('Valor de velocidad lineal');
    legend('Ucin','Udin','Ureal'); 
    MM4=getframe();
    axes(handles.axes5);
    plot(t(1:k),wref(1:k),':b','LineWidth',3);grid on;hold on;
    plot(t(1:k),wdim(1:k),'-.r','LineWidth',2);
    plot(t(1:k),w(1:k),'c');
    hold off;
    xlabel('t (s)');ylabel('w (rad/s)');
    title('Valor de velocidad angular');
    legend('Wcin','Wdin','Wreal'); 
    MM5=getframe();
    texto1=sprintf('T: %f s',t(k));
    set(handles.t, 'String', texto1);
    texto2=sprintf('Posicion en x: %.2f',xdato(k));
    set(handles.text8, 'String', texto2);
    texto3=sprintf('Posicion en y: %.2f',ydato(k));
    set(handles.text9, 'String', texto3);
    texto4=sprintf('Angulo real: %.2f',fidato(k));
    set(handles.text10, 'String', texto4);
    texto5=sprintf('Error en x: %f',xddato(k)-xdato(k));
    set(handles.text11, 'String', texto5);
    texto6=sprintf('Error en y: %f',yddato(k)-ydato(k));
    set(handles.text12, 'String', texto6);
    texto7=sprintf('Error en angulo: %f',fiddato(k)-fidato(k));
    set(handles.text13, 'String', texto7);
end



function x_posicion_Callback(hObject, eventdata, handles)
% hObject    handle to x_posicion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of x_posicion as text
%        str2double(get(hObject,'String')) returns contents of x_posicion as a double


% --- Executes during object creation, after setting all properties.
function x_posicion_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x_posicion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function y_posicion_Callback(hObject, eventdata, handles)
% hObject    handle to y_posicion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of y_posicion as text
%        str2double(get(hObject,'String')) returns contents of y_posicion as a double


% --- Executes during object creation, after setting all properties.
function y_posicion_CreateFcn(hObject, eventdata, handles)
% hObject    handle to y_posicion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function tiempo_Callback(hObject, eventdata, handles)
% hObject    handle to tiempo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tiempo as text
%        str2double(get(hObject,'String')) returns contents of tiempo as a double


% --- Executes during object creation, after setting all properties.
function tiempo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tiempo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in detener.
function detener_Callback(hObject, eventdata, handles)
% hObject    handle to detener (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
