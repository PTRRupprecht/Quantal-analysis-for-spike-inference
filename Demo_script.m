%% Apply GMM to example traces of GCaMP8 recordings to extract the unitary amplitude

% add folder with dependent functions to path
addpath('helper scripts')

% define example data -
% the mat-file contains the dF/F trace ("calcium", not
% used in the script) and the associated inferred spike rate ("spike_rates")
example_data_path = 'example data\CAttached_jGCaMP8s_479572_9_mini.mat';

% define properties of the CASCADE model
imaging_rate = 30; % in Hz
smoothing = 0.05; % in second

% different modes of rescaling based on unitary amplitude, as described in the paper
rescaling_mode = 'divisive'; % 'divisive' or 'subtractive'

% show results - 
% top: quantal analysis with histogram with Gaussian mixture model fit
% bottom: mean value of the first four components of the quantal analysis
show_plot = true;

% run quantal analysis on the selected recording
[unitary_amplitude, spike_rates,spike_rates_rescaled] = Quantal_analysis_spike_rate(example_data_path,imaging_rate,smoothing,rescaling_mode,show_plot);





