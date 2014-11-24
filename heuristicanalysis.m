
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

piece_index = find(piece_colour==currentcolour);
opp_piece_index = find(piece_colour==oppcolour);
%ccaptureval is for the value of the piece that was captured in this game
%state to be added to the value of the calculation

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

%------------------------- Capture In This Round---------------------------

%------------------- Opponent's King Checked? ----------------------------

%--------------------- Checkmate?-----------------------------------------

%--------------------- Possibility of own promotion? ---------------------
%A move is good if it brings own pawn closer to the end of the board for promotion.
pawn_pos = chessboard==1 & piece_colour==currentcolour;
pawn_index = find(pawn_pos==1);
end_dist = 8-rem(pawn_index, 8);
sum_pawn_pos = sum(end_dist==0);

%------------------ Gain Factor ------------------------------------------
gainCapture = 3;  %Encourages AI to position a piece such that it can capture more pieces in the next move
gainMoves = 10; %Encourages AI to position such that it opens space for other pieces
gainThreats = -2.5; %Discourages AI to make moves that will lead to threats
gainOpppieces = 30; %Discourages AI from making moves that do not decrease opponents pieces
gainOwnpieces = -10; %Discourages AI from making moves that decrease own pieces
gainCentre = 1; %Encourages AI to increase control of centre space
gainOwnprom =1;
%----------------- Final Score Calculation ------------------------------
boardscore =  gainCapture * capt_value_sum... 
         + gainMoves * num_moves_available... 
         + gainThreats * opp_capt_value_sum...
         + gainOpppieces * capt_value_diff...
         + gainOwnpieces * own_piece_sum_diff...
         + gainCentre * centre_space_sum;

     boardscore = rand*boardscore;

end