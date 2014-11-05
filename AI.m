%AI - Enables the computer to perform moves.
function AI(B,chessboard,piece_colour,num_moves)

%-------------------------------------------------------------------------
%                           Init Values
%-------------------------------------------------------------------------
colour = B.info.AIcolour;
%-------------------------------------------------------------------------
%        Loop that generates all possible moves & evaluates them
%-------------------------------------------------------------------------
[p_x,p_y] = find(piece_colour == colour);
n_remaining = length(boardpieces);

%The loop should be 1 swift swoop
%Generate possiblemoves, move each move, analyse, store
for i=1:n_remaining
    p_type = chessboard(p_x(i),p_y(i));
    switch p_type
        case 1
            [move] = PawnMovement(chessboard,piece_colour,num_moves,p_x(i),p_y(i));
        case 5
            [move] = RookMovement(chessboard,piece_colour,p_x(i),p_y(i)); 
        case 4
            [move] = BishopMovement(chessboard,piece_colour,p_x(i),p_y(i));
        case 3
            [move] = KnightMovement(chessboard,piece_colour,p_x(i),p_y(i));
        case 9
            [move] = QueenMovement(chessboard,piece_colour,p_x(i),p_y(i));
        case 10
            [move] = KingMovement(chessboard,piece_colour,num_moves,potentialmoves,p_x(i),p_y(i));
    end
    
    ind_piece_moves = find(move==1)
    n_ipm = length(boardpieces)
    for j = 1:n_ipm
        

%-------------------------------------------------------------------------
%                     Execution of best possible move
%-------------------------------------------------------------------------

%-------------------------------------------------------------------------
%                           Redraw the Board
%-------------------------------------------------------------------------