function MPC_practice_heat(screen_param, expt_param)
%% Assign variables

global ip port;

font = screen_param.window_info.font ;
fontsize = screen_param.window_info.fontsize;
theWindow = screen_param.window_info.theWindow;
window_num = screen_param.window_info.window_num ;
window_rect = screen_param.window_info.window_rect;
H = screen_param.window_info.H ;
W = screen_param.window_info.W;

lb1 = screen_param.line_parameters.lb1 ;
lb2 = screen_param.line_parameters.lb2 ;
rb1 = screen_param.line_parameters.rb1;
rb2 = screen_param.line_parameters.rb2;
scale_H = screen_param.line_parameters.scale_H ;
scale_W = screen_param.line_parameters.scale_W;
anchor_lms = screen_param.line_parameters.anchor_lms;

bgcolor = screen_param.color_values.bgcolor;
orange = screen_param.color_values.orange;
red = screen_param.color_values.red;
white = screen_param.color_values.white;   


%%

max_heat = max(expt_param.heat_intensity_table);


PathPrg = load_PathProgram('MPC');
index = find([PathPrg{:,1}] == max_heat);
max_heat_program = PathPrg{index, 4};


% -------------Setting Pathway------------------
if expt_param.Pathway
    main(ip,port,1, max_heat_program);     % program: 47.5 degree (MPC)
end
WaitSecs(2) %waitsec_fromstarttime(GetSecs, wait_pre_state-2) 

% -------------Ready for Pathway------------------
if expt_param.Pathway
    main(ip,port,2); %ready to pre-start
end
WaitSecs(2) % waitsec_fromstarttime(data.dat.trial_starttime(Trial_num), wait_pre_state) % Because of wait_pathway_setup-2, this will be 2 seconds

Screen('Flip', theWindow);

% Heat pain stimulus
if ~expt_param.Pathway
    Screen(theWindow, 'FillRect', bgcolor, window_rect);
    DrawFormattedText(theWindow, double(num2str(max_heat)), 'center', 'center', white, [], [], [], 1.2);
    Screen('Flip', theWindow);
end

% ------------- start to trigger thermal stimulus------------------
if expt_param.Pathway
    Screen(theWindow, 'FillRect', bgcolor, window_rect);
    Screen('TextSize', theWindow, 60);
    DrawFormattedText(theWindow, double('+'), 'center', 'center', white, [], [], [], 1.2);
    Screen('Flip', theWindow);
    Screen('TextSize', theWindow, fontsize);
    main(ip,port,2);
end


end