function testLoadCompumedicsAnnotationsClass
%testLoadCompumedicsAnnotations Load compumedics annotations
%   load compumedics annotations file. Expanded class form of PhysioMiMi
%   loader
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This file is part of the EDFViewer, Physio-MIMI Application tools
%
% EDFViewer is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
%
% EDFViewer is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with Foobar.  If not, see <http://www.gnu.org/licenses/>.
%
% Copyright 2010, Case Western Reserve University
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Function includes modifications added in Boston.  The modifications are
% designed to make it easier to analyst to perform signal processing
% applications.
%
% Revisions:
%   2013 09 25: Added flag to turn off scoring transformation,which might
%               be needed to GUI applications.
%---------------------------------------------- 
% Version: 0.1.04
% ---------------------------------------------
% Dennis A. Dean, II, Ph.D
%
% Program for Sleep and Cardiovascular Medicine
% Brigam and Women's Hospital
% Harvard Medical School
% 221 Longwood Ave
% Boston, MA  02149
%
% File created: November 14, 2013
% Last update:  May 5, 2014 
%    
% Copyright © [2013] The Brigham and Women's Hospital, Inc. THE BRIGHAM AND 
% WOMEN'S HOSPITAL, INC. AND ITS AGENTS RETAIN ALL RIGHTS TO THIS SOFTWARE 
% AND ARE MAKING THE SOFTWARE AVAILABLE ONLY FOR SCIENTIFIC RESEARCH 
% PURPOSES. THE SOFTWARE SHALL NOT BE USED FOR ANY OTHER PURPOSES, AND IS
% BEING MADE AVAILABLE WITHOUT WARRANTY OF ANY KIND, EXPRESSED OR IMPLIED, 
% INCLUDING BUT NOT LIMITED TO IMPLIED WARRANTIES OF MERCHANTABILITY AND 
% FITNESS FOR A PARTICULAR PURPOSE. THE BRIGHAM AND WOMEN'S HOSPITAL, INC. 
% AND ITS AGENTS SHALL NOT BE LIABLE FOR ANY CLAIMS, LIABILITIES, OR LOSSES 
% RELATING TO OR ARISING FROM ANY USE OF THIS SOFTWARE.
%

% Test Files
xmlFn1 = '20017.edf.XML';                 % SOF data file

% Test flags
RUN_TEST_1 =  1;   % Load and export scored events
RUN_TEST_2 =  1;   % Plot hypnograms and return dependent properties 
RUN_TEST_3 =  1;   % Probe XML structure and contents with dependendent variables

% ------------------------------------------------------------------ Test 1
% Test 1: load compumedics file
if RUN_TEST_1 == 1
    % Write test results to console
    fprintf('------------------------------- Test 1\n\n');
    fprintf('Load compumedics file\n\n');
    
    % Create class and load file
    lcaObj = loadCompumedicsAnnotationsClass(xmlFn1);
    lcaObj = lcaObj.loadFile;
    
    ScoredEvent = lcaObj.ScoredEvent;
    SleepStages = lcaObj.SleepStages;
    EpochLength = lcaObj.EpochLength;
        
    numScoredEvents = length(ScoredEvent);
   
    % Echo basic info.
    fprintf('Number of scored events = %0.0f\n',numScoredEvents);
    fprintf('Number of epochs = %0.0f\n',length(SleepStages));
    fprintf('Epoch length = %0.0f\n', EpochLength);
    
    % Convert Structure to Cell Array
    eventFields = fieldnames(ScoredEvent)';
    numFields = length(eventFields);
    eventCell = cell(numScoredEvents+1, numFields);
    eventCell(1,:) = eventFields;
    for e = 1:numScoredEvents
       eventCell(e+1,:) = struct2cell(ScoredEvent(e))';
    end
    
    % Write scored events to xls file
    xlswrite('20017.Scored.Events.xls',eventCell);
    
end
% ------------------------------------------------------------------ Test 2
% Test 2: Add GrassLoaderFunctionality
if RUN_TEST_2 == 1
    % Write test results to console
    fprintf('------------------------------- Test 2\n\n');
    fprintf('Load compumedics file (CHAT)\n\n');
    
    % Score Assoications
    scoreKey = { ...
        { 'Awake' ,      0,  'W'}; ...
        { '1' ,          1,  '1'}; ...
        { '2' ,          2,  '2'}; ...
        { '3' ,          3,  '3'}; ...
        { '4' ,          4,  '4'}; ...
        { 'REM' ,        5,  'R'}; ...
    };
    figPosition =[-1919, 1, 1920, 1004];    
    
    % Create class and load file
    lcaObj = loadCompumedicsAnnotationsClass(xmlFn1);
    lcaObj.scoreKey = scoreKey;
    lcaObj = lcaObj.loadFile;
    
    ScoredEvent = lcaObj.ScoredEvent;
    SleepStages = lcaObj.SleepStages;
    EpochLength = lcaObj.EpochLength;
        
    % Grass Loader Terms
    uniqueStageText = lcaObj.uniqueStageText;
    numericHypnogram = lcaObj.numericHypnogram;
    characterHypnogram = lcaObj.characterHypnogram;
    normalizeHyp = lcaObj.normalizeHyp;
    numHypDist = lcaObj.numHypDist;
    
    % Create Figures
    lcaObj = lcaObj.plotHypnogram(figPosition);
    lcaObj = lcaObj.plotHypnogramWithDist(figPosition);
    
end
% ------------------------------------------------------------------ Test 3
% Test 3: Probe XML contents
if RUN_TEST_3 == 1
    % Write test results to console
    fprintf('------------------------------- Test 3\n\n');
    fprintf('Probe XML contents\n\n');
    
    % Score Assoications
    scoreKey = { ...
        { 'Awake' ,      0,  'W'}; ...
        { '1' ,          1,  '1'}; ...
        { '2' ,          2,  '2'}; ...
        { '3' ,          3,  '3'}; ...
        { '4' ,          4,  '4'}; ...
        { 'REM' ,        5,  'R'}; ...
    };
    figPosition =[-1919, 1, 1920, 1004];        

    % Create class and load file
    lcaObj = loadCompumedicsAnnotationsClass(xmlFn1);
    lcaObj.scoreKey = scoreKey;
    
    
    % Get File Structure
    lcaObj = lcaObj.loadXmlStruct;
    
    % Get File Information
    lcaObj = lcaObj.loadFile;
    
    % Get event information
    EventTypes = lcaObj.xmlEntries;
    ScoredEvent = lcaObj.ScoredEvent;
    SleepStages = lcaObj.SleepStages;
    EpochLength = lcaObj.EpochLength;
    
    % Get detailed event information
    EventList = lcaObj.EventList;
    EventTypes = lcaObj.EventTypes;
    EventStart = lcaObj.EventStart;  
    
    % Get arousal start time
    arousalLabel = EventTypes{1};
    arousalStart = ...
        lcaObj.GetEventTimes(arousalLabel, EventList, EventStart);
       
    % Grass Loader Terms
    uniqueStageText = lcaObj.uniqueStageText;
    numericHypnogram = lcaObj.numericHypnogram;
    characterHypnogram = lcaObj.characterHypnogram;
    normalizeHyp = lcaObj.normalizeHyp;
    numHypDist = lcaObj.numHypDist;
    
    % Create Figures
    lcaObj = lcaObj.plotHypnogram(figPosition);
    lcaObj = lcaObj.plotHypnogramWithDist(figPosition);
    
end
end

