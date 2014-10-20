function [chessboard] = PawnPromotion(chessboard,p_x,p_y)
%Pawn promotion
            disp('Pawn has been promoted');
            flags=0
          while(flags==0)
              flags=1;
              pawn_prom = input('Please enter a valid piece name\n','s')
              
            switch pawn_prom
                case 'rook'
                    chessboard(p_x,p_y)= 5;
                case 'queen'
                    chessboard(p_x,p_y)= 9;
                case 'knight'
                    chessboard(p_x,p_y)= 3;
                case 'bishop'
                    chessboard(p_x,p_y)= 4;
                otherwise
                    disp('Invalid input');
                    flags=0;
            end   
          end  
end

