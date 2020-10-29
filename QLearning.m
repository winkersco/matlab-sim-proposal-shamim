%% Developed by Shamim Ahmadinezhad

clc;
clear;
close all;
warning off all;
tic;

%%%%%%%%%%%%%%%%%%%%%%%%% Initial Parameters %%%%%%%%%%%%%%%%%%%%%%%
[Area, Model] = setParameters(); %Set sensors and network parameters
n = Model.n; %Number of nodes in the field

%%%%%%%%%%%%%%%%%%%%%%%%% Configuration Sensors and Area %%%%%%%%%%%%%%%%%%%%
if Model.StaticScenario
    createStaticScenario(); %Create a static scenario
else
    createRandomScenario(Model, Area); %Create a random scenario
end
load Locations %Load sensor Location

% createRandomSenses(Model); %Create Random sensing model
load Senses %Load Sensing model

Sensors = configureSensors(Model, n, X, Y); %Configure sensors

%%%%%%%%%%%%%%%%%%%%%%%%% Initial Calculation %%%%%%%%%%%%%%%%%%%%
Distances = calculateDistances(Model, Sensors); %Calculate distances
Neighbors = findNeighbors(Model, Sensors, Distances); %Find neighbors

%%%%%%%%%%%%%%%%%%%%%%%%%% Parameters initialization %%%%%%%%%%%%%
firstDead = 0; %FirstDead
initEnergy = 0; %Initial Energy
for i = 1:n
    initEnergy = Sensors(i).E + initEnergy;
end

SRP = zeros(1, Model.TimeMax); %number of sent routing packets
RRP = zeros(1, Model.TimeMax); %number of receive routing packets
FRP = zeros(1, Model.TimeMax); %number of forward routing packets
SDP = zeros(1, Model.TimeMax); %number of sent data packets
RDP = zeros(1, Model.TimeMax); %number of receive data packets
FDP = zeros(1, Model.TimeMax); %number of forward data packets
DN = zeros(1, Model.TimeMax); %number of dead nodes

%%%%%%%%%%%%%%%%%%%%%%%%% Start Simulation %%%%%%%%%%%%%%%%%%%%%%%%%
global srp rrp frp sdp rdp fdp sapv rapv fapv Q 
srp = 0; %counter number of sent routing packets
rrp = 0; %counter number of receive routing packets
frp = 0; %counter number of forward routing packets
sdp = 0; %counter number of sent data packets
rdp = 0; %counter number of receive data packets
fdp = 0; %counter number of forward data packets
sapv = zeros(1, n); %counter number of sent data packets for nodes
rapv = zeros(1, n+1); %counter number of receive data packets for nodes
fapv = zeros(1, n); %counter number of forward data packets for nodes
Q = zeros(n, n); %counter number of Q for nodes

%% Main loop program for start Q-learning
for t = 1:1:Model.TimeMax

    %%%%%%%%%%%%%%%%%%%%%%%%%%%% Initialization %%%%%%%%%%%%%%%%%%%%%
    HopToSink = calculateHopToSink(Model, Sensors, Neighbors); %Calculate hop to sink
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%% sending and routing %%%%%%%%%%%%%%%%
    [Sensors, Send] = sendAndReceivePackets(Sensors, Model, 'Data', t, Neighbors, Distances, Senses, HopToSink);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%% plot sensors %%%%%%%%%%%%%%%%%%%%%%%
    ploter(Sensors, Model, Area, Send, t);
    pause(0.001);
    picname=sprintf('Figures/Figure_%d', t);
    pictype='png';
    saveas(gcf,picname,pictype);
    

    %% STATISTICS
    SRP(t) = srp;
    RRP(t) = rrp;
    FRP(t) = frp;
    SDP(t) = sdp;
    RDP(t) = rdp;
    FDP(t) = fdp;

    alive = 0;
    SensorEnergy = 0;
    deadNodes = 0;

    for i = 1:n
        if Sensors(i).E > 0
            alive = alive + 1;
            SensorEnergy = SensorEnergy + Sensors(i).E;
        else
            deadNodes = deadNodes + 1;
        end
    end

    if (deadNodes >= 1)
        if (firstDead == 0)
            firstDeadTime = t;
            firstDead = 1;
        end
    end

    AliveSensors(t) = alive; %#ok
    SumEnergyAllSensor(t) = SensorEnergy; %#ok
    AvgEnergyAllSensor(t) = SensorEnergy / alive; %#ok
    ConsumEnergy(t) = (initEnergy - SumEnergyAllSensor(t)) / n; %#ok

    En = 0;
    for i = 1:n
        if Sensors(i).E > 0
            En = En + (Sensors(i).E - AvgEnergyAllSensor(t))^2;
        end
    end

    Enheraf(t) = En / alive; %#ok
    
    DN(t) = deadNodes;

    last = true;
    for i = 1:n
        if HopToSink(i) ~= -1
            last = false;
            break;
        end
    end
    if n == deadNodes
        last = true;
    end
    
    if (last == true)
        lastPeriod = t;
        break;
    end
end

disp('End of Simulation');
toc;
disp('Create Report...')

filename = sprintf('%s%d.mat', Model.Routing, n);

%% Save Report
save(filename);
