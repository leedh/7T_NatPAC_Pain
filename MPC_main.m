clc;
clear;
close all;

%% SETTTING
addpath(genpath(pwd));
PATH = getenv('PATH');
%setenv('PATH', [PATH ':/Users/sungwoo320/anaconda3/bin:/Users/sungwoo320/anaconda3/condabin']); %For biopack, you need to add your python3 path
setenv('PATH', [PATH ':/Library/Frameworks/Python.framework/Versions/3.7/bin']);

basedir = pwd;
expt_param.Run_name = 'movie';
expt_param.Run_Num = 003;
expt_param.screen_mode = 'Testmode'; %{'Testmode','Full'}
expt_param.eyelink_filename = 'F_NAME'; % Eyelink file name should be equal or less than 8

expt_param.Pathway = false;
expt_param.USE_BIOPAC = false;
expt_param.USE_EYELINK = false;
expt_param.dofmri = false;

%expt_param.heat_intensity_table = [43, 44, 45, 46, 47, 48]; % stimulus intensity
expt_param.heat_intensity_table = [44.5, 45.5, 46.5, 47.5]; % stimulus intensity
expt_param.moviefile = fullfile(pwd, '/Video/2222.mp4');
expt_param.movie_duration = 20;
expt_param.caps_duration = 90;
expt_param.resting_duration = 90;

expt_param.Trial_nums = 16;
expt_param.run_type = {'resting'}; % {'no_movie_heat', 'movie_heat', 'caps', 'resting'}


%% SETTING
% or, you can load pre-determined information 
global ip port
ip = '192.168.0.2'; %ip = '115.145.189.133'; %ip = '203.252.54.21';
port = 20121;


%% Start experiment
data = MPC_data_save(expt_param, basedir);
data.expt_param = expt_param;
data.dat.experiment_start_time = GetSecs; 

screen_param = MPC_setscreen(expt_param);

MPC_explain(screen_param);

MPC_practice(screen_param);

data = MPC_run(screen_param, expt_param, data);
  
data = MPC_close(screen_param, data);