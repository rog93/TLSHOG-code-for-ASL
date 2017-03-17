clc
clear all
label=zeros(24,1);
for i=1:1
    for j=1:24
        label(((i-1)*24+j),1)=j;
    end
end