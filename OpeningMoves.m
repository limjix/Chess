function [ chessboard,piece_colour,num_moves ] = OpeningMoves(B,chessboard,piece_colour, num_moves )
%OpeningMoves Allows the AI to obtain a starting move from a database

%% Defense to White King's Pawn to e4
if chessboard(5,5) == 1
rng(0,'twister');
choice = randi([1 5],1,1);
    switch choice
    % ----------------------Sicilian Defense----------------------------------
        case 1
        x_ori = 2;
        y_ori = 3;
        move_x = 4;
        move_y = 3;
        [PM] = MovementPawn(chessboard,piece_colour,num_moves,x_ori,y_ori);
        [chessboard,piece_colour, num_moves,~]=ClickMovePiece(0,0,x_ori,y_ori,B,piece_colour,chessboard,...
    num_moves,0,PM,0,1,move_x,move_y);
    %---------------------- French Defense -----------------------------------
        case 2
        x_ori = 2;
        y_ori = 5;
        move_x = 3;
        move_y = 5;
        [PM] = MovementPawn(chessboard,piece_colour,num_moves,x_ori,y_ori);
        [chessboard,piece_colour, num_moves,~]=ClickMovePiece(0,0,x_ori,y_ori,B,piece_colour,chessboard,...
    num_moves,0,PM,0,1,move_x,move_y);

    %---------------------- Caro-Kann Defense --------------------------------
        case 3 
        x_ori = 2;
        y_ori = 3;
        move_x = 3;
        move_y = 3;
        [PM] = MovementPawn(chessboard,piece_colour,num_moves,x_ori,y_ori);
        [chessboard,piece_colour, num_moves,~]=ClickMovePiece(0,0,x_ori,y_ori,B,piece_colour,chessboard,...
    num_moves,0,PM,0,1,move_x,move_y);

    %------------------------- Pirc Defense ----------------------------------
        case 4
        x_ori = 2;
        y_ori = 4;
        move_x = 3;
        move_y = 4;
        [PM] = MovementPawn(chessboard,piece_colour,num_moves,x_ori,y_ori);
        [chessboard,piece_colour, num_moves,~]=ClickMovePiece(0,0,x_ori,y_ori,B,piece_colour,chessboard,...
    num_moves,0,PM,0,1,move_x,move_y);
    %------------------------ Italian Game--------------------------------
        case 5
        x_ori = 2;
        y_ori = 5;
        move_x = 4;
        move_y = 5;
        [PM] = MovementPawn(chessboard,piece_colour,num_moves,x_ori,y_ori);
        [chessboard,piece_colour, num_moves,~]=ClickMovePiece(0,0,x_ori,y_ori,B,piece_colour,chessboard,...
    num_moves,0,PM,0,1,move_x,move_y);
    end

elseif chessboard(5,4) ==1
%% Defense to pawn move at D4
    rng(0,'twister');
    choice = randi([1 2],1,1);
    switch choice
%-------------------------- Indian Defenses ------------------------------
        case 1
        x_ori = 1;
        y_ori = 7;
        move_x = 3;
        move_y = 6;
        [PM] = MovementKnight(chessboard,piece_colour,x_ori,y_ori);
        [chessboard,piece_colour, num_moves,~]=ClickMovePiece(0,0,x_ori,y_ori,B,piece_colour,chessboard,...
    num_moves,0,PM,0,1,move_x,move_y);
%--------------------------- Queen's Gambit ------------------------------
        case 2
        x_ori = 2;
        y_ori = 4;
        move_x = 4;
        move_y = 4;
        [PM] = MovementPawn(chessboard,piece_colour,num_moves,x_ori,y_ori);
        [chessboard,piece_colour, num_moves,~]=ClickMovePiece(0,0,x_ori,y_ori,B,piece_colour,chessboard,...
    num_moves,0,PM,0,1,move_x,move_y);
    end
    
elseif chessboard(5,3) ==1
%% ----------------------- Defense against English Opening -------------------
        x_ori = 2;
        y_ori = 3;
        move_x = 4;
        move_y = 3;
        [PM] = MovementPawn(chessboard,piece_colour,num_moves,x_ori,y_ori);
        [chessboard,piece_colour, num_moves,~]=ClickMovePiece(0,0,x_ori,y_ori,B,piece_colour,chessboard,...
    num_moves,0,PM,0,1,move_x,move_y);

else
    rng(0,'twister');
    choice = randi([1 6],1,1);
    switch choice
%--------------------------- Knight Openings ------------------------------ 
        case 1
        x_ori = 1;
        y_ori = 7;
        move_x = 3;
        move_y = 6;
        [PM] = MovementKnight(chessboard,piece_colour,x_ori,y_ori);
        [chessboard,piece_colour, num_moves,~]=ClickMovePiece(0,0,x_ori,y_ori,B,piece_colour,chessboard,...
    num_moves,0,PM,0,1,move_x,move_y);

        case 2
        x_ori = 1;
        y_ori = 2;
        move_x = 3;
        move_y = 3;
        [PM] = MovementKnight(chessboard,piece_colour,x_ori,y_ori);
        [chessboard,piece_colour, num_moves,~]=ClickMovePiece(0,0,x_ori,y_ori,B,piece_colour,chessboard,...
    num_moves,0,PM,0,1,move_x,move_y);

%---------------------------- Pawn Openings--------------------------------
        case 3
        x_ori = 2;
        y_ori = 5;
        move_x = 4;
        move_y = 5;
        [PM] = MovementPawn(chessboard,piece_colour,num_moves,x_ori,y_ori);
        [chessboard,piece_colour, num_moves,~]=ClickMovePiece(0,0,x_ori,y_ori,B,piece_colour,chessboard,...
    num_moves,0,PM,0,1,move_x,move_y);

        case 4
        x_ori = 2;
        y_ori = 2;
        move_x = 4;
        move_y = 2;
        [PM] = MovementPawn(chessboard,piece_colour,num_moves,x_ori,y_ori);
        [chessboard,piece_colour, num_moves,~]=ClickMovePiece(0,0,x_ori,y_ori,B,piece_colour,chessboard,...
    num_moves,0,PM,0,1,move_x,move_y);

        case 5
        x_ori = 2;
        y_ori = 7;
        move_x = 4;
        move_y = 7;
        [PM] = MovementPawn(chessboard,piece_colour,num_moves,x_ori,y_ori);
        [chessboard,piece_colour, num_moves,~]=ClickMovePiece(0,0,x_ori,y_ori,B,piece_colour,chessboard,...
    num_moves,0,PM,0,1,move_x,move_y);

        case 6
        x_ori = 2;
        y_ori = 4;
        move_x = 3;
        move_y = 4;
        [PM] = MovementPawn(chessboard,piece_colour,num_moves,x_ori,y_ori);
        [chessboard,piece_colour, num_moves,~]=ClickMovePiece(0,0,x_ori,y_ori,B,piece_colour,chessboard,...
    num_moves,0,PM,0,1,move_x,move_y);
    end
end

