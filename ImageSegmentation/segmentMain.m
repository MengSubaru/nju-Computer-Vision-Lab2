k = 6;%texton codebook中texton的种类的个数
numColorRegions = 6;%kmeans-color-segment中region的个数 6最好，5差不多
numTextureRegions = 6;%kmeans-texture-segment中region的个数  
winSize = 5;%计算texton histogram时每个像素需要考虑的窗口大小，即以该像素为中心，考虑周边win*win的区域

img1 = imread('gumballs.jpg');
img2 = imread('snake.jpg');
img3 = imread('twins.jpg');
img4 = imread('planets.jpg');

imStack = {rgb2gray(im2double(img1)), rgb2gray(im2double(img2)), rgb2gray(im2double(img3)), rgb2gray(im2double(img4))};

bank = load('filterBank.mat').F;

[textons] = createTextons(imStack, bank, k);%创建codebook

imStack = {img1, img2, img3, img4};%彩色图像

for i = 1:4
    [colorLabelIm, textureLabelIm] = compareSegmentations(imStack{i}, bank, textons, winSize, numColorRegions, numTextureRegions);
    figure(1);  imshow(imStack{i}); title('img');%显示未处理的图像
    figure(2);  imshow(label2rgb(colorLabelIm)); title('color segment');%显示基于color分割的结果
    figure(3);  imshow(label2rgb(textureLabelIm)); title('texture segment');%显示基于texture分割的结果
    drawnow;
    %pause(1);
end