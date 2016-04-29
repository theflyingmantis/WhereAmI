a=VideoReader('vidit.mp4');
k=a.NumberOfFrames;
display(k);
%% Extracting Images from Video!
tic;
for img = 1:a.NumberOfFrames;
    %if mod(img,100) == 0
        filename=strcat(num2str(img),'.jpg');
        b=read(a,img);
        imwrite(b,filename);
    %end
end
toc;