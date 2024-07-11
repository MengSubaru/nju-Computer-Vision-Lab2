function [labelIm] = quantizeFeats(featIm, meanFeats)
    %两种思路：一种是meanF中存有k个聚类中心的值，计算每个点的d维向量与每个中心的欧式距离并取min，不需要迭代；
    %第二种是每个像素的d维向量与meanF相乘相加作为该像素的值，随机k个中心，以刚才计算出的值来迭代

    %结合extractTextonHists的意思来看，似乎是先调用此函数计算出每个像素的类
    %随后再用extractTextonHists计算出每个像素处的texton直方图

    [h, w, d] = size(featIm);

    % 遍历图像中的每个像素并计算它们与聚类中心的距离
    img_change = permute(featIm, [3, 1, 2]);
    img_change = reshape(img_change, [1, d, h*w]);
    Edis = sqrt( sum( (img_change - meanFeats).^2, 2 ) );
    [~, idx_tmp] = min(Edis);
    labelIm = reshape(idx_tmp, [h, w]);

end