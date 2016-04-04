function [ Output ] = RotAngConvert( Input, sequence )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
sequence = lower(sequence);
disp(size(size(Input), 1));
if size(size(Input), 2) == 2 
    if isequal(size(Input), [3, 3])
        if det(Input) - 1 < 0.001 % Rotation matrix
            Output = Rot2Ang(Input, sequence);
        else
            Output = Ang2Rot(Input, sequence);
        end
    else    %one frame theta
        Output = Ang2Rot(Input, sequence);
    end
else size(size(Input), 2) == 3    %Rotation matrix
    Output = Rot2Ang(Input, sequence);
end

end
