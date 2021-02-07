classdef Capillaro_MatFunctions
    properties
        
        Version(1,:) char = 'v2019Alpha'
        Update(1,:) char = '2020-08-08'        
        Editors(1,:) char = 'T.Sugashi'
        mFilePath = GetHELP
        % % video data 
        VideoExtension(1,:) char ...
            {mustBeMember(VideoExtension,{'.avi','.mp4'})} = '.avi'
        VideoInfomation(1,:) struct 
        VideoData struct  %% shuld be empty to save memory?
        AdjImage(:,:,:,:) uint8 {mustBeNumeric} %% shuld be empty to save memory?
        GrayImage(:,:,1,:) uint8 {mustBeNumeric}
        ReferenceSliceInd(1,:) = 1 % using XYreposit
        ReferenceSliceImage
        DetectedCapillaries
        XYSize(1,:) {mustBeNumeric}
        FOV(1,2) {mustBeNumeric}
        % % Analysis Coef.
        ContrastLim = [0.1, 0.9]
        GetDuration(1,1) double...
            {mustBeReal, mustBeFinite}= 10 %,mustBeGreaterThanOrEqual(GetDuration,10)?
        StartTime(1,1) double...
            {mustBeReal, mustBeFinite}= 0
        InputPSF_KernelSize(1,1) = 17
        InputPSF_Sigma(1,1) = 4
        InputPSF_VerticalCoef = 0.0001
        BWReferenceInd = [1:10]
        PreProcessingMedSize = [5 5]
        BWblockSize = 50 % unit pix.
        EdgeSize = 50; %% pixels
        bwcloseRsiz = 2; %% unit pix.
        bwopenRsiz = 2 %% unit pix.
        FirstCutLength = 30 % unit um
        TopNumFeautures = 10; %% using DetectFeatures2ROI_RepositXY
        ResamplingStep = 0.5 % unit um/pix
        SNRLimit = 1.6
        DiameterAnlysisNumel = 0.8
        % % Kymography
        WindSiz4Velo = [128 128]; % [X,T] pix
        % % Deep Learning (Unet)
        Input_PatchSize = [128 128 1]
        OutPut_PatchSize = [128 128 2]
        ClassNames = {'background'; 'Ves'}
        % % Function handles, and other
        Segment(1,1) struct          
        SegFunc = Segment_Functions
        SegViewFun = Sugashi_ReconstructGroup
        GUI = Sugashi_GUI_support
        
        UserData         
    end
    methods
        %% set up function
        function obj = set.Segment(obj,SEG)
            obj.Segment = obj.SegFunc.set_Segment(SEG);
        end
        function obj = set.XYSize(obj,siz)
            obj.XYSize = siz([1 2]);
        end
        %% main 
        
        function [outImage,predictedPSF] = Blind_Deconv(obj,Image,varargin)
            %[outputImage,predictedPSF] = Blind_Deconv(Image)
            %[outputImage,predictedPSF] = Blind_Deconv(Image,[slice index])
            %[outputImage,predictedPSF] = Blind_Deconv(Image,'green')
            %
            %KernelSiz = obj.InputPSF_KernelSize;
            %Sigma = obj.InputPSF_Sigma; 
            %VerticalCoef = obj.InputPSF_VerticalCoef;
            %outImage = Image;
            %Reso = obj.Resolution;
            %slind = 1:size(Image,4); AS slice index, must BE vector,
            %if, 'green' , predict PSF with RGB on 1st slice, then deconv
            %to only green channels.
                       
            KernelSiz = obj.InputPSF_KernelSize;
            Sigma = obj.InputPSF_Sigma; 
            VerticalCoef = obj.InputPSF_VerticalCoef;
            outImage = Image;
            siz = size(Image);
            obj.XYSize = siz(1:2);
            Reso = obj.Resolution;
            slind = 1:size(Image,4);
            HighSpeedTF = false;
            if nargin == 3
                val = varargin{1};
                if ischar(val)
                    if strcmpi(val,'green')
                        HighSpeedTF = true;
                    end
                else
                    if isvector(val)
                        slind = val;
                    end
                end                    
            end
            
            %% input PSF
            InPSF = fspecial('gaussian',KernelSiz,Sigma);
            ydata = 1:size(InPSF,1); %% pix. size,
            ydata = (ydata-1).*Reso(2); %% real size,
            ycoef = ydata *VerticalCoef;
            ycoef = repmat(ycoef(:),[1 size(InPSF,2)]);
            ycoef =  ycoef - nanmin(ycoef(:));
            % ycoef = ycoef./nansum(ycoef(:));
            ycoef(isnan(ycoef)) = 0;           
            InPSF = InPSF+ycoef/2 ;
            InPSF = ones(KernelSiz);
            InPSF = repmat(InPSF,[1 1 3]);
            % figure,imagesc(InPSF),title('Input PSF')
            %% loop
            im = Image(:,:,:,slind(1));
            [J,predictedPSF] = deconvblind(im,InPSF,20);
            if isscalar(slind)
                outImage = J;
            else
                if HighSpeedTF                                        
                    if ~ismatrix(J)
                        Image = Image(:,:,2,:);
                        outImage(:,:,2:end,:) = [];
                        J(:,:,[1 3]) = [];
                    end
                end
                
                GPU_ON = ~isempty(obj.GUI.GPUDevice);
                if GPU_ON
                    GPUmaxnumel = floor(330/15)*1024*786*3;%% GPU memory 8 GiB,experiment value...
                    loopNum = max(GPUmaxnumel/prod(obj.XYSize(1:2)),1);
                    if HighSpeedTF                    
                        Image3D = reshape(Image,size(Image,1),size(Image,2),[]);
                        loopSteps = 0:floor(loopNum):size(Image3D,3);
                        if loopSteps(end) ~=size(Image3D,3)
                            loopSteps = [loopSteps size(Image3D,3)];
                        end
                        fprintf(1,'%c','  GPU Deconv.  Progress in ...  0%')
                        for n = 1:length(loopSteps)-1
                            pwIndex = loopSteps(n)+1:loopSteps(n+1);
                            Image3D(:,:,pwIndex) = TS_deconvlucy(...
                                gpuArray(single(Image3D(:,:,pwIndex))),...
                                gpuArray(single(predictedPSF(:,:,2))));                                        
                            fprintf(1,'\b\b\b\b%3d',round(n/(length(loopSteps)-1)*100))
                            fprintf(1,'%c','%') 
                        end 
                        fprintf('\n')
                        outImage = reshape(Image3D,size(Image));
                    else
                        outImage(:,:,:,1) = J;
                        loopNum = loopNum/3;
                        Image4D = Image(:,:,:,2:end);
                        
                        loopSteps = 0:floor(loopNum):size(Image4D,4);
                        if loopSteps(end) ~=size(Image4D,4)
                            loopSteps = [loopSteps size(Image4D,4)];
                        end
                        fprintf(1,'%c','  GPU Deconv.  Progress in ...  0%')
                        for n = 1:length(loopSteps)-1
                            pwIndex = loopSteps(n)+1:loopSteps(n+1);
                            Image4D(:,:,:,pwIndex) = TS_deconvlucy(...
                                gpuArray(single(Image4D(:,:,:,pwIndex))),...
                                gpuArray(single(predictedPSF)));                                        
                            fprintf(1,'\b\b\b\b%3d',round(n/(length(loopSteps)-1)*100))
                            fprintf(1,'%c','%') 
                        end 
                        fprintf(1,'Done...\n');
                        Image4D = uint8(Image4D);
                        outImage(:,:,:,2:end) = Image4D;
                    end
                else
                    outImage(:,:,:,1) = J;
                    TS_WaiteProgress(0); %% if using pafor, comment out!!
                    for n =2:length(slind)
                        im = Image(:,:,:,slind(n));
                        outImage(:,:,:,n) = deconvlucy(im,predictedPSF); %% TOO SLOW
                        TS_WaiteProgress(n/length(slind)); %% if using pafor, comment out!!
                    end
                end
            end            
        end
        function RGBImage = AdjustContrast(obj,Image)
            % Input Image is uitn8 class
            RGBImage = zeros(...
                size(Image),...
                'like',uint8(1));            
            for n = 1:size(RGBImage,4)
                im = Image(:,:,:,n);
                % if wanna define each RGB color limit....
                % CLim = [min(reshape(im,3,[]),[],2), max(reshape(im,3,[]),[],2)];
                CLim = double([min(im(:)), max(im(:))]) / 255;
                CLim(1) = CLim(1)+obj.ContrastLim(1);
                CLim(2) = CLim(2)*obj.ContrastLim(2);
                RGBImage(:,:,:,n) = imadjust(im,CLim);
            end
        end
        function RepositImage = ShiftXY2RepositImage(~,Image,ShiftXY)            
            RepositImage = Image;
            ShiftXY = flip(ShiftXY,2);            
            for n = 1:size(Image,4)
                RepositImage(:,:,:,n) = ...
                    imtranslate(Image(:,:,:,n),ShiftXY(n,:));                
            end
        end
        function [skel,RGB,slice_bw_processed] = Slice2skel(obj,slice_im)
%             slice_im = TSmedfilt2(slice_im,obj.PreProcessingMedSize);
%             slice_im = TS_ShadingImage(slice_im,obj.Resolution);
%             slice_im = imcomplement(slice_im);
%             BWBlockSiz = round(obj.XYSize/obj.BWblockSize); %% 100 pix squared,roi
            EdgeIndex = true(size(slice_im,[1:2]));
            EdgeSiz = obj.EdgeSize;
            EdgeIndex(EdgeSiz+1:end-EdgeSiz,EdgeSiz+1:end-EdgeSiz) = false;
%             slice_im(EdgeIndex) = mode(slice_im(~EdgeIndex));
%             slice_im = double(slice_im);
%             slice_im = slice_im - min(slice_im(:));
%             slice_im = slice_im./max(slice_im(:));
%             [slice_bw,level] = TS_im2bw_block(slice_im,BWBlockSiz);
            
%             load('trainedUNetValid-24-Nov-2019-15-22-42-Epoch-10.mat', 'net')
            load('trainedUNetValid-13-Dec-2019-20-20-51-Epoch-10.mat')
            slice_bw = obj.ExtractCapillaries_unet_proto(net,slice_im);
            slice_bw(EdgeIndex) = false;
            % closing, 
            close_se = strel('disk',obj.bwcloseRsiz,0);
            slice_bw_processed = imclose(slice_bw,close_se);
            open_se = strel('disk',obj.bwopenRsiz,0);
            slice_bw_processed = imopen(slice_bw_processed,open_se);
            skel = bwskel(slice_bw_processed);
            
            R = slice_bw;R(or(skel,slice_bw_processed)) = false;
            B = slice_bw_processed;B(skel) = false;
            RGB = rgbproj(cat(3,R,skel,B));
        end
        function SEG = Skel2Segment(obj,skel,Mask)
            try
%             SEG = TS_AutoSegment_v2019Charly(...
%                 skel,obj.Resolution,[],obj.FirstCutLength);
            Reso = [obj.Resolution 1];
            SEG = TS_AutoSEG_mex(skel,Reso,[],obj.FirstCutLength);
            SEG = obj.SegFunc.set_Segment(SEG);
            if length(SEG.Pointdata)>1
                SEG = obj.SegFunc.ReSEG_Capillaro(SEG);
            end
            SEG.BaseMask = Mask; %% should add AutoSEG? if Volumedata, too big.
            SEG = obj.SegFunc.SmoothingSEG(SEG,obj.ResamplingStep,[1 1 1]);
%             SEG = obj.SegFunc.SmoothingSEG(SEG,0.5,[.5 .5 .5]);
            
            SEG = obj.SegFunc.AddSpatialPhysicalQuantity_Capillaro(SEG);
            SEG = obj.Add_IndexOf_Left_Right_Curve(SEG); 
            catch err
                error(err.message)
%                 keyboard
            end
        end
        
        function RMSEG = AutoSelectSEG(obj,NewSEG)
            MSEG = NewSEG;
            % MSEG = obj.SegFunc.AddSpatialPhysicalQuantity_Capillaro(NewSEG,'-f');            
            %% SNR cut 
            SNRLim = obj.SNRLimit;
            for n = 1:length(MSEG.Pointdata)
                Si = MSEG.Pointdata(n).Signal;
                Ni = MSEG.Pointdata(n).Noise;
                SNRi = Si./Ni;
                SNRi = nanmean(SNRi);
                if SNRi <SNRLim
                    MSEG.Pointdata(n).ID = -1 *abs(MSEG.Pointdata(n).ID);
                end
            end
            clear n Si Ni SNRi 
            %% Reseg            
            RMSEG = MSEG;
            NumelLim = obj.DiameterAnlysisNumel;
            DiamLim = 5;
            for n = 1:length(RMSEG.Pointdata)
                ID = RMSEG.Pointdata(n).ID;
                if ID>0
            %         Type = MSEG.Pointdata(n).Type;
            %         if strcmpi(Type,'Branch to Branch') || strcmpi(Type,'End to Branch')
                        Di = RMSEG.Pointdata(n).Diameter;
                        if sum(or(isnan(Di),Di<DiamLim))>numel(Di)*(1-NumelLim)
% %                             disp(ID)
                            RMSEG.Pointdata(n).ID = -1 *abs(ID);
                        end
            %         end
                end
            end
            obj.SegFunc.Segment = RMSEG;
            RMSEG = obj.SegFunc.ModifySEG();
            clear ID Type
            
        end
        
        function [SEG,NUM,PlotSort,plot_x,plot_y] = AutoSegmentCounter(obj,RMSEG,RGBim)
            SEG = RMSEG;
            if isfield(RMSEG.Pointdata,'StatisticsTF')
                TF = true;
                while TF
                    LP = length(RMSEG.Pointdata);
                    for id = 1:LP
                        if ~RMSEG.Pointdata(id).StatisticsTF
                            RMSEG.Pointdata(id) = [];
                            break
                        end
                    end
                    if id == LP
                        TF = false;
                    end
                end
            end
            %% view set up for check
            Reso = obj.Resolution;
            Xdata = (0:size(RGBim,2)-1) * Reso(2);
            Ydata = (0:size(RGBim,1)-1) * Reso(2);
            fgh = figure('Posi',[10 10 1024 768]);
            axh = axes('Position',[0 0 1 1]);
            imh = imagesc(axh,RGBim,'Xdata',Xdata,'Ydata',Ydata);            
            hold(axh,'on')
            ph = obj.SegViewFun.SEGview_Limit(axh,RMSEG,'same');
            ph.LineWidth = 3;
            ph.EdgeColor = [0 .8 .1];
            view(axh,2);
            setappdata(fgh,'EachData',[]);
            %%
            Pdata = RMSEG.Pointdata;
            DeleteIDList = [];
            TF = true;
            while TF
                plot_ids = zeros(1,length(Pdata));
                plot_angle = nan(1,length(plot_ids));
                plot_x = plot_ids;
                plot_y = plot_ids;
                for n = 1:length(Pdata)
                    xyz = Pdata(n).PointXYZ;
                    [checkY,sort_ind] = sort(xyz(:,2));
                    checkX = xyz(sort_ind,1);
                    plot_x(n) = checkX(1);
                    plot_y(n) = checkY(1);
                    plot_ids(n) = Pdata(n).ID;
                end
                [plot_x,sort_ind] = sort(plot_x);
                plot_y = plot_y(sort_ind);

                plot_x = (plot_x -1) * Reso(1);
                plot_y = (plot_y -1) * Reso(2);

                plot_ids = plot_ids(sort_ind);
                ph2 = plot(axh,plot_x,plot_y,'*:');
                    ph2.Color = [.1 .1 .8];
                    ph2.LineWidth = 5;
                    ph2.MarkerSize = 7;
                for n = 2:length(plot_angle)-1
                    a1 = plot_x(n-1) - plot_x(n) ;
                    a2 = plot_y(n-1) - plot_y(n) ;
                    b1 = plot_x(n+1) - plot_x(n) ;
                    b2 = plot_y(n+1) - plot_y(n) ;    
                    CosTheta = (a1*b1 + a2*b2) /...
                        (sqrt(a1^2 + a2^2)*sqrt(b1^2 + b2^2));
                    plot_angle(n) = acos(CosTheta) *180/pi;
                    if plot_y(n) < max(plot_y([n-1,n+1]))
                        plot_angle(n) = 360 - plot_angle(n);
                    end    
                end
                delete_index = plot_angle <90;
                delete_ID = plot_ids(delete_index);
                DeleteIDList = cat(2,DeleteIDList,delete_ID);
                delete_Ind = obj.SegFunc.ID2Index(delete_ID,cat(1,Pdata.ID));
                Pdata(delete_Ind) = [];
                % % text
                y_margin = -3;
                for n = 1:length(plot_angle)
                    txh(n) = text(plot_x(n),plot_y(n)+y_margin,num2str(plot_angle(n),'%.1f'));
                    if plot_angle(n) < 90
                        txh(n).Color = [.9 .6 .6 ];
                    else
                        txh(n).Color = [.9 .9 .9];
                    end
                    txh(n).FontWeight = 'bold';
                end
                for n = 1:length(txh)
                    txh(n).FontSize = 25;
                end
                %%%%%%%%%%%%% ASOBI, lol
                pause(.5)%%%%%
                %%%%%%%%%%%%%
                drawnow
                Mov = getappdata(fgh,'EachData');
                if isempty(Mov)
                    Mov = getframe(axh);
                    PlotSort = plot_ids;
                else
                    Mov(end+1) = getframe(axh);
                end
                setappdata(fgh,'EachData',Mov)
                
                TF = sum(plot_angle<90) ~= 0;
                if TF 
                    delete(txh)
                    delete(ph2)
                    clear txh ph2
                end
            end
            
            NUM = length(Pdata);
            if isfield(RMSEG.Pointdata,'StatisticsTF')
                for delID = DeleteIDList
                    id = obj.SegFunc.ID2Index(delID,cat(1,SEG.Pointdata.ID));
                    SEG.Pointdata(id).StatisticsTF = false;
                end
            end
            SEG.ExisID = cat(1,Pdata.ID);
            SEG.VesselsCounter = NUM;            
        end
        
        function [SEG,NUM,PlotSort,plot_x,plot_y] = AutoSegmentCounter_4kusaka(obj,RMSEG)
            SEG = RMSEG;
            if isfield(RMSEG.Pointdata,'StatisticsTF')
                TF = true;
                while TF
                    LP = length(RMSEG.Pointdata);
                    for id = 1:LP
                        if ~RMSEG.Pointdata(id).StatisticsTF
                            RMSEG.Pointdata(id) = [];
                            break
                        end
                    end
                    if id == LP
                        TF = false;
                    end
                end
            end

            %%
            Reso = obj.Resolution;
            Pdata = RMSEG.Pointdata;
            DeleteIDList = [];
            TF = true;
            while TF
                plot_ids = zeros(1,length(Pdata));
                plot_angle = nan(1,length(plot_ids));
                plot_x = plot_ids;
                plot_y = plot_ids;
                for n = 1:length(Pdata)
                    xyz = Pdata(n).PointXYZ;
                    [checkY,sort_ind] = sort(xyz(:,2));
                    checkX = xyz(sort_ind,1);
                    plot_x(n) = checkX(1);
                    plot_y(n) = checkY(1);
                    plot_ids(n) = Pdata(n).ID;
                end
                [plot_x,sort_ind] = sort(plot_x);
                plot_y = plot_y(sort_ind);

                plot_x = (plot_x -1) * Reso(1);
                plot_y = (plot_y -1) * Reso(2);

                plot_ids = plot_ids(sort_ind);

                for n = 2:length(plot_angle)-1
                    a1 = plot_x(n-1) - plot_x(n) ;
                    a2 = plot_y(n-1) - plot_y(n) ;
                    b1 = plot_x(n+1) - plot_x(n) ;
                    b2 = plot_y(n+1) - plot_y(n) ;    
                    CosTheta = (a1*b1 + a2*b2) /...
                        (sqrt(a1^2 + a2^2)*sqrt(b1^2 + b2^2));
                    plot_angle(n) = acos(CosTheta) *180/pi;
                    if plot_y(n) < max(plot_y([n-1,n+1]))
                        plot_angle(n) = 360 - plot_angle(n);
                    end    
                end
                delete_index = plot_angle <90;
                delete_ID = plot_ids(delete_index);
                DeleteIDList = cat(2,DeleteIDList,delete_ID);
                delete_Ind = obj.SegFunc.ID2Index(delete_ID,cat(1,Pdata.ID));
                Pdata(delete_Ind) = [];
                % % text
                
                TF = sum(plot_angle<90) ~= 0;

            end
            PlotSort = [];
            NUM = length(Pdata);
%             if isfield(RMSEG.Pointdata,'StatisticsTF')
                for delID = DeleteIDList
                    id = obj.SegFunc.ID2Index(delID,cat(1,SEG.Pointdata.ID));
                    SEG.Pointdata(id).StatisticsTF = false;
                end
%             end
            SEG.ExisID = cat(1,Pdata.ID);
            SEG.VesselsCounter = NUM;            
        end
        %% suport function
        % % basic Reposition function
        function ShiftXY = RepositXY(obj,B)
            B = squeeze(B);
            A = mean(B(:,:,obj.ReferenceSliceInd),3);
            if ~ismatrix(A)
                error('Input data is not Matrix.')
            end
            sizB = [size(B,1), size(B,2)];
            if min(size(A) == sizB) == false
                error('Input size is A =~ B...')
            end
            if ndims(B)>3
                error('Input Movement object data is over 3D')
            end

            siz = (size(A)-1)/2;
            
            ShiftXY = zeros(size(B,3),2);
            for k = 1:size(B,3)
                nA = single(A);
                nA = (nA - min(nA(:))) / (max(nA(:)) - min(nA(:)));
                nB = single(B(:,:,k));
                nB = (nB - min(nB(:))) / (max(nB(:)) - min(nB(:)));

                D = ifftshift(ifft2(fft2(nA).*conj(fft2(nB))));
                [~,Ind1] = max(D(:));                
                Ind = Ind1;                
                [y,x] = ind2sub(size(D),Ind);
                shift_siz = round([y x] - siz -1.1); %% 1.1 is adjusment coef
                ShiftXY(k,:) = shift_siz;
            end            
        end
        % % detect Feautures
        function ShiftXY = DetectFeatures2ROI_RepositXY(obj,B)
            % obj.ReferenceSliceInd
            % obj.EdgeSize
            
            B = squeeze(B);
            A = mean(B(:,:,obj.ReferenceSliceInd),3);
            if ~ismatrix(A)
                error('Input data is not Matrix.')
            else
                A = feval(class(B),A);
            end
            
            EdgeSiz = obj.EdgeSize;
            Xlim = [EdgeSiz+1, obj.XYSize(1)-EdgeSiz];
            Ylim = [EdgeSiz+1, obj.XYSize(2)-EdgeSiz];
            P = detectSURFFeatures(A);
            OverAllFactor = cat(1,P.Location);
            TFx = and(OverAllFactor(:,1)>Xlim(1),Xlim(2)>OverAllFactor(:,1));
            TFy = and(OverAllFactor(:,2)>Ylim(1),Ylim(2)>OverAllFactor(:,2));
            TF = and(TFx,TFy);
            OverAllFactor = OverAllFactor(TF,:);
            TOP10 = min(size(OverAllFactor,1), obj.TopNumFeautures);
            if TOP10 ==0 
                error(['Analysis Error in ' mfilename])
            end
            ROIsiz = ceil(100 ./ obj.Resolution +1); %% 100 um rectangle.
            ROIx = 1:ROIsiz(1); ROIx = ROIx - ceil((ROIx-1)/2);
            ROIy = 1:ROIsiz(2); ROIy = ROIy - ceil((ROIy-1)/2);
            ShiftXY = nan(size(B,3),2,TOP10);
            for n = 1:TOP10
                Center = round(OverAllFactor(n,:));
                xdata = ROIx+Center(1);
                xdata(xdata<1) = [];xdata(xdata>obj.XYSize(1)) = [];
                ydata = ROIy+Center(2);
                ydata(ydata<1) = [];ydata(ydata>obj.XYSize(2)) = [];    
                ROI = B(ydata,xdata,:);
                ShiftXY(:,:,n) = obj.RepositXY(ROI);
            end
            ShiftXY = nanmean(ShiftXY,3);
        end
        
        % % xcorr2
        function [RePositInf1 , CCmaximum1] = TSXCORR2(obj,ROI1)
            
            ROI1 = ROI1(...
                obj.EdgeSize+1:end-obj.EdgeSize,...
                obj.EdgeSize+1:end-obj.EdgeSize,...
                :,:);
            
            RePositInf1 = zeros(size(ROI1,4),2);
            CCmaximum1 = nan(size(ROI1,4),1);
            ROI1 = squeeze(ROI1);
            Temp = mean(ROI1(:,:,obj.ReferenceSliceInd),3);
            R(1:size(ROI1,3)) = struct('shift',[]);
            keyboard
            parfor n = 1:size(ROI1,3)
                fprintf('.')
                CC = normxcorr2(double(Temp),double(ROI1(:,:,n)));
                len = double(ceil(size(CC)/2));
                [y,x] = find(CC==max(CC(:)));
                if ~isempty(y)
                    CCmaximum1(n) = max(CC(:));
%                     RePositInf1(n,1) = double(y(1))-len(1);
%                     RePositInf1(n,2) = double(x(1))-len(2);
                    Rs = nan(1,2);
                    Rs(1) = double(y(1))-len(1);
                    Rs(2) = double(x(1))-len(2);
                    R(n).shift = Rs;
                end                
            end
            fprintf('\n')
            RePositInf1 = cat(1,R.shift);
        end
        %% Deep learning
        function x = ExtractCapillaries_unet_proto(obj,net,RGB)
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
        
        %% flow / Kymograph
        function M2SEG = Output_Velocity_proto(obj,MSEG,RDImage,FPS)
            M2SEG = obj.Add_IndexOf_Left_Right_Curve(MSEG);
            for ID = 1:length(M2SEG.Pointdata)
                if isnan(M2SEG.Pointdata(ID).LeftCurveRight_Label(1))
                    nanind = ID;
                end
            end
            M2SEG.Pointdata(nanind) = [];
            for ID = 1:length(M2SEG.Pointdata)
                siz = size(M2SEG.Pointdata(ID).PointXYZ,1);
                M2SEG.Pointdata(ID).VelocityMean = nan(siz,1);
                if isnan(M2SEG.Pointdata(ID).LeftCurveRight_Label(1))
                    continue
                end
                if sort(M2SEG.Pointdata(ID).LeftCurveRight_Label) ~= ...
                        M2SEG.Pointdata(ID).LeftCurveRight_Label
                    M2SEG.Pointdata(ID).PointXYZ = ...
                        flip(M2SEG.Pointdata(ID).PointXYZ);
                    M2SEG.Pointdata(ID).Diameter = ...
                        flip(M2SEG.Pointdata(ID).Diameter,2);
                    M2SEG.Pointdata(ID).Signal = ...
                        flip(M2SEG.Pointdata(ID).Signal,2);
                    M2SEG.Pointdata(ID).Noise = ...
                        flip(M2SEG.Pointdata(ID).Noise,2);
                    M2SEG.Pointdata(ID).Theta = ...
                        flip(M2SEG.Pointdata(ID).Theta);
                    M2SEG.Pointdata(ID).NewXYZ = ...
                        flip(M2SEG.Pointdata(ID).NewXYZ);
                    M2SEG.Pointdata(ID).OriginalPointXYZ = ...
                        flip(M2SEG.Pointdata(ID).OriginalPointXYZ);
                    M2SEG.Pointdata(ID).Length_from_Branch = ...
                        flip(M2SEG.Pointdata(ID).Length_from_Branch);
                    M2SEG.Pointdata(ID).SphereFitRadius = ...
                        flip(M2SEG.Pointdata(ID).SphereFitRadius);
                    M2SEG.Pointdata(ID).SphereFitUnitVector = ...
                        flip(M2SEG.Pointdata(ID).SphereFitUnitVector);
                    M2SEG.Pointdata(ID).SphereFitScalar = ...
                        flip(M2SEG.Pointdata(ID).SphereFitScalar);
                    M2SEG.Pointdata(ID).LeftCurveRight_Label = ...
                        flip(M2SEG.Pointdata(ID).LeftCurveRight_Label);
                end
            end

            % %% Kymograph
            ID = cat(1,M2SEG.Pointdata.ID);
            ID = ID(ID>0);
            RDImage = single(squeeze(RDImage));
            zsiz = size(RDImage,3);
            
            for indexID =1:length(ID)        
                id = obj.SegFunc.ID2Index(ID(indexID),cat(1,M2SEG.Pointdata.ID));
                xy = M2SEG.Pointdata(id).PointXYZ;
                X= repmat(xy(:,1)',[zsiz, 1]);
                Y= repmat(xy(:,2)',[zsiz, 1]);
                Z = repmat((1:zsiz)',[1 size(xy,1)]);
                Map = interp3(RDImage,X,Y,Z);       
                plen = obj.SegFunc.xyz2plen(M2SEG.Pointdata(id).PointXYZ,MSEG.ResolutionXYZ);

%                 Map = squeeze(Kdata(ceil(size(Kdata,1)/2),:,:))';
        %         [angle,utheta,uvar] = hybridvel(...
        %             Map,ShowingTF,SaveName or [],...
        %             ResoXY,TimeReso,WindwSize,SkipWidth,XRange,FunkyIndex);
                LabelName = {'Left';'Curve';'Right'};
                LabelVal = [-1 0 1];
                for ln = 1:length(LabelVal)            
                    selectindex = M2SEG.Pointdata(id).LeftCurveRight_Label == LabelVal(ln);
                    Width = 100; %% about 50 um
                    WidthLim = 10;
                    if LabelVal(ln) ==-1
                        wrange = [max(2,sum(selectindex)-2-Width)    sum(selectindex)-2];
                    elseif LabelVal(ln) ==0
                        wrange = [max(2,round(sum(selectindex)/2-Width/2)) ,...
                            min(sum(selectindex)-2, round(sum(selectindex)/2+Width/2)) ];
                    elseif LabelVal(ln) == 1
                        wrange = [2 min(sum(selectindex)-2,2+Width)];
                    end
                    try
                        if or(min(wrange)<1,WidthLim>sum(selectindex))
                            error('Wrange ERROR')
                        end
                        [~,~,~,tdata,veldata] = TS_hybridvel_v2019Alpha(...
                            Map(:,selectindex),false,[],...
                            mean(plen),1/FPS*1000,round(FPS*5),...
                            FPS,wrange, ID(indexID));
                        
                        veldata = veldata(:,2);
                        SelectIndex = false(size(selectindex));
                        p = find(selectindex,true,'first');
                        wrange = wrange + p -1;
                        SelectIndex(wrange(1):wrange(2)) = true;
                        veldata = nanmean(veldata);
                        M2SEG.Pointdata(ID(indexID)).VelocityMean(SelectIndex)= veldata;
                    catch err
                        warning(err.message)
                        tdata = nan;
                        veldata = nan;
                    end
                    disp(num2str(veldata))
                end
            end
        end
        
        
        function M2SEG = Output_Velocity_vTN(obj,MSEG,RDImage,FPS)
            M2SEG = obj.Add_IndexOf_Left_Right_Curve(MSEG);
%             nanind = false(length(M2SEG.Pointdata),1);
%             for ID = 1:length(M2SEG.Pointdata)
%                 if isnan(M2SEG.Pointdata(ID).LeftCurveRight_Label(2))
%                     nanind(ID) = true;
%                 end
%             end
%             M2SEG.Pointdata(nanind) = [];
            
            % %% Kymograph
            ID = cat(1,M2SEG.Pointdata.ID);
            ID = ID(ID>0);
            RDImage = single(squeeze(RDImage));
            zsiz = size(RDImage,3);
            Tstep = FPS * 1;
            for indexID =1:length(ID)        
                id = obj.SegFunc.ID2Index(ID(indexID),cat(1,M2SEG.Pointdata.ID));
                xy = M2SEG.Pointdata(id).PointXYZ;
                X= repmat(xy(:,1)',[zsiz, 1]);
                Y= repmat(xy(:,2)',[zsiz, 1]);
                Z = repmat((1:zsiz)',[1 size(xy,1)]);
                Kymograph = interp3(RDImage,X,Y,Z);       
                plen = obj.SegFunc.xyz2plen(M2SEG.Pointdata(id).PointXYZ,MSEG.ResolutionXYZ);
                delx = mean(plen(2:end));
                delt = 1/FPS*1000;
                SCL = M2SEG.Pointdata(id).StraightCurve_Label;
                LCRL = M2SEG.Pointdata(id).LeftCurveRight_Label;
                ALVL = M2SEG.Pointdata(id).ArtLoopVein_Label;
                try
                    [Timedata,Veldata,QCdata] = TN_hybridvel_v2019Beta(...
                                Kymograph,delx,delt,Tstep);
                catch err
                    warning(err.message)
                    SCLnum = TS_GetSameValueSort(SCL);
                    Veldata = nan(1,length(SCLnum));
                    Timedata = nan(1,length(SCLnum));
                    QCdata = [];
                end
                
                %% Repmat
                Ave_Vel = nanmean(Veldata,1);
                if nanmedian(Ave_Vel(:))>0
                    ALVL(LCRL<0) = 1;
                    ALVL(LCRL==0) = 0;
                    ALVL(LCRL>0) = -1;
                elseif nanmedian(Ave_Vel(:))<0
                    ALVL(LCRL>0) = 1;
                    ALVL(LCRL==0) = 0;
                    ALVL(LCRL<0) = -1;
                    Veldata = Veldata .* -1;
                    Ave_Vel = Ave_Vel .* -1;
                else
                    ALVL = nan;
                end
                %% 
                
                M2SEG.Pointdata(id).Velocity_Map = Veldata;
                M2SEG.Pointdata(id).Velocity_QCMap = QCdata;
                M2SEG.Pointdata(id).Velocity_Timedata = Timedata;
                M2SEG.Pointdata(id).Kymograph = Kymograph;
                M2SEG.Pointdata(id).ArtLoopVein_Label = ALVL;
                %% %%%%%%%%%%%%%%%%%%%%
%                 Veldata(QCdata) = nan;
%                 M2SEG.Pointdata(id).VelocityMean = Velmap;
                M2SEG.Pointdata(id).VelocityMean = Ave_Vel';
                %%%%%%%%%%%%%%%%%%%%%%%%%
            end
        end
        
        function M2SEG = Output_Velocity_vTest(obj,MSEG,RDImage,FPS)
            M2SEG = obj.Add_IndexOf_Left_Right_Curve(MSEG);
%             nanind = false(length(M2SEG.Pointdata),1);
%             for ID = 1:length(M2SEG.Pointdata)
%                 if isnan(M2SEG.Pointdata(ID).LeftCurveRight_Label(2))
%                     nanind(ID) = true;
%                 end
%             end
%             M2SEG.Pointdata(nanind) = [];
            
            % %% Kymograph
            ID = cat(1,M2SEG.Pointdata.ID);
            ID = ID(ID>0);
            RDImage = single(squeeze(RDImage));
            zsiz = size(RDImage,3);
            Tstep = FPS * 1;
            for indexID =1:length(ID)        
                id = obj.SegFunc.ID2Index(ID(indexID),cat(1,M2SEG.Pointdata.ID));
                xy = M2SEG.Pointdata(id).PointXYZ;
                X= repmat(xy(:,1)',[zsiz, 1]);
                Y= repmat(xy(:,2)',[zsiz, 1]);
                Z = repmat((1:zsiz)',[1 size(xy,1)]);
                Kymograph = interp3(RDImage,X,Y,Z);       
                plen = obj.SegFunc.xyz2plen(M2SEG.Pointdata(id).PointXYZ,MSEG.ResolutionXYZ);
                delx = mean(plen(2:end));
                delt = 1/FPS*1000;
                SCL = M2SEG.Pointdata(id).StraightCurve_Label;
                LCRL = M2SEG.Pointdata(id).LeftCurveRight_Label;
                ALVL = M2SEG.Pointdata(id).ArtLoopVein_Label;
                try
                    [TIMEdata,Veldata,QCdata] = TN_hybridvel_v2020Test(...
                                Kymograph,delx,delt,Tstep);
                catch err
                    warning(err)
                    SCLnum = TS_GetSameValueSort(SCL);
                    Veldata = nan(1,length(SCLnum));
                    QCdata = [];
                end
                
                %% Repmat
                Ave_Vel = nanmean(Veldata,1);
%                 Velmap = nan(size(xy,1),1);
%                 c = 1;                
%                 Velmap(1) = Ave_Vel(1);
%                 if ~isnan(TS_GetSameValueSort(SCL))
%                     for n = 2:length(SCL)
%                         if diff(SCL(n-1:n))~=0
%                             c = c + 1;
%                         end
%                         Velmap(n) = Ave_Vel(c);
%                     end 
%                 end
                if and(~isempty(find((LCRL==0),1)),nanmean(Ave_Vel)>0)
                    ALVL(LCRL<0) = 1;
                    ALVL(LCRL==0) = 0;
                    ALVL(LCRL>0) = -1;
                elseif nanmean(Ave_Vel)<0
                    ALVL(LCRL>0) = 1;
                    ALVL(LCRL==0) = 0;
                    ALVL(LCRL<0) = -1;
                    Veldata = Veldata .* -1;
                    Ave_Vel = Ave_Vel .* -1;
                end
                %% 
                
                M2SEG.Pointdata(id).Velocity_Map = Veldata;
                M2SEG.Pointdata(id).Velocity_QCMap = QCdata;
                M2SEG.Pointdata(id).Kymograph = Kymograph;
                M2SEG.Pointdata(id).ArteryCurveVenous_Label = ALVL;
                %% %%%%%%%%%%%%%%%%%%%%
%                 Veldata(QCdata) = nan;
%                 M2SEG.Pointdata(id).VelocityMean = Velmap;
                M2SEG.Pointdata(id).VelocityMean = Ave_Vel';
                %%%%%%%%%%%%%%%%%%%%%%%%%
            end
        end
        
        %% Statistics 
        
        function M2SEG = Add_StatisticsTF(obj,M2SEG,RGBim)
            Pdata = M2SEG.Pointdata;
            
            % 0th
            TF = true;
            while TF
                LP = length(Pdata);
                for id = 1:LP
                    if Pdata(id).ID<0
                        Pdata(id) = [];
                        break
                    end
                end
                if id == LP
                    TF = false;
                end
            end
            
            ID = cat(1,Pdata.ID);
            
            % 1st  is_LoopLabel
            for indexID = 1:length(ID)
                id = obj.SegFunc.ID2Index(ID(indexID),cat(1,M2SEG.Pointdata.ID));
                Pdata(id).StatisticsTF = true;
                ALV = Pdata(id).ArtLoopVein_Label;
                if isempty(ALV) || length(TS_GetSameValueSort(ALV))<3
                    Pdata(id).StatisticsTF = false;
                end
            end
            
            % 2nd is_StraightAV and enough_Len
            SP = 10; % sampling points as art, loop, vein
            for indexID = 1:length(ID)
                id = obj.SegFunc.ID2Index(ID(indexID),cat(1,M2SEG.Pointdata.ID));
                if Pdata(id).StatisticsTF
                    ALV = Pdata(id).ArtLoopVein_Label;
                    TF_Straight = Pdata(id).TF_straght;
                    ALen = length(find(ALV==1));
                    VLen = length(find(ALV==-1));
                    if max([ALen VLen] < (round(obj.WindSiz4Velo(1)/2)+SP)) || ...
                            sum(TF_Straight(1:(round(obj.WindSiz4Velo(1)/2)+SP)))>0.8*(obj.WindSiz4Velo(1)+SP) || ...
                            sum(TF_Straight(end-(round(obj.WindSiz4Velo(1)/2)+SP)+1:end))>0.8*(obj.WindSiz4Velo(1)+SP)
%                         disp()
                        Pdata(id).StatisticsTF = false;
                    end
                end
            end
            
            % 3rd naikaku??
%             keyboard

            % 4th enough_SegmentNumber
            M2SEG.Pointdata = Pdata;
            if sum(cat(1,Pdata.StatisticsTF))>0
                M2SEG = AutoSegmentCounter(obj,M2SEG,RGBim);
            end
            
            close
            
            % 5th Manual
            catStatisticsID = cat(1,M2SEG.Pointdata.StatisticsTF);
            if sum(catStatisticsID)>0
                TSEG = M2SEG;
                TSEG.Pointdata = M2SEG.Pointdata(catStatisticsID);
                Reso = obj.Resolution;
                Xdata = (0:size(RGBim,2)-1) * Reso(2);
                Ydata = (0:size(RGBim,1)-1) * Reso(2);
                fgh = figure('Posi',[10 10 1024 768]);
                axh = axes('Position',[0 0 1 1]);
                imh = imagesc(axh,RGBim,'Xdata',Xdata,'Ydata',Ydata);            
                hold(axh,'on')
                ph = obj.SegViewFun.SEGview_Limit(axh,TSEG,'same');
                ph.LineWidth = 3;
                ph.EdgeColor = [0 .8 .1];
                p = obj.SegViewFun.SEGview_Limit_text(gca,TSEG);
                for nn = 1:length(p)
                    p(nn).Color = [1 1 .3];
                    p(nn).FontSize = 16;
                    p(nn).FontWeight = 'bold';
                end

                prompt = 'Is this OK?? [y/n]: ';
                strTF = true;
                while strTF
                    str = input(prompt,'s');
                    if isempty(str)
                        str = 'y';
                    end
                    if max(strcmp(str,{'y','n'}))
                        strTF = false;
                    else
                        warning('Input Error')
                    end
                end
                prompt2 ='Input Delete IDs: \n';

                if strcmp(str,'n')
                    selIDsTF = true;
                    while selIDsTF
                        ManualDelID = input(prompt2);
                        catID = cat(2,M2SEG.Pointdata.ID);
                        [ManualDelIdx,Loc] = ismember(catID,ManualDelID);
                        if isempty(ManualDelIdx)
                            warning('Input Error')
                        else
                            for i = 1:length(ManualDelID)
                                M2SEG.Pointdata(Loc==i).StatisticsTF = false;
                            end
                            selIDsTF = false;
                        end
                    end
                end

                close(fgh)
            end
        end
        
        %% other dump, tried function
        function TFORM = EstimateGeometricTransformation(obj,B)
            B = squeeze(B);            
            A = mean(B(:,:,obj.ReferenceSliceInd),3);
            A = uint8(A);            
            [optimizer,metric] = imregconfig('monomodal');
            TransFormType = 'translation';
            %% %%%%%%%%%%%%%%%%
            TFORM(1:size(B,3)) = struct('tform',[],'Image',[]);
            TS_WaiteProgress(0)
            Pobj = gcp('nocreate');
            parfor n = 1:size(B,3)
                T = imregtform(B(:,:,n),A,TransFormType,optimizer,metric);
                TFORM(n).tform = T;
                outim = imwarp(B(:,:,n),T,'OutputView',imref2d(size(A)) );
                TFORM(n).Image = outim;
                if isempty(Pobj)
                    TS_WaiteProgress((n-1)/size(B,3))
                else
                    fprintf('.')
                end
            end
            TS_WaiteProgress(1)
        end        
        function TFORM = DetectSURFFeaturesReposit(obj,B)
            TIME = tic;
            MetricThreshold = 100; % 1000 is default
            
            EdSize = obj.EdgeSize;
            Xlim = [EdSize+1:obj.XYSize(1)-EdSize];
            Ylim = [EdSize+1:obj.XYSize(2)-EdSize];
            
            B = squeeze(B);
            A = mean(B(:,:,obj.ReferenceSliceInd),3);
            boxImage = uint8(A(Ylim,Xlim));
            boxPoints = detectSURFFeatures(boxImage,'MetricThreshold',MetricThreshold);
            [boxFeatures, boxPoints] = ....
                extractFeatures(boxImage, boxPoints);
            TFORM(1:size(B,3)) = struct('tform',[],'Image',[]);
            Pobj = gcp('nocreate');
            for n = 1:size(B,3)
                sceneImage = B(Ylim,Xlim,n);
                scenePoints = detectSURFFeatures(sceneImage,'MetricThreshold',MetricThreshold);
                [sceneFeatures, scenePoints] = ...
                    extractFeatures(sceneImage, scenePoints);
                boxPairs = matchFeatures(boxFeatures, sceneFeatures);
                
                matchedBoxPoints = boxPoints(boxPairs(:, 1), :);
                matchedScenePoints = scenePoints(boxPairs(:, 2), :);
                try
                [tform, inlierBoxPoints, inlierScenePoints] = ...
                    estimateGeometricTransform(...
                    matchedBoxPoints, ...
                    matchedScenePoints, 'similarity');
                catch                     
                    tform = affine2d(single(eye(3)));
                end
                TFORM(n).tform = tform;   
                if isempty(Pobj)
                    TS_WaiteProgress((n-1)/size(B,3))
                else
                    fprintf('.')
                end
            end
            TS_WaiteProgress(1)
            toc(TIME)
        end
        function outImage = TformTranslation(~,TFORM,B)
            IS4dim = ndims(B)==4;            
            if IS4dim
                B = permute(B,[1 2 4 3]);
            end
            outImage = B;
            Siz = size(B(:,:,1,1));            
            for n = 1:size(B,3)
                T = TFORM(n).tform;
                im = B(:,:,n,:);
                outim = im;
                for rgb = 1:size(im,4)
                    outim(:,:,1,rgb) = imwarp(im(:,:,1,rgb),T,'OutputView',imref2d(Siz));
                end
                outImage(:,:,n,:) = outim;
            end
            if IS4dim
                outImage = ipermute(outImage,[1 2  4 3]);
            end
            
        end
        
        %% interpolation
        function Kymograph = SEG2Kymograph(obj,SEG,ID,Image)
            SegReso = SEG.ResolutionXYZ;
            catID = cat(1,SEG.Pointdata.ID);
            ind = obj.SegFunc.ID2Index(ID,catID);
            xyz = SEG.Pointdata(ind).PointXYZ;
            Reso = obj.Resolution;
            Image = squeeze(Image);
            if ndims(Image)>3
                error('Input Image is over dimmention')
            end
            % %main
            X = repmat(xyz(:,1)',[size(Image,3),1]);
            Y = repmat(xyz(:,2)',[size(Image,3),1]);
            Z = repmat((1:size(Image,3))',[1,size(X,2)]);
            if min(Reso(1:2) == SegReso(1:2))
                Kymograph = interp3(single(Image),X,Y,Z);
            else
                X = (X -1) *SegReso(1)/Reso(1) +1;
                Y = (Y -1) *SegReso(2)/Reso(2) +1;
                Kymograph = interp3(single(Image),X,Y,Z);                
            end
        end
        
        %% basic function
        function Ans = Resolution(obj)
            siz = obj.XYSize;
            fov = obj.FOV;
            Ans = fov./(siz -1);
        end
        function FULLPATH = UIGetVideoPath(obj)
            if ~isempty(obj.VideoInfomation)
                PATH = obj.VideoInfomation.Path;
            else
                PATH = pwd;
            end
            [fname,Path] = uigetfile([PATH filesep '*' obj.VideoExtension]);
            FULLPATH = [Path, fname];
        end
        function [Mov,vdata] = LoadVideo(obj,FULLPATH,varargin)            
            NumLimit = zeros(1,2);
            NumLimit(1) = obj.StartTime;
            NumLimit(2) = obj.StartTime + obj.GetDuration;            
            if nargin >2
                NumLimit = varargin{1};
                if isscalar( NumLimit )
                    NumLimit = NumLimit([1 1]);
                end
            end
            
            MemLim = 1; %% Memory limit, unit GibiByte,          
            v = VideoReader(FULLPATH);
            Duration = v.Duration; % sec.
            FrameRate = v.FrameRate; %% Hz

            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            num = ceil(Duration*FrameRate); %% need change,,,,,%%
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            % "cdata" and "colormap" is for VideoWriter.m, movieview.m and
            % etc .m matlab function.
            Mov(1:num) = struct('cdata',[],'CurrentTime',[],'colormap',[]);
            Mem = TS_checkmem('double') / 2^30;
            n = 1;
            while and(hasFrame(v),Mem>MemLim)                
                Mov(n).CurrentTime = v.CurrentTime;
                if Mov(n).CurrentTime<NumLimit(1)
                    readFrame(v);
                    continue
                else
                    Mov(n).cdata = readFrame(v);    
                    Mem = TS_checkmem('double') / 2^30;
                end
                if Mov(n).CurrentTime >= NumLimit(2)
                    break
                end
                n = n+1;
            end
            
            %%%%%%%%%%%%%%%%%%%%%%wanna change %%%%%%%%%%%%%
            TF = false(1,length(Mov));
            for n = 1:length(Mov)
                TF(n) = isempty(Mov(n).cdata);
            end
            Mov(TF) = [];
            %%%%%%%%%%%%%%%%%%%%%% %%%%%%%%%%% %%%%%%%%%%%%%
            vdata = TS_classdef2structure(v);
        end
        
        function [FFTLine,bw] = Kymograph2FFTFitting(obj,im)
            x = log(abs(real(fftshift(fft2(im)))));
            x(x ==max(x(:))) = nan;
            x = x ./max(x(:));
%             level = graythresh(x);
            bw = x > 0.6;
            [y,x] = find(bw);
            
            FFTLine = fitlm(x,y);
        end
        
        function CC = EvaluateSpatialShape(obj,RMSEG,cdata)
            ID = cat(1,RMSEG.Pointdata.ID)>0;
            Pdata = RMSEG.Pointdata(ID);
            RMSEG.Pointdata = Pdata;
            Reso = RMSEG.ResolutionXYZ;
            
            %% Add & Edit 2019 12 21(Sat.)            
            c = 1;
            FieldOfView = (RMSEG.Size-1).*RMSEG.ResolutionXYZ;            
            CC{c,1} = 'VessCounter [num/mm]';
            CC{c,2} = RMSEG.VesselsCounter/(FieldOfView(2)/1000);
            
            c = c + 1;
            W = nan(1,length(Pdata));            
            Mask = RMSEG.BaseMask;            
            Label = bwlabel(Mask,8);
            SuroundS = nan(1,length(Pdata));           
            for n = 1:length(Pdata)
                wid = max(Pdata(n).Width_vector);
                if isempty(wid)
                    wid = nan;
                end
                W(n) = wid;
                xy = round(Pdata(n).PointXYZ(:,1:2));
                ind = sub2ind(RMSEG.Size(1:2),xy(:,2),xy(:,1));
                Lind = Label(ind);
                Lind(Lind==0) = [];
                Lind = TS_GetSameValueSort(Lind);
                bw = false(size(Mask));
                for k = 1:length(Lind)
                    bw = or(bw,Label ==Lind(k));
                end
                SuroundS(n) = sum(bw(:));
                clear xy ind Lind bw k wid
            end            
            CC{c,1} = 'Ellipiticity \piw^2/4S[a.u.]';
            CC{c,2} = (pi*W.^2)./(4*SuroundS);
            
            c = c + 1;            
            CC{c,1} = 'Ellipiticity Min.[a.u.]';
            CC{c,2} = nanmin((pi*W.^2)./(4*SuroundS));
            
            c = c + 1;            
            CC{c,1} = 'Ellipiticity Med.[a.u.]';
            CC{c,2} = nanmedian((pi*W.^2)./(4*SuroundS));
            
            c = c + 1;            
            CC{c,1} = 'Ellipiticity Max.[a.u.]';
            CC{c,2} = nanmax((pi*W.^2)./(4*SuroundS));
            
            c = c + 1;            
            GrayIm = rgb2gray(cdata);
            CC{c,1} = 'Clearness [a.u.]';
            CC{c,2} = nanmean(GrayIm(~Mask))/nanmean(GrayIm(Mask));
            
            c = c + 1;
            BendingFreq = nan(1,length(Pdata));
            for n = 1:length(Pdata)                
                xy = round(Pdata(n).PointXYZ(:,1:2));
                BendingFreq(n) = nansum( obj.SegFunc.BendingFreq(xy) )./Pdata(n).Length;
            end
            CC{c,1} = 'Bending Freq [rad./um]';
            CC{c,2} = BendingFreq;
            
            c = c + 1;            
            CC{c,1} = 'Bending Freq Min.[rad./um]';
            CC{c,2} = nanmin(BendingFreq);
                        
            c = c + 1;            
            CC{c,1} = 'Bending Freq Med.[rad./um]';
            CC{c,2} = nanmedian(BendingFreq);
            
            c = c + 1;            
            CC{c,1} = 'Bending Freq Max.[rad./um]';
            CC{c,2} = nanmax(BendingFreq);
            
            c = c + 1;            
            CC{c,1} = 'Width [a.u.]';
            CC{c,2} = W;
            
            c = c + 1;            
            CC{c,1} = 'Width Min.[a.u.]';
            CC{c,2} = nanmin(W);
            
            c = c + 1;            
            CC{c,1} = 'Width Med.[a.u.]';
            CC{c,2} = nanmedian(W);
            
            c = c + 1;            
            CC{c,1} = 'Width Max.[a.u.]';
            CC{c,2} = nanmax(W);
            
            c = c + 1;            
            D = cat(1,Pdata.Diameter);
            CC{c,1} = 'Min. All Diameter [a.u.]';            
            CC{c,2} = nanmin(D);
                        
            c = c + 1;            
            CC{c,1} = 'Median All Diameter [a.u.]';            
            CC{c,2} = nanmedian(D);
            
            c = c + 1;            
            CC{c,1} = 'Mode All Diameter [a.u.]';            
            CC{c,2} = mode(round(D(~isnan(D))));
            
            c = c + 1;            
            CC{c,1} = 'Max All Diameter [a.u.]';            
            CC{c,2} = nanmax(D);            
                        
            c = c + 1;            
            CC{c,1} = 'Vessels Count [#]';
            ID = cat(1,Pdata.ID);
            CC{c,2} = sum(ID>0);
            
            c = c + 1;            
            CC{c,1} = 'Vessels Length [um]';
            CC{c,2} = cat(2,Pdata.Length);
                        
            c = c + 1;            
            CC{c,1} = 'Vessels Length Min.[um]';
            CC{c,2} = nanmin(cat(2,Pdata.Length));
            
            c = c + 1;            
            CC{c,1} = 'Vessels Length Med.[um]';
            CC{c,2} = nanmedian(cat(2,Pdata.Length));
            
            c = c + 1;            
            CC{c,1} = 'Vessels Length Max.[um]';
            CC{c,2} = nanmax(cat(2,Pdata.Length));
            
            c = c + 1;            
            CC{c,1} = 'Curve Number [#/Vessel]';
            CC{c,2} = cat(2,Pdata.CurveNumber);
            
            c = c + 1;            
            CC{c,1} = 'Curve Number Max.';
            CC{c,2} = nanmax(cat(2,Pdata.CurveNumber));
                        
            c = c + 1;            
            CC{c,1} = 'Curve Number Med.';
            CC{c,2} = nanmedian(cat(2,Pdata.CurveNumber));
            
            c = c + 1;            
            CC{c,1} = 'Curve Number Min.';
            CC{c,2} = nanmin(cat(2,Pdata.CurveNumber));
            
                       
            c = c + 1;            
            CC{c,1} = 'Curve Minimum R [um, /Vessels]';
            CC{c,2} = cat(2,Pdata.CurveMinimumR);
                        
            c = c + 1;            
            CC{c,1} = 'Curve Minimum R Min.[um,]';
            CC{c,2} = nanmin(cat(2,Pdata.CurveMinimumR));
            c = c + 1;            
            CC{c,1} = 'Curve Minimum R Med.[um,]';
            CC{c,2} = nanmedian(cat(2,Pdata.CurveMinimumR));
            c = c + 1;            
            CC{c,1} = 'Curve Minimum R Max.[um,]';
            CC{c,2} = nanmax(cat(2,Pdata.CurveMinimumR));
            
            c = c + 1;            
            CC{c,1} = 'StraghtNumber /Vessels';
            CC{c,2} = cat(2,Pdata.StraghtNumber);
            
            c = c + 1;            
            CC{c,1} = 'StraghtNumber MinPerVessels';
            CC{c,2} = nanmin(cat(2,Pdata.StraghtNumber));            
            c = c + 1;            
            CC{c,1} = 'StraghtNumber MedPerVessels';
            CC{c,2} = nanmedian(cat(2,Pdata.StraghtNumber));
            c = c + 1;            
            CC{c,1} = 'StraghtNumber MaxPerVessels';
            CC{c,2} = nanmax(cat(2,Pdata.StraghtNumber));
            
            c = c + 1;            
            CC{c,1} = 'Straght Sumation [um] / Vessels';
            CC{c,2} = cat(2,Pdata.StraghtSumationLength);            
            c = c + 1;            
            CC{c,1} = 'Straght Sumation Min.[um]';
            CC{c,2} = nanmin(cat(2,Pdata.StraghtSumationLength));
            c = c + 1;            
            CC{c,1} = 'Straght Sumation Med.[um]';
            CC{c,2} = nanmedian(cat(2,Pdata.StraghtSumationLength));
            c = c + 1;            
            CC{c,1} = 'Straght Sumation Max.[um]';
            CC{c,2} = nanmax(cat(2,Pdata.StraghtSumationLength));            
            
            c = c + 1;            
            CC{c,1} = 'Straght Max [um]';
            CC{c,2} = cat(2,Pdata.StraghtMaximumLength);
            c = c + 1;            
            CC{c,1} = 'Straght Max Mean[um]';
            CC{c,2} = nanmean(cat(2,Pdata.StraghtMaximumLength));
            
            c = c + 1;            
            CC{c,1} = 'Straght Min [um]';
            CC{c,2} = cat(2,Pdata.StraghtMinimumLength);            
            c = c + 1;            
            CC{c,1} = 'Straght Min Mean[um]';
            CC{c,2} = nanmean(cat(2,Pdata.StraghtMinimumLength));
            
            
        end
        
        %% GUI
        
    end
    methods (Static)
        function NewSEG = Add_IndexOf_Left_Right_Curve(SEG)
            Sf = Segment_Functions;
            NewSEG = SEG;
            SegReso = SEG.ResolutionXYZ;
            StraghtAS = SEG.StraghtAS;
            if ~isscalar(StraghtAS)
                error('Input Segment data has vector or more data as "StraghtAS"')
            end
            ID = cat(1,SEG.Pointdata.ID);
            NewSEG.Pointdata = SEG.Pointdata(ID>0);
            for n = 1:length(NewSEG.Pointdata)
                xyz = NewSEG.Pointdata(n).PointXYZ;
                R = NewSEG.Pointdata(n).SphereFitRadius;
                LeftCurveRight_Label = nan(size(xyz,1),1);
                % % find Top of Curve
                Curve = R < StraghtAS;
                CC1 = bwconncomp(Curve);
                FlipTF = false;
                if CC1.NumObjects ~= 0                                          
                    TopYaxis = nan(CC1.NumObjects,1);
                    
                    for k = 1:CC1.NumObjects
                        TopYaxis(k) = min(xyz(CC1.PixelIdxList{k},2));
                    end
                    [~,ind] = min(TopYaxis);
                    Index = CC1.PixelIdxList{ind};
                    LeftCurveRight_Label(Index) = 0;
                    % % vector check
                    % % pre
                    if Index(1) == 1
                        preIndex = [];
                    else
                        preIndex = 1:Index(1)-1;
                    end
                    % % post
                    if Index(end) == size(xyz,1)
                        postIndex = [];
                    else
                        postIndex = Index(end)+1:size(xyz,1);
                    end
                    % % Left or Right
                    preX = xyz(Index(1),1);
                    postX = xyz(Index(end),1);
                    
                    if preX<postX
                        LeftCurveRight_Label(preIndex)  = -1;
                        LeftCurveRight_Label(postIndex) =  1;
                    else
                        LeftCurveRight_Label(preIndex)  =  1;
                        LeftCurveRight_Label(postIndex) = -1;
                        FlipTF = true;
                    end                    
                else
%                     fprintf([mfilename 'Unknow Curve Index...\n'])
                end
                
                if FlipTF 
                    xyz = flip(xyz,1);
                    NewSEG.Pointdata(n).PointXYZ = xyz;
                    NewSEG.Pointdata(n).Diameter = flipud(NewSEG.Pointdata(n).Diameter);
                    NewSEG.Pointdata(n).Signal = flipud(NewSEG.Pointdata(n).Signal);
                    NewSEG.Pointdata(n).Noise = flipud(NewSEG.Pointdata(n).Noise);
                    NewSEG.Pointdata(n).Theta = flipud(NewSEG.Pointdata(n).Theta);
                    NewSEG.Pointdata(n).NewXYZ = flipud(NewSEG.Pointdata(n).NewXYZ);
                    NewSEG.Pointdata(n).OriginalPointXYZ = flipud(NewSEG.Pointdata(n).OriginalPointXYZ);
                    NewSEG.Pointdata(n).Length_from_Branch = flipud(NewSEG.Pointdata(n).Length_from_Branch);
                    NewSEG.Pointdata(n).SphereFitRadius = flipud(NewSEG.Pointdata(n).SphereFitRadius);
                    NewSEG.Pointdata(n).SphereFitUnitVector = flipud(NewSEG.Pointdata(n).SphereFitUnitVector);
                    NewSEG.Pointdata(n).SphereFitScalar = flipud(NewSEG.Pointdata(n).SphereFitScalar);
                    NewSEG.Pointdata(n).TF_curve = flipud(NewSEG.Pointdata(n).TF_straght);
                    LeftCurveRight_Label = flip(LeftCurveRight_Label,1);
                end
                NewSEG.Pointdata(n).LeftCurveRight_Label = LeftCurveRight_Label;
                NewSEG.Pointdata(n).ArtLoopVein_Label = nan(length(LeftCurveRight_Label),1);
                if isfield(NewSEG.Pointdata,'ArteryCurveVenous_Label')
                    NewSEG.Pointdata = rmfield(NewSEG.Pointdata,'ArteryCurveVenous_Label');
                end
                    
                %% add StraightCurve_Label
                R = NewSEG.Pointdata(n).SphereFitRadius;
                StraightCurve_Label = nan(size(xyz,1),1);
                % % find Top of Curve
                Curve = R < StraghtAS;
                Straight = ~Curve;
                
                [CC1,LCnum] = bwlabel(Curve);
                [CC2,LSnum] = bwlabel(Straight);
                if LCnum >= 1
                    for i = 1:LCnum
                        Index = CC1==i;
                        StraightCurve_Label(Index) = i;
                    end
                    for j = 1:LSnum
                        Index2 = CC2==j;
                        StraightCurve_Label(Index2) = -1*j;
                    end
                elseif LCnum<1 && LSnum == 1
                    Index2 = CC2==1;
                    StraightCurve_Label(Index2) = -1;
                end
                NewSEG.Pointdata(n).StraightCurve_Label = StraightCurve_Label;                        

                %% add width 
                if isnan(LeftCurveRight_Label(1))
                    Width_vector = nan;
                else                    
                    L = flip(find(LeftCurveRight_Label ==-1), 1);
                    R = find(LeftCurveRight_Label ==1);
                    Num = min(numel(L),numel(R));
                    Width_vector = zeros(Num,1);
                    
                    for k = 1:Num
                        Width_vector(k) = Sf.GetEachLength(...
                            xyz(L(k),:),xyz(R(k),:),SegReso);
                    end                    
                end
                NewSEG.Pointdata(n).Width_vector = Width_vector;
            end
        end
        % output figure for A4
        function fgh = OutputFig
            fgh = figure;
            fgh.PaperType= 'A4';
            fgh.Position = [10 10 636 900];
            fgh.PaperPosition = [0.1700    0.1700    7.9277   11.3529];
        end
    end
end
function D = GetHELP
D = which(mfilename);
FS = find(D==filesep);
D = D(1:FS(end));
end

function MEMO
H(1) = @TS_classdef2structure;
H(2) = @TS_checkmem;
H(3) = @TS_deconvlucy;
H(4) = @TS_Deconv3D_GPU;
H(5) = @TS_im2bw_block
H(6) = @TS_AutoSegment_v2019Charly
end

