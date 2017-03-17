% clc
% clear all
% load trainpath2.mat
% load testpath2.mat
% load label2.mat
% TPM_feature3=[];
% Iter=20;
% times=0;
% TPM_feature=[];
% for ii=1:5
%     for jj=1:24
%         (ii-1)*24+jj
%         A=trainpath((ii-1)*24+jj,:);
%         A(cellfun(@isempty,A))=[];
%         sizeStr=size(A,2);
%         %%%%%%%%%%%%%%%%%%%%%%%%%%分块
%         cellNum=10;
%         itv=floor(sizeStr/cellNum);
%         rangeStr=1:itv:sizeStr;
%         %%%%%%%%%%%%%%%%随机采样步骤
%         t=0;
%         Numitv=size(rangeStr,2)-1;
%         if Numitv<cellNum
%             rangeStr=[rangeStr,sizeStr];
%         end
%         for k_=1:cellNum
%             rangei=rangeStr(k_):rangeStr(k_+1);
%             size_ri=size(rangei,2);
%             Ai=cell(1,size_ri);
%             for kk=1:size_ri
%                 Ai{1,kk}=A{1,rangei(kk)};
%             end
% %             delta_max=13;
%             delta_fixed=2;
%             LSH_feature=zeros(sizeStr,1161);
%             sizeA=size(Ai,2);
%             for i=1:sizeA
%                 LSH_feature(i,:)=LS_HOG(Ai{1,i});
%             end
%             for i=1:Iter%迭代20次，20次采样
%                 Begin=1;
%                 End=sizeA-1;
%                 k=1;
%                 for j=Begin:delta_fixed:End
%                     randplus=randi([0,1]);
%                     sample_A{1,k}=Ai{1,j+randplus};
%                     LSH_f(k,:)=LSH_feature(j+randplus,:);
%                     k=k+1;
%                 end
%                 TPM_feature(times*Iter+i,:)=TPM(sample_A,LSH_f);
% %                 Train_label(label_k,1)=ii;
%             end
%             times=times+1; 
%             %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
%         end
%           
%     end
% end
clc
clear all
% load model.mat
load testpath5.mat
tic;
Iter=5;
times=0;
for ii=1:1
    for jj=1:24
        (ii-1)*24+jj
        Aa=testpath((ii-1)*24+jj,:);
        Aa(cellfun(@isempty,Aa))=[];
        sizeStr=size(Aa,2);
    %%%%%%%Aa是文件名矩阵%%%%%%%%%
    %%%%%%%进行滑动窗口%%%%%%%%%
        window_size=30;%窗口长度30
        step=10;%步长为10
        size_Aa=size(Aa,2);
        fNum=1;
        for frm=1:step:(size_Aa-window_size)
            A=cell(1,window_size);
            for l=1:window_size
                A{1,l}=Aa{1,frm+l-1};
            end
    %%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%随机采样步骤
            delta_max=3;
            delta_fixed=3;
            mid_max=ceil(delta_max/2);
            sizeStr=size(A,2);
            LSH_feature=zeros(sizeStr,787);
            for i=1:sizeStr
                LSH_feature(i,:)=LS_HOG(A{1,i});
            end
            sample_A=[];
            LSH_f=[];
            for i=1:Iter%迭代5次，5次采样
                sizeA=size(A,2);
                Begin=(delta_max-1)/2+1;
                End=sizeA-(delta_max-1)/2;
                k=1;
                for j=Begin:delta_fixed:End
                    randplus=randi(delta_max)-mid_max;
                    sample_A{1,k}=A{1,j+randplus};
                    LSH_f(k,:)=LSH_feature(j+randplus,:);
                    k=k+1;
                end
                TPM2_feature(times*Iter+i,:)=TPM(sample_A,LSH_f);
                Test_label(times*Iter+i,1)=jj;
            end
            times=times+1; 
        end
    end
end
toc;