% The MATLAB help file suggests an interesting method of generating
% the Fibonacci numbers. Apparently the determinate of the Dramadah
% Matrix of type 3 (MATLAB designation) and size n-by-n is the
% nth Fibonacci number. This method is implimented below. 

function number = fibonacci2(n) 
    if n == 1
        number = 1;
    elseif n == 0
        number = 0;
    elseif n < 0
        number = ((-1)^(n+1))*fibonacci2(-n);;
    else
        number = det(gallery('dramadah',n,3));
    end 
end