function [featIm] = extractTextonHists(origIm, bank, textons, winSize)
    %origIm ：h*w       将win尽可能限制为奇数吧

    [h, w] = size(origIm);
    d = size(bank, 3);
    m = size(bank, 1);
    k = size(textons, 1);

    %feat = zeros(h, w, d);
    im = padarray(origIm, [(m-1)/2, (m-1)/2], 0);

    blockIm = im2col(im, [m,m], 'sliding');%(m*m) * (h*w)
    bankReshaped = reshape(bank, [], d);%(m*m) * d

    conv_res = blockIm' * bankReshaped;%(h*w) * (m*m) * (m*m) * d

    feat = reshape(conv_res, h, w, d);

    [labelIm] = quantizeFeats(feat, textons);%h*w
    halfSize = floor(winSize / 2);


    tmp_featIm = zeros(k+1, h*w);
    labelIm = padarray(labelIm, [halfSize, halfSize], k+1);%额外增加一个不存在的组

    block = im2col(labelIm, [winSize, winSize], 'sliding');%(win*win) * (h*w)

    for i = 1:size(block, 2)
        tmp_vector = accumarray(block(:,i), ones(1, winSize*winSize), [k+1, 1]);
        tmp_featIm(:, i) = tmp_vector;
    end

    featIm = tmp_featIm(1:k, :);%k* (h*w)
    featIm = featIm./sum(featIm);
    featIm = reshape(featIm, k, h, w);
    featIm = permute(featIm, [2, 3, 1]);

end