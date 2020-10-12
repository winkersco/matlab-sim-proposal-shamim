function reward = calculateReward(Model, Receiver, HopToSink)

    global rapv fapv

    if rapv(Receiver.id) == 0
        Trust =  0.5;
    else
        Trust =  fapv(Receiver.id) / rapv(Receiver.id);
    end

    if HopToSink(Receiver.id) == -1
        Hop = 0;
    else
        Hop = 1 - (HopToSink(Receiver.id) / Model.HopMax);
    end

    E = (Receiver.E / Model.EnergyMax);
    
    T = 1 - (Receiver.T / Model.ThermalThreshold);
    
    reward = Model.WEnergy*E + Model.WThermal*T + Model.WTrust*Trust + Model.WHop*Hop;

    fprintf('Candidate #%i\n', Receiver.id);
    fprintf('Trust => P:%f Forward:%i Receive:%i\n', Trust, fapv(Receiver.id), rapv(Receiver.id));
    fprintf('Energy => P:%f Energy:%f EnergyMax:%f\n', E, Receiver.E, Model.EnergyMax);
    fprintf('Thermal => P:%f Thermal:%f ThermalThreshold:%f\n', T, Receiver.T, Model.ThermalThreshold);
    fprintf('Hop => P:%f Hop:%i HopMax:%i\n', T, HopToSink(Receiver.id), Model.HopMax);
    fprintf('Reward => %f\n\n', reward);
end
