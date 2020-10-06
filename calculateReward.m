function reward = calculateReward(Model, Receiver, dissink)

    global sapv rapv fapv

    if rapv(Receiver.id) == 0
        Trust =  0.5;
    else
        Trust =  fapv(Receiver.id) / rapv(Receiver.id);
    end

    if dissink(Receiver.id) == -1
        Hop = 0;
    else
        Hop = 1 - (dissink(Receiver.id) / Model.HopMax);
    end

    E = (Receiver.E / Model.EnergyMax);
    
    T = 1 - (Receiver.T / Model.ThermalThreshold);
    
    reward = Model.WEnergy*E + Model.WThermal*T + Model.WTrust*Trust + Model.WHop*Hop;

    disp(['candidate #', num2str(Receiver.id)]);
    disp(['sapv ', num2str(sapv(Receiver.id))]);
    disp(['rapv ', num2str(rapv(Receiver.id))]);
    disp(['fapv ', num2str(fapv(Receiver.id))]);
    disp(['Trust ', num2str(Trust)]);
    disp(['E ', num2str(E)]);
    disp(['T ', num2str(T)]);
    disp(['Hop ', num2str(Hop)]);
    disp(['reward ', num2str(reward)]);
    disp('---------');
end
