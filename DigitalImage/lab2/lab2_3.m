img = imread("./image/lena.bmp");

min = input("下限: ");
max = input("上限: ");

histogram(img,'BinLimits',[min, max]);