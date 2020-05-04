function dissink=distancetosink(Model,Sensors,Neighbors)

    n=Model.n;
    dissink=[];
    
    dissink(1)=-1;
    dissink(2)=-1;
    dissink(3)=-1;
    dissink(4)=-1;
    dissink(5)=-1;
    dissink(n+1)=0;
    
    for i=n+1:-1:1
        for j=1:n+1
            if (Neighbors(i,j)==1 && Sensors(j).E>0)
                if(dissink(j)==-1 || dissink(j)>dissink(i)+1)
                    dissink(j)=dissink(i)+1;
                end
            end
        end
    end

end