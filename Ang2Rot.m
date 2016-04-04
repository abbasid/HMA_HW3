function [ R ] = Ang2Rot( theta, sequence )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

sequence = lower(sequence);
theta_sequence = int32(sequence) - 119;
a = sym('a');
% disp(theta_sequence);
%disp(size(theta, 1));
R = zeros(3, 3, size(theta, 1));
Rot(:, :, 1) = [1, 0, 0; 0, cos(a), -sin(a); 0, sin(a), cos(a)]; %x
Rot(:, :, 2) = [cos(a), 0, sin(a); 0, 1, 0; -sin(a), 0, cos(a)]; %y
Rot(:, :, 3) = [cos(a), -sin(a), 0; sin(a), cos(a), 0; 0, 0, 1]; %z
%disp(eval(subs(Rot(:, :, theta_sequence(1)), a, theta(1, 1))));

for i = 1 : size(R, 3)
   R(:, :, i) = eval(subs(Rot(:, :, theta_sequence(1)), a, theta(i, 1))) * eval(subs(Rot(:, :, theta_sequence(2)), a, theta(i, 2))) * eval(subs(Rot(:, :, theta_sequence(3)), a, theta(i, 3)));
end

end

