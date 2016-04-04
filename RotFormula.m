function [ R ] = RotFormula( sequence )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

sequence = lower(sequence);
theta_num = int32(sequence) - 119;
theta = sym(sym('theta_%d', size(theta_num)), 'real');
a = sym('a');

R = sym(zeros(3, 3, 3));
Rot = eye(3);

R(:, :, 1) = [1, 0, 0; 0, cos(a), -sin(a); 0, sin(a), cos(a)]; %x
R(:, :, 2) = [cos(a), 0, sin(a); 0, 1, 0; -sin(a), 0, cos(a)]; %y
R(:, :, 3) = [cos(a), -sin(a), 0; sin(a), cos(a), 0; 0, 0, 1]; %z

for i = 1: size(theta_num, 2)
   Rot = Rot * subs(R(:, :, theta_num(1, i)), theta(i));
end

R = Rot;



end

