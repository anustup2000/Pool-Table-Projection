%To find White ball
clear all;
close all;
image =imread('E:\Academics\Section Project\pool_images\Picture 1.jpg');
imsizex=size(image,1);
imsizey=size(image,2);
newx=500;
newy=(imsizey/imsizex)*newx;
image = imresize(image, [newx newy]);
figure(1),imshow(image);
image=im2double(image);
[r c p]=size(image);
imR=image(:,:,1);
imG=image(:,:,2);
imB=image(:,:,3);

img = (PictureMask(image));
newimg = zeros(size(img));
%%edit
[centers,radii] = imfindcircles(img,[5 20]);
    for j=1:size(radii)
          newimg = insertShape(newimg,'FilledCircle',[centers(j,:) radii(j)],'Color',[255 255 255] );  
    end


figure(2),imshow(img);
imbin=im2bw(newimg);
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
figure(4),imshow(imlabel);


% TO FIND WHITE COLOR BALL

newR = zeros(r,c); newG = zeros(r,c); newB = zeros(r,c);
newR(rlabel>0.93 & glabel>0.93 & blabel>0.93)=1;
newG(rlabel>0.93 & glabel>0.93 & blabel>0.93)=1;
newB(rlabel>0.93 & glabel>0.93 & blabel>0.93)=1;
newIMG = cat(3, newR, newG, newB);

bw=im2bw(newIMG);
figure(5); imshow(bw);
[centers,radii] = imfindcircles(bw,[5 20]);



%COORDINATES OF NEAREST NON ZERO PIXEL POINT FROM THE CENTRE OF THE IMAGE
image1=img;
se = strel('disk',2);
image2=imbin;
imgc1=imerode(image1,se);
imcdiff=image1-image2;
imcdil1=imerode(imcdiff,se);
imbw=im2bw(imcdil1);
figure(6),imshow(imbw);
[pointx,pointy] = find(imbw);
med_pointx = median(pointx);
med_pointy = median(pointy);
for i = 1:size(radii)
    distance(i) = (med_pointx-centers(1))^2 + (med_pointy-centers(2))^2;
end
[M,I] = min(distance);
Wcenter = centers(I,:);
Wradius = radii(I);
bw = zeros(size(imbw));
bw = insertShape(bw,'FilledCircle',[Wcenter Wradius],'Color',[255 255 255] );
bw = im2bw(bw);
figure(7),imshow(bw);
img_crop = imcrop1(imbw,Wcenter,Wradius);
if(size(find(img_crop))>0)
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

    [rows, cols] = find(imbw==1);
    k=size(rows);
    xcenter=(indrow1);
    ycenter=(indcol2);
    for i=1:k
        rp=rows(i);
        cp=cols(i);
        x=abs(rp-xcenter);
        y=abs(cp-ycenter);
        r(i)=x^2+y^2;
    end
    [rmin,j]=min(r);
    xmin=rows(j);
    ymin=cols(j);
          
    
     
    fimg=zeros(size(bw));
    fimg=im2bw(imresize(fimg,[size(bw,1) size(bw,2)]));
    fimg(xmin,ymin)=1;
    fimg(round(xcenter),round(ycenter))=1;
    se1 = strel('disk',2);
    fimg=imdilate(fimg,se1);
    figure(8),imshow(fimg);

    %DRAWING LINE BETWEEN DETECTED POINT
    x1=xmin;
    x2=xcenter;
    y1=ymin;
    y2=ycenter;
    m=(y2-y1)/(x2-x1);
 
    %condition 1
    if(x2<=x1&&y2<=y1)
        x3=1;
        y3=m*(x3-x2)+y2;
        if(y3>0 && y3< size(fimg,2))
            y3=m*(x3-x2)+y2;
        else
            y3=1;
            x3=((y3-y2)/m)+x2; 
        end
    else
    %condition 2   
        if(x2<x1&&y2>=y1)
            x3=1;
            y3=m*(x3-x2)+y2;
            if(y3>0 && y3< size(fimg,2))
                y3=m*(x3-x2)+y2;
            else
                y3=size(fimg,2);
                x3=((y3-y2)/m)+x2;
        
            end
        else   
        % condition 3
            if(x2>=x1&&y2>y1)
                x3=size(fimg,1);
                y3=m*(x3-x2)+y2;
                if(y3>0 && y3< size(fimg,2))
                    y3=m*(x3-x2)+y2;
                else
                    y3=size(fimg,2);
                    x3=((y3-y2)/m)+x2;
                end
            else   
            %condition 4
                if(x2>x1&&y2<y1)
                    x3=size(fimg,1);
                    y3=m*(x3-x2)+y2;
                    if(y3>0 && y3< size(fimg,2))
                        y3=m*(x3-x2)+y2;
                    else
                        y3=1;
                        x3=((y3-y2)/m)+x2;
                    end
                end
            end
        end
    end
    lineimg = zeros(size(fimg));
    for q = 0:(1/round(sqrt((x2-x3)^2+(y2-y3)^2))):1 
        xn = round(x2 +(x3 - x2)*q); 
        yn = round(y2 +(y3 - y2)*q); 
        lineimg(xn,yn)=1; 
    end



    %for 1st reflection
    [xref1,yref1,mref1] = reflection(x3,y3,m,lineimg);
    for q = 0:(1/round(sqrt((xref1-x3)^2+(yref1-y3)^2))):1 
        xn = round(x3 +(xref1 - x3)*q); 
        yn = round(y3 +(yref1 - y3)*q); 
        lineimg(xn,yn)=1; 
    end

    %for 2nd reflection
    x3 = xref1;
    y3 = yref1;
    [xref2,yref2,mref2] = reflection(x3,y3,mref1,lineimg);
    for q = 0:(1/round(sqrt((xref2-x3)^2+(yref2-y3)^2))):1 
        xn = round(x3 +(xref2 - x3)*q); 
        yn = round(y3 +(yref2 - y3)*q); 
        lineimg(xn,yn)=1; 
    end

    lineimg=imresize(lineimg,[size(bw,1) size(bw,2)]);
    fimg1=lineimg+bw;
    se1=strel('disk',2);
    lineimg =lineimg - imbin;
    figure(11),imshow(imdilate(lineimg,se1));
end