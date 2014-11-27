% % create main figure window
function mdp_chessboard(handles)
%GameType='Contemporary',
B = BoardInitialization('Contemporary');
uih.f1 = handles.graph;
% ========================== BOARD GRAPHICS ==============================
% clear the figure

handles.userboardscore = 0;
handles.AIBoardscore = 0;
handles.turnforblack= 0;
handles.turnforwhite = 0;

%-------------------Sets every box and figure to start position -----------
set(handles.gameconsole,'String','')
set(handles.checkstat,'String','')
set(handles.AIMsgs,'String','')
set(handles.APS,'String','')
set(handles.UPS,'String','')
set(handles.depth,'String','')
%--------------------------------------------------------------------------

% obtain size of playable area (in squares)
tmp = size(B.top)-B.info.pad;
% rename variables for clarity
rows = tmp(1); cols = tmp(2); 
[chessboard,piece_colour,num_moves] = SetUpChessBoard;

% hsq = zeros(cols,rows);
%  for i = 1:cols
%      for j=1:rows
%          % if this square is on the playable area only, make a square patch
%          if ~strcmpi(B.top(j+B.info.pad/2,i+B.info.pad/2).type,'OOB')
%              if mod(i+j,2),  color = ([194 207 214]-30)/225; %black
%              else            color = [1 1 1]; %white
%              end
%              hsq(i,j) = patch(i-1+[0 1 1 0], rows-j+[0 0 1 1], [1 1 1 1]*(0.9-2), color);
%          end
%      end
%  end


%--------------- create axes object for plotting -------------------------
axBoard = axes('color','none', ...
    'xlim',[0 cols]+[-.1 .1],'ylim',[0 rows]+[-.1 .1],...
    'xtick',[],'ytick',[],...
    'NextPlot','add',...
    'Layer','bottom',...
    'DataAspectRatio',[1 1 1],...
    'XColor',([194 207 214]-30)/225,'YColor',([194 207 214]-30)/225,...
    'Box','On','LineWidth',2,...
    'Position',[0.00 0.1 0.550 0.815],...
    'Tag','BoardAx');
    
title('Game State: play','color','w','fontsize',16,'fontweight','bold')
% store axes handles
hax = [axBoard];

hlastmove = rectangle('position',[0 0 1 1],'facecolor','none',...
    'linewidth',1,'visible','off','edgecolor',[0.2 0.8 0.2],'linewidth',3);
% good yellow color if rectangle uistack works again: [0.95 0.95 0]

%--------------------Plots Border Around ChessBoard -----------------------
borderhdl = axes('unit', 'normalized', 'position', [0.040 0.03 0.47 0.95]);
% import the background image and show it on the axes
bg = imread('WoodBorder3.jpg'); imagesc(bg);
% prevent plotting over the background and turn the axis off
set(borderhdl,'handlevisibility','off','visible','off')
% making sure the border is behind all the other uicontrols
uistack(borderhdl, 'down');
%-------------------- Initialise parameters for Rectangles ----------------
x =[   -0.0709   8.0709];
y=x;
dx=(x(2)-x(1))/8;
xx=((0:8)*dx)-0.0709;
xx=repmat(xx,9,1);
yy=xx';
parameters.xx=xx;
parameters.yy=yy;
parameters.dx=dx;
parameters.rows=rows;
parameters.cols=cols;

%-------------------------------------------------------------------------
%                       Draws the rectangles
%-------------------------------------------------------------------------
icount=0;
for i=1:71
         icount=icount+1;
         if mod(i,2)==1
         rectangle('Position',[xx(icount),yy(icount),dx ,dx],'Curvature',[0,0],'FaceColor',[0.82 0.545 0.278])
         else
         rectangle('Position',[xx(icount),yy(icount),dx ,dx],'Curvature',[0,0],'FaceColor',[1 0.808 0.62])             
         end
end
%----------------------Analyses Board--------------------------------------
[potentialmoves,capt_index] = analyseboard(chessboard, piece_colour,num_moves,98);
%--------------------------------------------------------------------------
%                   Draws piece images & associates Click Piece
%--------------------------------------------------------------------------
for r=1:rows
    for c=1:cols       
        % if there is an image associated with this square, render it
        if ~isempty(B.top(r+B.info.pad/2,c+B.info.pad/2).image)
            % load the image
            [X, map, alpha]  = imread(B.top(r+B.info.pad/2,c+B.info.pad/2).image);
            % draw the image
            imHdls(r,c) = image(c+[0 1]-1,[rows-1 rows]-r+1,...
                mirrorImage(X),'AlphaData',mirrorImage(alpha),...
                'ButtonDownFcn',{@ClickPiece,B,piece_colour,chessboard,num_moves,...
                parameters,potentialmoves,handles,uih.f1,hlastmove,hax});
            % each image has a corresponding rules file, upload that file
            % path to the user data of this image
            set(imHdls(r,c),'UserData',B.top(r+B.info.pad/2,c+B.info.pad/2).rules)
            
            % store the handle of this image in its piece object - 
            % this information is stored so that graphics procedures can
            % occur in "MakeMove" for captures and castles, etc...
            B.top(r+B.info.pad/2,c+B.info.pad/2).himg = imHdls(r,c);
        end
    end
end

if(get(handles.choice3,'Value')==1)
    AIvsAI(B,piece_colour,chessboard,num_moves,parameters, handles)
end

end
