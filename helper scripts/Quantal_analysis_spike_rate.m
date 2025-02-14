function [unitary_amplitude, spike_rates,spike_rates_rescaled]  = quantal_analysis_spike_rate(example_data_path,imaging_rate,smoothing,rescaling_mode,show_plot)

    %% Load example data, containing a raw dF/F trace ("calcium") and the spike rate inferred with CASCADE ("spike_rates")
    
    load(example_data_path);
    
    %% Determine the threshold for event detection; the threshold is based on the expected shape of an inferred single action potential
    
    % Create a single spike
    single_spike = zeros(1, 1001);
    single_spike(501) = 1;
    
    % Convert smoothing to standard deviation in samples
    sigma = smoothing * imaging_rate;
    
    % Apply Gaussian smoothing
    x = -500:500;  % Time axis for the kernel
    gaussian_kernel = exp(-x.^2 / (2 * sigma^2));
    gaussian_kernel = gaussian_kernel / sum(gaussian_kernel); % Normalize
    
    single_spike_smoothed = conv(single_spike, gaussian_kernel, 'same');
    
    % Compute Gaussian amplitude
    spike_amplitude = round(max(single_spike_smoothed) * 1000) / 1000;
        
    
    %% Detect events from the inferred spike rate input
    
    % threshold deconvolved trace
    event_detection = spike_rates > spike_amplitude;
    
    % detect contiguous events
    labels = bwlabel(event_detection);
    A = regionprops(labels);
    
    % initialize matrices that contain detected events 
    spike_rate_per_event = zeros(numel(A), 1);
    
    % go through all events
    for k = 1:numel(A)
    
        % get bounding box (left and right time points) for the current event
        range_values = round(A(k).BoundingBox(1):(A(k).BoundingBox(1)+A(k).BoundingBox(3)));
    
        % compute the number of inferred spikes (sum over the detected event,
        % extended by 2 time points to the left and right)
        spike_rate_per_event(k) = sum(spike_rates(range_values(1)-2:range_values(end)+2));
    end
        
        
    %% GMM fitting
    
    % this is the main part of the script
    [unitary_amplitude, model] = AnalyzeSpikesHBGMM(spike_rate_per_event,show_plot);


    %% Rescale inferred spike rates

    if strcmp(rescaling_mode,'divisive') % described in paper
        
        spike_rates_rescaled = spike_rates/unitary_amplitude;

    elseif strcmp(rescaling_mode,'subtractive') % described in paper

        spike_rates_rescaled = spike_rates + spike_amplitude*(1 - unitary_amplitude);
        spike_rates_rescaled(spike_rates_rescaled<0) = 0;

    end


end