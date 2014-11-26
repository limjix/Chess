%AI - Generates moves and stores them for 1 PLY (Only for DATA Tree)
function [boardscore,bchessboard,bpiece_colour,bnum_moves]=...
    AI_GenerateAllMoves(B,chessboard,piece_colour,num_moves,depth,maxormin,alpha,beta,handles)
%-------------------------------------------------------------------------
%                           Init Values
%-------------------------------------------------------------------------
TmpB = B;

if(mod(TmpB.info.turn,2)==1)
    colour = 119;
    oppcolour = 98;
else
    colour = 98;
    oppcolour = 119;
end

TmpB.info.turn = TmpB.info.turn +1;
%-------------------------------------------------------------------------

if depth == 0
   TmpB.info.turn = TmpB.info.turn -1;
  [boardscore] = heuristicanalysis(TmpB,chessboard, piece_colour,num_moves,colour,handles);
  bchessboard = chessboard;
  bpiece_colour = piece_colour;
  bnum_moves = num_moves;
else

if maxormin == 1  %Maximizing Player
%===================== Generates Future Nodes or Leafs ====================
%-------------------------------------------------------------------------
%        Loop that generates all possible moves
%-------------------------------------------------------------------------
[p_x,p_y] = find(piece_colour == colour);
perm_index = randperm(length(p_x));
p_x = p_x(perm_index);
p_y = p_y(perm_index);
n_remaining = length(p_x);
[potentialmoves] = analyseboard(chessboard, piece_colour,num_moves,oppcolour);
previousboardscore = -99999;
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
     perm_index2 = randperm(length(move_x));
     move_x = move_x(perm_index2);
     move_y = move_y(perm_index2);
     n_move = length(move_x);
     pruneflag = 0;
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
                     num_moves,0,move,0,1,move_x(j),move_y(j),'queen');
         end
%--------A node has been generated, what do you want to do with it?--------
         if kingincheck  
             %ignore because move not valid
             if ~exist('boardscore','var')
             boardscore = -99999;
             bchessboard = 0;
             bpiece_colour =0;
             bnum_moves =0;
             end
         else
                 %Generate another layer with recursive parameters
                 [boardscore,~,~,~]=...
            AI_GenerateAllMoves(TmpB,pchessboard,ppiece_colour,pnum_moves,depth-1,-maxormin,alpha,beta,handles);
    
                    if boardscore > previousboardscore
                        previousboardscore = boardscore;
                        bchessboard = pchessboard;
                        bpiece_colour = ppiece_colour;
                        bnum_moves = pnum_moves;
                    end
                    if boardscore>alpha
                        alpha = boardscore;
                    end
%             disp([depth alpha beta boardscore previousboardscore i j n_remaining n_move])
                    if alpha>beta
                        pruneflag = 1;
                        break
                    end
         end
%--------------------------------------------------------------------------
     end
     if pruneflag
         break
     end
end
%=========================================================================


elseif maxormin == -1 %Minimizing Player
%===================== Generates Future Nodes or Leafs ====================
%-------------------------------------------------------------------------
%        Loop that generates all possible moves
%-------------------------------------------------------------------------
[p_x,p_y] = find(piece_colour == colour);
perm_index = randperm(length(p_x));
p_x = p_x(perm_index);
p_y = p_y(perm_index);
n_remaining = length(p_x);
[potentialmoves] = analyseboard(chessboard, piece_colour,num_moves,oppcolour);
previousboardscore = 99999;
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
     perm_index2 = randperm(length(move_x));
     move_x = move_x(perm_index2);
     move_y = move_y(perm_index2);
     n_move = length(move_x);
     pruneflag = 0;
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
                     num_moves,0,move,0,1,move_x(j),move_y(j),'queen');

         end
%--------A node has been generated, what do you want to do with it?--------
         if kingincheck  
             %ignore because move not valid
             if ~exist('boardscore','var')
             boardscore = 99999;
             bchessboard = 0;
             bpiece_colour =0;
             bnum_moves =0;
             end
         else
                 %Generate another layer with recursive parameters
                 [boardscore,~,~,~]=...
            AI_GenerateAllMoves(TmpB,pchessboard,ppiece_colour,pnum_moves,depth-1,-maxormin,alpha,beta,handles);
        
                if boardscore < previousboardscore
                    previousboardscore = boardscore;
                    bchessboard = pchessboard;
                    bpiece_colour = ppiece_colour;
                    bnum_moves = pnum_moves;
                end
                if boardscore<beta
                    beta = boardscore;
                end
                
% disp([depth alpha beta boardscore previousboardscore i j n_remaining n_move])
                if alpha>beta
                    pruneflag = 1;
                    break
                end
         end
     end
      if pruneflag
         break
     end
%--------------------------------------------------------------------------
end
%=========================================================================
end % For if maxormin
end % For DEPTH if condition
end %For Function




