function [B,piece_colour,chessboard,num_moves,parameters, handles]=AIControl(B,piece_colour,chessboard,...
                num_moves,parameters, handles)
%AIControl Enables AI to be in action

%-------------------------------------------------------------------------
%                       Init Values
%-------------------------------------------------------------------------
if(mod(B.info.turn-1,2)==1)
    colourturn = 119;
    oppositecolour = 98;
else
    colourturn = 98;
    oppositecolour = 119;
end

[userboardscore] = heuristicanalysis(B,chessboard, piece_colour,num_moves,119,handles);
set(handles.UPS,'String',userboardscore)
handles.userboardscore = [handles.userboardscore userboardscore];
depth = 2;
set(handles.depth,'String',depth)

%------------------ Stops Game Execution if White Wins -------------------
% [ischeckmate]=checkmate(B,chessboard,piece_colour, num_moves);
% if ischeckmate
%     return
% end

[oppcolourpotentialmoves,oppcolourcapt_index] = analyseboard(chessboard, piece_colour,num_moves,colourturn);

[ischeck]=KingCheck(chessboard,piece_colour,oppositecolour, oppcolourcapt_index,oppcolourpotentialmoves);
if ischeck == 1
    set(handles.checkstat,'String','Check')
    [ischeckmate]=checkmate(B,chessboard,piece_colour, num_moves);
    if ischeckmate
        set(handles.checkstat,'String','Checkmate, White Wins')
    end
elseif ischeck == 0
    [ischeckmate]=checkmate(B,chessboard,piece_colour, num_moves);
    if ischeckmate
        set(handles.checkstat,'String','Stalemate')
    else
        set(handles.checkstat,'String','')
    end
end
%--------------------Plot UserBoardScore-----------------------------------

 handles.turnforwhite = [handles.turnforwhite B.info.turn];
 plot(handles.graph,handles.turnforwhite,handles.userboardscore,'-b',...
     handles.turnforblack,handles.AIBoardscore,'-r','LineWidth',2)
 set(handles.graph,'XColor','w','YColor','w')
 xlabel(handles.graph,'Turn')
 ylabel(handles.graph,'Score')

%-------------------------------------------------------------------------
set(handles.AIMsgs,'String','Thinking Really Hard')

%Produces AI's decision
tic
[boardscore,chessboard,piece_colour,num_moves]=...
    AI_GenerateAllMoves(B,chessboard,piece_colour,num_moves,depth,1,-99999,99999,handles);
time =toc;

set(handles.AIMsgs,'String',['Time Taken To Think Was: ' num2str(time) ' seconds'])

%Translates the results into B.top
[B] = readchessboard(B,chessboard,piece_colour);
%Iterates turn
B.info.turn = B.info.turn + 1;

%--------------------- Shows AI Board Score-------------------------------
[AIBoardScore] = heuristicanalysis(B,chessboard, piece_colour,num_moves,98,handles);
set(handles.APS,'String',AIBoardScore)
handles.AIBoardscore = [handles.AIBoardscore AIBoardScore];

%---------------------Plots AI Board Score--------------------------------

 handles.turnforblack = [handles.turnforblack B.info.turn];
 plot(handles.graph,handles.turnforwhite,handles.userboardscore,'-b',...
     handles.turnforblack,handles.AIBoardscore,'-r','LineWidth',2)
 set(handles.graph,'XColor','w','YColor','w')
 xlabel(handles.graph,'Turn')
 ylabel(handles.graph,'Score')

%------------------------ Checks if AI has checkmated User ---------------
[oppcolourpotentialmoves,oppcolourcapt_index] = analyseboard(chessboard, piece_colour,num_moves,oppositecolour);

[ischeck]=KingCheck(chessboard,piece_colour,colourturn, oppcolourcapt_index,oppcolourpotentialmoves);
if ischeck == 1
    set(handles.checkstat,'String','Check')
    [ischeckmate]=checkmate(B,chessboard,piece_colour, num_moves);
    if ischeckmate
        set(handles.checkstat,'String','Checkmate, Black Wins')
    end
elseif ischeck == 0
    [ischeckmate]=checkmate(B,chessboard,piece_colour, num_moves);
    if ischeckmate
        set(handles.checkstat,'String','Stalemate')
    else
        set(handles.checkstat,'String','')
    end
end
%-------------------------------------------------------------------------

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
                num_moves,parameters,oppcolourpotentialmoves,handles});
        end
    end
end
drawnow;
%-------------------------------------------------------------------------
end

