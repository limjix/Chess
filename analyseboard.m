%Analyseboard Looks at one colour, sees where each piece is able to
%move. This is to allow for the Check function and castling.
%Colour in this case can be either current one or opposing one
%Use oppositecolour to generate threats and threat captures
function [potentialmoves,capt_index] = analyseboard(chessboard, piece_colour,num_moves,colour)

%Initialisation ----------------------------------------------------------
[p_x, p_y] = find(piece_colour == colour);
n_remaining = length(p_x);
potentialmoves = zeros(8,8);

%Loop to look at every piece's moves ------------------------------------
for i=1:n_remaining
    %Determines what piece is selected
    p_type = chessboard(p_x(i),p_y(i)); 
    
    %Based on the type of piece, its movement is calculated
    switch p_type
        case 1
            [move] = PawnMovement(chessboard,piece_colour,num_moves,p_x(i),p_y(i));
            %disp('Pawn');
        case 5
            [move] = RookMovement(chessboard,piece_colour,p_x(i),p_y(i));
            %disp('Rook');
        case 4
            [move] = BishopMovement(chessboard,piece_colour,p_x(i),p_y(i));
            %disp('Bishop');
        case 3
            [move] = KnightMovement(chessboard,piece_colour,p_x(i),p_y(i));
            %disp('Knight');
        case 9
            [move] = QueenMovement(chessboard,piece_colour,p_x(i),p_y(i));
            %disp('Queen');
        case 10
            [move] = KingMovement(chessboard,piece_colour,num_moves,potentialmoves,p_x(i),p_y(i));
            %disp('King');
    end
    
    %Sums up all possible moves of 1 colour.
    potentialmoves = potentialmoves+move;
end
%-------------------------------------------------------------------------
%                     Analysis of potentialmoves
%-------------------------------------------------------------------------
%--------------------- Piece Analysis ------------------------------------


%-------------------Capture Analysis--------------------------------------
potentialcaptures = potentialmoves ~= 0 & chessboard~= 0;
capt_index = find(potentialcaptures==1);
num_pot_capture = length(capt_index);
capt_value_sum = sum(chessboard(capt_index));

%------------------ Moves Analysis ---------------------------------------
nocapture = potentialmoves;
nocapture(capt_index) = 0;
num_moves_available = sum(sum(nocapture));



end