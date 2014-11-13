%KingCheck Checks if the king is in check, checkmate or stalemate
%Colour in this case must be the current colour
%King Colour must be contrary to CAPT_INDEX & POTENTIAL MOVES
function [value]=KingCheck(chessboard,piece_colour,ownkingcolour, oppcolourcapt_index,oppcolourpotentialmoves)

%-------------------- King In Check --------------------------------------
king_index = find(chessboard == 10 & piece_colour == ownkingcolour);
kingincheck = ismember(king_index,oppcolourcapt_index);
if(kingincheck)
    value = 1;
%Otherwise not in check
else
    value = 0;
end
end
