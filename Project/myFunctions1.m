classdef myFunctions1
    methods(Static)
        function dot_delay()
            fprintf("\n")
            for i=1:3
                pause(0.3)
                fprintf(".")
            end
            pause(1)
            fprintf("\n")
        end

        function stereo_delay(Stereo, delay, Fs, LINE)
            sound_delay = zeros(size(Stereo,1) + delay, 2);
            
            SL = 1:size(Stereo,1);
            SR = delay:size(Stereo,1) + delay-1;
            
            sound_delay(SL,1) = Stereo(:,1);
            sound_delay(SR,2) = Stereo(:,2);
            
            audiowrite(LINE, sound_delay, Fs);
        end

        function stereo_attenuation(Stereo, delay, Fs, LINE, X)
            sound_delay = zeros(size(Stereo,1) + delay, 2);
            
            gain = zeros(length(Stereo), 1) + X;
            gain = gain(:);
            
            SL = 1:size(Stereo,1);

            if delay==0
                SR = 1:size(Stereo,1);
            else
                SR = delay:size(Stereo,1) + delay-1;
            end

            sound_delay(SL,1) = Stereo(:,1);
            sound_delay(SR,1) = Stereo(:,2).*gain;
            
            audiowrite(LINE, sound_delay, Fs);
        end
    end
end