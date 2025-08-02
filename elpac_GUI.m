function varargout = elpac_GUI(varargin)
% ELPAC_GUI MATLAB code for elpac_GUI.fig
%      ELPAC_GUI, by itself, creates a new ELPAC_GUI or raises the existing
%      singleton*.
%
%      H = ELPAC_GUI returns the handle to a new ELPAC_GUI or the handle to
%      the existing singleton*.
%
%      ELPAC_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ELPAC_GUI.M with the given input arguments.
%
%      ELPAC_GUI('Property','Value',...) creates a new ELPAC_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before elpac_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to elpac_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help elpac_GUI

% Last Modified by GUIDE v2.5 17-Oct-2017 12:02:04

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @elpac_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @elpac_GUI_OutputFcn, ...
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


% --- Executes just before elpac_GUI is made visible.
function elpac_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to elpac_GUI (see VARARGIN)

% Choose default command line output for elpac_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

handles.alreadyPlot = false;
guidata(hObject,handles);

% UIWAIT makes elpac_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = elpac_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


function numPts_Callback(hObject, eventdata, handles)
% hObject    handle to numPts (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of numPts as text
%        str2double(get(hObject,'String')) returns contents of numPts as a double


% --- Executes during object creation, after setting all properties.
function numPts_CreateFcn(hObject, eventdata, handles)
% hObject    handle to numPts (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function epsilon_Callback(hObject, eventdata, handles)
% hObject    handle to numPts (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of numPts as text
%        str2double(get(hObject,'String')) returns contents of numPts as a double

function deltaT_Callback(hObject, eventdata, handles)
% hObject    handle to numPts (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of numPts as text
%        str2double(get(hObject,'String')) returns contents of numPts as a double

% --- Executes on button press in run.
function run_Callback(hObject, eventdata, handles)
% hObject    handle to run (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    h = guihandles;
    
    markerSize = str2double(get(h.markerSize,'String'));
    handles.markerSize = markerSize;
    lineWidth = str2double(get(h.lineWidth,'String'));
    handles.lineWidth = lineWidth;
    contents = cellstr(get(h.contourType,'String'));
    contourType = contents{get(h.contourType,'Value')};
    handles.contourType = contourType;
    numPts = str2double(get(h.numPts,'String'));
    handles.numPts = numPts;
    radius = str2double(get(h.radius,'String'));
    handles.radius = radius;
    x = str2double(get(h.x,'String'));
    handles.x = x;
    y = str2double(get(h.y,'String'));
    handles.y = y;
    width = str2double(get(h.h,'String'));
    handles.width = width;
    height = str2double(get(h.k,'String'));
    handles.height = height;
    
    gamma = str2double(get(h.gamma,'String'));
    handles.gamma = gamma;
    alpha = get(h.alpha,'String');
    handles.alpha = alpha;
    beta = get(h.beta,'String');
    handles.beta = beta;
    
    epsilon = str2double(get(h.epsilon,'String'));
    handles.epsilon = epsilon;
    deltaT = str2double(get(h.deltaT,'String'));
    handles.deltaT = deltaT;
    plotC1 = get(h.plotC1,'Value');
    handles.plotC1 = plotC1;
    plotC2 = get(h.plotC2,'Value');
    handles.plotC2 = plotC2;
    plotV = get(h.plotV,'Value');
    handles.plotV = plotV;
    contents = cellstr(get(h.filter,'String'));    
    fieldType = contents{get(h.filter,'Value')};
    
    split = get(h.split,'Value');
    handles.split = split;
    split_dist = get(h.split_dist,'Value');
    handles.split_dist = split_dist;
    connect = get(h.connect,'Value');
    handles.connect = connect;
    dist = str2double(get(h.dist,'String'));    
    handles.dist = dist;
    
    switch fieldType
        case 'Norm of Grad in Poisson Eq'
            fieldType = 'gradient';
        case 'Norm of Laplacian in Poisson Eq'
            fieldType = 'laplacian';
        case 'Schrodinger Img Convolution'
            fieldType = 'schrodinger';
        case 'Gaussian Img Convolution'
            fieldType = 'gaussian';
    end
    handles.fieldType = fieldType;
    
    contents = cellstr(get(h.stopType,'String'));
    stopType = contents{get(h.stopType,'Value')};
    handles.stopType = stopType;
    filter = struct('fieldType',fieldType,'stopType',stopType);
    fSize = str2double(get(h.fSize,'String'));
    handles.fSize = fSize;
    %save = get(h.save,'Value');
    save = false;
    
    filename = get(h.filename,'String');
    if(isempty(filename))
        msgbox('Please select a file.');
        return;
    end
    
    cOpt = struct('contourType',contourType,'numPts',numPts,'radius',radius,'x',x,'y',y,'h',width,'k',height,'split',split,'split_dist',split_dist,'dist',dist,'connect',connect);
    iOpt = struct('filter',filter,'fSize',fSize,'epsilon',epsilon,'deltaT',deltaT);
    eOpt = struct('gamma',gamma,'alpha',inline(alpha),'beta',inline(beta));
    plotOpt = struct('C1',false,'C2',false,'V',false);
    options = struct('cOpt',cOpt,'plot',plotOpt,'eOpt',eOpt,'iOpt',iOpt,'save',save);
    
    set(h.status,'String','Working...');
    set(h.status,'BackgroundColor','yellow');
    drawnow;
    
    try
        tic;
        result = elpac(filename,options);
        toc;
        handles.result=result;
        guidata(hObject,handles);
    catch err
        set(h.status,'String','Error! Check command window.');
        set(h.status,'BackgroundColor','red');
        rethrow(err);
    end
    
    %Graph, plotImg, and save plotImg
    %plotTitle=sprintf('numPts=%g_R=%g_alpha=%s_beta=%s_epsilon=%g_gamma=%g_deltaT=%g_filter=%s_fSize=%g',o.cOpt.numPts,char(o.eOpt.alpha),char(o.eOpt.beta),o.iOpt.epsilon,o.eOpt.gamma,o.iOpt.deltaT,o.iOpt.filter,o.iOpt.fSize);
    ax = findobj(gcf,'type','axes');
    hold off;
    axes(ax);
    Img=double(imread(filename));
    imshow(uint8(Img));
    handles.ax=ax;
    guidata(hObject,handles);
    hold(ax,'all');
    
    if plotC1 == true %Plot orginal contour
        plot(result.cOriginal(:,2),result.cOriginal(:,1),'-g*','MarkerSize',markerSize,'LineWidth',lineWidth);
    end
    if plotV == true %plotimg vector field
        [rows,cols,~]=size(imread(filename));
         [x,y] = meshgrid(1:cols,1:rows);
         u = result.gradX;
         v = result.gradY;
         quiver(x,y,u,v);
    end
    if plotC2 == true %Plot final contour
       [~,contours,~]=size(result.c);
       for i = 1:contours
            plot(result.c(1,i).y,result.c(1,i).x,'-r*','MarkerSize',markerSize,'LineWidth',lineWidth,'Parent',ax); 
       end
    end
   
    
    handles.potential = result.potential;
    
    handles.alreadyPlot = true;
    guidata(hObject,handles);
    
    %if save    
    %    fNameSplit=strsplit(filename,'.');
    %    fNameFig=sprintf('%s_%s.fig',fNameSplit{1},datestr(clock,'yyyy-mm-dd_HHMMSS'));
    %    fNameTxt=sprintf('%s_%s.txt',fNameSplit{1},datestr(clock,'yyyy-mm-dd_HHMMSS'));
    %    file = fopen(fNameTxt,'w');
    %    if(strcmp(cOpt.contourType,'circle'))
    %        text = 'Gamma = %g\nAlpha = %s\nBeta = %s\nEpsilon = %g\ndeltaT = %g\nnumPts = %g\nRadius = %g\nx = %g y = %g\nFilter = %s\nfSize = %g';
    %        fprintf(file,text,eOpt.gamma,char(eOpt.alpha),char(eOpt.beta),iOpt.epsilon,iOpt.deltaT,cOpt.numPts,cOpt.radius,cOpt.x,cOpt.y,iOpt.filter,iOpt.fSize);
    %        fclose(file);
    %    elseif(strcmp(cOpt.contourType,'ellipse'))
    %        text = 'Gamma = %g\nAlpha = %s\nBeta = %s\nEpsilon = %g\ndeltaT = %g\nnumPts = %g\nx = %g y = %g\nh = %g k = %g\nFilter = %s\nfSize = %g';
    %        fprintf(file,text,eOpt.gamma,char(eOpt.alpha),char(eOpt.beta),iOpt.epsilon,iOpt.deltaT,cOpt.numPts,cOpt.x,cOpt.y,cOpt.h,cOpt.k,iOpt.filter,iOpt.fSize);
    %        fclose(file);
    %    end
    %    saveas(imgPlot,fNameFig);
    %end
    
    %set(h.finalC,'Data',result);
    %handles.plotFinal = ax;
    %guidata(hObject,handles);
    set(h.saveResult,'String','Figure Not Saved Yet');
    set(h.status,'String','Done!');
    set(h.status,'BackgroundColor','green');


function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double


% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit10_Callback(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit10 as text
%        str2double(get(hObject,'String')) returns contents of edit10 as a double


% --- Executes during object creation, after setting all properties.
function edit10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function gamma_Callback(hObject, eventdata, handles)
% hObject    handle to gamma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of gamma as text
%        str2double(get(hObject,'String')) returns contents of gamma as a double

% --- Executes during object creation, after setting all properties.
function gamma_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gamma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function alpha_Callback(hObject, eventdata, handles)
% hObject    handle to alpha (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of alpha as text
%        str2double(get(hObject,'String')) returns contents of alpha as a double

% --- Executes during object creation, after setting all properties.
function alpha_CreateFcn(hObject, eventdata, handles)
% hObject    handle to alpha (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit23_Callback(hObject, eventdata, handles)
% hObject    handle to edit23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit23 as text
%        str2double(get(hObject,'String')) returns contents of edit23 as a double


% --- Executes during object creation, after setting all properties.
function edit23_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit22_Callback(hObject, eventdata, handles)
% hObject    handle to edit22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit22 as text
%        str2double(get(hObject,'String')) returns contents of edit22 as a double


% --- Executes during object creation, after setting all properties.
function edit22_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit21_Callback(hObject, eventdata, handles)
% hObject    handle to edit21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit21 as text
%        str2double(get(hObject,'String')) returns contents of edit21 as a double


% --- Executes during object creation, after setting all properties.
function edit21_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function y_Callback(hObject, eventdata, handles)
% hObject    handle to y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of y as text
%        str2double(get(hObject,'String')) returns contents of y as a double

% --- Executes during object creation, after setting all properties.
function y_CreateFcn(hObject, eventdata, handles)
% hObject    handle to y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function x_Callback(hObject, eventdata, handles)
% hObject    handle to x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of x as text
%        str2double(get(hObject,'String')) returns contents of x as a double

x = str2double(get(hObject,'String'));


% --- Executes during object creation, after setting all properties.
function x_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit18_Callback(hObject, eventdata, handles)
% hObject    handle to numPts (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of numPts as text
%        str2double(get(hObject,'String')) returns contents of numPts as a double


% --- Executes during object creation, after setting all properties.
function edit18_CreateFcn(hObject, eventdata, handles)
% hObject    handle to numPts (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function radius_Callback(hObject, eventdata, handles)
% hObject    handle to radius (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of radius as text
%        str2double(get(hObject,'String')) returns contents of radius as a double


% --- Executes during object creation, after setting all properties.
function radius_CreateFcn(hObject, eventdata, handles)
% hObject    handle to radius (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit13_Callback(hObject, eventdata, handles)
% hObject    handle to alpha (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of alpha as text
%        str2double(get(hObject,'String')) returns contents of alpha as a double


% --- Executes during object creation, after setting all properties.
function edit13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to alpha (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit12_Callback(hObject, eventdata, handles)
% hObject    handle to gamma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of gamma as text
%        str2double(get(hObject,'String')) returns contents of gamma as a double


% --- Executes during object creation, after setting all properties.
function edit12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gamma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit14_Callback(hObject, eventdata, handles)
% hObject    handle to edit14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit14 as text
%        str2double(get(hObject,'String')) returns contents of edit14 as a double


% --- Executes during object creation, after setting all properties.
function edit14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit15_Callback(hObject, eventdata, handles)
% hObject    handle to edit15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit15 as text
%        str2double(get(hObject,'String')) returns contents of edit15 as a double


% --- Executes during object creation, after setting all properties.
function edit15_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit16_Callback(hObject, eventdata, handles)
% hObject    handle to edit16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit16 as text
%        str2double(get(hObject,'String')) returns contents of edit16 as a double


% --- Executes during object creation, after setting all properties.
function edit16_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in filter.
function filter_Callback(hObject, eventdata, handles)
% hObject    handle to filter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns filter contents as cell array
%        contents{get(hObject,'Value')} returns selected item from filter

% --- Executes during object creation, after setting all properties.
function filter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to filter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit25_Callback(hObject, eventdata, handles)
% hObject    handle to edit25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit25 as text
%        str2double(get(hObject,'String')) returns contents of edit25 as a double


% --- Executes during object creation, after setting all properties.
function edit25_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit24_Callback(hObject, eventdata, handles)
% hObject    handle to edit24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit24 as text
%        str2double(get(hObject,'String')) returns contents of edit24 as a double


% --- Executes during object creation, after setting all properties.
function edit24_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit30_Callback(hObject, eventdata, handles)
% hObject    handle to gamma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of gamma as text
%        str2double(get(hObject,'String')) returns contents of gamma as a double


% --- Executes during object creation, after setting all properties.
function edit30_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gamma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit29_Callback(hObject, eventdata, handles)
% hObject    handle to alpha (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of alpha as text
%        str2double(get(hObject,'String')) returns contents of alpha as a double


% --- Executes during object creation, after setting all properties.
function edit29_CreateFcn(hObject, eventdata, handles)
% hObject    handle to alpha (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function fSize_Callback(hObject, eventdata, handles)
% hObject    handle to fSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fSize as text
%        str2double(get(hObject,'String')) returns contents of fSize as a double

% --- Executes during object creation, after setting all properties.
function fSize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function beta_Callback(hObject, eventdata, handles)
% hObject    handle to beta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of beta as text
%        str2double(get(hObject,'String')) returns contents of beta as a double

% --- Executes during object creation, after setting all properties.
function beta_CreateFcn(hObject, eventdata, handles)
% hObject    handle to beta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function epsilon_CreateFcn(hObject, eventdata, handles)
% hObject    handle to beta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function deltaT_CreateFcn(hObject, eventdata, handles)
% hObject    handle to beta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in plotC1.
function plotC1_Callback(hObject, eventdata, handles)
% hObject    handle to plotC1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of plotC1

% --- Executes on button press in plotC2.
function plotC2_Callback(hObject, eventdata, handles)
% hObject    handle to plotC2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of plotC2

% --- Executes on button press in plotV.
function plotV_Callback(hObject, eventdata, handles)
% hObject    handle to plotV (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of plotV

    h = guihandles;
    
    fileN = get(h.filename,'String');
    if(isempty(fileN))
        return;
    end
    markerSize = str2double(get(h.markerSize,'String'));
    lineWidth = str2double(get(h.lineWidth,'String'));
    plotC1 = get(h.plotC1,'Value');
    plotC2 = get(h.plotC2,'Value');
    plotV = get(h.plotV,'Value');
    filename = get(h.filename,'String');
    
    if(handles.alreadyPlot)
        ax = findobj(gcf,'type','axes');
        hold off;
        Img=double(imread(filename));
        imshow(uint8(Img),'Parent',ax);
        handles.ax=ax;
        guidata(hObject,handles);
        hold(ax,'all');

        if plotC1 == true %Plot orginal contour
            plot(handles.result.cOriginal(:,2),handles.result.cOriginal(:,1),'-g*','MarkerSize',markerSize,'LineWidth',lineWidth,'Parent',ax);
        end
        if plotV == true %plotimg vector field
            [rows,cols,~]=size(imread(filename));
             [x,y] = meshgrid(1:cols,1:rows);
             u = handles.result.gradX;
             v = handles.result.gradY;
             quiver(x,y,u,v);
        end
        if plotC2 == true %Plot final contour
            [~,contours,~]=size(handles.result.c);
            for i = 1:contours
               plot(handles.result.c(1,i).y,handles.result.c(1,i).x,'-r*','MarkerSize',markerSize,'LineWidth',lineWidth,'Parent',ax); 
            end
        end
    end
    

function filename_Callback(hObject, eventdata, handles)
% hObject    handle to filename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of filename as text
%        str2double(get(hObject,'String')) returns contents of filename as a double


% --- Executes during object creation, after setting all properties.
function filename_CreateFcn(hObject, eventdata, handles)
% hObject    handle to filename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in browse.
function browse_Callback(hObject, eventdata, handles)
% hObject    handle to browse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    h = guihandles;
    [filename, pathname] = uigetfile({'*.bmp;*.jpg;*.png','Image Files (*.bmp,*.jpg,*.png)';'*.*','All Files (*.*)'},'File Selector');
    if filename
        [cols,rows,~]=size(imread(strcat(pathname,filename)));
        %if cols == rows
            set(h.x,'String',round(cols/2));
            set(h.y,'String',round(rows/2));
            set(h.radius,'String',round((min(cols,rows)/2)-4));
            set(h.h,'String',round(cols/2)-6);
            set(h.k,'String',round(rows/2)-6);
            set(h.filename,'String',strcat(pathname,filename));
            set(h.fName,'Title',filename);
        %else
        %    msgbox('Error! Please only use square images.');
        %end
        ax = findobj(gcf,'type','axes');
        handles.ax=ax;
        guidata(hObject,handles);
        hold off;
        Img=double(imread([pathname,filename]));
        imshow(uint8(Img),'Parent',handles.ax);
        handles.alreadyPlot = false;
        guidata(hObject,handles);
    end


% --- Executes on button press in save.
function save_Callback(hObject, eventdata, handles)
% hObject    handle to save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of save


% --- Executes when entered data in editable cell(s) in finalC.
function finalC_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to finalC (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
open('about.fig');

% --- Executes on selection change in contourType.
function contourType_Callback(hObject, eventdata, handles)
% hObject    handle to contourType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns contourType contents as cell array
%        contents{get(hObject,'Value')} returns selected item from contourType

    h = guihandles;

    contents = cellstr(get(h.contourType,'String'));
    contourType = contents{get(h.contourType,'Value')};
    
    if(strcmp(contourType,'ellipse'))
        set(h.rText,'visible','off');
        set(h.radius,'visible','off');
        set(h.h,'visible','on');
        set(h.k,'visible','on');
        set(h.wText,'visible','on');
        set(h.hText,'visible','on');
    elseif(strcmp(contourType,'circle'))
        set(h.rText,'visible','on');
        set(h.radius,'visible','on');
        set(h.h,'visible','off');
        set(h.k,'visible','off');
        set(h.wText,'visible','off');
        set(h.hText,'visible','off');
    end


% --- Executes during object creation, after setting all properties.
function contourType_CreateFcn(hObject, eventdata, handles)
% hObject    handle to contourType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function h_Callback(hObject, eventdata, handles)
% hObject    handle to h (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of h as text
%        str2double(get(hObject,'String')) returns contents of h as a double


% --- Executes during object creation, after setting all properties.
function h_CreateFcn(hObject, eventdata, handles)
% hObject    handle to h (see GCBO)
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


% --- Executes on button press in openFig.
function openFig_Callback(hObject, eventdata, handles)
% hObject    handle to openFig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    h = guihandles;
        
    fileN = get(h.filename,'String');
    if(isempty(fileN))
        msgbox('Please select a file.');
        return;
    end
    
    numPts = handles.numPts;
    gamma = handles.gamma;
    alpha = handles.alpha;
    beta = handles.beta;
    epsilon = handles.epsilon;
    deltaT = handles.deltaT;   
    fieldType = handles.fieldType;
    stopType = handles.stopType;
    fSize = handles.fSize;
    
    plotTitle=sprintf('numPts=%g alpha=%s beta=%s epsilon=%g gamma=%g deltaT=%g fieldType=%s fSize=%g stopType=%s',numPts,alpha,beta,epsilon,gamma,deltaT,fieldType,fSize,stopType);
    imgPlot = figure('Name',plotTitle,'NumberTitle','off');
    newAxis=axes('parent',imgPlot);
    axChildrenHandle=get(handles.ax,'Children');
    %ax = findobj(gca,'type','axes');
    %set(handles.ax,'Position',[0 0 1 1]);
    %copyobj(handles.ax,imgPlot);
    copyobj(axChildrenHandle,newAxis);
    
    [cols,rows,~]=size(imread(fileN));
    
    % Create a uicontrol of type "text"
    mTextBox = uicontrol('style','text');
    set(mTextBox,'String',plotTitle);

    set(mTextBox,'Units','characters')
    set(mTextBox,'Position',[0,0,120,1]);
    set(mTextBox,'HorizontalAlignment','left');
    
    set(imgPlot,'ToolBar','figure');
    
    set(newAxis,'DataAspectRatio',[1 1 1],'YDir','reverse','XTick',[],'XLim',[0,rows],'YTick',[],'YLim',[0,cols],'XTickLabel',[],'YTickLabel',[]);
    
    %refresh(imgPlot);
    
    

% --- Executes on selection change in stopType.
function stopType_Callback(hObject, eventdata, handles)
% hObject    handle to stopType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns stopType contents as cell array
%        contents{get(hObject,'Value')} returns selected item from stopType


% --- Executes during object creation, after setting all properties.
function stopType_CreateFcn(hObject, eventdata, handles)
% hObject    handle to stopType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in saveFig.
function saveFig_Callback(hObject, eventdata, handles)
% hObject    handle to saveFig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

    h = guihandles;
        
    fileN = get(h.filename,'String');
    if(isempty(fileN))
        msgbox('Please select a file.');
        return;
    end
        
    fileN = char(fileN);
    
    fNameSplit=strsplit(fileN,'.');
    fNameFig=sprintf('%s_%s.fig',fNameSplit{1},datestr(clock,'yyyy-mm-dd_HHMMSS'));
    fNameTxt=sprintf('%s_%s.txt',fNameSplit{1},datestr(clock,'yyyy-mm-dd_HHMMSS'));
    
    contourType = handles.contourType;
    numPts = handles.numPts;
    radius = handles.radius;
    x = handles.x;
    y = handles.y;
    width = handles.width;
    height = handles.height;
    gamma = handles.gamma;
    alpha = handles.alpha;
    beta = handles.beta;
    
    epsilon = handles.epsilon;
    deltaT = handles.deltaT;    
    fieldType = handles.fieldType;
    stopType = handles.stopType;
    fSize = handles.fSize;
    
    initVecInt = handles.result.integrals.initVecInt;
    initVecImg = handles.result.integrals.initIntImg;
    finalIntegral = handles.result.integrals.finalIntegral;
    finalIntegralImg = handles.result.integrals.finalIntegralImg;
    [~,contours,~]=size(handles.result.c);
    
    file = fopen(fNameTxt,'w');
    if(strcmp(contourType,'circle'))
        text = 'Gamma = %g\nAlpha = %s\nBeta = %s\nEpsilon = %g\ndeltaT = %g\nnumPts = %g\nRadius = %g\nx = %g y = %g\nfieldType = %s\nfSize = %g\nstopType=%s\nInit Vec Integral=%g\nFinal Vec Integral=%g\nInit Scalar Integral=%g\nFinal Scalar Integral=%g\n\nFinal Contour Points\n--------------------\n';
        fprintf(file,text,gamma,char(alpha),char(beta),epsilon,deltaT,numPts,radius,x,y,fieldType,fSize,stopType,initVecInt,finalIntegral,initVecImg,finalIntegralImg);
        for i = 1:contours
            fprintf(file,'\n%s %g \n','Contour ',i);
            for j=1:size(handles.result.c(1,i).x,2)
                finalCy = num2str(handles.result.c(1,i).y(j));
                finalCx = num2str(handles.result.c(1,i).x(j));
                fprintf(file,'%s %s \n',finalCx,finalCy);
            end
        end
        fclose(file);
    elseif(strcmp(contourType,'ellipse'))
        text = 'Gamma = %g \n Alpha = %s \n Beta = %s \n Epsilon = %g \n deltaT = %g \n numPts = %g \n x = %g y = %g \n h = %g k = %g \n fieldType = %s \n fSize = %g \n stopType=%s \n Init Vec Integral=%g \n Final Vec Integral=%g \n Init Scalar Integral=%g \n Final Scalar Integral=%g \n Final Contour Points \n ';
        fprintf(file,text,gamma,char(alpha),char(beta),epsilon,deltaT,numPts,x,y,width,height,fieldType,fSize,stopType,initVecInt,finalIntegral,initVecImg,finalIntegralImg);
        for i = 1:contours
            fprintf(file,'\n%s %g \n','Contour ',i);
            for j=1:size(handles.result.c(1,i).x,2)
                finalCy = num2str(handles.result.c(1,i).y(j));
                finalCx = num2str(handles.result.c(1,i).x(j));
                fprintf(file,'%s %s \n',finalCx,finalCy);
            end
        end
        fclose(file);
    end
    
    plotTitle=sprintf('numPts=%g alpha=%s beta=%s epsilon=%g gamma=%g deltaT=%g fieldType=%s fSize=%g stopType=%s',numPts,alpha,beta,epsilon,gamma,deltaT,fieldType,fSize,stopType);
    imgPlot = figure('Name',plotTitle,'NumberTitle','off');
    set(imgPlot,'Visible','on');
    newAxis=axes('parent',imgPlot);
    axChildrenHandle=get(handles.ax,'Children');
    copyobj(axChildrenHandle,newAxis);
    [cols,rows,~]=size(imread(fileN));
    
    % Create a uicontrol of type "text"
    mTextBox = uicontrol('style','text');
    set(mTextBox,'String',plotTitle);

    set(mTextBox,'Units','characters')
    set(mTextBox,'Position',[0,0,120,1]);
    set(mTextBox,'HorizontalAlignment','left');
    
    set(imgPlot,'ToolBar','figure');
    
    set(newAxis,'DataAspectRatio',[1 1 1],'YDir','reverse','XTick',[],'XLim',[0,rows],'YTick',[],'YLim',[0,cols],'XTickLabel',[],'YTickLabel',[]);
    saveas(imgPlot,fNameFig);
    set(imgPlot,'Visible','off');
    
    msg = sprintf('Saved to: %s.\n               %s.',fNameFig,fNameTxt);
    set(h.saveResult,'String',msg);



function lineWidth_Callback(hObject, eventdata, handles)
% hObject    handle to lineWidth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of lineWidth as text
%        str2double(get(hObject,'String')) returns contents of lineWidth as a double


% --- Executes during object creation, after setting all properties.
function lineWidth_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lineWidth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function markerSize_Callback(hObject, eventdata, handles)
% hObject    handle to markerSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of markerSize as text
%        str2double(get(hObject,'String')) returns contents of markerSize as a double


% --- Executes during object creation, after setting all properties.
function markerSize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to markerSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on pushbutton3 and none of its controls.
function pushbutton3_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over pushbutton3.
function pushbutton3_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in split.
function split_Callback(hObject, eventdata, handles)
% hObject    handle to split (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of split


% --- Executes during object creation, after setting all properties.
function axes3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes3


% --- Executes on button press in split_dist.
function split_dist_Callback(hObject, eventdata, handles)
% hObject    handle to split_dist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of split_dist



function dist_Callback(hObject, eventdata, handles)
% hObject    handle to dist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dist as text
%        str2double(get(hObject,'String')) returns contents of dist as a double


% --- Executes during object creation, after setting all properties.
function dist_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in connect.
function connect_Callback(hObject, eventdata, handles)
% hObject    handle to connect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of connect


% --- Executes on button press in poisson_sol.
function poisson_sol_Callback(hObject, eventdata, handles)
% hObject    handle to poisson_sol (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    try
        pot = handles.potential;
    catch err
        pot = '';
    end
    
    if(isempty(pot))
        return;
    end
    
    potPlot = figure('Name','Poisson Solution','NumberTitle','off');
    potAxes = axes('Parent',potPlot);
    imshow(uint8(pot),'Parent',potAxes);
