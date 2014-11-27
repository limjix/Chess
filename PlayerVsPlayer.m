function PlayerVsPlayer( B,piece_colour,chessboard,num_moves,parameters, handles )
%PlayerVsPlayer Enables PvP functionality

if(mod(B.info.turn,2)==1)
    colourturn = 119;
    oppositecolour = 98;
else
    colourturn = 98;
    oppositecolour = 119;
end

%--------------------------- Checks score for white----------------------
if colourturn == 98
[whiteBS] = heuristicanalysis(B,chessboard, piece_colour,num_moves,119,handles);
set(handles.UPS,'String',whiteBS)
handles.userboardscore = [handles.userboardscore whiteBS];
else
%--------------------------- Checks score for black----------------------
[blackBS] = heuristicanalysis(B,chessboard, piece_colour,num_moves,98,handles);
set(handles.APS,'String',blackBS)
handles.AIBoardscore = [handles.AIBoardscore blackBS];
end
%------------------------- Does check and checkmate stats-----------------
[potentialmoves,capt_index] = analyseboard(chessboard, piece_colour,num_moves,oppositecolour);

[ischeck]=KingCheck(chessboard,piece_colour,colourturn, capt_index,potentialmoves);
if ischeck == 1
    set(handles.checkstat,'String','Check')
    [ischeckmate]=checkmate(B,chessboard,piece_colour, num_moves);
    if ischeckmate
        if colourturn == 119
            set(handles.checkstat,'String','Checkmate, Black Wins')
        else
            set(handles.checkstat,'String','Checkmate, White Wins')
        end
    end
elseif ischeck == 0
    [ischeckmate]=checkmate(B,chessboard,piece_colour, num_moves);
    if ischeckmate
        set(handles.checkstat,'String','Stalemate')
    else
        set(handles.checkstat,'String','')
    end
end
%---------------------Plots Boardscores----------------------------------
if colourturn == 119
 handles.turnforblack = [handles.turnforblack B.info.turn-1];
else
 handles.turnforwhite = [handles.turnforwhite B.info.turn-1];
end
 plot(handles.graph,handles.turnforwhite,handles.userboardscore,'-b',...
     handles.turnforblack,handles.AIBoardscore,'-r','LineWidth',2)
 set(handles.graph,'XColor','w','YColor','w')
 xlabel(handles.graph,'Turn')
 ylabel(handles.graph,'Score')
 %------------------------------------------------------------------------
 
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

%------------------------------------------------------------------------
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
drawnow;
end

