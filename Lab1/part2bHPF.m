% Constants
zeta = [0.1 0.3 0.707 1.0 3.0 10.0];
W0 = 1;  % net nat freq
w = 0.01:0.01:100;

% High-Pass RLC Filter
H_hp = zeros(length(zeta), length(w));
for k = 1:length(zeta)
    H_hp(k, :) = (1j .* w / W0).^2 ./ (1 + 2 * zeta(k) * 1j .* w / W0 + (1j .* w / W0).^2);
end
H_hp_mag = abs(H_hp);
H_hp_db = 20 * log10(H_hp_mag); % convert to dB
H_hp_phase = rad2deg(angle(H_hp)); % convert to degrees

%plotting magnitude (dB)
figure;
semilogx(w, H_hp_db);
title('High-Pass Filter Magnitude (dB)');
xlabel('Frequency (\omega/\omega_0)');
ylabel('Magnitude (dB)');
legend(arrayfun(@(z) sprintf('\\zeta = %.3f', z), zeta, 'UniformOutput', false), 'Location', 'best');
grid on;

% plotting phase
figure;
semilogx(w, H_hp_phase);
title('High-Pass Filter Phase');
xlabel('Frequency (\omega/\omega_0)');
ylabel('Phase (degrees)');
legend(arrayfun(@(z) sprintf('\\zeta = %.3f', z), zeta, 'UniformOutput', false), 'Location', 'best');
grid on;
