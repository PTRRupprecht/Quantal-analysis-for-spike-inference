

% set defaults based on priors
function options = SetDefault(options)
    
    % maximum number of spikes typically can be seen in one event
    if ~isfield(options, 'max_spikes')
        options.max_spikes = 8;
    end
    
    % variance scaling with amplitude
    if ~isfield(options, 'variance_scaling')
        options.variance_scaling = 0.2; % approximately, 0.2 for s/m, 0.4 for f
    end
    
    % component weights (single spikes more common than doubles, doubles more than triples...)
    if ~isfield(options, 'component_prior')
        options.component_prior = exp(-(0:7));
        options.component_prior = options.component_prior / sum(options.component_prior);
    end
    
    % minimum weight for a component
    if ~isfield(options, 'weight_threshold')
        options.weight_threshold = 0.09;
    end

    % priors combine gradient descent modeling and deconvolution
    % approximately 1.5, the normal range should be 1.0-2.0
    if ~isfield(options, 'expected_unit_amp')
        options.expected_unit_amp = 1.5;
    end

end
