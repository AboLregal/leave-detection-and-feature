% Ahmed Raafat Abo Lregal
% 26 - Feb - 2018

clc;clear;close all;warning off

[file,path]=uigetfile('*.jpg','Choose Your Image');
Im=imread(strcat(path,file));
Im_gray=rgb2gray(Im);
figure();imshow(Im)
% Take The green channel
Im_med=medfilt2(Im_gray,[33 33]);
Im_bw=im2bw(Im_med,graythresh(Im_med));
figure();imshow(Im_med)
figure();imshow(Im_bw)
if sum(sum(Im_bw))/numel(Im_bw)>0.5
    Im_bw=~Im_bw;
end
prop=regionprops(Im_bw);
ar=cat(1,prop.Area);
[Ar,l]=max(ar);
% First Property
Im_bw=bwareaopen(Im_bw,Ar-100);
e=bwperim(Im_bw);
premiter=nnz(e);
% Second
conv_hull=bwconvhull(Im_bw);
convex_hull=sum(sum(conv_hull));
% Third
major=regionprops(Im_bw,'MajorAxisLength');
major=major.MajorAxisLength;
% Fourth
minor=regionprops(Im_bw,'MinorAxisLength');
minor=minor.MinorAxisLength;
% Fifth
major_minor=major/minor;
% Last
table(Ar,premiter,convex_hull,major,minor,major_minor)
