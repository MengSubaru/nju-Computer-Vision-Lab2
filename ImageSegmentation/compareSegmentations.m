function [colorLabelIm, textureLabelIm] = compareSegmentations(origIm, bank, textons, winSize, numColorRegions, numTextureRegions)
    
    h = size(origIm, 1);
    w = size(origIm, 2);
    k = size(textons, 1);
    im = im2double(origIm);

    [hist] = extractTextonHists(rgb2gray(im), bank, textons, winSize);%h*w*k
    %label_texture = kmeans(reshape(hist, [], k), numTextureRegions);
    textureLabelIm = reshape(kmeans(reshape(hist, [], k), numTextureRegions), h, w);

    im = reshape(im, [], 3);%(h*w) * 3
    im = kmeans(im, numColorRegions);%(h*w) * 1
    colorLabelIm = reshape(im, h, w);% h * w
end