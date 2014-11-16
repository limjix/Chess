%Checkmate Determines if the currentboard is a checkmate state
function [result]=checkmate(B,chessboard,piece_colour,p_x,p_y)

if(mod(B.info.turn,2)==1)
    colour = 119;
    oppcolour = 98;
else
    colour = 98;
    oppcolour = 119;
end

[potentialmoves,capt_index] = analyseboard(chessboard, piece_colour,num_moves,colour)
[opppotentialmoves,opp_capt_index] = analyseboard(chessboard, piece_colour,num_moves,oppcolour)

switch chessboard(p_x,p_y)
        case 1
            [move] = MovementPawn(chessboard,piece_colour,num_moves,p_x,p_y);
        case 5
            [move] = MovementRook(chessboard,piece_colour,p_x,p_y); 
        case 4
            [move] = MovementBishop(chessboard,piece_colour,p_x,p_y);
        case 3
            [move] = MovementKnight(chessboard,piece_colour,p_x,p_y);
        case 9
            [move] = MovementQueen(chessboard,piece_colour,p_x,p_y);
        case 10
            [move] = MovementKing(chessboard,piece_colour,num_moves,potentialmoves,p_x,p_y);
    end
