function [ Output ] = RotAngConvFix( Input, sequence )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
sequence = fliplr(sequence);
sequence = lower(sequence);

if ndims(Input) == 2
    if isequal(size(Input), [3, 3])
        if det(Input) - 1 < 0.001 % Rotation matrix
            Output = Rot2Ang(Input, sequence);
        end
    else    %one frame theta
        disp(size(Input));
        Output = Ang2Rot(Input, sequence);
    end
if ndims(Input) == 3    %Rotation matrix
    disp(size(Input));
    Output = Rot2Ang(Input, sequence);
end

end

