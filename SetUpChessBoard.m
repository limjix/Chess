%SetUpChessBoard creates a new chessboard with positioned pieces.

function [piece_colour,chessboard,num_moves] = SetUpChessBoard

chessboard = zeros(8,8); %Pre-allocates space

%sets piece positions on chess board
chessboard = [ 5 3 4 9 10 4 3 5 ; ones(1,8); chessboard(3:6,:); ones(1,8);5 3 4 9 10 4 3 5];

%Creates a grid to track number of moves each piece makes
num_moves = zeros(8,8);

%sets up board to indicate colour of pieces.
%98 is black in ASCII
%119 is white in ASCII
piece_colour = [ 98*ones(2,8); zeros(4,8); 119*ones(2,8)];

end