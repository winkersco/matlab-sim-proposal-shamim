function HopToSink = calculateHopToSink(Model, Sensors, Neighbors)

    n = Model.n;
    HopToSink = zeros(1, n + 1);

    for i = 1:n
        HopToSink(i) = -1;
    end

    for i = n + 1:-1:1
        for j = 1:n + 1
            if (Neighbors(i, j) == 1 && Sensors(j).E > 0)
                if (HopToSink(i) ~= -1 && (HopToSink(j) == -1 || HopToSink(j) > HopToSink(i) + 1))
                    HopToSink(j) = HopToSink(i) + 1;
                end
            end
        end
    end
end
