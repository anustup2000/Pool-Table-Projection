function [img] = imcrop1(img,center,radius)
if((center(1)-10*radius)>0 && (center(2)-10*radius)>0 && (center(1)+10*radius)<size(img,1) && (center(2)+10*radius)<size(img,2))            
    img = imcrop(img,[center(1)-10*radius,center(2)-10*radius,20*radius,20*radius]);
elseif((center(1)-10*radius)<0 && (center(2)-10*radius)>0 && (center(2)+10*radius)<size(img,2))            
    img = imcrop(img,[0,center(2)-10*radius,center(1)+10*radius,20*radius]);
elseif((center(1)-10*radius)>0 && (center(2)-10*radius)<0 && (center(1)+10*radius)<size(img,1))            
    img = imcrop(img,[center(1)-10*radius,0,10*radius,20*radius]);
elseif((center(1)-10*radius)<0 && (center(2)-10*radius)<0)            
    img = imcrop(img,[0,0,center(1)+10*radius,center(2)+10*radius]);
elseif((center(2)-10*radius)>0 && (center(1)+10*radius)>size(img,1) && (center(2)+10*radius)<size(img,2))            
    img = imcrop(img,[center(1)-10*radius,center(2)-10*radius,size(img,1)-center(1)+10*radius,20*radius]);
elseif((center(1)-10*radius)>0 && (center(1)+10*radius)<size(img,1) && (center(2)+10*radius)>size(img,2))            
    img = imcrop(img,[center(1)-10*radius,center(2)-10*radius,20*radius,size(img,2)-center(2)+10*radius]);
elseif((center(1)+10*radius)>size(img,1) && (center(2)+10*radius)>size(img,2))            
    img = imcrop(img,[center(1)-10*radius,center(2)-10*radius,size(img,1)-center(1)+10*radius,size(img,2)-center(2)+10*radius]);
elseif((center(1)-10*radius)<0 && (center(2)+10*radius)>size(img,2))            
    img = imcrop(img,[0,center(2)-10*radius,center(1)+10*radius,size(img,2)-center(2)+10*radius]);
elseif((center(2)-10*radius)<0 && (center(1)+10*radius)>size(img,1))            
    img = imcrop(img,[center(1)-10*radius,0,size(img,1)-center(1)+10*radius,center(2)+10*radius]);
end