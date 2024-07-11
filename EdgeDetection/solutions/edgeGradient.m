function bmap = edgeGradient(im)
    sigma = 2.1;  
    [mag, ~] = gradientMagnitude(im, sigma);
    % 0.616 0.652

    % ѡ����ʵ�˫��ֵʹ��canny���� OR ʹ�ø����ķǼ���ֵ���ƺ���
    bmap = (mag.* edge(mag, 'Canny')).^0.7;

    % 1.61 0.606 0.632 bmap = nonmax(mag.^0.7, theta);
end

function [mag, theta] = gradientMagnitude(im, sigma)
    % im��Ϊ�����RGBͼ���Ѿ�������im2double�Ĵ���

    smoothed_image = imgaussfilt3(im, sigma);
    [Rx, Ry] = gradient(smoothed_image(:,:,1));
    [Gx, Gy] = gradient(smoothed_image(:,:,2));
    [Bx, By] = gradient(smoothed_image(:,:,3));
    
    magR = sqrt(Rx.^2 + Ry.^2);
    magG = sqrt(Gx.^2 + Gy.^2);
    magB = sqrt(Bx.^2 + By.^2);
    
    %�����ݶȷ��򲿷�
    cat_matrix = cat(3, magR, magG, magB);
    [~, idx]= max(cat_matrix, [], 3);
    theta = zeros(size(im, 1), size(im, 2));

    theta(idx == 1) = atan2(Ry(idx == 1), Rx(idx == 1));
    theta(idx == 2) = atan2(Gy(idx == 2), Gx(idx == 2));
    theta(idx == 3) = atan2(By(idx == 3), Bx(idx == 3));
    %theta = atan2(-gy, gx)?
    
    % overall gradient magnitude 
    mag = sqrt(magR.^2 + magG.^2 + magB.^2);

end