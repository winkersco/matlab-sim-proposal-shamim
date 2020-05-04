function reward=calculateReward(Receiver,Model,Neighbors)

    n=Model.n;
    nnexthop=zeros(n,n);
    B=[];
    global sapv rapv
    if (sapv(Receiver.id)==0 && rapv(Receiver.id)==0)
        Trust=0;
    else
        Trust=(sapv(Receiver.id)/((sapv(Receiver.id)+rapv(Receiver.id))))*10;
    end
    
    for b=1:n
        if (Neighbors(Receiver.id,b)==1)
            nnexthop(Receiver.id,b)=1
        else
            nnexthop(Receiver.id,b)=0
        end
        
    end
     B=find(nnexthop)
     if(isempty(B))
        numhop = 1;
     else
        numhop=2;
    end
    
    E=Receiver.E;
    T=Receiver.T;
    reward=E-T+Trust+numhop;
    
    disp(['candidate #',num2str(Receiver.id)]);
    disp(['sapv ',num2str(sapv(Receiver.id))]);
    disp(['rapv ',num2str(rapv(Receiver.id))]);
    disp(['Trust ',num2str(Trust)]);
    disp(['E ',num2str(E)]);
    disp(['T ',num2str(T)]);
    disp(['numhop ',num2str(numhop)]);
    disp('---------');
end