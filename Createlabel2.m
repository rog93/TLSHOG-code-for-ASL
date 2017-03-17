clc
clear all
load label.mat
label_size=200*120;
label_N=zeros(label_size,1);
for i=1:5
    for j=1:24
        for k=1:200
            label_N((((i-1)*24+j-1)*200+k),1)=label(((i-1)*24+j),1);
        end
    end
end