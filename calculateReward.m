function reward = calculateReward(Receiver, dissink)

    global sapv rapv

    if (sapv(Receiver.id) == 0 && rapv(Receiver.id) == 0)
        Trust = 0;
    else
        Trust = (sapv(Receiver.id) / ((sapv(Receiver.id) + rapv(Receiver.id)))) * 10;
    end

    if dissink(Receiver.id) == -1
        Hop = length(dissink) * 100;
    else
        Hop = dissink(Receiver.id);
    end

    E = Receiver.E;
    T = Receiver.T;
    reward = E - T + Trust - Hop;

    disp(['candidate #', num2str(Receiver.id)]);
    disp(['sapv ', num2str(sapv(Receiver.id))]);
    disp(['rapv ', num2str(rapv(Receiver.id))]);
    disp(['Trust ', num2str(Trust)]);
    disp(['E ', num2str(E)]);
    disp(['T ', num2str(T)]);
    disp(['Hop ', num2str(Hop)]);
    disp('---------');
end
