zeta = [0.1 0.3 0.707 1.0 3.0 10.0];
W0 = 1;
w = 0.01:0.01:100;

% Initialize h & h2 to store the freq responses for each zeta
h = zeros(length(zeta), length(w));
h2 = zeros(length(zeta), length(w));

% Calculate the frequency response for each damping ratio
for k = 1:length(zeta)
    h(k, :) = 1 ./ (1 + (2 * zeta(k) * (1j .* w / W0)) + ((1j .* w / W0).^2));
    h2(k, :) = abs(h(k, :));  % Compute the magnitude of each frequency resposne fxn.
end
%%---------------------------------------
% Linear|H(jw)| Plot

figure;
for k = 1:length(zeta)
    w1 = (20.*log10(w))/W0 ;
    plot(w1, h2(k, :)); 
    hold on
end
% xlim([10^(-2) 10^2]);
grid on
xlim([10^(-2) 10^(2)]);
xlabel('Frequency (\omega/\omega_0)');
ylabel('|H(j\omega)| (lienar)');
legend(arrayfun(@(z) sprintf('\\zeta = %.3f', z), zeta, 'UniformOutput', false), 'Location', 'best'); % Create a legend for all zeta values
title('linear |H(jw)| Plot');
hold off;

%%---------------------------------------
% Magnitude Bode plot
h_db = 20 * log10(h2); % Calc dB magnitude for all zeta values

figure; % Create a new figure window
for k = 1:length(zeta)
    semilogx(w, h_db(k, :)); % Use semilogx to plot magnitude in dB
    hold on; % Hold on to plot all curves on the same graph
end
grid on; 
xlim([10^(-2) 10^2]); 
xlabel('Frequency (\omega/\omega_0)');
ylabel('|H(j\omega)| (20log_{10} dB)');
legend(arrayfun(@(z) sprintf('\\zeta = %.3f', z), zeta, 'UniformOutput', false), 'Location', 'best'); % Create a legend for all zeta values
title('Bode Plot of |H(j\omega)|');
hold off;

%%---------------------------------------
% Phase Bode Plot
ph = zeros(length(zeta), length(w));

for k = 1:length(zeta)
    ph(k, :) = angle(h(k, :));
end

figure; 
for k = 1:length(zeta)
    semilogx(w, ph(k, :));
    hold on;
end
grid on; 
xlim([10^(-2) 10^2]); 
xlabel('Frequency (\omega/\omega_0)');
ylabel('\angle|H(j\omega)|  (\theta)');
legend(arrayfun(@(z) sprintf('\\zeta = %.3f', z), zeta, 'UniformOutput', false), 'Location', 'best'); % Create a legend for all zeta values
title('Phase Bode Plot');
hold off;