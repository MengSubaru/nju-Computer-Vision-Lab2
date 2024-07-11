function bmap = edgeOrientedFilters(im)
    [mag, ~] = orientedFilterMagnitude(im);

    % 选择合适的双阈值使用canny算子 OR 使用给出的非极大值抑制函数
    bmap = mag.* edge(mag, 'Canny').^0.7;
    %bmap = nonmax(mag.^0.7, theta+pi/2);
end 

function [mag, theta] = orientedFilterMagnitude(im)
    im = rgb2gray(im);
    sigma = 2.6;%根据情况选择
    %canny
    %2.0 0.594 0.614
    %2.6 0.597 0.615
    %2.8 0.595 0.612

    h = 2 * ceil(2 * sigma) + 1;%模仿matlab官方的选择

    [x, y] = meshgrid(-(h-1)/2:(h-1)/2, -(h-1)/2:(h-1)/2);

    same = exp(-(x.^2 + y.^2) / (2 * sigma^2));%计算后面两个导数的公共部分以减少计算量

    gx = -(x .* same);
    gy = -(y .* same);

    gx = gx / sum(gx, "all");
    gy = gy / sum(gy, "all");
       
    filter0 = gx.*cos(0) + gy.*sin(0);
    res0 = conv2(im, filter0, 'same');

    filter45 = gx.*cos(pi/4) + gy.*sin(pi/4);
    res45 = conv2(im, filter45, 'same');

    filter90 = gx.*cos(pi/2) + gy.*sin(pi/2);
    res90 = conv2(im, filter90, 'same');

    filter135 = gx.*cos(3*pi/4) + gy.*sin(3*pi/4);
    res135 = conv2(im, filter135, 'same');

    %归一化
    res0 = res0 / max(res0(:));
    res45 = res45 / max(res45(:));
    res90 = res90 / max(res90(:));
    res135 = res135 / max(res135(:));

    [mag, idx] = max(cat(3, abs(res0), abs(res45), abs(res90), abs(res135)), [], 3);
    theta = zeros(size(im, 1), size(im, 2));
    theta(idx == 2) = pi/4;
    theta(idx == 3) = pi/2;
    theta(idx == 4) = 3*pi/4;
    
end