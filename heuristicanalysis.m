
function [boardscore] = heuristicanalysis(B,chessboard, piece_colour,num_moves,currentcolour,handles)
%Colour should be the side in which it is being analysed for

%-------------------------------------------------------------------------
%                        Init Values
%-------------------------------------------------------------------------
if currentcolour == 119
    oppcolour = 98;
else
    oppcolour = 119;
end
%Generates potential moves of the currently investigated game state colour
[potentialmoves,capt_index] = analyseboard(chessboard, piece_colour,num_moves,currentcolour);
%Generates potential moves of the opponent
[oppcolourpotentialmoves, oppcolourcapt_index] = analyseboard(chessboard, piece_colour,num_moves,oppcolour);

%Finds the locations of own pieces and opponent's pieces
piece_index = find(piece_colour==currentcolour);
opp_piece_index = find(piece_colour==oppcolour);

%-------------------------------------------------------------------------

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
opp_num_pot_capture = length(oppcolourcapt_index);
opp_capt_value_sum = sum(chessboard(oppcolourcapt_index)); 

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
own_ischeck = KingCheck(chessboard,piece_colour,currentcolour,oppcolourcapt_index,oppcolourpotentialmoves);
if own_ischeck==1
    own_ischeckmate = checkmate(B,chessboard,piece_colour,num_moves);
    else own_ischeckmate = 0;
end

%--------------------------- Castling? -----------------------------------
%Checks if castling has taken place
rook_pos = find(chessboard==5 & piece_colour==currentcolour);
king_pos = find(chessboard==10 & piece_colour==currentcolour);
castle = 0;

if currentcolour == 98 %Black case
    if (king_pos==49 && ismember(41,rook_pos) && num_moves(41)==1 && num_moves(49)==1)
        castle = 1;
    elseif (king_pos==17 && ismember(25,rook_pos) && num_moves(25)==1 && num_moves(17)==1)
            castle = 1;
    end
    
else %White case
    if (king_pos==56 && ismember(48,rook_pos) && num_moves(48)==1 && num_moves(56)==1)
        castle = 1;
    elseif (king_pos==24 && ismember(32,rook_pos) && num_moves(32)==1 && num_moves(24)==1)
            castle = 1;
    end
end

%--------------------- Opponent Checkmate?--------------------------------
%Checks if opponent king is in check. If in check, also checks if its a checkmate
opp_ischeck = KingCheck(chessboard,piece_colour,oppcolour,capt_index,potentialmoves);
if opp_ischeck==1
    opp_ischeckmate = checkmate(B,chessboard,piece_colour,num_moves);
else opp_ischeckmate = 0;
end   

%------------------- Possibility of opponenet's promotion? ---------------
%A move is bad if it brings opponent's pawn closer to the end of the board for promotion.
pawn_index = find(chessboard==1 & piece_colour==oppcolour);
if oppcolour == 98 %Black case
    end_dist = 8-rem(pawn_index,8);
    sum_opp_pawn_dist = sum(end_dist==0) + 0.5*sum(end_dist==1);
else %White case
    end_dist = rem(pawn_index,8)-1; 
    sum_opp_pawn_dist = sum(end_dist==0) + 0.5*sum(end_dist==1);
end

%--------------------- Possibility of own promotion? ---------------------
%A move is good if it brings own pawn closer to the end of the board for promotion.
pawn_index = find(chessboard==1 & piece_colour==currentcolour);
if currentcolour == 98 %Black case
    end_dist = 8-rem(pawn_index,8);
    sum_own_pawn_dist = sum(end_dist==0) + 0.5*sum(end_dist==1);
else %White case
    end_dist = rem(pawn_index,8)-1; 
    sum_own_pawn_dist = sum(end_dist==0) + 0.5*sum(end_dist==1);
end

%------------------ Gain Factor for Hard-------------------------------------
if(get(handles.setHard,'Value')==1)
gainCapture = 3;  %Encourages AI to position a piece such that it can capture more pieces in the next move
gainMoves = 10; %Encourages AI to position such that it opens space for other pieces
gainThreats = -4; %Discourages AI to make moves that will lead to threats
gainOpppieces = 30; %Encourages to make moves that decrease opponents pieces
gainOwnpieces = -5; %Discourages AI from making moves that decrease own pieces
gainCentre = 1; %Encourages AI to increase control of centre space
gainOwnprom = 1; %Encourages AI to promote own pawns close to the end of the board
gainOppprom = -10; %Discourages AI to promote opponent's pawns
end
%--------------------Gain Factor for Easy ---------------------------------
if(get(handles.setEasy,'Value')==1)
gainCapture = 2;  %Encourages AI to position a piece such that it can capture more pieces in the next move
gainMoves = 10; %Encourages AI to position such that it opens space for other pieces
gainThreats = -2; %Discourages AI to make moves that will lead to threats
gainOpppieces = 3.5; %Encourages to make moves that decrease opponents pieces
gainOwnpieces = 1; %Discourages AI from making moves that decrease own pieces
gainCentre = 10; %Encourages AI to increase control of centre space
gainOwnprom = 10; %Encourages AI to promote own pawns close to the end of the board
gainOppprom = -1; %Discourages AI to promote opponent's pawns
end
%--------------------- Gain Factor for Random -----------------------------
if(get(handles.setRandom,'Value')==1)
gainCapture = 0;  %Encourages AI to position a piece such that it can capture more pieces in the next move
gainMoves = 0; %Encourages AI to position such that it opens space for other pieces
gainThreats = 0; %Discourages AI to make moves that will lead to threats
gainOpppieces = 0; %Encourages to make moves that decrease opponents pieces
gainOwnpieces = 0; %Discourages AI from making moves that decrease own pieces
gainCentre = 0; %Encourages AI to increase control of centre space
gainOwnprom = 0; %Encourages AI to promote own pawns close to the end of the board
gainOppprom = 0; %Discourages AI to promote opponent's pawns
end
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
if(get(handles.setHard,'Value')==1 || get(handles.setEasy,'Value')==1 )
    if opp_ischeckmate == 1
        boardscore = 99999;
    end

    if own_ischeckmate == 1
        boardscore = -99999;
    end
end


%Checks if castling has occured
    if castle == 1
        boardscore = boardscore + 250;
    end


if(get(handles.setRandom,'Value')==1)
    boardscore=rand* 2000;
end
end