function reward=calculateReward(Receiver)

  
    E=Receiver.E;
    T=Receiver.T;
    %Trust=(sapv(Receiver)/(sapv(Receiver)+rapv(Receiver)))*10;
    reward=E-T;

end