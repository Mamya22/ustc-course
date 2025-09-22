% img = imread('./image/blood.bmp');
img = imread('./image/lena.bmp');
%Roberts算子
Roberts = edge(img,'Roberts');

%Sobel算子
Sobel = edge(img,'Sobel');

%Prewitt算子
Prewitt = edge(img,'Prewitt');

%拉普拉斯算子
Laplacian1 = imfilter(img, [0 1 0; 1 -4 1; 0 1 0]);
Laplacian2 = imfilter(img,[-1 -1 -1; -1 8 -1; -1 -1 -1]);
%Canny算子
Canny = edge(img,'Canny');

subplot(3,3,[1,3]); imshow(img); title('原图'); 
subplot(3,3,4); imshow(Roberts); title('Roberts'); 
subplot(3,3,5); imshow(Sobel); title('Sobel'); 
subplot(3,3,6); imshow(Prewitt); title('Prewitt'); 
subplot(3,3,7); imshow(Laplacian1); title('Laplacian1'); 
subplot(3,3,8); imshow(Laplacian2); title('Laplacian2'); 
subplot(3,3,9); imshow(Canny); title('Canny'); 