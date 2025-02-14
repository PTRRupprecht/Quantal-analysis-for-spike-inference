%% Functions

function [unitary_amplitude, hb_gmm_model] = AnalyzeSpikesHBGMM(spike_rate,visualization_on, options)

    % default options based on our prior knowledge
    if ~exist('options', 'var')
        options = struct();
    end
    
    options = SetDefault(options);
    
    % load data and handle NaN
    X = spike_rate(~isnan(spike_rate));
    
    % initialize model with priors
    [F, max_components] = InitializeModel(X, options);
    
    % fit model with all initialization
    [best_model, best_ll] = FitModel(X, F, max_components, options);
    
    % analyze results
    [unitary_amplitude, hb_gmm_model] = AnalyzeResult(best_model, X, options);
    if visualization_on
        Visualization(X, hb_gmm_model, unitary_amplitude, options);
    end
end
