
function Visualization(X, model, unitary_amplitude, options)

    figure;
    
    % plot 1: data and fitted components
    subplot(2,1,1);
    X_plot = X(X > 0);
    histogram(X_plot, 40, 'Normalization', 'pdf', 'FaceAlpha', 0.3);
    hold on;
    
    % generate points of plotting
    x = linspace(min(X_plot), max(X_plot), 200);
    y_total = zeros(size(x));
    
    % get components
    weights = model.PComponents;
    means = model.mu;
    sigmas = sqrt(squeeze(model.Sigma));
    good_idx = weights > options.weight_threshold;
    
    % plot components
    cmap = lines(sum(good_idx));
    component_idx = 1;
    
    for i = 1:length(weights)
        if weights(i) > options.weight_threshold
            y_i = weights(i) * normpdf(x, means(i), sigmas(i));
            plot(x, y_i, 'Color', cmap(component_idx,:), 'LineWidth', 2, ...
                'DisplayName', sprintf('Component %d (μ=%.2f, w=%.2f)', ...
                component_idx, means(i), weights(i)));
            y_total = y_total + y_i;
            component_idx = component_idx + 1;
        end
    end
    
    % plot sum of components
    plot(x, y_total, 'k--', 'LineWidth', 2, 'DisplayName', 'Sum of Components');
    title('Spike Rate Distribution (HB-GMM Fit)');
    xlabel('Spike Rate');
    ylabel('Probability Density');
    legend('show', 'Location', 'best');
    grid on;
    
    % plot 2: component analysis
    subplot(2,1,2);
    
    % get sorted good components
    good_means = means(good_idx);
    [sorted_means, sort_idx] = sort(good_means);
    
    % bar plot of component means
    bar(sorted_means, 'FaceColor', [0.4 0.6 0.8]);
    hold on;
    
    % plot expected integer multiples
    expected_means = unitary_amplitude * (1:length(sorted_means));
    plot(1:length(sorted_means), expected_means, 'r--o', 'LineWidth', 2);
    
    title('Component Mean Analysis');
    xlabel('Component Number');
    ylabel('Mean Value');
    legend('Actual Means', 'Expected Integer Multiples');
    grid on;
end
 
