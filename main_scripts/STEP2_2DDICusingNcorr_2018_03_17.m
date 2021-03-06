%% STEP 2: Run Ncorr analysis on sets of images from a pair of 2 cameras using Ncorr
% The complete set of 2n images includes 2 sets of images taken simultaneously
% from 2 cameras (2 views). The first n images are from the "reference"
% camera and the last n are the "deformed" camera. It's not really
% important which one is defined as Ref and Def, as long as it's
% consistent. The 1st image from the 1st camera is always defined as the reference
% image.

clearvars; close all

fs=get(0, 'DefaultUIControlFontSize');
set(0, 'DefaultUIControlFontSize', 10);

%% CHOOSE PATHS OPTIONS
% initial image path
folderPathInitial=pwd;

% select the folder containing the analysis images (if imagePathInitial=[] then the initial path is the current path)
folderPathRef=uigetdir(folderPathInitial,'Select the folder containing images from the reference camera');
folderPathInitial2 = strsplit(folderPathRef,'\');
folderPathInitial2 = strjoin(folderPathInitial2(1:end-1),'\');
folderPathDef=uigetdir(folderPathInitial2,'Select the folder containing images from the "deformed"fe camera');
folderPaths=cell(1,2);
folderPaths{1}=folderPathRef;
folderPaths{2}=folderPathDef;

% camera indeces for current analysis  
folderNameCell=strsplit(folderPaths{1},'\');
folderNameStr=folderNameCell{end};
nCamRef=str2double(folderNameStr);
folderNameCell=strsplit(folderPaths{2},'\');
folderNameStr=folderNameCell{end};
nCamDef=str2double(folderNameStr);

% save 2D-DIC results? choose save path
[save2DDIClogic,savePath]=Qsave2DDICresults(folderPaths);

% create folder for processed images and warn for overwriting
if save2DDIClogic
    processedImagePath=[savePath '\processedImages'];
    warning('off','MATLAB:MKDIR:DirectoryExists');
    mkdir(processedImagePath);
else
    processedImagePath=[];
end

%% create structure for saving the 2DDIC results
DIC2DpairResults = struct;

DIC2DpairResults.nCamRef=nCamRef;
DIC2DpairResults.nCamDef=nCamDef;

%%  load images from the paths, convert to gray and undistort, and create IMset cell for Ncorr
h=msgbox({'Please wait while loading images'});
[ImPaths,ImSet]=createDICimageSet(folderPaths,processedImagePath);
DIC2DpairResults.nImages=numel(ImPaths)/2;
DIC2DpairResults.ImPaths=ImPaths;
if isvalid(h)
    close(h);
end
%% animate the 2 sets of images to be correlated with Ncorr
hf1=anim8_DIC_images(ImPaths,ImSet);
pause

%% choose ROI
% This is a GUI for choosing the ROI instead of choosing the ROI in the
% NCorr softwhere (too small). It also allows the assistance of SIFT
% matches (it helps locating the overlapping region, but is time costly)
set(0, 'DefaultUIControlFontSize', 10);
chooseMaskButton = questdlg('Create new mask for correlation, use saved mask, or use Ncorr to draw mask?', 'mask options?', 'New', 'Saved','Ncorr', 'New'); % existing mask should be in savePath
switch chooseMaskButton
    case 'New'
        nROI=1;
        % input box to select number of ROIs (comment out the next two
        % lines to use the above default without having to click the box
        answer=inputdlg('Enter the number of ROIs','Enter the number of ROIs',1,{'1'});
        nROI=str2double(answer{1});        

        ROImask = selectROI(ImPaths,nROI);
        
        if save2DDIClogic
            % save image mask
            % The format is ROIMask_C01_C02, where 01 is the reference camera of the pair, and 02 is the "deformed" camera of the pair.
            save([savePath '\ROIMask' '_C_' num2str(nCamRef) '_C_' num2str(nCamDef)],'ROImask');
        end
        DIC2DpairResults.ROImask=ROImask;
    case 'Saved'
        if save2DDIClogic
            PathInitial=[savePath '\ROIMask' '_C_' num2str(nCamRef) '_C_' num2str(nCamDef)];
        else
            PathInitial=folderPathInitial;
        end
        [FileName,PathName,~] = uigetfile('','Select ROI file',PathInitial);
        load([PathName FileName]);
        DIC2DpairResults.ROImask=ROImask;
    case 'Ncorr'
end

h=msgbox({'Please wait while initializing Ncorr'; ''; 'Press enter in the command window when'; 'Ncorr analysis is finished (without closing Ncorr)'});

%% Start Ncorr 2D analysis
% open Ncorr
handles_ncorr = ncorr;
% set reference image
handles_ncorr.set_ref(ImSet{1});
% set current image
handles_ncorr.set_cur(ImSet);
% set ROI (skip this step if you want to select the ROI in Ncorr)
if ~strcmp(chooseMaskButton,'Ncorr')
    handles_ncorr.set_roi_ref(ROImask);
end

% Set analysis in Ncorr and wait
disp('Press enter in the command window when Ncorr analysis is finished (without closing Ncorr)');
pause

%% Extract results from Ncorr and calculate correlated image points, correlation coefficients, faces and face colors
[Points,CorCoeffVec,F,CF] = extractNcorrResults(handles_ncorr,ImSet{1});
DIC2DpairResults.ncorrInfo=handles_ncorr.data_dic.dispinfo;
DIC2DpairResults.Points=Points;
DIC2DpairResults.CorCoeffVec=CorCoeffVec;
DIC2DpairResults.Faces=F;
DIC2DpairResults.FaceColors=CF;
if ~strcmp(chooseMaskButton,'Ncorr')
    DIC2DpairResults.ROImask=handles_ncorr.reference.roi.mask;
end

%% save important variables for further analysis (write text files of correlated 2D points, their cirrelation coefficients, triangular faces, and face colors
if save2DDIClogic
    save([savePath '\DIC2DpairResults_C_' num2str(nCamRef) '_C_' num2str(nCamDef)] ,'DIC2DpairResults');
end

%% plot?
set(0, 'DefaultUIControlFontSize', 10);
plotButton = questdlg('Plot correlated points on images?', 'Plot?', 'Yes', 'No', 'Yes');
switch plotButton
    case 'Yes'
        plotNcorrPairResults(DIC2DpairResults);
    case 'No'
end

%% close Ncorr figure
close(handles_ncorr.handles_gui.figure);
if isvalid(h)
    close(h);
end
close(hf1);

%% finish
hm=msgbox(['STEP2 for the camera pair [' num2str([nCamRef nCamDef]) '] is completed']);

set(0, 'DefaultUIControlFontSize', fs);

