

function [best_model, best_ll] = FitModel(X, F, max_components, options)
    n_replicates = 20;
    best_ll = inf;
    best_model = [];
    
    % fit model
    for rep = 1:n_replicates
        try
            model = fitgmdist(X, max_components, ...
                'CovarianceType', 'diagonal', ...
                'RegularizationValue', 1e-6, ...
                'Options', statset('MaxIter', 1000, 'TolFun', 1e-6), ...
                'Start', F);
            
            if model.NegativeLogLikelihood < best_ll
                best_ll = model.NegativeLogLikelihood;
                best_model = model;
            end

        catch ER
            fprintf('Warning: Iteration %d failed: %s\n', rep, ER.message);
            continue;
        end
    end
    
    if isempty(best_model)
        error('Failed to fit model after all replicates');
    end
end
