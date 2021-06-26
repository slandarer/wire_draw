oriPic=imread('test15.jpg');%ori pic‘≠Õº
linePic=imread('untitled16.png');%wire draw pic»∆œﬂÕº

linePic=rgb2gray(linePic);
oriPic=imresize(oriPic,size(linePic));

oriR=oriPic(:,:,1);
oriG=oriPic(:,:,2);
oriB=oriPic(:,:,3);
newPic(:,:,1)=255-(255-double(linePic)).*(255-double(oriR))./255;
newPic(:,:,2)=255-(255-double(linePic)).*(255-double(oriG))./255;
newPic(:,:,3)=255-(255-double(linePic)).*(255-double(oriB))./255;
newPic=uint8(newPic);
figure(2)
imshow(newPic)

saveas(2,'renderPic.png')