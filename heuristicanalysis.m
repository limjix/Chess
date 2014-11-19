
function [boardscore] = heuristicanalysis(chessboard, piece_colour,num_moves,currentcolour,ccaptureval)
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
%ccaptureval is for the value of the piece that was captured in this game
%state to be added to the value of the calculation

%-------------------Capture Analysis--------------------------------------
%A move is good because it opens up capture possibilities
num_pot_capture = length(capt_index); %Number of potential Captures
capt_value_sum = sum(chessboard(capt_index)); %The total capture value

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
piece_index = find(piece_colour==currentcolour);
own_piece_sum = sum(chessboard(piece_index)); 

%------------------ Number of opponent pieces ----------------------------
%A move is good if it decreases the no of opponents pieces.
opp_piece_index = find(piece_colour==oppcolour);
opp_piece_sum = sum(chessboard(opp_piece_index)); 

%------------------- Control of centre space -----------------------------
%A move is good if it increases control of the centre of the board
centre_piece=zeros(8,8);
centre_piece([28 29 36 37])=chessboard([28 29 36 37]);
centre_piece = centre_piece~=0;
centre_space_sum =  sum(centre_piece(piece_index));

%------------------------- King's Safety ---------------------------------

%------------------- Opponent's King Checked? ----------------------------

%--------------------- Checkmate?-----------------------------------------

%--------------------- Possibility of own promotion? ---------------------
%A move is good if it brings own pawn closer to the end of the board for promotion.
pawn_pos = chessboard==1 & piece_colour==currentcolour;
pawn_index = find(pawn_pos==1);
end_dist = rem(pawn_index, 8);
end_dist = end_dist-1;


%------------------ Gain Factor ------------------------------------------
gainCurrentCapture = 1; %Encourages AI to seize captures immediately
gainCapture = 1;  %Encourages AI to position a piece such that it can capture more pieces in the next move
gainMoves = 1; %Encourages AI to position such that it opens space for other pieces
gainThreats = -1; %Discourages AI to make moves that will lead to threats
gainOpppieces = -1; %Discourages AI from making moves that do not decrease opponents pieces
gainOwnpieces = 1; %Discourages AI from making moves that decrease own pieces
gainCentre = 1; %Encourages AI to increase control of centre space
gainOwnprom =1;
%----------------- Final Score Calculation ------------------------------
boardscore =  gainCapture * capt_value_sum... 
         + gainMoves * num_moves_available... 
         + gainThreats * opp_capt_value_sum...
         + gainCurrentCapture * ccaptureval...
         + gainOpppieces * opp_piece_sum...
         + gainOwnpieces * own_piece_sum...
         + gainCentre * centre_space_sum;
end