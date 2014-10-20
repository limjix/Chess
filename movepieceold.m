%movepiece Receives algebraic instructions, moves piece to specified
%location.

function [piece_colour, chessboard,num_moves] = movepieceold(ori_x,ori_y,...
    final_x,final_y, chessboard, piece_colour,num_moves)

%Original index returns the index of where the piece is
%Final index returns the index of where the piece should be moved to
% original_index = find(x_grid == original_pos(1) & y_grid ==original_pos(2));
% final_index = find(x_grid == final_pos(1) & y_grid ==final_pos(2));

%This step officially moves the piece
chessboard(final_x,final_y) = chessboard(ori_x,ori_y);
piece_colour(final_x,final_y) = piece_colour(ori_x,ori_y);
num_moves(final_x,final_y) = num_moves(ori_x,ori_y) + 1;

%This step empties the previous box
chessboard(ori_x,ori_y) = 0;
piece_colour(ori_x,ori_y) = 0;
num_moves(ori_x,ori_y) = 0;
end