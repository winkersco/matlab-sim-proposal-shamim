function [Area,Model]=setParameters(n)
%% Developed by Amin Nazari 
% 	aminnazari91@gmail.com 
%	0918 546 2272
%%%%%%%%%%%%%%%%%%%%%%%%% Set Inital PARAMETERS %%%%%%%%%%%%%%%%%%%%%%%%
%Field Dimensions - x and y maximum (in meters)
Area.x=10;
Area.y=10;

%Sink Motion pattern 
Sinkx=0.5*Area.x;
Sinky=Sinkx;

%Optimal Election Probability of a node to become cluster head
p=0.1;

%%%%%%%%%%%%%%%%%%%%%%%%% Energy Model (all values in Joules)%%%%%%%%%%%
%Initial Energy 
Eo=0.01;

%Eelec=Etx=Erx
ETX=50*0.000000001;
ERX=50*0.000000001;

%Transmit Amplifier types
Efs=10*0.000000000001;
Emp=0.0013*0.000000000001;

%Data Aggregation Energy
EDA=5*0.000000001;

%Computation of do
do=sqrt(Efs/Emp);

%%%%%%%%%%%%%%%%%%%%%%%%% Run Time Parameters %%%%%%%%%%%%%%%%%%%%%%%%%
%maximum number of rounds
rmax=5000;

%Data packet size
DpacketLen=4000;

%Hello packet size
HpacketLen=100;

%Number of Packets sended in steady-state phase
NumPacket=10;

%Redio Range
RR=0.5*Area.x*sqrt(2);

%maximum time
tmax=5;

%Data Rate
DataRate=5;

%Initial Thermal 
To=2;

%cool Thermal 
Tc=0.0001;

%send Thermal 
Ts=0.0001;

%Receive Thermal 
Tr=0.0001;

%learning rate 
alpha=0.5;

%Discount rate 
gamma=0.5;

%Buffer Length 
BufferLength=32;
%%%%%%%%%%%%%%%%%%%%%%%%% END OF PARAMETERS %%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%% Save in Model %%%%%%%%%%%%%%%%%%%%%%%%%%%%
Model.n=n;
Model.Sinkx=Sinkx;
Model.Sinky=Sinky;
Model.p=p;
Model.Eo=Eo;
Model.ETX=ETX;
Model.ERX=ERX;
Model.Efs=Efs;
Model.Emp=Emp;
Model.EDA=EDA;
Model.do=do;
Model.rmax=rmax;
Model.DpacketLen=DpacketLen;
Model.HpacketLen=HpacketLen;
Model.NumPacket=NumPacket;
Model.RR=RR;
Model.tmax=tmax;
Model.DataRate=DataRate;
Model.To=To;
Model.Tc=Tc;
Model.Ts=Ts;
Model.Tr=Tr;
Model.alpha=alpha;
Model.gamma=gamma;
Model.BufferLength=BufferLength;

end