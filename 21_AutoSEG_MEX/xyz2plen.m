function PieceLength = xyz2plen(xyz,Reso)
% xyz position data caluculate to piece length
PieceLength =  sqrt(nansum(diff((xyz-1).*repmat(Reso,size(xyz,1),1),1,1).^2 ,2));
PieceLength = cat(1,0,PieceLength);