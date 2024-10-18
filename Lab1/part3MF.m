% Constants
zeta = [0.1 0.3 0.707 1.0 3.0 10.0];
W0 = 1;  % nat frequency
w = 0.01:0.01:100;

% Mystery RLC Filter
H_mystery = zeros(length(zeta), length(w));

for k = 1:length(zeta)
    H_mystery(k, :) = ((1j .* w / W0).^2 + 1) ./ ((1j .* w / W0).^2 + 2 * zeta(k) * 1j .* w / W0 + 1);
end

H_mystery_mag = abs(H_mystery);  % magnitude
H_mystery_db = 20 * log10(H_mystery_mag); % convert dB
H_mystery_phase = rad2deg(angle(H_mystery)); % convert to degrees

% plotting dB
figure;
semilogx(w, H_mystery_db);
title('Mystery Filter Magnitude (dB)');
xlabel('Frequency (\omega/\omega_0)');
ylabel('Magnitude (dB)');
legend(arrayfun(@(z) sprintf('\\zeta = %.3f', z), zeta, 'UniformOutput', false), 'Location', 'best');
grid on;

% plotting phase
figure;
semilogx(w, H_mystery_phase);
title('Mystery Filter Phase');
xlabel('Frequency (\omega/\omega_0)');
ylabel('Phase (degrees)');
legend(arrayfun(@(z) sprintf('\\zeta = %.3f', z), zeta, 'UniformOutput', false), 'Location', 'best');
grid on;
