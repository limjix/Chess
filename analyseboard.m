%Analyseboard Looks at one colour, sees where each piece is able to
%move. This is to allow for the Check function and castling.
function [potentialmoves] = analyseboard(chessboard, piece_colour)

%Initialisation ----------------------------------------------------------
[p_x, p_y] = find(piece_colour == 98);
n_remaining = length(p_x);
potentialmoves = zeros(8,8);

%Loop to look at every piece's moves ------------------------------------
for i=1:n_remaining
    %Determines what piece is selected
    p_type = chessboard(p_x(i),p_y(i)); 
    
    %Based on the type of piece, its movement is calculated
    switch p_type
        case 1
            [move] = PawnMovement(piece_colour,chessboard,p_x(i),p_y(i));
            %disp('Pawn');
        case 5
            [move] = RookMovement(chessboard,piece_colour,p_x(i),p_y(i));
            %disp('Rook');
        case 4
            [move] = BishopMovement(chessboard,piece_colour,p_x(i),p_y(i));
            %disp('Bishop');
        case 3
            [move] = KnightMovement(piece_colour,chessboard,p_x(i),p_y(i));
            %disp('Knight');
        case 9
            [move] = QueenMovement(chessboard,piece_colour,p_x(i),p_y(i));
            %disp('Queen');
        case 10
            [move] = KingMovement(piece_colour,chessboard,p_x(i),p_y(i));
            %disp('King');
    end
    
    %Sums up all possible moves of 1 colour.
    potentialmoves = potentialmoves+move;
end
%-------------------------------------------------------------------------
%                     Analysis of potentialmoves
%-------------------------------------------------------------------------

%-------------------Capture Analysis--------------------------------------
potentialcaptures = potentialmoves ~= 0 & chessboard~= 0
capt_index = find(potentialcaptures==1);
num_pot_capture = length(capt_index)
capt_value_sum = sum(chessboard(capt_index))

%------------------ Moves Analysis ---------------------------------------
nocapture = potentialmoves
nocapture(capt_index) = 0
num_moves_available = sum(sum(nocapture))

%-------------------- King In Check --------------------------------------
king_index = find(chessboard == 10 & piece_colour == 119);
kingincheck = ismember(king_index,capt_index);
if(kingincheck)
    disp('Check')
end

end