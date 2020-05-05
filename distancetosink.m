function dissink=distancetosink(Model,Sensors,Neighbors)

    n=Model.n;
    dissink=zeros(1,n+1);
    
    for i=1:n
        dissink(i)=-1;
    end
    
    for i=n+1:-1:1
        for j=1:n+1
            if (Neighbors(i,j)==1 && Sensors(j).E>0)
                if(dissink(i)~=-1 && (dissink(j)==-1 || dissink(j)>dissink(i)+1))
                    dissink(j)=dissink(i)+1;
                end
            end
        end
    end

end