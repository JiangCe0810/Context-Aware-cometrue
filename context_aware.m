clear
clc
pic='bird.jpg';
img_gr=rgb2gray(imread(pic));%转换为灰度图
img  = im2double(img_gr);%将图像数据转换为double精度
%% 对图像进行FFT变换
f = fft2(img);%傅立叶变换将图像由灰度分布函数变为频率分布函数
L = log(abs(f));
P = angle(f);
%% 通过减去均值来计算saliency，均值通过光滑frequency图像得到
k=3;
H(1:k,1:k)=1/(k*k);%均值滤波直接定义算子即可
flimg= imfilter(L, H, 'replicate');%对图片进行均值滤波，边界点的值取与其最相近的点的值
R = L - flimg;
S = abs(ifft2(exp(R + 1i*P))).^2;
%% 使用高斯滤波得到需要的图像
%高斯滤波是对整幅图像进行加权平均的过程，每一个像素点的值都是由本身和其临域的像素点加权平均得到
%用一个模板（或称卷积、掩模）扫描图像中的每一个像素，用模板确定的邻域内像素的加权平均灰度值去替代模板中心像素点的值。
G=imfilter(S, fspecial('gaussian', [10, 10], 2.5));%使用一个10*10的高斯核对图片进行处理
%fspecial用于与定义滤波器算子，此处定义了一个10*10的滤波器算子，高斯公式中的标准差为2.5
S = mat2gray(G);%将数据为double的图像矩阵成功转换为灰度图像，每个像素值在[0,1]
imshow(S);