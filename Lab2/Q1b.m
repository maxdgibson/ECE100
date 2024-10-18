% Define the range for zeta
zeta_range = linspace(0.1, 0.7, 600);

% Initialize array to store dB values
H_dB = zeros(size(zeta_range));

% Calculate the dB values across the range of zeta
for i = 1:length(zeta_range)
    zeta = zeta_range(i);
    
    % Calculate |H(fpeak)|^2 / |H(0)|^2 using the provided formula
    H_ratio = 1 ./ (4*((zeta)^2)*(1-(zeta)^2));
    
    % its already squared so we use 10
    H_dB(i) = 10 * log10(H_ratio);
end

% Plotting
figure;
plot(zeta_range, H_dB);
grid on;
xlabel('\zeta (Damping Factor)');
ylabel('Magnitude Ratio (dB)');
title('|H(f_{peak})|^2 / |H(0)|^2 in dB vs \zeta');

[~, idx] = min(abs(H_dB - 1));
zeta_1dB = zeta_range(idx);
disp(['at 1 dB peak Zeta is: ', num2str(zeta_1dB)]);
