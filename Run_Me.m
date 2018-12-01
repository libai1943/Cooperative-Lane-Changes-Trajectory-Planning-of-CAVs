% ==============================================================================
% MATLAB Source Codes for "Cooperative Lane Change Motion Planning of Connected and Automated Vehicles: A Stepwise Computational Framework". 

% ==============================================================================

%   Copyright (C) 2018 Bai Li
%   Useers MUST cite the following article when utilizing these source codes to produce new contributions. 
%   Bai Li, Yue Zhang, Youmin Zhang, and Ning Jia, "Cooperative Lane Change Motion Planning of Connected
%   and Automated Vehicles: A Stepwise Computational Framework", 2018 IEEE
%   Intelligent Vehicles Symposium (IV'18), accepted.

% ==============================================================================

% If there are inquiries, feel free to contact libai@zju.edu.cn

% ==============================================================================
clear all
close all
clc

Nfe = 20; % This is a fixed parameter related to the number of finite elements in OCDT, should not change.

% Execution of Algorithm 1 (approximately takes 3000 seconds)
tic
CPU_time_recorder = zeros(1,(Nfe+1));
step_1;

CPU_time_recorder(1) = toc;
for iiiiii = [1 : 4 : (Nfe-1), Nfe]
    delete('libai');
    fid = fopen('libai', 'w');
    fprintf(fid,'1 %g;', iiiiii);
    fclose(fid);
    step_2_to_21;
    CPU_time_recorder(iiiiii+1) = toc;
end



figure (1)
video_generation

figure (2)
figure_generation

figure (3)
ind = find(CPU_time_recorder > 0);
plot(ind,CPU_time_recorder(ind),'-+')
axis tight
xlabel('Sub-problem Number');
ylabel('CPU Time / sec')