function Sensors = configureSensors(Model, n, GX, GY)
    %% Developed by Shamim Ahmadinezhad

    %Configuration EmptySensor
    EmptySensor.xd = 0;
    EmptySensor.yd = 0;
    EmptySensor.df = 0;
    EmptySensor.E = 0;
    EmptySensor.id = 0;
    EmptySensor.RR = 0;
    EmptySensor.dis2sink = 0;
    EmptySensor.DataRate = 0;
    EmptySensor.T = 0;
    EmptySensor.Buffer = cell(1, Model.BufferLength);
    
    %Configuration sensors
    Sensors = repmat(EmptySensor, n + 1, 1);

    for i = 1:1:n
        %Sensor x location
        Sensors(i).xd = GX(i);

        %Sensor y location
        Sensors(i).yd = GY(i);

        %Sensor dead flag. Whether dead or alive S(i).df=0 alive. S(i).df=1 dead.
        Sensors(i).df = 0;

        %Sensor energy
        Sensors(i).E = Model.Eo;

        %Sensor id
        Sensors(i).id = i;
        
        %Sensor radio range
        Sensors(i).RR = Model.RR;

        %Sensor data rate
        Sensors(i).DataRate = Model.DataRate;

        %Sensor initial temperature
        Sensors(i).T = Model.To;

        %Sensor buffer
        Sensors(i).Buffer = cell(1, Model.BufferLength);
    end

    Sensors(n + 1).xd = Model.Sinkx;
    Sensors(n + 1).yd = Model.Sinky;
    Sensors(n + 1).E = 100;
    Sensors(n + 1).id = n + 1;
    Sensors(n + 1).RR = Model.RR;

end
