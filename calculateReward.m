function reward = calculateReward(Receiver, dissink)

    global sapv rapv

    if (sapv(Receiver.id) == 0 && rapv(Receiver.id) == 0)
        Trust = 0;
    elseif (sapv(Receiver.id) <= rapv(Receiver.id))
        sr = sapv(Receiver.id)/rapv(Receiver.id)
        rate = exp(sr)
        Trust = ((sapv(Receiver.id) + (0.5 * rate)) / (sapv(Receiver.id) + rate + rapv(Receiver.id))*10);
    else
        if (rapv(Receiver.id) == 0)
            sr = sapv(Receiver.id)
        else
            sr = sapv(Receiver.id)/rapv(Receiver.id)
        end
        rate = exp(sr)
        Trust = (10 - ((sapv(Receiver.id) + (0.5 * rate)) / (sapv(Receiver.id) + rate + rapv(Receiver.id))*10));
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
