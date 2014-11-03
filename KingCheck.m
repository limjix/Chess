%KingCheck Checks if the king is in check, checkmate or stalemate
%Colour in this case must be the current colour
function [value]=KingCheck(chessboard,piece_colour,colour, capt_index,potentialmoves)

%-------------------- King In Check --------------------------------------
king_index = find(chessboard == 10 & piece_colour == colour);
kingincheck = ismember(king_index,capt_index);
if(kingincheck)
    value = 1;
%Checkmate condition
elseif kingincheck && max(max(potentialmoves))==0
    value = 2;
%Stalemate Condition
elseif kingincheck==0 && max(max(potentialmoves))==0
    value = 3;
%Otherwise not in check
else
    value = 0;
end
end
