# PictureViewer
单手操作图片的移动、缩放、旋转
利用touchsBegin与touchesMoved方法实现的单手操作图片的移动、缩放、循转。
主要利用了触摸点所在位置与图片中心点位置，进行一些列的计算，在利用CGAffineTransform系列方法进行移动（设置center的位置）、缩放（设置scale）、旋转（设置rotate）。
