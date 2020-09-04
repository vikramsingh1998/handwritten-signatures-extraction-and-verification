function [I1 I2] = divide(Image)

% DIVIDE Divide the full signature into initial and final signatures.

% B = divide(A) computes the initial and final parts of the original
% signature.

Is = skeletonize(Image);
I = RemoveWhiteSpace(Is);
[m,n] = size(I);
b = 1;
a = 1;
Z = [];
Y = [];

for i = 1:n
    
    if sum(I(:,i)) == m
        
        Y(1,b) = i;
        
    end
    
    b = b + 1;
    
end

if ~isempty(Y) == 1
    
    X = mat2cell(Y,1,diff([0, find(diff(Y)~=1), length(Y)]));
    
    Length_X = cellfun('length', X);
    
    for i = 1:numel(Length_X)
        
        if Length_X(i) >= 13 & Length_X <= 80
            
            Z{a} = cell2mat(X(i));
            a = a+1;
            
        end
        
    end
    
    
    [p r] = size(Z);
    
    if r == 0
        
        c1 = [];
        c2 = [];
        I1 = I;
        I2 = I;
        
    elseif r == 1
        
        x = cell2mat(Z);
        c1 = x(1,1);
        c2 = x(1,end);
        
        if nnz(~I(:,c2:end)) == 1 | nnz(~I(:,c2:end)) == 2
            
            I1 = I;
            I2 = I;
            
        else
            
            I1 = I(:,1:c1);
            I2 = I(:,c2:end);
            
        end
    else
        
        x1 = cell2mat(Z(1));
        x2 = cell2mat(Z(2));
        
        if x2(1,1)-x1(1,end) == 2
            
            c1 = x1(1,end) + 2;
            c2 = x2(1,end);
            I1 = I(:,1:c1);
            I2 = I(:,c2:end);
            
        else
            
            c1 = x2(1);
            c2 = x2(1,end);
            I1 = I(:,1:c1);
            I2 = I(:,c2:end);
            
        end
        
    end
    
    if size(I1) == size(I) & size(I2) == size(I)
        
        imshow(I)
        
    else
        
        subplot(1,2,1)
        imshow(I1)
        
        subplot(1,2,2)
        imshow(I2)
        
    end
    
else
    
    imshow(I)
end

end