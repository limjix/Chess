p_type = input('Input Piece Value plz: ')
p_x = input('Please input X: ')
p_y = input('Please input Y: ')

switch p_type
    case 1
        [possiblemoves] = PawnMovement(chessboard,piece_colour,num_moves,p_x,p_y)
        %disp('Pawn');
    case 5
        [possiblemoves] = RookMovement(chessboard,piece_colour,p_x,p_y)
        %disp('Rook');
    case 4
        [possiblemoves] = BishopMovement(chessboard,piece_colour,p_x,p_y)
        %disp('Bishop');
    case 3
        [possiblemoves] = KnightMovement(piece_colour,chessboard,p_x,p_y)
        %disp('Knight');
    case 9
        [possiblemoves] = QueenMovement(chessboard,piece_colour,p_x,p_y)
        %disp('Queen');
    case 10
        [possiblemoves] = KingMovement(piece_colour,chessboard,p_x,p_y)
        %disp('King');
end