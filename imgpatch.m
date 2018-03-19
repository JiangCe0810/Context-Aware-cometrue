function CenterPixelPatch=imgpatch(pic,patchsize,sizeofimg)
    if nargin<3
        sizeofimg=128;
    end
    picPading=padarray(pic,[(patchsize-1)/2,(patchsize-1)/2],0,'both');
    %cform = makecform('srgb2lab'); %Create a color transformation structure.
    %lab = applycform(picPading, cform);%将图像的矩阵信息转换为每个pixel对应的Lab信息
    CenterPixelPatch=cell(sizeofimg,sizeofimg);%元胞数组，数组内的元素可以存储所有类型的变量
    lab = rgb2lab(picPading);
    %resizeImg=lab;
    %imshow(resizeImg);
    patchmatrix=zeros(patchsize,patchsize,3);
    L=lab(:,:,1);
    A=lab(:,:,2);
    B=lab(:,:,3);
    %r=(patchsize-1)/2;
    %for z=1:3
        for i=1:sizeofimg
            for j=1:sizeofimg
                patchmatrix(:,:,1)=L(i:i + patchsize-1,j:j +patchsize-1);
                patchmatrix(:,:,2)=A(i:i + patchsize-1,j:j +patchsize-1);
                patchmatrix(:,:,3)=B(i:i + patchsize-1,j:j +patchsize-1);
%                  x=1;
%                  for i2=i:i+patchsize-1
%                      y=1;
%                      for j2=j:j+patchsize-1
%                          patchmatrix(x,y,z)=resizeImg(i2,j2,z);
%                          y=y+1;
%                      end
%                      x=x+1;
%                  end
%                patchmatrix=resizeImg(i-(patchsize-1)/2:i+(patchsize-1)/2,j-(patchsize-1)/2:j+(patchsize-1)/2);
                CenterPixelPatch{i,j}=patchmatrix;
            end
        end
    %end
%picPading=padarray(pic,[(patchsize-1)/2,(patchsize-1)/2],0,'both');
%lab = rgb2lab(picPading);
%lab(1:7,1:7,1)
