function [possiblemoves] = QueenMovement(chessboard,piece_colour,p_x,p_y)

%Initialisation values --------------------------------------------------
possiblemoves = zeros(8,8);
r_colour = piece_colour(p_x,p_y);

%This section allows movement in / direction -----------------------------
i=1;
while(p_x+i<9 && p_y+i<9)
    if(piece_colour(p_x+i,p_y+i)== r_colour)
        break
    end
    if(piece_colour(p_x+i,p_y+i)~= r_colour && chessboard(p_x+i,p_y+i)~=0)
        possiblemoves(p_x+i,p_y+i) = 2;
        break
    end
    possiblemoves(p_x+i,p_y+i) = 1;
    i = i+1;
end

i=1;
while(p_x-i>0 && p_y-i>0)
    if(piece_colour(p_x-i,p_y-i)== r_colour)
        break
    end
    if(piece_colour(p_x-i,p_y-i)~= r_colour && chessboard(p_x-i,p_y-i)~=0)
        possiblemoves(p_x-i,p_y-i) = 2;
        break
    end
    possiblemoves(p_x-i,p_y-i) = 1;
    i = i+1;
end

%This section allows movement in the \ direction-------------------------
i=1;
while(p_x+i<9 && p_y-i>0)
    if(piece_colour(p_x+i,p_y-i)== r_colour)
        break
    end
    if(piece_colour(p_x+i,p_y-i)~= r_colour && chessboard(p_x+i,p_y-i)~=0)
        possiblemoves(p_x+i,p_y-i) = 2;
        break
    end
    possiblemoves(p_x+i,p_y-i) = 1;
    i = i+1;
end

i=1;
while(p_x-i>0 && p_y+i<9)
    if(piece_colour(p_x-i,p_y+i)== r_colour)
        break
    end
    if(piece_colour(p_x-i,p_y+i)~= r_colour && chessboard(p_x-i,p_y+i)~=0)
        possiblemoves(p_x-i,p_y+i) = 2;
        break
    end
    possiblemoves(p_x-i,p_y+i) = 1;
    i = i+1;
end

%This section allows movement in vertical direction -----------------------------
i = 1;
while(p_x+i<9)
    if(piece_colour(p_x+i,p_y)== r_colour)
        break
    end
    if(piece_colour(p_x+i,p_y)~= r_colour && chessboard(p_x+i,p_y)~=0)
        possiblemoves(p_x+i,p_y) = 2;
        break
    end
    possiblemoves(p_x+i,p_y) = 1;
    i = i+1;
end
            
i = 1;
while(p_x-i>0)
    if(piece_colour(p_x-i,p_y)== r_colour)
        break
    end
     if(piece_colour(p_x-i,p_y)~= r_colour && chessboard(p_x-i,p_y)~=0)
        possiblemoves(p_x-i,p_y) = 2;
        break
    end
    possiblemoves(p_x-i,p_y) = 1;
    i = i+1;
end

%This section allows movement in the horizontal direction-------------------------
i = 1;
while(p_y+i<9)
    if(piece_colour(p_x,p_y+i)== r_colour)
        break
    end
    if(piece_colour(p_x,p_y+i)~= r_colour && chessboard(p_x,p_y+i)~=0)
        possiblemoves(p_x,p_y+i) = 2;
        break
    end
    possiblemoves(p_x,p_y+i) = 1;
    i = i+1;
end

i = 1;
while(p_y-i>0)
    if(piece_colour(p_x,p_y-i)== r_colour)
        break
    end
    if(piece_colour(p_x,p_y-i)~= r_colour && chessboard(p_x,p_y-i)~=0)
        possiblemoves(p_x,p_y-i) = 2;
        break
    end
    possiblemoves(p_x,p_y-i) = 1;
    i = i+1;
end
%-------------------------------------------------------------------------

end