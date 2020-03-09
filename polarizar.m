%polarizar punto dadas las cordenadas de contorno
function [ro, angle] = polarizar( Cx, Cy, X ,Y)
    ro = sqrt((Cx - X).^2 + (Cy - Y).^2);
    angle = atan2d(Y-Cy, X-Cx);
    if angle < 0
        angle = angle + 360;
    end
end