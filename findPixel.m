function pos = findPixel( pList, x, y)
%findPixel Summary of this function goes here
%   Detailed explanation goes here

[N, ~] = size(pList);

for i = 1:N
    if pList(i,1) == x && pList(i,2) == y
        pos = i;
        return
    end
end

pos = 0;

end

