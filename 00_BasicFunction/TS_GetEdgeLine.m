function Edgebw = TS_GetEdgeLine(bw)

if ~islogical(bw)
    error('input is not Logical')
end

bw = padarray(imdilate(bw,true(3)),[1 1],'symmetric');
bw = bwmorph(bw,'remove');
Edgebw = bw(2:end-1,2:end-1);