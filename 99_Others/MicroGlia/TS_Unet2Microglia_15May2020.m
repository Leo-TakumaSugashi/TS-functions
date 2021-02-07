function x = TS_Unet2Microglia_15May2020(net,RGB)
%             vol = RGB(:,:,2);
            vol= RGB;
%             volSize = size(vol,(1:2));
%             
%             inputPatchSize = obj.Input_PatchSize;
%             outPatchSize = obj.OutPut_PatchSize;
%             classNames = obj.ClassNames;
%             
%             padSizePre  = (inputPatchSize(1:2)-outPatchSize(1:2))/2;
%             padSizePost = (inputPatchSize(1:2)-outPatchSize(1:2))/2 + (outPatchSize(1:2)-mod(volSize,outPatchSize(1:2)));
%             volPaddedPre = padarray(vol,padSizePre,'symmetric','pre');
%             volPadded = padarray(volPaddedPre,padSizePost,'symmetric','post');
%             [heightPad,widthPad,depthPad,~] = size(volPadded);
            [height,width,depth,~] = size(vol);
%             
%             depth = 1;
%             tempSeg = categorical(zeros([height,width,depth],'uint8'),[0;1],classNames);

            % Overlap-tile strategy for segmentation of volumes.
            %keyboard
%             for j = 1:outPatchSize(2):widthPad-inputPatchSize(2)+1
%                 for i = 1:outPatchSize(1):heightPad-inputPatchSize(1)+1
%                     patch = volPadded( i:i+inputPatchSize(1)-1,...
%                         j:j+inputPatchSize(2)-1,:);
%                     patchSeg = semanticseg(patch,net);
%                     tempSeg(i:i+outPatchSize(1)-1, ...
%                         j:j+outPatchSize(2)-1) = patchSeg;
%                 end            
%             end
            
            % Crop out the extra padded region.
%             tempSeg = tempSeg(1:height,1:width,1:depth) ;
            tempSeg = semanticseg(RGB,net);
            %%
            [~,~,x] = unique(tempSeg);
            x = reshape(x,height,[]) ~=1;
           
            
        end