function [labelIm] = quantizeFeats(featIm, meanFeats)
    %����˼·��һ����meanF�д���k���������ĵ�ֵ������ÿ�����dά������ÿ�����ĵ�ŷʽ���벢ȡmin������Ҫ������
    %�ڶ�����ÿ�����ص�dά������meanF��������Ϊ�����ص�ֵ�����k�����ģ��Ըղż������ֵ������

    %���extractTextonHists����˼�������ƺ����ȵ��ô˺��������ÿ�����ص���
    %�������extractTextonHists�����ÿ�����ش���textonֱ��ͼ

    [h, w, d] = size(featIm);

    % ����ͼ���е�ÿ�����ز�����������������ĵľ���
    img_change = permute(featIm, [3, 1, 2]);
    img_change = reshape(img_change, [1, d, h*w]);
    Edis = sqrt( sum( (img_change - meanFeats).^2, 2 ) );
    [~, idx_tmp] = min(Edis);
    labelIm = reshape(idx_tmp, [h, w]);

end