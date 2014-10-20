[piece_colour, chessboard, x_grid, y_grid] = SetUpChessBoard
[piece_colour, chessboard] = movepiece([101 1],[99 6], chessboard, piece_colour,x_grid,y_grid)
[piece_colour, chessboard] = movepiece([99 2],[99 5], chessboard, piece_colour,x_grid,y_grid)
chessboard(2,4) = [0]
piece_colour(2,4) = [0]