function varargout = imageprocessing(varargin)
%IMAGEPROCESSING MATLAB code file for imageprocessing.fig
%      IMAGEPROCESSING, by itself, creates a new IMAGEPROCESSING or raises the existing
%      singleton*.
%
%      H = IMAGEPROCESSING returns the handle to a new IMAGEPROCESSING or the handle to
%      the existing singleton*.
%
%      IMAGEPROCESSING('Property','Value',...) creates a new IMAGEPROCESSING using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to imageprocessing_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      IMAGEPROCESSING('CALLBACK') and IMAGEPROCESSING('CALLBACK',hObject,...) call the
%      local function named CALLBACK in IMAGEPROCESSING.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help imageprocessing

% Last Modified by GUIDE v2.5 20-Jun-2016 21:15:17

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @imageprocessing_OpeningFcn, ...
                   'gui_OutputFcn',  @imageprocessing_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
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

%  set(data_panel,'Visible','off');
%  set(pushbutton9,'Visible','off');
% --- Executes just before imageprocessing is made visible.
function imageprocessing_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for imageprocessing
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes imageprocessing wait for user response (see UIRESUME)
% uiwait(handles.figure1);
% set(handles.data_panel,'Visible','off');
%  set(handles.image1,'Visible','off');
%  set(handles.axes6,'Visible','off');
%  set(handles.axes7,'Visible','off');
%  set(handles.axes8,'Visible','off');
%  set(handles.close_win,'Visible','off');
 

% --- Outputs from this function are returned to the command line.
function varargout = imageprocessing_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes during object creation, after setting all properties.
function image_ax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to image_ax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



% --- Executes on button press in import_image.
function import_image_Callback(hObject, eventdata, handles)
% hObject    handle to import_image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% myImage = imread('/home/soha/Desktop/project/finger.png');
% axes(handles.image_ax);
% imshow(myImage);
%        [File_Name, Path_Name] = uigetfile('*.png','/home/soha/Desktop/project');
%        axes(handles.image_ax)
%        imshow([Path_Name,File_Name])

prompt = {'Enter the ID : ','Enter name :'};
dlg_title = 'Input';
num_lines = 1;
handles.answer = inputdlg(prompt,dlg_title,num_lines);
name=strcat('Database2345f/',handles.answer{1});
if exist(name,'dir')
msgbox('This ID already exists please enter a valid ID','Warning','warn');
uiwait();
return;
else
    
mkdir(name);
end

msgbox('select 4 sample images of an individual');
uiwait();

[parentdir,~,~]=fileparts(pwd);
DbFile =fullfile(parentdir,'FingerVeinDatabase');

for i=1:4
    
[filename,pathname]=uigetfile(...
    {'*.jpg;*.gif;*.png;*.bmp',...
     'image file(*.jpg,*.gif,*.png,*.bmp)';'*.*','all files(*.*)'},...
     'open the image file to be registered',DbFile);

% need to handle the case where the user presses cancel
if filename~=0
    fullimagefilename = fullfile(pathname,filename);

    % create an img field in handles for the image that is being loaded
    handles.img = imread(fullimagefilename);

    axes(handles.image_ax);
    image(handles.img);
    imshow([pathname,filename]);
    
%F=getframe(handles.image_ax); %select axes in GUI
%Image=frame2im(F);
handles.datapath=name;
j=dir(handles.datapath);
fileattrib(handles.datapath,'-w','a'); %giving write permission
num=num2str(size(j,1)-1);
path=strcat(handles.datapath,'/',num);
imwrite(handles.img,path,'bmp');
end
    % save the application data
    guidata(hObject,handles);
end



% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Pre_Process.
function Pre_Process_Callback(hObject, eventdata, handles)
% hObject    handle to Pre_Process (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% check to ensure that img exists in handles\
set(handles.figure1,'pointer','watch')
drawnow;
ID=handles.answer{1};
datapath=handles.datapath;
%imgset=imageSet(datapath);

Imgs=dir(datapath);
    Num=size(Imgs,1)-2;
    for i= 1:Num
        image=im2double(rgb2gray(imread([datapath '/' Imgs(i+2).name])));
        image=imresize(image,0.5);
        [~,edges1]=lee_region(image,4,20);
        x=size(edges1,2);
      ROI1=imcrop(image,[1 edges1(1,floor(x/2)) x-1 edges1(2,floor(x/2))-edges1(1,floor(x/2))]);
%      ROI1=imcrop(image,[1 edges1(1,x) x-1 edges1(2,x)-edges1(1,x)]);

        ROI1=imadjust(imresize(ROI1,[64 96],'bilinear'));
        X{i}=ROI1;
        lbp{i}=LBP(ROI1);
%         imshow(X{i});
    end
    PBBM=getPBBM(X{1},X{2},X{3},X{4},lbp{1},lbp{2},lbp{3},lbp{4});
    if exist('DATA2345f.mat','file')==0 
        DATA=[{handles.answer{1}} {handles.answer{2}} {PBBM}];
        save ('DATA2345f.mat','DATA');
    else
        load DATA2345f
        m=size(DATA,1);
        DATA{m+1,1}=handles.answer{1};
        DATA{m+1,2}=handles.answer{2};
        DATA{m+1,3}=PBBM;
        save ('DATA2345f.mat','DATA');
    end
    guidata(hObject,handles);
    set(handles.figure1,'pointer','arrow')



% --- Executes on button press in PBBM_MATCH.
function PBBM_MATCH_Callback(hObject, eventdata, handles)
% hObject    handle to PBBM_MATCH (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[parentdir,~,~]=fileparts(pwd);
DbTestFile=fullfile(parentdir,'FingerVeinDatabase')

[filename,pathname]=uigetfile(...
    {'*.jpg;*.gif;*.png;*.bmp',...
     'image file(*.jpg,*.gif,*.png,*.bmp)';'*.*','all files(*.*)'},...
     'open the image file to be verified',DbTestFile);


% need to handle the case where the user presses cancel
if filename~=0
    fullimagefilename = fullfile(pathname,filename);

    % create an img field in handles for the image that is being loaded
    handles.img = imread(fullimagefilename);

    axes(handles.image_ax);
    %image(handles.img);
    imshow([pathname,filename]);
    image=im2double(rgb2gray(handles.img));
        image=imresize(image,0.5);
        [~,edges]=lee_region(image,4,20);
        x=size(edges,2);
       ROI=imcrop(image,[1 edges(1,floor(x/2)) x-1 edges(2,floor(x/2))-edges(1,floor(x/2))]);
 %       ROI=imcrop(image,[1 edges(1,x) x-1 edges(2,x)-edges(1,x)]);

        ROI=imadjust(imresize(ROI,[64 96],'bilinear'));
    LBP_test=LBP(ROI);
    load DATA2345f
    d=size(DATA,1);
    score=zeros(d,1);
    for k=1:d
%         P=DATA{k,3};
        score(k)=PBBM_matching(DATA{k,3},LBP_test);
    end
    [S,I]=max(score);
    if exist('graph1.mat','file')==0 
        graph=[DATA{I,1} DATA{I,2} {S}];
        save ('graph1.mat','graph');
    else
        load graph1
        m=size(graph,1);
        graph{m+1,1}=DATA{I,1};
        graph{m+1,2}=DATA{I,2};
        graph{m+1,3}=S;
        save ('graph1.mat','graph');
    end
    
    
    if(S>=0.89)
        %msgbox('VERIFIED!!,This finger belongs to ID ' ,[DATA{I,1} DATA{I,2}]);
        set(handles.result,'string',['VERIFIED! ' DATA{I,1} '-' DATA{I,2}]); 
    else
        %msgbox('TRY AGAIN!! ,NO MATCH FOUND','ERROR');
        set(handles.result,'string','ERROR! NO MATCH FOUND');
    end
    guidata(hObject,handles);
end



% --- Executes during object creation, after setting all properties.
function result_CreateFcn(hObject, eventdata, handles)
% hObject    handle to result (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB


% --- Executes on button press in exit.
function exit_Callback(hObject, eventdata, handles)
% hObject    handle to exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close;