function [possiblemoves] = MovementKing(chessboard,piece_colour,num_moves,potential_moves,p_x,p_y)

%Initialisation values --------------------------------------------------
r_colour = piece_colour(p_x,p_y);
possiblemoves = zeros(8,8);

%This section allows all movements after checking whether it exceeds the board or not 
%and ensures that the king is not moving into square that is in check ---------------

%------------------------------------------------------------------------
%                        Movement (8 Directions)
%------------------------------------------------------------------------

    
    if(p_x+1<9)
        if (piece_colour(p_x+1,p_y)~= r_colour && chessboard(p_x+1,p_y)~=0)
            possiblemoves(p_x+1,p_y) = 2;
        elseif (piece_colour(p_x+1,p_y)== r_colour)
            ;
        else
            possiblemoves(p_x+1,p_y) = 1;
        end
    end
    
    
    if(p_x+1<9 && p_y+1<9)
        if (piece_colour(p_x+1,p_y+1)~= r_colour && chessboard(p_x+1,p_y+1)~=0)
            possiblemoves(p_x+1,p_y+1) = 2;
        elseif (piece_colour(p_x+1,p_y+1)== r_colour)
            ;
        else
            possiblemoves(p_x+1,p_y+1) = 1;
        end
    end
    
    
    if(p_x+1<9 && p_y-1>0)
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
    
    
    if(p_x-1>0 && p_y+1<9)
        if (piece_colour(p_x-1,p_y+1)~= r_colour && chessboard(p_x-1,p_y+1)~=0)
            possiblemoves(p_x-1,p_y+1) = 2;
        elseif (piece_colour(p_x-1,p_y+1)== r_colour)
            ;
        else
            possiblemoves(p_x-1,p_y+1) = 1;
        end
    end
    
    
    if(p_x-1>0 && p_y-1>0)
        if (piece_colour(p_x-1,p_y-1)~= r_colour && chessboard(p_x-1,p_y-1)~=0)
            possiblemoves(p_x-1,p_y-1) = 2;
        elseif (piece_colour(p_x-1,p_y-1)== r_colour)
            ;
        else
            possiblemoves(p_x-1,p_y-1) = 1;
        end
    end

%-------------------------------------------------------------------------   
%                                  Castling 
%-------------------------------------------------------------------------


%---------------------------- For white king -----------------------------
%Checks to see if traversed squares are in check and if the final square is
%checked. Also checks if squares in between are empty
   if (piece_colour(p_x,p_y)==119 && num_moves(p_x,p_y)==0 && num_moves(8,8)==0 .... 
           && piece_colour(8,6)==0 && piece_colour(8,7)==0 && potential_moves(8,6)==0 ...  
           && potential_moves(8,7)==0 && chessboard(8,8)==5 && piece_colour(8,8)==119 )
       possiblemoves(8,7) = 4;  
   end    
   if (piece_colour(p_x,p_y)==119 && num_moves(p_x,p_y)==0 && num_moves(8,1)==0 ....
           && piece_colour(8,2)==0 && piece_colour(8,3)==0 && piece_colour(8,4)==0 ... 
           && potential_moves(8,3)==0 && potential_moves(8,4)==0 && chessboard(8,1)==5 ...
           && piece_colour(8,1)==119)
       possiblemoves(8,3) = 4;
   end
   
%---------------------------- For black king -----------------------------
%Checks to see if traversed squares are in check and if the final square is
%checked
   if (piece_colour(p_x,p_y)==98 && num_moves(p_x,p_y)==0 && num_moves(1,1)==0 .... 
           && piece_colour(1,2)==0 && piece_colour(1,3)==0 && piece_colour(1,4)==0 .... 
           && potential_moves(1,3)==0 && potential_moves(1,4)==0 && ...
           chessboard(1,1)==5 && piece_colour(1,1)==98)
       possiblemoves(1,3) = 4;
   end    
   if (piece_colour(p_x,p_y)==98 && num_moves(p_x,p_y)==0 && num_moves(1,8)==0 .... 
           && piece_colour(1,6)==0 && piece_colour(1,7)==0 && potential_moves(1,6)==0 .... 
           && potential_moves(1,7)==0 && chessboard(1,8)==5 && piece_colour(1,8)==98)
       possiblemoves(1,7) = 4;
   end 
   
   
possiblemoves(p_x,p_y)=0;
%-------------------------------------------------------------------------
end