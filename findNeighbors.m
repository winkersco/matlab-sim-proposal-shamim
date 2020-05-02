function Neighbors=findNeighbors(Model,Sensors)

n=Model.n;
Neighbors=zeros(n,n);
D=zeros(n,n);

 for i=1:n
   
    for j=1:n
             
        D(i,j)=sqrt((Sensors(i).xd-Sensors(j).xd)^2+ ...
            (Sensors(i).yd-Sensors(j).yd)^2);
    end
                      
 end 

 for i=1:n
   
  for j=1:n
     if (i~=j && D(i,j)<=(Model.RR/2))

         Neighbors(i,j)=1;
     end

  end


 end
  

end