function varargout = ShanoGUI(varargin)
% SHANOGUI MATLAB code for ShanoGUI.fig
%      SHANOGUI, by itself, creates a new SHANOGUI or raises the existing
%      singleton*.
%
%      H = SHANOGUI returns the handle to a new SHANOGUI or the handle to
%      the existing singleton*.
%
%      SHANOGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SHANOGUI.M with the given input arguments.
%
%      SHANOGUI('Property','Value',...) creates a new SHANOGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ShanoGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ShanoGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ShanoGUI

% Last Modified by GUIDE v2.5 27-Sep-2016 21:43:53

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ShanoGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @ShanoGUI_OutputFcn, ...
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


% --- Executes just before ShanoGUI is made visible.
function ShanoGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ShanoGUI (see VARARGIN)

% Choose default command line output for ShanoGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ShanoGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ShanoGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function entry_word_Callback(hObject, eventdata, handles)
% hObject    handle to entry_word (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of entry_word as text
%        str2double(get(hObject,'String')) returns contents of entry_word as a double


% --- Executes during object creation, after setting all properties.
function entry_word_CreateFcn(hObject, eventdata, handles)
% hObject    handle to entry_word (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in shannFano.
function shannFano_Callback(hObject, eventdata, handles)
% hObject    handle to shannFano (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Shannon-Fannon Algorithm
clc
message = get(handles.entry_word,'string')
n = length(message);

symbols = unique(message)       %Includes white spacing
probabilities = zeros(1,length(symbols));

%Creates array of binary codes for each probability
codes = cell([length(probabilities) 1]);
codes{1}='';
total_probability = 0;
i = 1;

%--------------------------------------------------------------------------
%Calculates probabilities for each symbol
for symbol = symbols
     indexes = find(message == symbol);
     ocurrence = length(message(indexes));
     format short;
     probabilities(i) =  ocurrence/n;
     i = i + 1;
end
 probabilities = reshape(probabilities,[],1)
 probabilities = num2cell(probabilities)
 symbols = reshape(symbols,[],1);
 psymbols = [probabilities num2cell(symbols)];
 psymbols = sortrows(psymbols,-1);

results = [psymbols codes];

%ShannonFano Algorithm
SF = shanonfano(results)

set(handles.results_table,'data',SF);

result_word = ''
for symbol = message
 for i = 1:length(results)
     if symbol ==cell2mat(results(i,2))
        result_word = strcat(result_word, SF(i,3));
        break;
     end
 end
end
results_word = cell2mat(result_word)
bits = length(cell2mat(result_word))

set(handles.results_word,'string',results_word);

set(handles.number_bits,'string',bits);
