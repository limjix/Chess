%Enpassant Enables frontend implementation of En Passant
function [B]=Enpassant(v1,v2,x_ori,y_ori,B,piece_colour,chessboard,...
    num_moves,parameters,PM,varargin)

%--------------------------------------------------------------------------
%                  Init values,conversions and click location
%--------------------------------------------------------------------------
if(mod(B.info.turn,2)==1)
    colourturn = 119;
    oppositecolour = 98;
else
    colourturn = 98;
    oppositecolour = 119;
end

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
      
%-------------------------------------------------------------------------
%        Checks if King is exposed to check in any way due to move
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
[value]=KingCheck(fboard,f_p_colour,colourturn,...
    capt_index_future,potentialfuturemoves);
if value==1
    disp('King will be left in check, move invalid')
end
%-------------------------------------------------------------------------
%Ensures it can only move legally
if PM(p_x,p_y)==3 && value==0
%--------------------------------------------------------------------------
%                Moves Data in B.TOP & deletes previous cell
%--------------------------------------------------------------------------

%Moves Pawn
B.top(x,y) = B.top(x_ori,y_ori);

%Coordinates of the captured piece
if (piece_colour(ori_x,ori_y)==98)
   del_x = [p_x+3 p_x-1];
   del_y = [p_y+4 p_y];
end
   
if (piece_colour(ori_x,ori_y)==119)    
   del_x = [p_x+5 p_x+1];
   del_y = [p_y+4 p_y];
end
        
    
%Restores original pawn cell to empty
        B.top(x_ori,y_ori).name      = [];
        B.top(x_ori,y_ori).colour     = 0;
        B.top(x_ori,y_ori).move      = [];
        B.top(x_ori,y_ori).capture   = [];
        B.top(x_ori,y_ori).royal     = 0;
        B.top(x_ori,y_ori).init      = nan;
        B.top(x_ori,y_ori).promotion = nan;
        B.top(x_ori,y_ori).castle    = nan;
        B.top(x_ori,y_ori).immobile   = nan;
        B.top(x_ori,y_ori).protect   = nan;
        B.top(x_ori,y_ori).type      = 'empty';
        B.top(x_ori,y_ori).image     = [];
        B.top(x_ori,y_ori).himg      = [];
        
%Restores captured pawn cell to empty
        B.top(del_x(1),del_y(1)).name      = [];
        B.top(del_x(1),del_y(1)).colour     = 0;
        B.top(del_x(1),del_y(1)).move      = [];
        B.top(del_x(1),del_y(1)).capture   = [];
        B.top(del_x(1),del_y(1)).royal     = 0;
        B.top(del_x(1),del_y(1)).init      = nan;
        B.top(del_x(1),del_y(1)).promotion = nan;
        B.top(del_x(1),del_y(1)).castle    = nan;
        B.top(del_x(1),del_y(1)).immobile   = nan;
        B.top(del_x(1),del_y(1)).protect   = nan;
        B.top(del_x(1),del_y(1)).type      = 'empty';
        B.top(del_x(1),del_y(1)).image     = [];
        B.top(del_x(1),del_y(1)).himg      = [];        
     
B.info.turn = B.info.turn + 1;
%-------------------------------------------------------------------------
%              This is to edit the backend chessboard matrix
%-------------------------------------------------------------------------
%This step officially moves the piece
chessboard(p_x,p_y) = chessboard(ori_x,ori_y);
piece_colour(p_x,p_y) = piece_colour(ori_x,ori_y);
num_moves(p_x,p_y) = num_moves(ori_x,ori_y) + 1;

%This step empties the previous box
chessboard(ori_x,ori_y) = 0;
piece_colour(ori_x,ori_y) = 0;
num_moves(ori_x,ori_y) = 0;

%This step deletes the capured piece
chessboard(del_x(2),del_y(2)) = 0;
piece_colour(del_x(2),del_y(2)) = 0;
num_moves(del_x(2),del_y(2)) = 0;


%-------------Analyses for potential checks & provides game stats---------
[potentialmoves,capt_index] = analyseboard(chessboard,piece_colour,num_moves,colourturn);
[value]=KingCheck(chessboard,piece_colour,oppositecolour,capt_index,potentialmoves);
if value == 1
    disp('Check')
end

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
                num_moves,parameters,potentialmoves});
        end
    end
end
%---------------------------------------------------------------------------------------
end
end