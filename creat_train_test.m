clc
clear all
trainpath=[];
testpath=[];
F1={'A','B','C','D','E'};
F2={'a','b','c','d','e','f','g','h','i','k','l','m','n','o','p','q','r','s','t'...
    ,'u','v','w','x','y'};
trainid=1;
for i=5:5
    for j=1:24
        Files = dir(fullfile(['/Volumes/CRM_HW/dataset5/',F1{i},'/',F2{j}],'*.png'));
        len=size(Files,1);
        if(rem(len,2)==1)
            len=len-1;
        end
        folder=[Files(1,1).folder,'/'];
        len1=len;
        for k=1:len1
            file1=[folder,Files(k,1).name];
            testpath{trainid,k}=file1;
        end
        trainid=trainid+1
        
    end
end