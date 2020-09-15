load Trainfea
for aaa = 11 : 11
    aaa
IMAGE = imread(['Dataset\',num2str(aaa),'.png']);
    IMAGE = imresize(IMAGE,[500 500]);
    
IM = fspecial('gaussian',[3 3],0.5);
Filt_img = imfilter(IMAGE,IM);
% axes(handles.axes1);
% imshow(Filt_img);axis off;
% title('Filtered image','fontname','Times New Roman','fontsize',12);
R = Filt_img(:,:,1);
G = Filt_img(:,:,2);
B = Filt_img(:,:,3);

RJ = imadjust(R);
GJ = imadjust(G);
BJ = imadjust(B);
try
    OUT = cat(3,RJ,GJ,BJ);
catch
    
    OUT(:,:,1) = RJ;
    OUT(:,:,2) = GJ;
    OUT(:,:,3) = BJ;

end

% axes(handles.axes1);
% imshow(OUT);
% title('Normalized image','fontname','Times New Roman','fontsize',12);


% -- Patch Extraction -- %
Img = OUT;
I1 = Img(1:size(Img,1)/2,1:size(Img,2)/2,:);
J1 = I1(1:size(I1,1)/2,1:size(I1,2)/2,:);
J2 = I1(size(I1,1)/2+1:size(I1,1),1:size(I1,2)/2,:);
J3 = I1(1:size(I1,1)/2,size(I1,2)/2+1:size(I1,2),:);
J4 = I1(size(I1,1)/2+1:size(I1,1),size(I1,2)/2+1:size(I1,2),:);
% -----------------------------------------------------------------
I2 = Img(size(Img,1)/2+1:size(Img,1),1:size(Img,2)/2,:);
K1 = I2(1:size(I2,1)/2,1:size(I2,2)/2,:);
K2 = I2(size(I2,1)/2+1:size(I2,1),1:size(I2,2)/2,:);
K3 = I2(1:size(I2,1)/2,size(I2,2)/2+1:size(I2,2),:);
K4 = I2(size(I2,1)/2+1:size(I2,1),size(I2,2)/2+1:size(I2,2),:);
% J2 = I2(size(I2,1)/2+1:size(I2,1),1:size(I2,2)/2,:);
% -----------------------------------------------------------------
I3=Img(1:size(Img,1)/2,size(Img,2)/2+1:size(Img,2),:);
L1 = I3(1:size(I3,1)/2,1:size(I3,2)/2,:);
L2 = I3(size(I3,1)/2+1:size(I3,1),1:size(I3,2)/2,:);
L3 = I3(1:size(I3,1)/2,size(I3,2)/2+1:size(I3,2),:);
L4 = I3(size(I3,1)/2+1:size(I3,1),size(I3,2)/2+1:size(I3,2),:);
% J3 = I3(1:size(I3,1)/2,size(I3,2)/2+1:size(I3,2),:);
% -----------------------------------------------------------------
I4 = Img(size(Img,1)/2+1:size(Img,1),size(Img,2)/2+1:size(Img,2),:);
M1 = I4(1:size(I4,1)/2,1:size(I4,2)/2,:);
M2 = I4(size(I4,1)/2+1:size(I4,1),1:size(I4,2)/2,:);
M3 = I4(1:size(I4,1)/2,size(I4,2)/2+1:size(I4,2),:);
M4 = I4(size(I4,1)/2+1:size(I4,1),size(I4,2)/2+1:size(I4,2),:);


% figure(4),
% subplot(2,2,1);
% imshow(I1);
% subplot(2,2,2);
% imshow(I3);
% subplot(2,2,3);
% imshow(I2);
% subplot(2,2,4);
% imshow(I4);

% -- Chanel Sepepration -- %

R1 = I2(:,:,1);
G1 = I2(:,:,2);
B1 = I2(:,:,3);
R2 = I1(:,:,1);
G2 = I1(:,:,2);
B2 = I1(:,:,3);
R4 = I4(:,:,1);
G4 = I4(:,:,2);
B4 = I4(:,:,3);
R3 = I3(:,:,1);
G3 = I3(:,:,2);
B3 = I3(:,:,3);


GRAY = rgb2gray(OUT);

title('segmented image','fontname','Times New Roman','fontsize',12);

    LBPimg = LBP((GRAY), [2,3]); 
    LBPfeature=imhist(LBPimg);
    LBPfea = LBPfeature';
    Trainfea(aaa,:) = LBPfea;
    save Trainfea Trainfea


end
