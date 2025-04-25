%Kernel Matrix Calculator
%By Makenna Noel

% Gaussian Kernel Formula
% G(x,y) = (1 /(2*pi*σ²))*e^((-x²+y²)/(2* σ²)) 
% Step 1: The function will determine the Kernel Size with the input, size
% Step 2: Compute G(x,y) for each cell, where x, y range from the center pixel
% Step 3: Normalizing the matrix sum so it equals 1 (or integer power of two for
% hardware). For example, if I normalize it by 16 for my hardware, it should 
% be divided by 16 in verilog code via shifting (>> 4)

function Kernel_Matrix = KernelCalculation(size, standard_dev)
    Kernel_Matrix = zeros(size,size);
    center = fix(size/2) + 1;
    disp(center);
    for row = 1:size
        for col = 1:size
            x = row - center;
            y = col - center;
            Kernel_Matrix(row,col) = (1 /(2*pi*(standard_dev^2)))*exp(-1*((x^2)+(y^2))/(2*(standard_dev^2))); 
        end
    end
    %disp(Kernel_Matrix * 16);
    %disp((1 /(2*pi*(standard_dev^2)))*exp(-1*((0^2)+(0^2))/(2*(standard_dev^2)))); 

    Kernel_Matrix = round(Kernel_Matrix * 16);
end

disp(KernelCalculation(3, 1));
disp(KernelCalculation(5, 1));

disp(round(fspecial('gaussian', 3, 1)*16));
disp(round(fspecial('gaussian', 5, 1)*256));








