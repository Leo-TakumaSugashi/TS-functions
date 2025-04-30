function [outA,outB,shift_matrix] = TS_3dReposi_v2(A,B,Reso,varargin)
% [outA,outB,shift_matrix] = TS_3dReposi_proto(A,B,Reso,{'crop'})
% 1st step Depth size Equaler
% [A,B,overrap] = TS_3dReposiPre_proto(A,B,{'crop'});
% 2nd EachSlice
% [outA,outB,shift_matrix] = TS_3dReposi_proto(A,B)
%  outA and outB is reposit only Depeth axis..
% You need next code...
%   [outputA,outputB] = TS_Shift2pad2d(A,B,shift_matrix)


[A,B,overrap] = TS_3dReposiPre_v2(A,B,Reso,varargin{:});
shift_matrix = zeros(size(A,3),2);

for n = 1:size(A,3)
    sh = TS_SliceReposition(A(:,:,n,1,1),B(:,:,n,1,1));
    shift_matrix(n,:) = sh;
end
outA = A;
outB = B;












% % % % % % Old version %     %% % % % % %
% % % % % %% 2nd EachSlice
% % % % % S_coef = 1; %% slice/unit
% % % % % MIP_num = round(50 /Reso(3)); % slice/unit
% % % % % DeepRef = abs(overrap);
% % % % % if DeepRef == 0
% % % % %     DeepRef = 1;
% % % % % end
% % % % % % Deep
% % % % % Deep_A = max(A(:,:,DeepRef:DeepRef+MIP_num,1,1),[],3);
% % % % % Deep_B = max(B(:,:,DeepRef:DeepRef+MIP_num,1,1),[],3);
% % % % % Deep_shift = TS_SliceReposition(Deep_A,Deep_B);
% % % % % Deep_ind = DeepRef ;
% % % % % 
% % % % % % Surface
% % % % % Surface_A = max(A(:,:,end-MIP_num-S_coef:end-S_coef,1,1),[],3);
% % % % % Surface_B = max(B(:,:,end-MIP_num-S_coef:end-S_coef,1,1),[],3);
% % % % % Surface_shift = TS_SliceReposition(Surface_A,Surface_B);
% % % % % Surface_ind = size(A,3) - S_coef;
% % % % % 
% % % % % %% output
% % % % % % vp_y = interp1([Deep_ind Surface_ind],[Deep_shift(1) Surface_shift(1)],...
% % % % % %     Deep_ind:Surface_ind,'linear');
% % % % % % vp_x = interp1([Deep_ind Surface_ind],[Deep_shift(2) Surface_shift(2)],...
% % % % % %     Deep_ind:Surface_ind,'linear');
% % % % % % vp = cat(2,vp_y(:),vp_x(:));
% % % % % % 
% % % % % % 
% % % % % % if Deep_ind>1
% % % % % %     vp = padarray(vp,[Deep_ind-1 0],'replicate','pre');
% % % % % % end
% % % % % % 
% % % % % % if Surface_ind<size(A,3)
% % % % % %     vp = padarray(vp,[size(A,3)-Surface_ind 0],'replicate','post');
% % % % % % end
% % % % % 
% % % % % % % edit 2016 12 02
% % % % % IncliX = (Deep_shift(2)- Surface_shift(2))/(Deep_ind - Surface_ind);
% % % % %  BiasX= Deep_shift(2) -IncliX * Deep_ind; 
% % % % % IncliY = (Deep_shift(1)- Surface_shift(1))/(Deep_ind - Surface_ind);
% % % % %  BiasY= Deep_shift(1) -IncliY * Deep_ind;
% % % % %  
% % % % % Func = @(x,Incli,Bias) Incli .* x + Bias;
% % % % % vp_y = linspace(Func(1,IncliY,BiasY),Func(size(A,3),IncliY,BiasY),size(A,3));
% % % % % vp_x = linspace(Func(1,IncliX,BiasX),Func(size(A,3),IncliX,BiasX),size(A,3));
% % % % % vp = cat(2,vp_y(:),vp_x(:));
% % % % % 
% % % % % 
% % % % % 
% % % % % shift_matrix = vp;
% % % % % outA = A;
% % % % % outB = B;
% % % % % 
% % % % % 






