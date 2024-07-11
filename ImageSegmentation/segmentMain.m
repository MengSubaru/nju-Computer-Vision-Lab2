k = 6;%texton codebook��texton������ĸ���
numColorRegions = 6;%kmeans-color-segment��region�ĸ��� 6��ã�5���
numTextureRegions = 6;%kmeans-texture-segment��region�ĸ���  
winSize = 5;%����texton histogramʱÿ��������Ҫ���ǵĴ��ڴ�С�����Ը�����Ϊ���ģ������ܱ�win*win������

img1 = imread('gumballs.jpg');
img2 = imread('snake.jpg');
img3 = imread('twins.jpg');
img4 = imread('planets.jpg');

imStack = {rgb2gray(im2double(img1)), rgb2gray(im2double(img2)), rgb2gray(im2double(img3)), rgb2gray(im2double(img4))};

bank = load('filterBank.mat').F;

[textons] = createTextons(imStack, bank, k);%����codebook

imStack = {img1, img2, img3, img4};%��ɫͼ��

for i = 1:4
    [colorLabelIm, textureLabelIm] = compareSegmentations(imStack{i}, bank, textons, winSize, numColorRegions, numTextureRegions);
    figure(1);  imshow(imStack{i}); title('img');%��ʾδ�����ͼ��
    figure(2);  imshow(label2rgb(colorLabelIm)); title('color segment');%��ʾ����color�ָ�Ľ��
    figure(3);  imshow(label2rgb(textureLabelIm)); title('texture segment');%��ʾ����texture�ָ�Ľ��
    drawnow;
    %pause(1);
end