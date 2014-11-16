%PawnPromo Enables Front End Implementation of Pawn Promo
function [chessboard,piece_colour, num_moves,allowscheck]=ClickPawnPromo(v1,v2,x_ori,y_ori,B,piece_colour,chessboard,...
    num_moves,parameters,PM,handles,onlyAIoption,move_x,move_y,varargin)

%--------------------------------------------------------------------------
%                  Init values,conversions and click location
%--------------------------------------------------------------------------
if(mod(B.info.turn,2)==1)
    colourturn = 119;
    colour = 1;
    oppositecolour = 98;
else
    colourturn = 98;
    colour = -1;
    oppositecolour = 119;
end

if onlyAIoption == 0
clickP = get(gca,'CurrentPoint');
      x = ceil(clickP(1,2));
      y = ceil(clickP(1,1));
%---- Conversion from Graph grid to B.top grid ---------------------------
      x = 13-x;      
      y = y + 4;
%--------Conversion from B.Top grid to Chessboard grid--------------------
      p_x = x - 4; %p_x is necessary because it is the current clicked position
      p_y = y - 4;
      ori_x = x_ori - 4; %The difference is that ori_x is for chessboard,
      ori_y = y_ori - 4; %x_ori is for B.top
else
    p_x = move_x;   %Where is it moving to
    p_y = move_y;
    ori_x = x_ori;   %Where was it originally
    ori_y = y_ori;
end

%-------------------------------------------------------------------------
%            Checks if King is exposed to check in any way
%-------------------------------------------------------------------------
%The method used is to create a future chessboard based on the move
%requested

fboard = chessboard;
f_p_colour= piece_colour;
f_num_moves = num_moves;
%This step officially moves the piece
fboard(p_x,p_y) = chessboard(ori_x,ori_y);
f_p_colour(p_x,p_y) = piece_colour(ori_x,ori_y);
f_num_moves(p_x,p_y) = num_moves(ori_x,ori_y) + 1;
%This step empties the previous box
fboard(ori_x,ori_y) = 0;
f_p_colour(ori_x,ori_y) = 0;
f_num_moves(ori_x,ori_y) = 0;

%Analyses the future board
[potentialfuturemoves,capt_index_future] = analyseboard(fboard,...
    f_p_colour,f_num_moves,oppositecolour);
[allowscheck]=KingCheck(fboard,f_p_colour,colourturn,...
    capt_index_future,potentialfuturemoves);
if allowscheck==1 && onlyAIoption == 0
    disp('King will be left in check, move invalid')
end
%-------------------------------------------------------------------------
%Ensures it can only move legally
if PM(p_x,p_y)==5 && allowscheck==0
%--------------------------------------------------------------------------
%                Moves Data in B.TOP & deletes previous cell
%--------------------------------------------------------------------------
%Allows user to input desired piece. Checks legality.
disp('Pawn has been promoted');
            flags=0
          while(flags==0)
              flags=1;
              pawn_prom = input('Please enter a valid piece name\n','s')
              
            switch pawn_prom
                case 'rook'
                    chessboard(p_x,p_y)= 5;
                case 'queen'
                    chessboard(p_x,p_y)= 9;
                case 'knight'
                    chessboard(p_x,p_y)= 3;
                case 'bishop'
                    chessboard(p_x,p_y)= 4;
                otherwise
                    disp('Invalid input');
                    flags=0;
            end   
          end

B.info.turn = B.info.turn + 1;

%-------------------------------------------------------------------------
%              This is to edit the backend chessboard matrix
%-------------------------------------------------------------------------
%This step officially moves the piece
num_moves(p_x,p_y) = num_moves(ori_x,ori_y) + 1;
piece_colour(p_x,p_y)= colourturn;
 
%This step empties the previous box
chessboard(ori_x,ori_y) = 0;
piece_colour(ori_x,ori_y) = 0;
num_moves(ori_x,ori_y) = 0;

%-------------Analyses for potential checks & provides game stats---------
[potentialmoves,capt_index] = analyseboard(chessboard,piece_colour,num_moves,colourturn);
[checkopp]=KingCheck(chessboard,piece_colour,oppositecolour,capt_index,potentialmoves);
if checkopp == 1 && onlyAIoption == 0
    disp('Check')
end

if onlyAIoption == 0
    [B] = readchessboard(B,chessboard,piece_colour);
%-------------------------------------------------------------------------
%                           Redraws the Board
%-------------------------------------------------------------------------
icount=0;
for i=1:71
         icount=icount+1;
         if mod(i,2)==1
             rectangle('Position',[parameters.xx(icount),parameters.yy(icount),...
                 parameters.dx ,parameters.dx],'Curvature',[0,0],...
                 'FaceColor',[0.82 0.545 0.278])
         else
            rectangle('Position',[parameters.xx(icount),parameters.yy(icount),...
                parameters.dx ,parameters.dx],...
                'Curvature',[0,0],'FaceColor',[1 0.808 0.62])             
         end
end

for r=1:parameters.rows
    for c=1:parameters.cols
        if ~isempty(B.top(r+B.info.pad/2,c+B.info.pad/2).image)
            % load the image
            [X, map, alpha]  = imread(B.top(r+B.info.pad/2,c+B.info.pad/2).image);
            % draw the image
            imHdls(r,c) = image(c+[0 1]-1,[parameters.rows-1 parameters.rows]-r+1,...
                mirrorImage(X),'AlphaData',mirrorImage(alpha),...
                'ButtonDownFcn',{@ClickPiece,B,piece_colour,chessboard,...
                num_moves,parameters,potentialmoves,handles});
        end
    end
end
end
%---------------------------------------------------------------------------------------
end
end