

function [unitary_amplitude, hb_gmm_model] = AnalyzeResult(model, X, options)

    % component parameters
    weights = model.PComponents;
    means = model.mu;
    
    % filter components
    good_idx = weights > options.weight_threshold;
    good_means = means(good_idx);
    good_weights = weights(good_idx);
    
    % sort components by mean
    [sorted_means, sort_idx] = sort(good_means);
    sorted_weights = good_weights(sort_idx);
    
    % first component mean as unitary amplitude estimate
    unitary_amplitude = sorted_means(1);
    hb_gmm_model = model;
    
    % print analysis
    fprintf('\nHB-GMM Analysis Results:\n');
    fprintf('Number of effective components: %d\n', sum(good_idx));
    fprintf('Unitary amplitude estimate: %.3f\n', unitary_amplitude);
    
    fprintf('\nComponent analysis:\n');
    for i = 1:length(sorted_means)
        expected = i;
        actual = sorted_means(i)/unitary_amplitude;
        error = abs(actual - expected)/expected * 100;
        fprintf(['Component %d: Mean=%.3f, Weight=%.3f\n' ...
                '   Expected ratio=%.1f, Actual ratio=%.2f (error=%.1f%%)\n'],i, ...
                sorted_means(i), sorted_weights(i), expected, actual, error);
    end
end

