function NodeNeighbors=SendAndReceivePackets(Sensors,Model,PacketType,t,Neighbors)
  
   global srp sdp
   sap=0;      % Send a packet
   
   n=Model.n;
   
   for i=1:n
       if (mod(t,Sensors(i).DataRate)==0)
           NodeNeighbors=[];
           for j=1:n
               if (Neighbors(i,j)==1)
                    NodeNeighbors=[NodeNeighbors,Sensors(j).id];
               end
           end
               % Sent a packet
                   sap=sap+1;
       end
   end
   
   if (strcmp(PacketType,'Data'))
        sdp=sdp+sap;
    else       
        srp=srp+sap;
    end
   
  
end