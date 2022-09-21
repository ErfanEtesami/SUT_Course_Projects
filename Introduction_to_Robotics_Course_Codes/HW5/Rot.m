function R = Rot(axis, angle)
% Homogenous rotation about "axis" for the amount of "angle"

axis = upper(axis);

if(axis == 'X')
    R = [1, 0, 0, 0;
         0, cosd(angle), -sind(angle), 0;
         0, sind(angle), cosd(angle), 0;
         0, 0, 0, 1];
end

if(axis == 'Y')
    R = [cosd(angle), 0, sind(angle), 0;
         0, 1, 0, 0;
         -sind(angle), 0, cosd(angle), 0;
         0, 0, 0, 1];
end

if(axis =='Z')
    R = [cosd(angle), -sind(angle), 0, 0;
         sind(angle), cosd(angle), 0, 0;
         0, 0, 1, 0;
         0, 0, 0, 1];
end

end
