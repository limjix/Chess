function AIvsAI( B,piece_colour,chessboard,...
                num_moves,parameters, handles )
%AIvsAI Enables AIvsAI functionality
[ischeckmate]=checkmate(B,chessboard,piece_colour, num_moves);

while ~ischeckmate && get(handles.choice3,'Value')==1
    [ischeckmate]=checkmate(B,chessboard,piece_colour, num_moves);
[B,piece_colour,chessboard,num_moves,parameters, handles]=AIControl(B,piece_colour,chessboard,...
                num_moves,parameters, handles);
            pause(2)
end
end

