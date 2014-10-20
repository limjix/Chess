function [possiblemoves] = KingMovement(piece_colour,chessboard,p_x,p_y)

%Initialisation values --------------------------------------------------
r_colour = piece_colour(p_x,p_y);
possiblemoves = zeros(8,8);

%This section allows all movements after checking whether it exceeds the board or not ---------------
    
    if(p_x+1<9)
        if (piece_colour(p_x+1,p_y)~= r_colour && chessboard(p_x+1,p_y)~=0)
            possiblemoves(p_x+1,p_y) = 2;
        elseif (piece_colour(p_x+1,p_y)== r_colour)
            ;
        else
            possiblemoves(p_x+1,p_y) = 1;
        end
    end
    
    if(p_x+1<9 & p_y+1<9)
        if (piece_colour(p_x+1,p_y+1)~= r_colour && chessboard(p_x+1,p_y+1)~=0)
            possiblemoves(p_x+1,p_y+1) = 2;
        elseif (piece_colour(p_x+1,p_y+1)== r_colour)
            ;
        else
            possiblemoves(p_x+1,p_y+1) = 1;
        end
    end
    
    if(p_x+1<9 & p_y-1>0)
        if (piece_colour(p_x+1,p_y-1)~= r_colour && chessboard(p_x+1,p_y-1)~=0)
            possiblemoves(p_x+1,p_y-1) = 2;
        elseif (piece_colour(p_x+1,p_y-1)== r_colour)
            ;
        else
            possiblemoves(p_x+1,p_y-1) = 1;
        end
    end
    
    if(p_y+1<9)
        if (piece_colour(p_x,p_y+1)~= r_colour && chessboard(p_x,p_y+1)~=0)
            possiblemoves(p_x,p_y+1) = 2;
        elseif (piece_colour(p_x,p_y+1)== r_colour)
            ;
        else
            possiblemoves(p_x,p_y+1) = 1;
        end
    end
    
    if(p_y-1>0)
        if (piece_colour(p_x,p_y-1)~= r_colour && chessboard(p_x,p_y-1)~=0)
            possiblemoves(p_x,p_y-1) = 2;
        elseif (piece_colour(p_x,p_y-1)== r_colour)
            ;
        else
            possiblemoves(p_x,p_y-1) = 1;
        end
    end
    
    if(p_x-1>0)
        if (piece_colour(p_x-1,p_y)~= r_colour && chessboard(p_x-1,p_y)~=0)
            possiblemoves(p_x-1,p_y) = 2;
        elseif (piece_colour(p_x-1,p_y)== r_colour)
            ;
        else
            possiblemoves(p_x-1,p_y) = 1;
        end
    end
    
    if(p_x-1>0 & p_y+1<9)
        if (piece_colour(p_x-1,p_y+1)~= r_colour && chessboard(p_x-1,p_y+1)~=0)
            possiblemoves(p_x-1,p_y+1) = 2;
        elseif (piece_colour(p_x-1,p_y+1)== r_colour)
            ;
        else
            possiblemoves(p_x-1,p_y+1) = 1;
        end
    end
    
    if(p_x-1>0 & p_y-1>0)
        if (piece_colour(p_x-1,p_y-1)~= r_colour && chessboard(p_x-1,p_y-1)~=0)
            possiblemoves(p_x-1,p_y-1) = 2;
        elseif (piece_colour(p_x-1,p_y-1)== r_colour)
            ;
        else
            possiblemoves(p_x-1,p_y-1) = 1;
        end
    end
   
   

possiblemoves(p_x,p_y)=0;
%-------------------------------------------------------------------------
end