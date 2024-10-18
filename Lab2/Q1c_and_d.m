fo = 5*10^3;
Z = 0.5227; % get value from max
f = 1*10^3:1:1*10^4;

M = length(f);

H = zeros(1, M);
H_mag2 = zeros(1, M);
H2 = zeros(1, M); 

for i = 1:M
    F = f(i);
    H(i) = 0.7943/((1-(F/fo)^2)^2 + (2*Z*F/fo)^2); 
    H2(i) = 10*log10(H(i));
end

figure(1); % making a figure for the plot to find req_fo
hold on 
legend on
semilogx(f, H2, 'DisplayName', 'fo = 5 kHz')

% Find the index where H2 is closest to -1
[~, index] = min(abs(H2 + 1)); % Find index of closest value to -1

% Get the corresponding x-coordinate
x_point = f(index)
y_value = -1;

% Add the point to the plot
plot(x_point, -1, 'r*', 'MarkerSize', 10); 



xlabel('frequency (Hz)');
ylabel('|H(f)|^{2} (dB)');
title('|H(jw)| Using fo = 5kHz (guess)');
grid on

hold off; % Release the plot
%------------------------------------



req_fo = 5*10^3 * 4*10^3 / x_point

f = 200:1:1*10^6;
N = length(f);

h = zeros(1, N);
h_mag2 = zeros(1, N); 
h2 = zeros(1, N); 

for j = i:N
    F = f(j);
    h(j) = 0.7943/((1-(F/req_fo)^2)^2 + (2*Z*F/req_fo)^2);
    h_mag2(j) = (abs(h(j)))^2;
    h2(j) = 10*log10(h_mag2(j));
end

figure(2); %new figure for plotting with req_fo
hold on
semilogx(f, h2, 'DisplayName', ['fo = ' num2str(req_fo)])
xlabel('frequency (Hz)');
ylabel('|H(f)|^{2} (dB)');
title('|H(f)| Using req\_fo');
grid on
legend on
hold off
%------------------------------------
% Finding an fo such that |H(f)|^2 clears the 
% passband edge and stopband edge by the 
% same factor


F = 4*10^3;

adj_fo = req_fo:10:req_fo + 10*10^3; 
Y = length(adj_fo); 

h = zeros(1, Y);
h_mag2 = zeros(1, Y); 
h2 = zeros(1, Y); 
for k = 1:Y
    fo_val = adj_fo(k);
    
    passbnd_clrnc = -1 - H2_dB(4*10^3, fo_val, Z);
    stpbnd_clrnc = H2_dB(32*10^3, fo_val, Z) -(-30);
    clearance = abs(passbnd_clrnc - stpbnd_clrnc);
    if clearance < 0.1
        sprintf("fo = %0.1f Hz clears passband & stopband w same clearances", fo_val)
    end
end


function [val] = H2_dB(freq, freq_o, zeta) 
    fxn = 0.7943/((1-(freq/freq_o)^2)^2 + (2*zeta*freq/freq_o)^2);
    fxn_magnitude = (abs(fxn))^2;
    fxn_magnitude_dB = 10*log10(fxn_magnitude); 

    val = fxn_magnitude_dB;
end


% plotting the graph using this newly found fo value:

