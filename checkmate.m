%Checkmate Determines if the currentboard is a checkmate state for
%specified colour
%Gives 1 for Checkmate, 0 for not checkmate
function [result]=checkmate(B,chessboard,piece_colour, num_moves)

if(mod(B.info.turn,2)==1)
    colour = 119;
    oppcolour = 98;
else
    colour = 98;
    oppcolour = 119;
end
result = 1;
%-------------------------------------------------------------------------
%        Loop that generates all possible moves
%-------------------------------------------------------------------------
[p_x,p_y] = find(piece_colour == colour);
n_remaining = length(p_x);
[potentialmoves] = analyseboard(chessboard, piece_colour,num_moves,oppcolour);

%In essence, we are going through each piece, looking at it's possible
%moves, make those possible moves, evaluate, save bestboard.
for i=1:n_remaining
    p_type = chessboard(p_x(i),p_y(i));
    switch p_type
        case 1
            [move] = MovementPawn(chessboard,piece_colour,num_moves,p_x(i),p_y(i));
        case 5
            [move] = MovementRook(chessboard,piece_colour,p_x(i),p_y(i)); 
        case 4
            [move] = MovementBishop(chessboard,piece_colour,p_x(i),p_y(i));
        case 3
            [move] = MovementKnight(chessboard,piece_colour,p_x(i),p_y(i));
        case 9
            [move] = MovementQueen(chessboard,piece_colour,p_x(i),p_y(i));
        case 10
            [move] = MovementKing(chessboard,piece_colour,num_moves,potentialmoves,p_x(i),p_y(i));
    end

%-------------------------------------------------------------------------
%            Individual Piece Moves That Generate New Game States
%                    Recursion is also added in each loop
%-------------------------------------------------------------------------
     [move_x,move_y] = find(move ~= 0);
     n_move = length(move_x);
%This loop generates all the game states from 1 piece
     for j = 1:n_move
         switch move(move_x(j),move_y(j))
             case 1
                 [pchessboard, ppiece_colour, pnum_moves,kingincheck]=ClickMovePiece(0,0,p_x(i),p_y(i),B,piece_colour,chessboard,...
                     num_moves,0,move,0,1,move_x(j),move_y(j));
             case 2
                 [pchessboard, ppiece_colour, pnum_moves,kingincheck]=ClickCapturePiece(0,0,p_x(i),p_y(i),B,piece_colour,chessboard,...
                     num_moves,0,move,0,1,move_x(j),move_y(j));
             case 3
                 [pchessboard, ppiece_colour, pnum_moves,kingincheck]=ClickEnpassant(0,0,p_x(i),p_y(i),B,piece_colour,chessboard,...
                     num_moves,0,move, 0,1,move_x(j),move_y(j));
             case 4
                 [pchessboard, ppiece_colour, pnum_moves,kingincheck]=ClickCastling(0,0,p_x(i),p_y(i),B,piece_colour,chessboard,...
                     num_moves,0,move,0,1,move_x(j),move_y(j));
             case 5
                 [pchessboard,ppiece_colour, pnum_moves,kingincheck]=ClickPawnPromo(0,0,p_x(i),p_y(i),B,piece_colour,chessboard,...
                     num_moves,0,move,0,1,move_x(j),move_y(j));
         end
         
         result = min(kingincheck, result);
         if result == 0
             break
         end
         
     end
     if result == 0
         break
     end
end