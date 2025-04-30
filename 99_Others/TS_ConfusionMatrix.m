function [A,C] = TS_ConfusionMatrix(T,P)
%% make Concusion Matrix 
% [A,C] = TS_ConfusionMatrix(T,P)
% recomennd comfusionmat
%
% Input : 
%     T : real Positive or Negative
%     P : predicted Positive or Negetive
%
% output : 
%      A : Number of each data.
%      C : Description of each data as charactor.
C = cell(2,2);
C{1,1}= 'True Negative';
C{2,1} = 'False Negative';
C{1,2} = 'False Positive';
C{2,2} = 'True Positive';

[cm,order] = confusionmat(T,P);
A = cm;