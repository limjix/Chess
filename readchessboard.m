%readchessboard takes in chessboard and creates B
function [B] = readchessboard(B,chessboard,piece_colour)

X = struct(NewPiece([]));
% build the initial board with everything non-playable at first
% add paddings to the non-playable areas of 4 squares and place pieces
for i=1:size(chessboard,1)+B.info.pad
    for j=1:size(chessboard,2)+B.info.pad
        X(i,j) = NewPiece([]);
    end
end


% now place pieces and playable areas
for i=1:size(chessboard,1)
    for j=1:size(chessboard,2)
        if chessboard(i,j) == 0
            pName = []; pColour = 0;
        else
            switch chessboard(i,j)
                case 1
                    pName = 'pawn';
                case 3
                    pName = 'knight';
                case 4
                    pName = 'bishop';
                case 5
                    pName = 'rook';
                case 9
                    pName = 'queen';
                case 10
                    pName = 'king';
            end
            
            switch piece_colour(i,j)
                case 119
                    pColour = 1;
                case 98
                    pColour = -1;
        end
        X(i+B.info.pad/2,j+B.info.pad/2) = NewPiece(pName,pColour);
    end
end
end

B.top = X;
end