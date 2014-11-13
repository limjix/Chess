%AI - Generates moves and stores them for 1 PLY (Only for DATA Tree)
function [bchessboard,bpiece_colour,bnum_moves,B]=AI_GenerateAllMoves(B,chessboard,piece_colour,num_moves,numberofplys)

%-------------------------------------------------------------------------
%                           Init Values
%-------------------------------------------------------------------------
evenorodd = mod(numberofplys,2)   %Checks if numberofplys requested is even or odd, 0 for even 1 for odd

bestboardscore = 0;
TmpB = B;

if(mod(TmpB.info.turn,2)==1)
    colour = 119;
    oppcolour = 98;
else
    colour = 98;
    oppcolour = 119;
end
%-------------------------------------------------------------------------
%        Loop that generates all possible moves
%-------------------------------------------------------------------------
[p_x,p_y] = find(piece_colour == colour);
n_remaining = length(p_x);
statenumber = 0; %Provides a number to relocate the board state in structure
[potentialmoves] = analyseboard(chessboard, piece_colour,num_moves,oppcolour);

%The loop should be 1 swift swoop
%Generate possiblemoves, move each move, analyse, store
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
 TmpB.info.turn = TmpB.info.turn +1;
 
 
%-------------------------------------------------------------------------
%            Individual Piece Moves That Generate New Game States
%                    Recursion is also added in each loop
%-------------------------------------------------------------------------

%-------------------- Generates Move Only Game States --------------------
     [move_x,move_y] = find(move == 1);
     for j = 1:length(move_x)
        [pchessboard, ppiece_colour, pnum_moves,kingincheck]=ClickMovePiece(0,0,p_x(i),p_y(i),B,piece_colour,chessboard,...
     num_moves,0,move,0,1,move_x(j),move_y(j))
        if kingincheck %If King is in check, that move isn't possible and so nothing carries on.
        else
            [pboardscore] = heuristicanalysis(pchessboard, ppiece_colour,pnum_moves,colour,0)
            if pboardscore>bestboardscore
                bchessboard = pchessboard;
                bpiece_colour = ppiece_colour;
                bnum_moves = pnum_moves;
            end
        end
     end

%---------------------- Generates Capture Only Game States ---------------
%      [move_x,move_y] = find(move == 2);
%      for j = 1:length(move_x)
%         [pchessboard, ppiece_colour, pnum_moves,ccaptureval]=ClickCapturePiece(0,0,p_x(i),p_y(i),B,piece_colour,chessboard,...
%     num_moves,0,move,0,1,move_x(j),move_y(j))
%      end

%-----------------------Generates Enpassant Only Game States--------------      
%      [move_x,move_y] = find(move == 3);
%      for j = 1:length(move_x)
%         [pchessboard, ppiece_colour, pnum_moves]=ClickEnpassant(0,0,p_x(i),p_y(i),B,piece_colour,chessboard,...
%     num_moves,0,move, 0,1,move_x(j),move_y(j))
%      end

%---------------------Generates Castling Only Game States-----------------      
%      [move_x,move_y] = find(move == 4)
%      for j = 1:length(move_x)
%         [pchessboard, ppiece_colour, pnum_moves]=ClickCastling(0,0,p_x(i),p_y(i),B,piece_colour,chessboard,...
%     num_moves,0,move,0,1,move_x(j),move_y(j))
%      end

%--------------------Generates Pawn Promotion Only Game States------------
%      [move_x,move_y] = find(move == 5)
%      for j = 1:length(move_x)
%         [chessboard,piece_colour, num_moves,cont]=ClickPawnPromo(0,0,x_ori,y_ori,B,piece_colour,chessboard,...
%     num_moves,parameters,PM,handles,onlyAIoption,move_x,move_y,varargin)
%      end
end

end
            
