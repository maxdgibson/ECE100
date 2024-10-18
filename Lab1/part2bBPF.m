% Constants
zeta = [0.1 0.3 0.707 1.0 3.0 10.0];
W0 = 1;  % Normalized natural frequency
w = 0.01:0.01:100;  % Angular frequency vector

% Band-Pass RLC Filter
H_bp = zeros(length(zeta), length(w));
for k = 1:length(zeta)
    H_bp(k, :) = 1j .* zeta(k) .* w / W0 ./ (1 + 2 * zeta(k) * 1j .* w / W0 + (1j .* w / W0).^2);
end
H_bp_mag = abs(H_bp);
H_bp_db = 20 * log10(H_bp_mag); % Convert magnitude to dB
H_bp_phase = rad2deg(angle(H_bp)); % Convert phase to degrees

% Plotting Band-Pass Filter Magnitude (dB)
figure;
semilogx(w, H_bp_db);
title('Band-Pass Filter Magnitude (dB)');
xlabel('Frequency (\omega/\omega_0)');
ylabel('Magnitude (dB)');
legend(arrayfun(@(z) sprintf('\\zeta = %.3f', z), zeta, 'UniformOutput', false), 'Location', 'best');
grid on;

% Plotting Band-Pass Filter Phase
figure;
semilogx(w, H_bp_phase);
title('Band-Pass Filter Phase');
xlabel('Frequency (\omega/\omega_0)');
ylabel('Phase (degrees)');
legend(arrayfun(@(z) sprintf('\\zeta = %.3f', z), zeta, 'UniformOutput', false), 'Location', 'best');
grid on;
