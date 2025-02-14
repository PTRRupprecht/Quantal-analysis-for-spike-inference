

function [F, max_components] = InitializeModel(X, options)

    % apply prior knowledge
    max_components = options.max_spikes;
    initial_unit = options.expected_unit_amp;

    % use the median of the smallest 25% of positive events as initial estimate (abandon after using priors)
    %initial_unit = median(X(X < prctile(X, 25)));
    
    % initialize means at integer multiples
    F.mu = initial_unit * (1:max_components)';
    
    % initialize covariances
    F.Sigma = zeros(1,1,max_components);
    
    for i = 1:max_components

        % variance increases with mean
        F.Sigma(1,1,i) = (options.variance_scaling * F.mu(i))^2;
    end
    
    % initialize weights with priors too
    F.PComponents = options.component_prior(:);
end
