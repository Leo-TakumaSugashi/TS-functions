function OutPut = TSresetdata(imgList)
warning([mfilename ' : This function will be delete from TS-toolbox.'])
for n = 1:size(imgList,2)
    outdata = imgList(n);
    OutPut(n).Name = outdata.Name;
    OutPut(n).FOV  = OutFOV(outdata);
    OutPut(n).Unit = OutUnit(outdata);
    OutPut(n).Size = OutSize(outdata);
    OutPut(n).Image = permute(cat(5,outdata.Channels.Image),[2 1 3 4 5]);
    OutPut(n).Processed.Image = [];
    OutPut(n).ChannelsNUM = size(OutPut(n).Image,5);
    OutPut(n).Maximum = max(OutPut(n).Image(:));
end
function A = OutFOV(outdata)
A = zeros(1,size(outdata.Dimensions,1));
for n = 1:size(outdata.Dimensions,1)
    A(n) = str2double(outdata.Dimensions(n).Length);    
end
B = A(1:2);
A(1:2) = flip(B,2);

function A = OutUnit(outdata)
STR = cat(1,outdata.Dimensions.Unit);
A = [];
for n = 1:size(STR,1)
    A = [A ' ' STR(n,:)];
end


function A = OutSize(outdata)
[x,y,z,t] = size(outdata.Channels(1).Image);
A = [y,x,z,t];