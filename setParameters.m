function [Area, Model] = setParameters()
    %% Developed by Shamim Ahmadinezhad

    %%%%%%%%%%%%%%%%%%%%%%%%% Set Inital PARAMETERS %%%%%%%%%%%%%%%%%%%%%%%%
    
    %Number of nodes
    n = 8;
    
    %Field dimensions - x and y maximum (in meters)
    Area.x = 2;
    Area.y = 2;

    %Sink motion pattern
    Sinkx = 0.5 * Area.x;
    Sinky = 0.5 * Area.y;

    %Static scenario mode
    StaticScenario = true;

    %%%%%%%%%%%%%%%%%%%%%%%%% Energy Model (all values in Joules) %%%%%%%%%%
    
    %Initial Energy
    Eo = 0.6;
    
    %Transmitter energy consume (per bits)
    ETE = 16.7 * 0.000000001;
    
    %Receiver energy consume (per bits)
    ERE = 36.1 * 0.000000001;
    
    %Amplified circuit energy consume (per bits)
    EAC = 1.97 * 0.000000001;

    %%%%%%%%%%%%%%%%%%%%%%%%% Run Time Parameters %%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %Data packet size
    DpacketLength = 4000;

    %Hello packet size
    HpacketLength = 100;
    
    %Buffer Length
    BufferLength = 32;

    %Radio Range
    RR = 0.5 * Area.x * sqrt(2);

    %Time Max
    TimeMax = 50000;

    %Data Rate
    DataRate = 5;

    %Initial Thermal
    To = 70;

    %cool Thermal
    Tc = 0.1;

    %send Thermal
    Ts = 0.2;

    %Receive Thermal
    Tr = 0.1;
    
    %Thermal Threshold
    ThermalThreshold = 101;
    
    %Energy Max
    EnergyMax = Eo;
    
    %Hop Max
    HopMax = n;
    
    %%%%%%%%%%%%%%%%%%%%%%%%% Routing Parameters %%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %routing (qlearning)
    Routing = 'myRouting';

    %learning rate
    Alpha = 0.5;

    %Discount rate
    Gamma = 0.5;
    
    %Blackhole Attacker
    BlackholeAttacker = [0 0 0 0 0 0 0 0 0 0 0];
    
    %Grayhole Attacker
    GrayholeAttacker = [0 0 0 0 0 0 0 0 0 0 0];
    
    %Grayhole Possibility
    GrayholePossibility = 0.5;
    
    %W of Thermal
    WThermal = 0.25;
    
    %W of Energy
    WEnergy = 0.25;
    
    %W of Hop
    WHop = 0.25;
    
    %W of Trust
    WTrust = 0.25;

    %%%%%%%%%%%%%%%%%%%%%%%%% END OF PARAMETERS %%%%%%%%%%%%%%%%%%%%%%%%

    %%%%%%%%%%%%%%%%%%%%%%%%% Save in Model %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    Model.n = n;
    Model.Sinkx = Sinkx;
    Model.Sinky = Sinky;
    Model.StaticScenario = StaticScenario;
    Model.Eo = Eo;
    Model.ETE = ETE;
    Model.ERE = ERE;
    Model.EAC = EAC;
    Model.DpacketLength = DpacketLength;
    Model.HpacketLength = HpacketLength;
    Model.BufferLength = BufferLength;
    Model.RR = RR;
    Model.TimeMax = TimeMax;
    Model.DataRate = DataRate;
    Model.To = To;
    Model.Tc = Tc;
    Model.Ts = Ts;
    Model.Tr = Tr;
    Model.ThermalThreshold = ThermalThreshold;
    Model.EnergyMax = EnergyMax;
    Model.HopMax = HopMax;
    Model.Routing = Routing;
    Model.Alpha = Alpha;
    Model.Gamma = Gamma;
    Model.BlackholeAttacker = BlackholeAttacker;
    Model.GrayholeAttacker = GrayholeAttacker;
    Model.GrayholePossibility = GrayholePossibility;
    Model.WThermal = WThermal;
    Model.WEnergy = WEnergy;
    Model.WHop = WHop;
    Model.WTrust = WTrust;

end
