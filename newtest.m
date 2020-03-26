function varargout = newtest(varargin)
% NEWTEST MATLAB code for newtest.fig
%      NEWTEST, by itself, creates a new NEWTEST or raises the existing
%      singleton*.
%
%      H = NEWTEST returns the handle to a new NEWTEST or the handle to
%      the existing singleton*.
%
%      NEWTEST('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NEWTEST.M with the given input arguments.
%
%      NEWTEST('Property','Value',...) creates a new NEWTEST or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before newtest_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to newtest_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help newtest

% Last Modified by GUIDE v2.5 02-Oct-2018 19:29:26

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @newtest_OpeningFcn, ...
                   'gui_OutputFcn',  @newtest_OutputFcn, ...
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


% --- Executes just before newtest is made visible.
function newtest_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to newtest (see VARARGIN)

% Choose default command line output for newtest
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes newtest wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = newtest_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a=240;
b=180;
t=str2num(get(handles.edit2,'string'));
s=str2num(get(handles.edit1,'string'));
% t=input('The number of columns along a side. Please enter more than 2: ');
% s=input('The number of columns along b side. Please enter more than 2: ');
% P is the value of the loading 
P=str2num(get(handles.P,'string'));
% E is modulus of Elasticity
E=3600000;
% H is the thickness of plate
H=8;
% vv is the Poiso's ratio
vv=0.2;
% k= stifness factor on elastic foundation
k=0;

x= linspace(0,a,s+2);
disp(x);
x=x(2:(numel(x)-1));
y = linspace(0,b,t+2);
disp(y);
y=y(2:(numel(y)-1));

Cp=zeros(s*t,1);
Cmn=zeros(t,s);
Cr=zeros(s*t,s*t);
ind = 0;
D=E*H^3/12/(1-vv)^2; 

for m=1:100
    for n=1:100
        ind=0;
        for ix=1:s
            for iy=1:t
                F(iy,ix)=sin(x(ix)*m*pi/a)*sin(y(iy)*n*pi/b);
                E=a*b*pi^4*D*((m/a)^2+(n/b)^2)^2;
                Cmn(iy,ix)=(4/(E+k))*F(iy,ix);
                
                ind = ind+1;
               Cp(ind)=Cp(ind)+Cmn(iy,ix)*sin(m*pi/2)*sin(n*pi/2);
      
            end
        end
        
        
        for mm=1:numel(Cmn)
            for nn=1:numel(F)
                Cr(mm,nn)=Cr(mm,nn)+Cmn(mm)*F(nn);
            end
        end
    end
end

Cr(4,6)=3.7257e-07;
R=Cr\(Cp*P);

[xx,yy] = meshgrid(linspace(0,240),linspace(0,180));
W=0;
A=0;
for m=1:100
    for n=1:100
    B=((m/a)^2+(n/b)^2)^2;
    B1=4/(a*b*pi^4*D*B)+k;
    B2=sin(xx.*m*pi./a).*sin(yy.*n*pi./b);
    A1=P*sin(m*pi/2)*sin(n*pi/2);
    for ia=1:s
        for ib=1:t
            FF(ib,ia)=sin(x(ia)*m*pi/a)*sin(y(ib)*n*pi/b);
        end
    end
    for aa=1:length(R)
      A=A+R(aa)*FF(aa);
%     A=-8.063333333e-12;
     end 
    W=W+B1*(A1-A)*B2;
      
    end
end
cla(handles.axes1);
axes(handles.axes1);
surf(xx,yy,W)   
mesh(xx,yy,W) 
title({'The deflection along the rectangular plate' ; ['s = ' num2str(s) ]; ['t = ' num2str(t)]})
xlabel('inches');
ylabel('inches');
zlabel('deflection of the plate');
% axis on;
% light;
% lighting phong;
% camlight('left');
% shading interp;

% moment x
Mx=0;
A=0;
[xx,yy] = meshgrid(linspace(0,240),linspace(0,180));

for m=1:100
    for n=1:100
    B=((m/a)^2+(n/b)^2)^2;
    B1=4/(a*b*pi^4*D*B)+k;
    B2=sin(xx.*m*pi./a).*sin(yy.*n*pi./b);
    
    A1=P*sin(m*pi/2)*sin(n*pi/2);
    
    for ia=1:s
        for ib=1:t
            FF(ib,ia)=sin(x(ia)*m*pi/a)*sin(y(ib)*n*pi/b);
        end
    end
    
    for aa=1:numel(FF)
        A=A+R(aa)*FF(aa);
    end
    
    Mx=Mx+D*((m*pi/a)^2+vv*(n*pi/b)^2)*B1*(A1-A)*B2;
    end    
end
cla(handles.axes2);
axes(handles.axes2);
surf(xx,yy,Mx)
% mesh(xx,yy,Mx)
title({'The Moment along the x axis of rectangular plate' ; ['s = ' num2str(s) ]; ['t = ' num2str(t)]})
xlabel('inches');
ylabel('inches');
zlabel('Moment along x axis');
axis on;
light;
lighting phong;
camlight('left');
shading interp;

% moment y
My=0;
A=0;
[xx,yy] = meshgrid(linspace(0,240),linspace(0,180));

for m=1:100
    for n=1:100
    B=((m/a)^2+(n/b)^2)^2;
    B1=4/(a*b*pi^4*D*B)+k;
    B2=sin(xx.*m*pi./a).*sin(yy.*n*pi./b);
    
    A1=P*sin(m*pi/2)*sin(n*pi/2);
    
    for ia=1:s
        for ib=1:t
            FF(ib,ia)=sin(x(ia)*m*pi/a)*sin(y(ib)*n*pi/b);
        end
    end
    
    for aa=1:numel(FF)
        A=A+R(aa)*FF(aa);
    end
    
    My=My+D*((n*pi/b)^2+vv*(m*pi/a)^2)*B1*(A1-A)*B2;
    end    
end
cla(handles.axes3);
axes(handles.axes3);
surf(xx,yy,My)
% mesh(xx,yy,My)
title({'The Moment along the y axis of rectangular plate' ; ['s = ' num2str(s) ]; ['t = ' num2str(t)]})
xlabel('inches');
ylabel('inches');
zlabel('Moment along y axis');
axis on;
light;
lighting phong;
camlight('left');
shading interp;

load gong Fs y
gongSound = audioplayer(y,Fs);
play(gongSound)



function P_Callback(hObject, eventdata, handles)
% hObject    handle to P (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of P as text
%        str2double(get(hObject,'String')) returns contents of P as a double


% --- Executes during object creation, after setting all properties.
function P_CreateFcn(hObject, eventdata, handles)
% hObject    handle to P (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function k_Callback(hObject, eventdata, handles)
% hObject    handle to k (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of k as text
%        str2double(get(hObject,'String')) returns contents of k as a double


% --- Executes during object creation, after setting all properties.
function k_CreateFcn(hObject, eventdata, handles)
% hObject    handle to k (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
