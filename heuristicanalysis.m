
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

%------------------- Opponent's King Checked? ----------------------------

%--------------------- Checkmate?-----------------------------------------

%--------------------- Promotion? ----------------------------------------

%--------------------- How Far is pawn from end board?--------------------

%------------------ Gain Factor ------------------------------------------
gainCurrentCapture = 1; %Encourages AI to seize captures immediately
gainCapture = 1;  %Encourages AI to position a piece such that it can capture more pieces in the next move
gainMoves = 1; %Encourages AI to position such that it opens space for other pieces
gainThreats = -1; %Discourages AI to make moves that will lead to threats
%----------------- Final Score Calculation ------------------------------
boardscore =  gainCapture * capt_value_sum... 
         + gainMoves * num_moves_available... 
         + gainThreats * opp_capt_value_sum...
         + gainCurrentCapture * ccaptureval;
end