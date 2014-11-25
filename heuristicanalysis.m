
function [boardscore] = heuristicanalysis(chessboard, piece_colour,num_moves,currentcolour)
%Colour should be the side in which it is being analysed for

%Generates potential moves of the currently investigated game state
[potentialmoves,capt_index] = analyseboard(chessboard, piece_colour,num_moves,currentcolour);

%-------------------------------------------------------------------------
%
%-------------------------------------------------------------------------
if currentcolour == 119
    oppcolour = 98;
else
    oppcolour = 119;
end

%Generates potential moves of the opponent
[oppcolourpotentialmoves, oppcolourcapt_index] = analyseboard(chessboard, piece_colour,num_moves,oppcolour);

%Finds the locations of own pieces and opponent's pieces
piece_index = find(piece_colour==currentcolour);
opp_piece_index = find(piece_colour==oppcolour);

%-------------------Capture Analysis--------------------------------------
%A move is good because it opens up capture possibilities
num_pot_capture = length(capt_index); %Number of potential Captures
capt_value_sum = sum(chessboard(capt_index)); %The total capture value

%A move is good if it increases the number of capture 
capt_value_diff = 51 - sum(chessboard(opp_piece_index));

%------------------ Moves Analysis ---------------------------------------
%A move is good because it opens up space for other pieces to move
nocapture = potentialmoves;
nocapture(capt_index) = 0;
num_moves_available = sum(sum(nocapture));

%------------------ Threats ----------------------------------------------
%If the move causes other pieces to be under threat, the move is worse.
[opp_potentialmoves,opp_capt_index] = analyseboard(chessboard, piece_colour,num_moves,oppcolour);
opp_num_pot_capture = length(opp_capt_index);
opp_capt_value_sum = sum(chessboard(opp_capt_index)); 

%------------------ Number of own pieces ---------------------------------
%A move is good if it prevents the number of own pieces from decreasing.
own_piece_sum_diff = 51 - sum(chessboard(piece_index)); 


%------------------- Control of centre space -----------------------------
%A move is good if it increases control of the centre of the board
centre_piece=zeros(8,8);
centre_piece([28 29 36 37])=chessboard([28 29 36 37]);
centre_piece = centre_piece~=0;
centre_space_sum =  sum(centre_piece(piece_index));


%------------------- Own King Checked? -----------------------------------
%Checks if own king is in check. If in check, also checks if its a checkmate
own_value = KingCheck(chessboard,piece_colour,currentcolour,capt_index,potentialmoves);
if own_value==1
    own_ischeckmate = checkmate(B,chessboard,piece_colour,num_moves);
    else own_ischeckmate = 0;
end

%--------------------- Opponent Checkmate?--------------------------------
%Checks if opponent king is in check. If in check, also checks if its a checkmate
opp_value = KingCheck(chessboard,piece_colour,oppcolour, oppcolourcapt_index,oppcolourpotentialmoves);
if opp_value==1
    opp_ischeckmate = checkmate(B,chessboard,piece_colour,num_moves);
else opp_ischeckmate = 0;
end   

%------------------- Possibility of opponenet's promotion? ---------------
%A move is bad if it brings opponent's pawn closer to the end of the board for promotion.
pawn_index = find(chessboard==1 & piece_colour==oppcolour);
if oppcolour == 98
    end_dist = 8-rem(pawn_index,8);
    sum_opp_pawn_dist = sum(end_dist==0) + 0.5*sum(end_dist==1);
else
    end_dist = rem(pawn_index,8)-1; 
    sum_opp_pawn_dist = sum(end_dist==0) + 0.5*sum(end_dist==1);
end

%--------------------- Possibility of own promotion? ---------------------
%A move is good if it brings own pawn closer to the end of the board for promotion.
pawn_index = find(chessboard==1 & piece_colour==currentcolour);
if currentcolour == 98
    end_dist = 8-rem(pawn_index,8);
    sum_own_pawn_dist = sum(end_dist==0) + 0.5*sum(end_dist==1);
else
    end_dist = rem(pawn_index,8)-1; 
    sum_own_pawn_dist = sum(end_dist==0) + 0.5*sum(end_dist==1);
end

%------------------ Gain Factor ------------------------------------------
gainCapture = 3;  %Encourages AI to position a piece such that it can capture more pieces in the next move
gainMoves = 10; %Encourages AI to position such that it opens space for other pieces
gainThreats = -2.5; %Discourages AI to make moves that will lead to threats
<<<<<<< HEAD
gainOpppieces = 30; %Encourages to make moves that decrease opponents pieces
=======
gainOpppieces = 30; %Discourages AI from making moves that do not decrease opponents pieces
>>>>>>> origin/master
gainOwnpieces = 0; %Discourages AI from making moves that decrease own pieces
gainCentre = 1; %Encourages AI to increase control of centre space
gainOwnprom = 1; %Encourages AI to promote own pawns close to the end of the board
gainOppprom = -1; %Discourages AI to promote opponent's pawns
%----------------- Final Score Calculation ------------------------------
boardscore =  gainCapture * capt_value_sum... 
         + gainMoves * num_moves_available... 
         + gainThreats * opp_capt_value_sum...
         + gainOpppieces * capt_value_diff...
         + gainOwnpieces * own_piece_sum_diff...
         + gainCentre * centre_space_sum...
         + gainOwnprom * sum_own_pawn_dist...
         + gainOppprom * sum_opp_pawn_dist;

%If a checkmate has occured, new boadscores are assigned     
if opp_ischeckmate == 1,
    boardscore = 99999;
end

<<<<<<< HEAD
if own_ischeckmate == 1,
    boardscore = -99999;
end

=======
>>>>>>> origin/master
end