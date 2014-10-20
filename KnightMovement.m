function [possiblemoves] = KnightMovement(chessboard,piece_colour,p_x,p_y)

%Initialisation values --------------------------------------------------
r_colour = piece_colour(p_x,p_y);
possiblemoves = zeros(8,8);

%This sections allows L shaped movements for knight
if(p_x-2>0 & p_y-1>0)
    if (piece_colour(p_x-2,p_y-1)~= r_colour && chessboard(p_x-2,p_y-1)~=0)
        possiblemoves(p_x-2,p_y-1) = 2;
    elseif (piece_colour(p_x-2,p_y-1)== r_colour)
        ;
    else
        possiblemoves(p_x-2,p_y-1) = 1;
    end
end

if(p_x-2>0 & p_y+1<9)
    if (piece_colour(p_x-2,p_y+1)~= r_colour && chessboard(p_x-2,p_y+1)~=0)
        possiblemoves(p_x-2,p_y+1) = 2;
    elseif (piece_colour(p_x-2,p_y+1)== r_colour)
        ;
    else
        possiblemoves(p_x-2,p_y+1) = 1;
    end
end

if(p_x-1>0 & p_y-2>0)
    if (piece_colour(p_x-1,p_y-2)~= r_colour && chessboard(p_x-1,p_y-2)~=0)
        possiblemoves(p_x-1,p_y-2) = 2;
    elseif (piece_colour(p_x-1,p_y-2)== r_colour)
        ;
    else
        possiblemoves(p_x-1,p_y-2) = 1;
    end
end

if(p_x-1>0 & p_y+2<9)
    if (piece_colour(p_x-1,p_y+2)~= r_colour && chessboard(p_x-1,p_y+2)~=0)
        possiblemoves(p_x-1,p_y+2) = 2;
    elseif (piece_colour(p_x-1,p_y+2)== r_colour)
        ;
    else
        possiblemoves(p_x-1,p_y+2) = 1;
    end
end

if(p_x+1<9 & p_y-2>0)
    if (piece_colour(p_x+1,p_y-2)~= r_colour && chessboard(p_x+1,p_y-2)~=0)
        possiblemoves(p_x+1,p_y-2) = 2;
    elseif (piece_colour(p_x+1,p_y-2)== r_colour)
        ;
    else
        possiblemoves(p_x+1,p_y-2) = 1;
    end
end

if(p_x+1<9 & p_y+2<9)
    if (piece_colour(p_x+1,p_y+2)~= r_colour && chessboard(p_x+1,p_y+2)~=0)
        possiblemoves(p_x+1,p_y+2) = 2;
    elseif (piece_colour(p_x+1,p_y+2)== r_colour)
        ;
    else
        possiblemoves(p_x+1,p_y+2) = 1;
    end
end

if(p_x+2<9 & p_y-1>0)
    if (piece_colour(p_x+2,p_y-1)~= r_colour && chessboard(p_x+2,p_y-1)~=0)
        possiblemoves(p_x+2,p_y-1) = 2;
    elseif (piece_colour(p_x+2,p_y-1)== r_colour)
        ;
    else
        possiblemoves(p_x+2,p_y-1) = 1;
    end
end

if(p_x+2<9 & p_y+1<9)
    if (piece_colour(p_x+2,p_y+1)~= r_colour && chessboard(p_x+2,p_y+1)~=0)
        possiblemoves(p_x+2,p_y+1) = 2;
    elseif (piece_colour(p_x+2,p_y+1)== r_colour)
        ;
    else
        possiblemoves(p_x+2,p_y+1) = 1;
    end
end

%-------------------------------------------------------------------------

end