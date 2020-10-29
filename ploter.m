function ploter(Sensors, Model, Area, SendFromSense, t)
    %% Developed by Shamim Ahmadinezhad

    hold off; %clear figure
    n = Model.n;

    for i = 1:n
        %check dead node
        if (Sensors(i).E > 0)
            if (Model.BlackholeAttacker(Sensors(i).id) == 0 && Model.GrayholeAttacker(Sensors(i).id) == 0)
                plot(Sensors(i).xd, Sensors(i).yd, 'o');
            elseif (Model.BlackholeAttacker(Sensors(i).id) == 1 || Model.GrayholeAttacker(Sensors(i).id) == 1) %Blackhole attacker
                plot(Sensors(i).xd, Sensors(i).yd, 'ks', 'MarkerSize', 10, 'MarkerFaceColor', 'k');
            end
        else
            plot(Sensors(i).xd, Sensors(i).yd, 'red .');
        end
        
        % show RR
        th = 0:pi/50:2*pi;
        xunit = Model.RR/2 * cos(th) + Sensors(i).xd;
        yunit = Model.RR/2 * sin(th) + Sensors(i).yd;
        plot(xunit, yunit);

        hold on;

    end

    plot(Sensors(n + 1).xd, Sensors(n + 1).yd, 'g*', 'MarkerSize', 15);
    
    for i = 1:n
        for j = 1:n+1
            if (Sensors(i).E > 0 && Sensors(j).E > 0)
                if (SendFromSense(i, j) == 1)
                    XL = [Sensors(i).xd, Sensors(j).xd];
                    YL = [Sensors(i).yd, Sensors(j).yd];
                    hold on
                    quiver( XL(1),YL(1),XL(2)-XL(1),YL(2)-YL(1),0 ,'MaxHeadSize',0.5);
                end
            end
        end
    end
    
    title(sprintf('time=%d', t))
    
    xlim([0 Area.x])
    ylim([0 Area.y])
    grid on
    axis square
    legend('Location','NorthEastOutside');

end
