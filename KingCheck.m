%KingCheck Checks if the king is in check, checkmate or stalemate
%Colour in this case must be the current colour
function [value]=KingCheck(chessboard,piece_colour,colour,B,num_moves)

%-------------------- King In Check --------------------------------------
if(mod(B.info.turn,2)==1)
    colourturn = 119
    oppositecolour = 98;
else
    colourturn = 98;
    oppositecolour = 119;
end

analyseboard(chessboard, piece_colour,num_moves,colour);
king_index = find(chessboard == 10 & piece_colour == colourturn);
kingincheck = ismember(king_index,capt_index);
[king_x,king_y] = find(chessboard == 10 & piece_colour == colour);
[possiblemoves] = KingMovement(chessboard,piece_colour,num_moves,potentialmoves,king_x,king_y)
kingcheckmate = (possiblemoves~=0)-(potentialmoves~=0);

if(kingincheck)
    value = 1;
%Checkmate condition
elseif kingincheck && max(max(kingcheckmate))==0
    value = 2;
%Stalemate Condition
elseif kingincheck==0 && max(max(potentialmoves))==0
    value = 3;
%Otherwise not in check
else
    value = 0;
end
end
