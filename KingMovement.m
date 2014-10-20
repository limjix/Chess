function [possiblemoves] = KingMovement(chessboard,piece_colour,num_moves,potential_moves,p_x,p_y)

%Initialisation values --------------------------------------------------
r_colour = piece_colour(p_x,p_y);
possiblemoves = zeros(8,8);

%-------------------------------------------------------------------------
%                           Movement(8 possible directions)
%-------------------------------------------------------------------------
    
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
%--------------------------------------------------------------------------   
%                                     Castling 
%--------------------------------------------------------------------------    
   %For white king 
   if (piece_colour(p_x,p_y)==119 && num_moves(p_x,p_y)==0 && num_moves(8,8)==0..... 
           && piece_colour(8,6)==0 && piece_colour(8,7)==0 && potential_moves(8,6)==0.....  
           && potential_moves(8,7)==0)
       possiblemoves(8,7) = 3;  
   end    
   if (piece_colour(p_x,p_y)==119 && num_moves(p_x,p_y)==0 && num_moves(8,1)==0.....
           && piece_colour(8,2)==0 && piece_colour(8,3)==0 && piece_colour(8,4)==0.... 
           && potential_moves(8,3)==0 && potential_moves(8,4)==0)
       possiblemoves(8,3) = 3;
   end    

   %For black king     
   if (piece_colour(p_x,p_y)==98 && num_moves(p_x,p_y)==0 && num_moves(1,1)==0..... 
           && piece_colour(1,2)==0 && piece_colour(1,3)==0 && piece_colour(1,4)==0..... 
           && potential_moves(1,3)==0 && potential_moves(1,4)==0)
       possiblemoves(1,3) = 3;
   end    
   if (piece_colour(p_x,p_y)==98 && num_moves(p_x,p_y)==0 && num_moves(1,8)==0..... 
           && piece_colour(1,6)==0 && piece_colour(1,7)==0 && potential_moves(1,6)==0..... 
           && potential_moves(1,7)==0)
       possiblemoves(1,7) = 3;
   end 
   
   
possiblemoves(p_x,p_y)=0;
%-------------------------------------------------------------------------
end