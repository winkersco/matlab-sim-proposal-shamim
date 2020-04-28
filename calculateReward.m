function reward=calculateReward(Receiver)

    global sapv rapv
    if (sapv(Receiver.id)==0 && rapv(Receiver.id)==0)
        Trust=0;
    else
        Trust=(sapv(Receiver.id)/((sapv(Receiver.id)+rapv(Receiver.id))))*10;
    end
    disp(Trust);
    E=Receiver.E
    T=Receiver.T
    reward=E-T+Trust

end