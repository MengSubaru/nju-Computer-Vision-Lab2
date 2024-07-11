function [textons] = createTextons(imStack, bank, k)
    %imStackΪcell����
    %�ڵ��ô˺���֮ǰҪ��data=load('filterBank.mat');ͨ��data.F������49*49*38���˲����飬��ȡ����һ����
    num_img = length(imStack);%ͼƬ�ĸ���

    m = size(bank, 1);
    d = size(bank, 3);
    num = 100;%ÿ��ͼƬȡ����������
    
    responses = zeros(num*num_img, d);
    for i = 1:num_img
        img = imStack{i};
        [row, col] = size(img);
          
        rand_pixel = randi([0, row * col - 1], num, 1);%randperm
        
        % ��ȡÿ��������Χ��ͼ��鲢�����˲�����Ӧ
        blocks = zeros(m, m, num);
        im = padarray(img, [(m-1)/2, (m-1)/2], 0);
        for j = 1:num %���num����Ҫ����Ŀ�
            pixel = rand_pixel(j);%���ص�
            tmp_row = floor(pixel / col) + 1;%��
            tmp_col = mod(pixel, col) + 1;%��
            %ind2sub

            blocks(:,:,j) = im(tmp_row:tmp_row+m-1, tmp_col:tmp_col+m-1);
        end

        blocks = reshape(blocks, m*m, num);%m*m * num
        responses((i - 1) * num + 1:i * num,:) = blocks' * reshape(bank,m*m, d);%num * (m*m) * (m*m) * d 

    end
    
    % ʹ��K-means�㷨���˲�����Ӧ���о���
    [~, textons] = kmeans(responses, k);
end