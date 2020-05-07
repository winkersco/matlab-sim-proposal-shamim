function nextQ = cauculatenextQ(Receiver, Model, Neighbors, Q)

    n = Model.n;
    nQs = [];

    for b = 1:n

        if (Neighbors(Receiver.id, b) == 1)
            nQs = [nQs, Q(Receiver.id, b)];
        end

    end

    if (isempty(nQs))
        nextQ = -1000;
    else
        nQs = sort(nQs, 'descend');
        nextQ = nQs(1);
    end

end
