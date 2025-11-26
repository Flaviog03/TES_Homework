function [ DFT ] = myDftMatrix( finestra )
    N = length ( finestra ) ;
    H = zeros (N , N ) ;
    for k =1:1: N
        for n =1:1: N
            H (k , n ) = exp ( -1 * j *2* pi *( n -1) *( k -1) / N ) ;
        end
    end
    DFT = H * finestra ;
end