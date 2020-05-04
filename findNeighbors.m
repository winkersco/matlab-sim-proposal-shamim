function Neighbors=findNeighbors(Model,Sensors)

n=Model.n;
Neighbors=zeros(n+1,n+1);
D=zeros(n+1,n+1);

 for i=1:n+1
   
    for j=1:n+1
             
        D(i,j)=sqrt((Sensors(i).xd-Sensors(j).xd)^2+ ...
            (Sensors(i).yd-Sensors(j).yd)^2);
    end
                      
 end 

 for i=1:n+1
   
  for j=1:n+1
     if (i~=j && D(i,j)<=(Model.RR/2))

         Neighbors(i,j)=1;
     end

  end


 end
  

end