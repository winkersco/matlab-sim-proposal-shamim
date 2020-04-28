function reward=calculateReward(Receiver)

    global sapv rapv
    E=Receiver.E;
    T=Receiver.T;
    Trust=(sapv(Receiver.id)/(sapv(Receiver.id)+rapv(Receiver.id)))*10;
    reward=E-T+Trust;

end