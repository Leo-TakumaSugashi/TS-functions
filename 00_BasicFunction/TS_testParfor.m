function TS_testParfor

%  �����������p�����[�^
theta1 = 1:100;
theta2 = 1:100;

% parfor�����珑�����݂����z��̃T�C�Y���Aparfor�̃C���f�b�N�X�̍ő�l�Ƃ��Ė�������
resultMatrix = zeros(length(theta1),length(theta2));
theta1indmax = size(resultMatrix,1);
theta2indmax = size(resultMatrix,2);
% theta1ind, theta2ind��z�ɃC���f�b�N�X�Ɏw�肷��E���̂P
parfor theta1ind = 1:theta1indmax
    for theta2ind = 1:theta2indmax
        % theta1ind, theta2ind��z�ɃC���f�b�N�X�Ɏw�肷��E���̂Q
        resultMatrix(theta1ind,theta2ind) = theta1(theta1ind)^2 + theta2(theta2ind)^2;
    end
end
figure,imagesc(resultMatrix)