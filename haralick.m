for itr= 350: 350
    disp(itr);
    PX= zeros(1,11);
    str1=M(itr,1);
    str=(strcat(str0,str1));
    str11=(str{:});
    II=imread(str11);  
    cycl=imresize(II,[MM,NN]);

    [row1,col1]=size(cycl);    
    
      grayImage=rgb2gray(cycl);
      imshow(grayImage);
      size1=200;
      I=imresize(grayImage, [size1 size1]);
      angles = [0] * pi/4;   
      distances = [1];      
      numlevels = 256;
      graylimits = [0, 255];
      %glcm=graycomatrix(I);
      %IOct = uint16(floor(numlevels*(double(I)/graylimits(2))));   
      %diminuish bit depth; I supposed graylimits(1) to be zero.
      theglcm = graycomatrix(I, numlevels, distances, angles);
      theglcm = squeeze(theglcm);

      %trans_glcm= transpose(theglcm);
      normalized_glcm=theglcm; %+trans_glcm;
      %normalized_glcm1=double(normalized_glcm);
      count=double(0);
      for i=1:size1
         for j=1:size1                                           
                         a=double(normalized_glcm(i,j));
                         count=count+a;                    
         end
       end
      for i=1:size1
          for j=1:size1
                       normalized_glcm1(i,j)=0.0;
                       if(normalized_glcm(i,j)>0)
                          normalized_glcm1(i,j)= ((double(normalized_glcm(i,j)))/count);
                          %disp(normalized_glcm1(i,j));                        
                       endif    
                                           
          end
       end
       %contrast%     
       Contrast=double(0.0);
       for i=1:size1
         for j=1:size1                                           
                 temp=normalized_glcm1(i,j)*(i-j)^2;
                 Contrast=Contrast+temp;                    
         end
       end
       %energy%     
       Energy=double(0.0);
       for i=1:size1
         for j=1:size1                                           
                 temp=normalized_glcm1(i,j)^2;
                 Energy=Energy+temp;                    
         end
       end 
       %Homogeneity%     
       Homogeneity=double(0.0);
       for i=1:size1
         for j=1:size1                                           
                 temp=(normalized_glcm1(i,j)/(1+(i-j)^2));
                 Homogeneity=Homogeneity+temp;                    
         end
       end
       %Entropy%     
       Entropy=double(0.0);
       for i=1:size1
         for j=1:size1      
                 if((normalized_glcm1(i,j)) != 0)
                    temp=(-1)*(normalized_glcm1(i,j)*(log(normalized_glcm1(i,j))));
                    Entropy=Entropy+temp;  
                  endif   
         end
       end
       %Mean%     
       MeanX=double(0.0);
       MeanY=double(0.0);
       for i=1:size1
         for j=1:size1                                           
                  temp1=(normalized_glcm1(i,j)*i);
                  temp2=(normalized_glcm1(i,j)*j);
                  MeanX=temp1+MeanX;
                  MeanY=temp2+MeanY;                                   
         end
       end
       %Variance%     
       VarianceX=double(0.0);
       VarianceY=double(0.0);
       for i=1:size1
         for j=1:size1                                           
                  temp1=(normalized_glcm1(i,j)*(i-MeanX)^2);
                  temp2=(normalized_glcm1(i,j)*(j-MeanY)^2);
                  VarianceX=temp1+VarianceX;
                  VarianceY=temp2+VarianceY;                                   
         end
       end
       %Correlation%     
       Correlation=double(0.0);
       for i=1:size1
         for j=1:size1                     
                    temp=(normalized_glcm1(i,j)*(((1-MeanX)*(1-MeanY))/(VarianceX*VarianceY)));
                    Correlation=Correlation+temp;                  
         end
       end
       %moment%     
       m1=double(0.0);
       m2=double(0.0);
       m3=double(0.0);
       m4=double(0.0);
       for i=1:size1
         for j=1:size1                                           
                 temp1=normalized_glcm1(i,j)*(i-j);
                 m1=m1+temp1;                    

                 temp2=normalized_glcm1(i,j)*(i-j)^2;
                 m2=m2+temp2;
                 
                 temp3=normalized_glcm1(i,j)*(i-j)^3;
                 m3=m3+temp3;
                 
                 temp4=normalized_glcm1(i,j)*(i-j)^4;
                 m4=m4+temp4;                    
         end
       end  
