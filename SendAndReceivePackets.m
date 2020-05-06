function [Send,Sensors]=SendAndReceivePackets(Sensors,Model,PacketType,t,Neighbors,dissink)
  
   global srp rrp sdp rdp sapv rapv list
   sap=0;      % Send a packet
   rap=0;      % Receive a packet
   
   if (strcmp(PacketType,'Data'))
       PacketSize=Model.DpacketLen;
   else
       PacketSize=Model.HpacketLen;
   end
   
   n=Model.n;
   Send=zeros(n,n);
   A=[];
   %reward=randi(n,n);
   
   %Sender for a send Packet
   for i=1:n
       if (mod(t,Sensors(i).DataRate)==0)
            if(Sensors(i).E>0)
               [nextHop] = SelectNextHop(i,Model, Neighbors, Sensors,dissink,list);
               % Sent a packet if have any neighbors
               if (nextHop ~= -1)
                   Send(i,nextHop)=1;
                   sap=sap+1;
                   sapv(i)=sapv(i)+1;
                   list(i)=1;
                   Sensors(i).E=Sensors(i).E- ...
                       (Model.ETX*PacketSize + Model.Efs*PacketSize);
                   Sensors(i).T=Sensors(i).T+(PacketSize*Model.Ts);
                    
               end
            end
       end
       for b=1:length(Sensors(i).Buffer)
           if (Sensors(i).E>0 && Sensors(i).Buffer(b)~=0)
               [nextHop] = SelectNextHop(i,Model, Neighbors, Sensors,dissink);
               % Sent a packet if have any neighbors
               if (nextHop ~= -1)
                   Send(i,nextHop)=1;
                   sap=sap+1;
                   sapv(i)=sapv(i)+1;
                   Sensors(i).E=Sensors(i).E- ...
                       (Model.ETX*PacketSize + Model.Efs*PacketSize);
                   Sensors(i).T=Sensors(i).T+(PacketSize*Model.Ts);
                    Sensors(i).Buffer(b)=0;
                    
               end
           end
       end
   end
   
   %Receiver for Receive Packet
   for i=1:n
       for j=1:n
           if (Send(i,j)==1)
               %Received a Packet
                if(Sensors(i).E>0 && Sensors(j).E>0)
                    rap=rap+1;
                    rapv(j)=rapv(j)+1;
                    Sensors(j).E =Sensors(j).E- ...
                        ((Model.ERX + Model.EDA)*PacketSize);
                    Sensors(j).T=Sensors(j).T+(PacketSize*Model.Tr);
                    A=find(Sensors(j).Buffer==0);
                    Sensors(j).Buffer(A(1))=PacketSize;
                end
           end
       end
   end
   
   % Thermal management
   for i=1:n
       Sensors(i).T=Sensors(i).T-Model.Tc;
   end
   
   if (strcmp(PacketType,'Data'))
        sdp=sdp+sap;
        rdp=rdp+rap;
    else       
        srp=srp+sap;
        rrp=rrp+rap;
    end
   
  
end