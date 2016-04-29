function [] = faceDetect( dim, IMG )
clc;
%% Read subject1 video
fprintf('Initializing training on first subject.\n');

fprintf('Extracting features...  ');
tic;
for a=1:127
    s = strcat('C:\Users\om\Desktop\abhimanyu\A', int2str(a), '.jpg');
    I = imresize(imread(s),[dim dim]);
    J = rgb2gray(I);
    T(a,:) = reshape(haar_2d(J),1,dim*dim);
end

toc;
%% Read subject0 video
fprintf('Initializing training on second subject.\n');
fprintf('Extracting features...  ');
tic;
for a=1:220
    s = strcat('P:\Techno Projs\faces\ClassA\', int2str(a), '.jpg');
    I = imresize(imread(s),[dim dim]);
    J = rgb2gray(I);
    T(n1+a,:) = reshape(haar_2d(J),1,dim*dim);
end
n0 = 220;
toc;
%% Train SVM
fprintf('Training:   ');
tic;
T = double(T);
Y = zeros(n1+n0,1);
Y(1:n1) = ones(n1,1);
SVMSTRUCT = svmtrain(T,Y);
toc;
fprintf('Training complete.\n\n');
%% Read Test Images

fprintf('Reading test images... \n');
s = strcat('P:\Techno Projs\faces\fwd\', int2str(IMG), '.jpg');
I = imresize(imread(s),[512 NaN]);
faceDetector = vision.CascadeObjectDetector();
bbox = step(faceDetector, I);
Iout = I;
fprintf('Total %d faces found. Beginning comparison..  \n', size(bbox,1));
for a=1:size(bbox,1)
    fprintf('Face %d -> ', a);
    X = imcrop(I,bbox(a,:));
    TI = imresize(X,[dim dim]);
    TJ = rgb2gray(TI);
    TV = reshape(haar_2d(TJ),1,dim*dim);
    TV = double(TV);
    GROUP = svmclassify(SVMSTRUCT,TV);
    fprintf('Match found!  ');
    pos = bbox(a,:);
    pos(2) = pos(2) - 20;
    pos(1) = pos(1) + pos(3)/8;
    if GROUP == 0
        name = 'Archit';
    else
        name = 'Kanika';
    end
    fprintf('Person: %s. \n', name);
    Iout = insertShape(Iout,'rectangle',bbox(a,:),'Color','yellow');
    Iout = insertText(Iout,pos(1:2),name);
end
figure, imshow(Iout);
fprintf('\n\n');

end

