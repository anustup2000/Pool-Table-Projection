clear all;
close all;
image =imread('E:\Academics\Section Project\pool_images\cs17.PNG');
figure(1),imshow(image);
image=im2double(image);
[r c p]=size(image);
imR=squeeze(image(:,:,1));
imG=squeeze(image(:,:,2));
imB=squeeze(image(:,:,3));
img1=cs18mask(image);
img = (cs18mask(image));
newimg = zeros(size(img));
%%edit
newimg1 = zeros(size(img));
[centers,radii] = imfindcircles(img,[20 40]);
    for j=1:size(radii)
          newimg1 = insertShape(newimg,'FilledCircle',[centers(j,:) radii(j)],'Color',[255 255 255] );
          newimg = newimg1;  
    end


figure(2),imshow(img1);
imbin=im2bw(newimg1);
figure(3),imshow(imbin);
[labels,numlabels]=bwlabel(imbin);
disp(['number of balls :' num2str(numlabels)]);
rlabel=zeros(r,c);
glabel=zeros(r,c);
blabel=zeros(r,c);

for i=1:numlabels
    rlabel(labels==i) = median(imR(labels==i));
    glabel(labels==i) = median(imG(labels==i));
    blabel(labels==i) = median(imB(labels==i));
end
imlabel=cat(3,rlabel,glabel,blabel);
imlabel2=imlabel;
figure(4),imshow(imlabel2);
%figure,imshow(imlabel);
% [x y]=ginput(1);
% 
% selcolor=imlabel(floor(y),floor(x),:);
% C=makecform('srgb2lab');
% imlab=applycform(imlabel,C);
% imsellab=applycform(selcolor,C);
% ima=imlab(:,:,2);
% imb=imlab(:,:,3);
% imsela=imsellab(1,2);
% imselb=imsellab(1,3);
% dist=10;
% immask=zeros(r,c);
% imdist=hypot(ima-imsela,imb-imselb);
% immask(imdist<dist)=1;
% [clabel,cnum]=bwlabel(immask);
% imseg=repmat(selcolor,[r,c,1]).*repmat(immask,[1,1,3]);
% imshow(imseg);
% disthresh=10;

%[centers, radii] = imfindcircles(newimg1,[20 40],'ObjectPolarity','bright','Sensitivity',0.95);
%figure,imshow(newimg1);
%h = viscircles(centers,radii);

% TO FIND WHITE COLOR BALL

newR = zeros(r,c); newG = zeros(r,c); newB = zeros(r,c);
newR(find(rlabel>0.7 & glabel>0.7 & blabel>0.7))=1;
newG(find(rlabel>0.7 & glabel>0.7 & blabel>0.7))=1;
newB(find(rlabel>0.7 & glabel>0.7 & blabel>0.7))=1;
newIMG = cat(3, newR, newG, newB);

bw=im2bw(newIMG);
figure(5); imshow(bw);
%APPLY imfindcircles AGAIN TO GET CENTER OF WHITE BALL
% [centers, radii] = imfindcircles(bw,[20 40],'ObjectPolarity','bright','Sensitivity',0.95);

 for l=1:size(bw,1)
    row1=bw(l,:);
    rowsum(l)=sum(row1);
 end
 [rowmax,ind1]=max(rowsum);
 rowm=find(rowsum==rowmax);
 indrow1=(min(rowm)+max(rowm))/2;
 for m=1:size(bw,2)
    col1=bw(:,m);
    colsum(m)=sum(col1);
 end
 [colmax,ind2]=max(colsum);
colm=find(colsum==colmax);
 indcol2=(min(colm)+max(colm))/2;

%COORDINATES OF NEAREST NON ZERO PIXEL POINT FROM THE CENTRE OF THE IMAGE
image1=img1;
se = strel('disk',4);
image2=imbin;
imgc1=imerode(image1,se);
imcdiff=image1-image2;
imcdil1=imerode(imcdiff,se);
imbw=im2bw(imcdil1);
figure(6),imshow(imbw);
figure(7),imshow(image1);


[rows, cols] = find(imbw==1);
k=size(rows);
for i=1:k
    rp=rows(i);
    cp=cols(i);
    xc=size(imbw,1)/2;
    yc=size(imbw,2)/2;
    x=abs(rp-xc);
    y=abs(cp-yc);
    r(i)=x^2+y^2;
end
    [rmin,j]=min(r);    

     xmin=rows(j);
     ymin=cols(j);
          
     xcenter=(indrow1);
     ycenter=(indcol2);
     
fimg=zeros(size(bw));
fimg=im2bw(imresize(fimg,[size(bw,1) size(bw,2)]));
 fimg(xmin,ymin)=1;
 fimg(xcenter,ycenter)=1;
se1 = strel('disk',2);
fimg=imdilate(fimg,se1);
figure(8),imshow(fimg);




%DRAWING LINE BETWEEN DETECTED POINT
  x1=xmin;
  x2=xcenter;
 y1=ymin;
  y2=ycenter;
 m=(y2-y1)/(x2-x1);

  x3=1;
  y3=m*(x3-x1)+y1;
%  y3=1;
%  x3=m*(y3-y1)+x1;
 for q = 0:(1/round(sqrt((x1-x3)^2 + (y1-y3)^2 ))):1 
xn = round(x1 +(x3 - x1)*q); 
yn = round(y1 +(y3 - y1)*q); 
if(xn > 0 && yn>0) 
    fimg(xn,yn) = 1; 
end
 end
%  fimg=im2bw(imresize(fimg,[size(bw,1) size(bw,2)]));
  fimg1=fimg+bw;
  se1=strel('disk',2);
 figure(9),imshow(imdilate(fimg1,se1));
    