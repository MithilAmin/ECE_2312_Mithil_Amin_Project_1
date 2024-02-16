%% Code Start

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% File Name: ECE_2312_Project1_Mithil_Amin
% By: Mithil Amin, WPI'25, ECE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Section End

%% Setting the stage
clear all
clc

obj1 = myFunctions1;

% Section End

%% Variables
Fs = 44000;
nBits = 8;
nChannels = 1;
ID = 0;
recDuration = 5;

%      >> Variable Info <<
% 
% Fs          = stores the initial sampling rate for this program
% nBits       = bitrate
% nChannels   = number of channels
% ID          = device identifier
% recDuration = duration for recording

% Section End

%% Lines

% These are the lines to be display as Plot/Spectrogram titles and
% displayed when recording.
line_1 = "The quick brown fox jumps over the lazy dog";
line_2 = "We promptly judged antique ivory buckles for the next prize";
line_3 = "Crazy Fredrick bought many very exquisite opal jewels";

% These are the lines with .wav extension
L1 = "The quick brown fox jumps over the lazy dog.wav";
L2 = "We promptly judged antique ivory buckles for the next prize.wav";
L3 = "Crazy Fredrick bought many very exquisite opal jewels.wav";

% Section End

%% Recording lines

disp("Let's Record audio for three sentences.")
obj1.dot_delay();

record = audiorecorder(Fs,nBits,nChannels,ID);

% record audio 1
    disp(line_1)
    pause(1)
    disp("Begin speaking.")
    recordblocking(record,recDuration);
    disp("End of recording.")
    y1_rec = getaudiodata(record);

% record audio 2
    disp(line_2)
    pause(1)
    disp("Begin speaking.")
    recordblocking(record,recDuration);
    disp("End of recording.")
    y2_rec = getaudiodata(record);

% record audio 3
    disp(line_3)
    pause(1)
    disp("Begin speaking.")
    recordblocking(record,recDuration);
    disp("End of recording.")
    y3_rec = getaudiodata(record);

%{
We now have following data:
    - Three files with our audio recording stored in.
    - We have the original audio data from the three recording stored in y<n>_rec
    - We also have audio data from the recording files stored in y<n>_wav
    - We have changed the data stored in line_1, line_2, line_3 to include
    .wav in the end. this way we can call the data stored in those three
    files.
%}

% Section End

%% Plotting Audio Recording

% Plot line_1 with the original recording
    figure(1)
    grid on;
    plot(y1_rec);
    title(line_1)

    % Lable
    xlabel("Time")
    ylabel("Amplitude")
    
    % Limiting x and y axis
    xlim("tight")
    ylim([-1 1])
    
    grid off;


% Plot line_2 with the original recording
    figure(2)
    grid on;
    plot(y2_rec);
    title(line_2)

    % Lable
    xlabel("Time")
    ylabel("Amplitude")

    % Limiting x and y axis
    xlim("tight")
    ylim([-1 1])
    grid off;


% Plot line_3 with the original recording
    figure(3)
    grid on;
    plot(y3_rec);
    title(line_3)

    % Lable
    xlabel("Time")
    ylabel("Amplitude")

    % Limiting x and y axis
    xlim("tight")
    ylim([-1 1])
    grid off;

% Section End
%% Spectogram of Audio Recording

figure(4)
spectrogram(y1_rec, 200, [], Fs, 16000, 'yaxis');
title(line_1)

figure(5)
spectrogram(y2_rec, 200, [], Fs, 16000, 'yaxis');
title(line_2)

figure(6)
spectrogram(y3_rec, 200, [], Fs, 16000, 'yaxis');
title(line_3)


% Section End

%% Storing Audio in .wav files before calling it

% Here we use audiowrite() function to store audio in respective .wav files
audiowrite(L1, y1_rec, Fs);
audiowrite(L2, y2_rec, Fs);
audiowrite(L3, y3_rec, Fs);

% Here we read those files so we have the data from wav files
[y1_wav,Fs1_wav] = audioread(L1);
[y2_wav,Fs2_wav] = audioread(L2);
[y3_wav,Fs3_wav] = audioread(L3);

% Section End

%% Spectrogram of Recorded Audio

figure(7)
spectrogram(y1_wav, 200, [], Fs1_wav, 16000, 'yaxis');
title(line_1)

figure(8)
spectrogram(y2_wav, 200, [], Fs2_wav, 16000, 'yaxis');
title(line_2)

figure(9)
spectrogram(y3_wav, 200, [], Fs3_wav, 16000, 'yaxis');
title(line_3)

% Section End

%% Section Break
% At this point in the code, we have already accomplished all tasks up
% until Saving and loading WAV files and comparing the spectrograms with
% raw data obtained from getaudiodata(record) function. In order to
% accomplish these tasks we have worked with mono audio.
%
% We will now "Have fun with stereo speech files" where we deal with dual
% channel audio.

% Section End

%% Stereo Audio Delay

% We have our sampling rate at 44000 Hz.
c = 343; % This is our speed of sound in m/s

% This project only has 1 team member. The ear-to-ear distance found was
% 16cm or 0.16m
s = 0.16; % This is our distance in meters

delay = s/c; % We now have our delay in seconds.
delay = delay*1000; % This gives is our delay in milliseconds as required

% We know we have a sampling rate of Fs(or 44000) samples per second or 44
% samples per millisecond (44000/1000 = 44)
% Thus for number of samples delayed in "delay" milliseconds is:
sample_delay = ceil(Fs*delay/1000);

% With a single team member, the average will be:
ave_sample_delay = sample_delay/1;

% For this part lets take line_1

y1 = y1_wav;

Stereo = y1(:, [1 1]);

% Now lets store this Stereo (2 channel) audio in .WAV file
LINE_0ms = "team[]-stereosoundfile-[0ms].wav";
audiowrite(LINE_0ms, Stereo, Fs);


% Now lets start with actual delaying of sound
LINE_ave = "team[]-stereosoundfile-[ave_sample_delay].wav";
obj1.stereo_delay(Stereo, ave_sample_delay, Fs, LINE_ave);


% Delay of 1ms
LINE_1ms = "team[]-stereosoundfile-[1ms].wav";
delay_1 = ceil(Fs*1/1000);
obj1.stereo_delay(Stereo, delay_1, Fs, LINE_1ms);


% Delay of 10ms
LINE_10ms = "team[]-stereosoundfile-[10ms].wav";
delay_10 = ceil(Fs*10/1000);
obj1.stereo_delay(Stereo, delay_10, Fs, LINE_10ms);


% Delay of 100ms
LINE_100ms = "team[]-stereosoundfile-[100ms].wav";
delay_100 = ceil(Fs*100/1000);
obj1.stereo_delay(Stereo, delay_100, Fs, LINE_100ms);

% Section End

%% Stereo Audio Attenuation

% We know to attenuate one of the columns of the audio signal, we need to
% multiply that column with a specific gain value.


% For 0ms delay
LINE_0ms_15 = "team[]-stereosoundfile-[0ms]-[-1.5].wav";
gain = 0.75;
obj1.stereo_attenuation(Stereo, 0, Fs, LINE_0ms_15, gain);

LINE_0ms_3 = "team[]-stereosoundfile-[0ms]-[-3].wav";
gain = 0.5;
obj1.stereo_attenuation(Stereo, 0, Fs, LINE_0ms_3, gain);

LINE_0ms_6 = "team[]-stereosoundfile-[0ms]-[-6].wav";
gain = 0.25;
obj1.stereo_attenuation(Stereo, 0, Fs, LINE_0ms_6, gain);


% For ave_sample_delay
LINE_ave_15 = "team[]-stereosoundfile-[ave_sample_delay]-[-1.5].wav";
gain = 0.75;
obj1.stereo_attenuation(Stereo, ave_sample_delay, Fs, LINE_ave_15, gain);

LINE_ave_3 = "team[]-stereosoundfile-[ave_sample_delay]-[-3].wav";
gain = 0.5;
obj1.stereo_attenuation(Stereo, ave_sample_delay, Fs, LINE_ave_3, gain);

LINE_ave_6 = "team[]-stereosoundfile-[ave_sample_delay]-[-6].wav";
gain = 0.25;
obj1.stereo_attenuation(Stereo, ave_sample_delay, Fs, LINE_ave_6, gain);

% Section End

%% Code End