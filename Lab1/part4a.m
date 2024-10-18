s = tf('s');
w0 = 1; 
zeta = [0.1, 0.3, 0.707, 1.0, 3.0, 10.0];

% Initialize fig
figure;
hold on;

for Z = zeta
    h = 1 / (1 + 2*Z*s/w0 + (s/w0)^2);
    bode(h);
    hold on;
end

% Formatting
title('Bode Plots for Different \zeta Values');
legend(arrayfun(@(z) sprintf('\\zeta = %.3f', z), zeta, 'UniformOutput', false), 'Location', 'best'); % Create a legend for all zeta values
grid on;
hold off;


% Initialize second fig
figure;
hold on;

for Z = zeta
    h = 1 / (1 + 2*Z*s/w0 + (s/w0)^2);
    step(h);
    hold on;
end

% Formatting for second fig
title('Step Responses for Different \zeta Values');
ylabel('Amplitude');
legend(arrayfun(@(z) sprintf('\\zeta = %.3f', z), zeta, 'UniformOutput', false), 'Location', 'best'); % Create a legend for all zeta values
grid on;
hold off;
