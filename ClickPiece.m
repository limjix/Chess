%ClickPiece Obtains all the data from a user's click, highlights possible
%moves and allows the user to make that move.
function [varargout]=ClickPiece(var1,var2,B,piece_colour,chessboard,...
    num_moves,parameters,potentialmoves,handles,varargin )

%----------Determines which colour is able to be selected------------------
if(mod(B.info.turn,2)==1)
    colourturn = 119;
    oppositecolour = 98;
else
    colourturn = 98;
    oppositecolour = 119;
end

onlyAIoption = 0;
%-------------------------------------------------------------------------
 clickP = get(gca,'CurrentPoint');
      x = ceil(clickP(1,2));
      y = ceil(clickP(1,1));
%---- Conversion from Graph Grid to B.top grid ---------------------------
      x = 13-x;      
      y = y + 4;
%-------------------------------------------------------------------------
%This is the board
      piecetype = B.top(x,y).name;

%--------Conversion from B.Top grid to Chessboard grid--------------------
      p_x = x - 4;
      p_y = y - 4;

if(piece_colour(p_x,p_y) == colourturn)
%----------------------Generates Possible Moves---------------------------

switch piecetype
    case 'pawn'
        [possiblemoves] = MovementPawn(chessboard,piece_colour,num_moves,p_x,p_y);
    case 'rook'
        [possiblemoves] = MovementRook(chessboard,piece_colour,p_x,p_y);
    case 'knight'
        [possiblemoves] = MovementKnight(chessboard,piece_colour,p_x,p_y);
    case 'bishop'
        [possiblemoves] = MovementBishop(chessboard,piece_colour,p_x,p_y);
    case 'queen'
        [possiblemoves] = MovementQueen(chessboard,piece_colour,p_x,p_y);
    case 'king'
        [possiblemoves] = MovementKing(chessboard,piece_colour,num_moves,...
            potentialmoves,p_x,p_y);
end

%-------------------------------------------------------------------------
%             REDRAWS THE BOARD BUT HIGHLIGHTS POSSIBLE MOVES
%-------------------------------------------------------------------------
%------------------------------Draws Rectangles---------------------------
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

%----------- Highlights possible moves------------------------------------
for r=1:parameters.rows
    for c=1:parameters.cols
        switch possiblemoves(r,c)
%_______________________Highlights movable squares________________________
            case 1
             rectangle('Position',[parameters.xx(9-r,c),parameters.yy(9-r,c),...
                 parameters.dx ,parameters.dx],'Curvature',[0,0],'FaceColor','y',...
                 'ButtonDownFcn',{@ClickMovePiece,x,y,B,piece_colour,chessboard...
                 ,num_moves,parameters,possiblemoves,handles,onlyAIoption,0,0})
%_______________________Highlights capturable squares______________________
            case 2
             rectangle('Position',[parameters.xx(9-r,c),parameters.yy(9-r,c),...
                 parameters.dx ,parameters.dx],'Curvature',[0,0],'FaceColor','r')
%_______________________Highlights Enpassant Squares_______________________
            case 3
             rectangle('Position',[parameters.xx(9-r,c),parameters.yy(9-r,c),...
                 parameters.dx ,parameters.dx],'Curvature',[0,0],'FaceColor','r',...
                 'ButtonDownFcn',{@ClickEnpassant,x,y,B,piece_colour,chessboard...
                 ,num_moves,parameters,possiblemoves,handles,onlyAIoption,0,0})
%_______________________Highlights Castling Squares________________________
            case 4
             rectangle('Position',[parameters.xx(9-r,c),parameters.yy(9-r,c),...
                 parameters.dx ,parameters.dx],'Curvature',[0,0],'FaceColor','b',...
                 'ButtonDownFcn',{@ClickCastling,x,y,B,piece_colour,chessboard...
                 ,num_moves,parameters,possiblemoves,handles,onlyAIoption,0,0})
%_______________________Highlights Pawn Promotion Square___________________
            case 5
             rectangle('Position',[parameters.xx(9-r,c),parameters.yy(9-r,c),...
                 parameters.dx ,parameters.dx],'Curvature',[0,0],'FaceColor','c',...
                 'ButtonDownFcn',{@ClickPawnPromo,x,y,B,piece_colour,chessboard...
                 ,num_moves,parameters,possiblemoves,handles,onlyAIoption,0,0})
         end
    end
end
%--------------------------------------------------------------------------
%                             Redraws images 
%--------------------------------------------------------------------------
for r=1:parameters.rows
    for c=1:parameters.cols
        if ~isempty(B.top(r+B.info.pad/2,c+B.info.pad/2).image)
            % load the image
            [X, map, alpha]  = imread(B.top(r+B.info.pad/2,c+B.info.pad/2).image);
            % draw the image
            %If Statement enables capture move
            if possiblemoves(r,c) == 2
                imHdls(r,c) = image(c+[0 1]-1,[parameters.rows-1 parameters.rows]-r+1,...
                mirrorImage(X),'AlphaData',mirrorImage(alpha),...
                'ButtonDownFcn',{@ClickCapturePiece,x,y,B,piece_colour,chessboard...
                 ,num_moves,parameters,possiblemoves,handles,onlyAIoption,0,0});
             %Enables Pawn Promotion
            elseif possiblemoves(r,c) == 5 && chessboard(r,c)~=0
                imHdls(r,c) = image(c+[0 1]-1,[parameters.rows-1 parameters.rows]-r+1,...
                mirrorImage(X),'AlphaData',mirrorImage(alpha),...
                'ButtonDownFcn',{@ClickPawnPromo,x,y,B,piece_colour,chessboard...
                 ,num_moves,parameters,possiblemoves,handles,onlyAIoption,0,0});
             %Else enable click piece
            else
            imHdls(r,c) = image(c+[0 1]-1,[parameters.rows-1 parameters.rows]-r+1,...
                mirrorImage(X),'AlphaData',mirrorImage(alpha),...
                'ButtonDownFcn',{@ClickPiece,B,piece_colour,chessboard,...
                num_moves,parameters,potentialmoves,handles,onlyAIoption,0,0});
            end
        end
    end
end
end

end
%-------------------------------------------------------------------------
%-------------------------------------------------------------------------
