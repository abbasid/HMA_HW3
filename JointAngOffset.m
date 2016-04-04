function [ Rc ] = JointAngOffset( Rs, Rd )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
Rc = zeros(size(Rs));

for i = 1 : size(Rc, 3)
   Rc(:, :, i) = Rs(:, :, i)' * Rd(:, :, i); 
end

end

