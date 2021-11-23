%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Victor Henrique Caldeira Barbosa
% Universidade de Brasília
% Engenharia Aeroespacial - Faculdade Gama
% 
% Parachute Design - CG position based on equilibrium AOA
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Simulation done by using NACA4412 aerodynamics characteristics

% Canopy characteristics - to change airfoil characteristics, edit this
% section
a = 4;
AC_perc = 0.245; %Aerodynamic center in % of chord
chord = 0.56;
Cm0 = -0.04;
D2 = 0.1;
D0 = 0.03;
i0 = 0;
span = 1.7;

%% Basic geometric properties
S = span * chord; % flat area
AC = AC_perc * chord; % aerodynamic center

%% CG position - variable
h0 = 0.6:0.001:1.1; h0 = h0';
h0 = repmat(h0, 1, length(h0));
d0 = 0:0.0002:0.1;
d0 = repmat(d0, length(d0), 1);

%% Equilibrium AOA calculation
AOA1 = (1 + sqrt(1 + 4 * h0./d0 * (1 - D2*a)...
    .* (h0./d0 * D0/a + chord*Cm0 ./ d0/a - i0)))...
    ./ (2 * h0./d0 * (1 - D2*a)) * 180/pi;
AOA1 = real(AOA1);
AOA1(AOA1<3) = nan; AOA1(AOA1>10) = nan;

% AOA2 = (1 - sqrt(1 + 4 * h0./d0 * (1 - D2*a)...
%     .* (h0./d0 * D0/a + chord*Cm0 ./ d0/a - i0)))...
%     ./ (2 * h0./d0 * (1 - D2*a)) * 180/pi;
% AOA2 = real(AOA2);

%% Plot results
figure(1); contourf(d0(1,:), h0(:,1), AOA1,'ShowText','on');
    set ( gca, 'ydir', 'reverse' ); set ( gca, 'xdir', 'reverse' )
    title('Ângulo de ataque de equilíbrio (deg)');
    xlabel('d0 (m)'); ylabel('h0 (m)'); grid on

% subplot(1, 2, 2); contourf(d0(1,:), h0(:,1), AOA2,'ShowText','on');
%     title('Equilibrium AOA 2 (deg)');
%    xlabel('d0 (m)'); ylabel('h0 (m)'); grid on