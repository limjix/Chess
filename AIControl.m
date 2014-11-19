function AIControl(B,piece_colour,chessboard,...
                num_moves,parameters, handles)
%AIControl Enables AI to be in action

%-------------------------------------------------------------------------
%                       Init Values
%-------------------------------------------------------------------------


%-------------------------------------------------------------------------
disp('Thinking Really Hard')

%Produces AI's decision
tic
[~,chessboard,piece_colour,num_moves]=...
    AI_GenerateAllMoves(B,chessboard,piece_colour,num_moves,4,1,-999,999);
toc
%Translates the results into B.top
[B] = readchessboard(B,chessboard,piece_colour);

%Iterates turn
B.info.turn = B.info.turn + 1;

[potentialmoves,~] = analyseboard(chessboard, piece_colour,num_moves,98);
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
%-------------------------------------------------------------------------
end

