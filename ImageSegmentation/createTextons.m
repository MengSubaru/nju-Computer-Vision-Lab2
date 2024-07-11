function [textons] = createTextons(imStack, bank, k)
    %imStack为cell数组
    %在调用此函数之前要先data=load('filterBank.mat');通过data.F来访问49*49*38的滤波器组，并取其中一部分
    num_img = length(imStack);%图片的个数

    m = size(bank, 1);
    d = size(bank, 3);
    num = 100;%每个图片取样的像素数
    
    responses = zeros(num*num_img, d);
    for i = 1:num_img
        img = imStack{i};
        [row, col] = size(img);
          
        rand_pixel = randi([0, row * col - 1], num, 1);%randperm
        
        % 提取每个像素周围的图像块并计算滤波器响应
        blocks = zeros(m, m, num);
        im = padarray(img, [(m-1)/2, (m-1)/2], 0);
        for j = 1:num %获得num个需要计算的块
            pixel = rand_pixel(j);%像素点
            tmp_row = floor(pixel / col) + 1;%行
            tmp_col = mod(pixel, col) + 1;%列
            %ind2sub

            blocks(:,:,j) = im(tmp_row:tmp_row+m-1, tmp_col:tmp_col+m-1);
        end

        blocks = reshape(blocks, m*m, num);%m*m * num
        responses((i - 1) * num + 1:i * num,:) = blocks' * reshape(bank,m*m, d);%num * (m*m) * (m*m) * d 

    end
    
    % 使用K-means算法对滤波器响应进行聚类
    [~, textons] = kmeans(responses, k);
end