%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Victor Henrique Caldeira Barbosa
% Universidade de Brasília
% Engenharia Aeroespacial - Faculdade Gama
% 
% Parachute Design - Incidence Angle vs AOA 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Simulation done by using NACA4412 aerodynamics characteristics

% Aerodynamics characteristics
C_D_CG = 0.5;
chord = 0.56;
S_CG = 0.2*0.1; % ?????? 
span = 1.7;
S = span*chord; % ?????? 
load NACA4412_Re5e4.mat;% http://airfoiltools.com/polar/details?polar=xf-naca4412-il-50000
                        % NACA4412 aerod. charact. (Re=5E4, Ncrit=9). [AOA CL CD CDp CM Top_Xtr Bot_Xtr]
coeffTable = NACA4412_Re5e4;

%% Coeff interpolation
AOA = 2:0.02:10;
C_L = interp1(coeffTable(:,1), coeffTable(:,2), AOA);
C_D = interp1(coeffTable(:,1), coeffTable(:,3), AOA);

%% Calculation
C_x = C_L .* cosd(AOA) + C_D .* sind(AOA); % Eq 4.77
C_z = C_L .* sind(AOA) - C_D .* cosd(AOA); % Eq 4.76

theta = atand( (C_x - cosd(AOA).^2 * S_CG * C_D_CG / S )...
    ./ (C_z + sind(AOA).^2 * S_CG * C_D_CG / S ) );

%% Plot Results

figure(); plot(AOA, theta);
title('Incidence angle vs AOA');
    xlabel('AOA (deg)'); ylabel('Theta (deg)'); grid on