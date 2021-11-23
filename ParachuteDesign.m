%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Victor Henrique Caldeira Barbosa
% Universidade de Brasília
% Engenharia Aeroespacial - Faculdade Gama
% 
% Parachute Design - chord and span range definition
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Constants definition
mParachute = 0.3; % kg
Cl = 0.4; % 0.7
rho_air = 1.225 ;%kg/m^3

%% Design as a function of the parachute geometry
% System characteristics
mPayload = 5; % kg
m = mPayload + mParachute; % kg

% Design limits
WL_range = [4 6];
AR_range = [1.9 3];

% Geometry range for simulation
Span = 0.1:0.001:3; Span = Span'; % m
Chord = 0.1:0.001:3; % m

% General parachute calculation
WL = m./ (Span*Chord);
AR = repmat(Span,1,length(Span))./repmat(Chord,length(Chord),1);

WL(WL < WL_range(1)) = nan; WL(WL > WL_range(2)) = nan;
AR(AR < AR_range(1)) = nan; AR(AR > AR_range(2)) = nan;

WL(isnan(AR)) = nan; AR(isnan(WL)) = nan; 

figure(1); subplot(1, 2, 1); contourf(Chord, Span, WL,'ShowText','on');
    title(['Carga alar (kg/m^2) - Carga paga = ' num2str(mPayload) ' kg']);
    xlabel('Corda (m)'); ylabel('Envergadura (m)'); grid on

subplot(1, 2, 2); contourf(Chord, Span, AR,'ShowText','on');
    title(['Alongamento - Carga paga = ' num2str(mPayload) ' kg']);
    xlabel('Corda (m)'); ylabel('Envergadura (m)'); grid on 