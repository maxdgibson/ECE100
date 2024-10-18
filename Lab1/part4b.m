s = tf('s');
w0 = 1;
zeta_range = 0.01:0.01:10;
zeta = [0.1, 0.3, 0.707, 1.0, 3.0, 10.0];

theoretical_overshoot = zeros(size(zeta_range));

% Calculate theoretical overshoot
for i = 1:length(zeta_range)
    if zeta_range(i) < 1
        theoretical_overshoot(i) = 100 * exp(-pi * zeta_range(i) / sqrt(1 - zeta_range(i)^2));
    else
        theoretical_overshoot(i) = 0;
    end
end

calculated_overshoot = zeros(size(zeta));

% Calculate overshoot using step response information
for i = 1:length(zeta)
    h = 1 / (1 + 2*zeta(i)*s/w0 + (s/w0)^2);
    info = stepinfo(h);
    calculated_overshoot(i) = info.Overshoot;
end

% Plotting both on top of each other
figure;
plot(zeta_range, theoretical_overshoot, 'LineWidth', 2, 'DisplayName', 'Theoretical Overshoot');
hold on;

plot(zeta, calculated_overshoot, 'o', 'MarkerSize', 8, 'DisplayName', 'Calculated Overshoot');

title('Overshoot vs. \zeta');
xlabel('Range of \zeta Values');
ylabel('Overshoot (%)');
legend('show', 'Location', 'best');
grid on;
hold off;
