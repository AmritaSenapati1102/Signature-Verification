function varargout = GUI(varargin)

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_OutputFcn, ...
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

% --- Executes just before GUI is made visible.
function GUI_OpeningFcn(hObject, eventdata, handles, varargin)

clear img2;
i1 = 0;
i2 = 0;
handles.Feat_Err = [ 0.006 0.8 0.04 6 [[0.0750 0.0750] [0.0750 0.0750]] 0.0065 ];
% Choose default command line output for GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% --- Outputs from this function are returned to the command line.
function varargout = GUI_OutputFcn(hObject, eventdata, handles) 

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)

[a b] = uigetfile('*.*','All Files');
img1=imread([b a]);
handles.img1 = img1;
guidata(hObject, handles);
imshow(img1,'Parent',handles.axes3);

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)

[a b] = uigetfile('*.*','All Files');
img2=imread([b a]);
handles.img2 = img2;
guidata(hObject, handles);
imshow(img2,'Parent',handles.axes4);

% --- Executes during object creation, after setting all properties.
function uipanel1_CreateFcn(hObject, eventdata, handles)

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)

isfield(handles, 'img1')

if isfield(handles, 'img1') && isfield(handles, 'img2')
    [Feat1,imgp1] = featureExtraction(handles.img1);
    imshow(imgp1,'Parent',handles.axes5);
    [Feat2,imgp2] = featureExtraction(handles.img2);
    imshow(imgp2,'Parent',handles.axes6);
    Feat_Err = handles.Feat_Err
    Feat1
    Feat2
    flag = 1;
    for i=1:9
        if abs(Feat2(i)-Feat1(i)) > Feat_Err(i)
            flag = 0;
            break;
        end
    end
    
    if flag
        set(handles.text8,'string','Valid');
    else
        set(handles.text8,'string','Invalid');
    end
    
else
    errordlg('Please Select both the images');
    set(handles.text8,'string','Not Processed');
end


