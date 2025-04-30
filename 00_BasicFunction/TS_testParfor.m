function TS_testParfor

%  走査したいパラメータ
theta1 = 1:100;
theta2 = 1:100;

% parfor内から書き込みたい配列のサイズを、parforのインデックスの最大値として明示する
resultMatrix = zeros(length(theta1),length(theta2));
theta1indmax = size(resultMatrix,1);
theta2indmax = size(resultMatrix,2);
% theta1ind, theta2indを陽にインデックスに指定する・その１
parfor theta1ind = 1:theta1indmax
    for theta2ind = 1:theta2indmax
        % theta1ind, theta2indを陽にインデックスに指定する・その２
        resultMatrix(theta1ind,theta2ind) = theta1(theta1ind)^2 + theta2(theta2ind)^2;
    end
end
figure,imagesc(resultMatrix)