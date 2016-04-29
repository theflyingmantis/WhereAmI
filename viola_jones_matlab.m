s = strcat('C:\Users\om\Desktop\abhimanyu\A', '1', '.jpg');
I=imread(s);
FaceDetector=vision.CascadeObjectDetector();
BBOX=step(FaceDetector,I);
B=insertObjectAnnotation(I,'rectangle',BBOX,'face');
imshow(B);
n=size(BBOX,1);
fprintf('%d\n',n);
