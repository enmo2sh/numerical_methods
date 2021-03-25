function varargout = GUI2(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI2_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI2_OutputFcn, ...
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

function GUI2_OpeningFcn(hObject, eventdata, handles, varargin)
global xData;
xData.MyData = [];
global yData;
yData.MyData = [];
global flag;
flag=0;
 
handles.output = hObject;
guidata(hObject, handles);
function varargout = GUI2_OutputFcn(hObject, eventdata, handles)
varargout{1} = handles.output;
 
function [myString]=result(method,str1,str2)
  global xData;
global yData;global flag; global A;

myString='';
if (flag==1)                           %reading from file
    x=zeros;y=zeros;
    for i=1:length(A)
        x(i)=A(i,1);
        y(i)=A(i,2);
    end
else 
x = str2double(xData.MyData);
y = str2double(yData.MyData);
end
if (((length(x))==(length(y)))&&(length(x)>1))
        order=str2double(str1);
        xre=str2double(str2);
         if(isnan(order) || isnan(xre))
           msgbox('you should enter only digits');  
           return ;  
         end
         if(order>=length(x))
                msgbox('order should be less than the number of points');
                return;
         end
        if(strcmp(method,'Newton'))
            [answer,time,equ,diverge] = Newton(order, x, y, xre);
             if(diverge==1)
                  myString=sprintf('Diverge as error increases');
                  return;
             end
        else
            [time,answer,equ] = LagrangeInterpolating(xre,order,x,y);
        end
            myString = sprintf('Time=%fSec\nSolution=%f\nequation=\n%s',time,answer,equ);   
        fplot(equ,[xre-50,xre+50])
        grid();
else
    msgbox('please enter X&Y correctly');  
    return ;
end  
  
 
% --- Executes on button press in newton.
function newton_Callback(hObject, eventdata, handles)
global flag;global order;global xrequire;
if (flag==1)
    flag=0;
    str1 = order;
    str2= xrequire;  
else
    str1 = get(handles.order,'string');
    str2= get(handles.xreq,'string');
     if(isempty(str1))
         msgbox('please enter the order');  
         return ;
    elseif(isempty(str2))
        msgbox('please enter the X wanted to compute');  
         return ;
     end
end
 myString=result('Newton',str1,str2);
 set(handles.solution, 'String', myString);
 
% --- Executes on button press in lagrange.
function lagrange_Callback(hObject, eventdata, handles)
global flag;global order;global xrequire;
if (flag==1)
    str1 = order;
    str2= xrequire;
    flag=0;
else
    str1 = get(handles.order,'string');
    str2= get(handles.xreq,'string');
    if(isempty(str1))
         msgbox('please enter the order');  
         return ;
    elseif(isempty(str2))
        msgbox('please enter the X wanted to compute');  
         return ;
     end
end
myString=result('Lagrange',str1,str2);
set(handles.solution, 'String', myString);
 
function Xfield_Callback(hObject, eventdata, handles) 
 
% --- Executes during object creation, after setting all properties.
function Xfield_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end 
 
function Yfield_Callback(hObject, eventdata, handles) 
 
% --- Executes during object creation, after setting all properties.
function Yfield_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
 
% --- Executes on button press in filling.
function filling_Callback(hObject, eventdata, handles)
global xData;
global yData;
x = get ( handles.Xfield,'string');
y = get ( handles.Yfield,'string');
if (length(x)>0)
    if(isnan(str2double(x)))
       msgbox('you should enter only digits');  
           return ;  
    end  
xData.MyData = [xData.MyData; [{x}]];
set (handles.Xtable,'Data',xData.MyData);
end
if(length(y)>0)
    if(isnan(str2double(y)))
     msgbox('you should enter only digits');  
           return ;  
    end
yData.MyData = [yData.MyData; [{y}]];
set (handles.Ytable,'Data',yData.MyData);
end
set ( handles.Xfield,'string','');
set ( handles.Yfield,'string','');
 
 
% --- Executes on button press in clear.
function clear_Callback(hObject, eventdata, handles)
global xData;
global yData;
set(handles.Xtable, 'Data', {});
set(handles.Ytable, 'Data', {});
set ( handles.Xfield,'string','');
set ( handles.Yfield,'string','');
xData.MyData = [];
yData.MyData = [];
set(handles.solution, 'String', '');
set(handles.solution, 'String', '');
cla(handles.axes1);

function order_Callback(hObject, eventdata, handles)

function order_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function xreq_Callback(hObject, eventdata, handles)
function xreq_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function axes1_CreateFcn(hObject, eventdata, handles)


% --- Executes on button press in Delete.
function Delete_Callback(hObject, eventdata, handles)
global xData;
global yData;
xData.MyData(end)=[];
set (handles.Xtable,'Data',xData.MyData);
yData.MyData(end)=[];
set (handles.Ytable,'Data',yData.MyData);


% --- Executes on button press in readfile.
function readfile_Callback(hObject, eventdata, handles)
% hObject    handle to readfile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global flag; global A; global order;global xrequire;
flag=0;
[A,order,xrequire,counter] =ReadFromFile2();

if(counter~=3)
    msgbox('Wrong input');
else
    flag=1;
end
