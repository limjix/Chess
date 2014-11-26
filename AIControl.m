function AIControl(B,piece_colour,chessboard,...
                num_moves,parameters, handles)
%AIControl Enables AI to be in action
[userboardscore] = heuristicanalysis(B,chessboard, piece_colour,num_moves,119,handles);
% plot(handles.graph,B.info.turn,userboardscore,'*')
% set(handles.graph,'XColor','w','YColor','w')
set(handles.UPS,'String',userboardscore)
%-------------------------------------------------------------------------
%                       Init Values
%-------------------------------------------------------------------------
depth = 2;
set(handles.depth,'String',depth)

%------------------ Stops Game Execution if White Wins -------------------
[ischeckmate]=checkmate(B,chessboard,piece_colour, num_moves);
if ischeckmate
    return
end
%-------------------------------------------------------------------------
set(handles.AIMsgs,'String','Thinking Really Hard')
if B.info.turn ==2 
    [chessboard,piece_colour,num_moves] = OpeningMoves(B,chessboard,piece_colour, num_moves);
else
%Produces AI's decision
tic
[boardscore,chessboard,piece_colour,num_moves]=...
    AI_GenerateAllMoves(B,chessboard,piece_colour,num_moves,depth,1,-99999,99999,handles);
time =toc;

set(handles.AIMsgs,'String',['Time Taken To Think Was: ' num2str(time) ' seconds'])
end
%Translates the results into B.top
[B] = readchessboard(B,chessboard,piece_colour);
%Iterates turn
B.info.turn = B.info.turn + 1;

%--------------------- Shows AI Board Score-------------------------------
[AIBoardScore] = heuristicanalysis(B,chessboard, piece_colour,num_moves,98,handles);
set(handles.APS,'String',AIBoardScore)


%------------------------ Checks if AI has checkmated User ---------------
[oppcolourpotentialmoves,oppcolourcapt_index] = analyseboard(chessboard, piece_colour,num_moves,98);

[ischeck]=KingCheck(chessboard,piece_colour,119, oppcolourcapt_index,oppcolourpotentialmoves);
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
%-------------------------------------------------------------------------
end

