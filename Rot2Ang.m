function [ theta ] = Rot2Ang(Rot, sequence) % Rot 3 by 3 by n

sequence = lower(sequence);
theta_sequence = int32(sequence) - 119;
unit_vector = eye(3);
Rot_after_circshift = zeros(size(Rot));
theta = zeros(size(Rot, 3), 3);

for i = 1: size(Rot, 3)
    Rot_after_circshift(:, :, i) = circshift(Rot(:, :, i), [-theta_sequence(1, 1) + 1, -theta_sequence(1, 3) + 1]);
    if theta_sequence(1, 1) == theta_sequence(1, 3)
        theta(i, 2) = acosd(Rot_after_circshift(1, 1, i));
        isTheta_1 = ismember(cross(unit_vector(theta_sequence(1), :), unit_vector(theta_sequence(2), :)), unit_vector);
        if isTheta_1
            theta(i, 1) = atan2d(Rot_after_circshift(2, 1, i), -Rot_after_circshift(3, 1, i));
            theta(i, 3) = atan2d(Rot_after_circshift(1, 2, i), Rot_after_circshift(1, 3, i));
        else
            theta(i, 1) = atan2d(Rot_after_circshift(3, 1, i), Rot_after_circshift(2, 1, i));
            theta(i, 3) = atan2d(Rot_after_circshift(1, 3, i), -Rot_after_circshift(1, 2, i));
        end
    else
        isTheta_2 = ismember(cross(unit_vector(theta_sequence(1), :), unit_vector(theta_sequence(3), :)), unit_vector);
        if isTheta_2
            theta(i, 2) = asind(-Rot_after_circshift(1, 1, i));
            theta(i, 1) = atan2d(Rot_after_circshift(3, 1, i), Rot_after_circshift(2, 1, i));
            theta(i, 3) = atan2d(Rot_after_circshift(1, 3, i), Rot_after_circshift(1, 2, i));
        else
            theta(i, 2) = asind(Rot_after_circshift(1, 1, i));
            theta(i, 1) = atan2d(-Rot_after_circshift(2, 1, i), Rot_after_circshift(3, 1, i));
            theta(i, 3) = atan2d(-Rot_after_circshift(1, 2, i), Rot_after_circshift(1, 3, i));
        end
    end
end



end
