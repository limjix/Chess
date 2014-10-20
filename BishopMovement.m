function [possiblemoves] = BishopMovement(chessboard,piece_colour,p_x,p_y)

%Initialisation values --------------------------------------------------
r_colour = piece_colour(p_x,p_y);
possiblemoves = zeros(8,8);

%This section allows movement in / direction -----------------------------
i=1;
while(p_x+i<9 & p_y+i<9)
    if(piece_colour(p_x+i,p_y+i)== r_colour)
        break
    end
    if(piece_colour(p_x+i,p_y+i)~= r_colour & chessboard(p_x+i,p_y+i)~=0)
        possiblemoves(p_x+i,p_y+i) = 2;
        break
    end
    possiblemoves(p_x+i,p_y+i) = 1;
    i = i+1;
end

i=1;
while(p_x-i>0 & p_y-i>0)
    if(piece_colour(p_x-i,p_y-i)== r_colour)
        break
    end
    if(piece_colour(p_x-i,p_y-i)~= r_colour & chessboard(p_x-i,p_y-i)~=0)
        possiblemoves(p_x-i,p_y-i) = 2;
        break
    end
    possiblemoves(p_x-i,p_y-i) = 1;
    i = i+1;
end

%This section allows movement in the \ direction-------------------------
i=1;
while(p_x+i<9 & p_y-i>0)
    if(piece_colour(p_x+i,p_y-i)== r_colour)
        break
    end
    if(piece_colour(p_x+i,p_y-i)~= r_colour & chessboard(p_x+i,p_y-i)~=0)
        possiblemoves(p_x+i,p_y-i) = 2;
        break
    end
    possiblemoves(p_x+i,p_y-i) = 1;
    i = i+1;
end

i=1;
while(p_x-i>0 & p_y+i<9)
    if(piece_colour(p_x-i,p_y+i)== r_colour)
        break
    end
    if(piece_colour(p_x-i,p_y+i)~= r_colour & chessboard(p_x-i,p_y+i)~=0)
        possiblemoves(p_x-i,p_y+i) = 2;
        break
    end
    possiblemoves(p_x-i,p_y+i) = 1;
    i = i+1;
end

%-------------------------------------------------------------------------

end