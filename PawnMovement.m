function [possiblemoves] = PawnMovement(chessboard,piece_colour,num_moves,p_x,p_y)

%Initialisation values --------------------------------------------------
r_colour = piece_colour(p_x,p_y);
possiblemoves = zeros(8,8);

%This section allows all movements after checking whether it exceeds the board or not ---------------
switch r_colour
    case 119 %White case
        
        if(p_x-1>0) %Forward movement
            if(chessboard(p_x-1,p_y)==0)
                possiblemoves(p_x-1,p_y) = 1;
            end
        end
        
        %Initial forward movement
        if(p_x==7 && chessboard(p_x-2,p_y)==0 && chessboard(p_x-1,p_y)==0)
        possiblemoves(p_x-2,p_y) = 1;
        end

        if(p_x-1>0 && p_y-1 >0) %Capture left
            if(piece_colour(p_x-1,p_y-1)~=r_colour && chessboard(p_x-1,p_y-1)~=0)
                possiblemoves(p_x-1,p_y-1) = 2;
            end
        end

        if(p_x-1>0 && p_y+1<9) %Capture right
            if(piece_colour(p_x-1,p_y+1)~=r_colour && chessboard(p_x-1,p_y+1)~=0)
                possiblemoves(p_x-1,p_y+1) = 2;
            end
        end    
           
        %En passant-------------------------------------------------------
        if (p_x==4)
            
            if(p_x-1>0 && p_y-1 >0) %Capture left
                if(piece_colour(p_x,p_y-1)~=r_colour && chessboard(p_x,p_y-1)==1 && num_moves(p_x,p_y-1)==1)
                    possiblemoves(p_x-1,p_y-1) = 2;
                end
            end

            if(p_x-1>0 && p_y+1<9) %Capture right
                if(piece_colour(p_x,p_y+1)~=r_colour && chessboard(p_x,p_y+1)==1 && num_moves(p_x,p_y+1)==1)
                    possiblemoves(p_x-1,p_y+1) = 2;
                end    
            end
        
        end
        
<<<<<<< HEAD
   
=======
>>>>>>> my-new-branch
   
    case 98 %Black Case
    
        if(p_x+1<9)
            if(chessboard(p_x+1,p_y)==0) 
                possiblemoves(p_x+1,p_y) = 1;
            end
        end

        if(p_x==2 && chessboard(p_x+2,p_y)==0 && chessboard(p_x+1,p_y)==0)
            possiblemoves(p_x+2,p_y) = 1;
        end
        
        if(p_x+1<9 && p_y-1>0)
            if(piece_colour(p_x+1,p_y-1)~=r_colour && chessboard(p_x+1,p_y-1)~=0)
                possiblemoves(p_x+1,p_y-1) = 2;
            end
        end
        
        if(p_x+1<9 && p_y+1<9)
            if(piece_colour(p_x+1,p_y+1)~=r_colour && chessboard(p_x+1,p_y+1)~=0)
                possiblemoves(p_x+1,p_y+1) = 2;
            end   
        end
        
         %En passant-------------------------------------------------------
        if (p_x==5)
            
            if(p_x-1>0 && p_y-1 >0) %Capture left
                if(piece_colour(p_x,p_y-1)~=r_colour && chessboard(p_x,p_y-1)==1 && num_moves(p_x,p_y-1)==1)
                    possiblemoves(p_x+1,p_y-1) = 2;
                end
            end

            if(p_x-1>0 && p_y+1<9) %Capture right
                if(piece_colour(p_x,p_y+1)~=r_colour && chessboard(p_x,p_y+1)==1 && num_moves(p_x,p_y+1)==1)
                    possiblemoves(p_x+1,p_y+1) = 2;
                end    
            end
        
        end
   
end

%-------------------------------------------------------------------------
end