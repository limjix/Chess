function GameControl(B,piece_colour,chessboard,num_moves,...
                parameters,handles,uih.f1,hlastmove,hax)
%GameControl Controls game flow

%-------------------------------------------------------------------------
%                           Init Values
%-------------------------------------------------------------------------
if(mod(B.info.turn,2)==1)
    colourturn = 119;
    oppositecolour = 98;
else
    colourturn = 98;
    oppositecolour = 119;
end

%-------------------------------------------------------------------------
%                   If Player's turn
%-------------------------------------------------------------------------
if colourturn == 119
    
%------------------------Draws Board & Embeds Click Piece ----------------
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
                parameters,handles,uih.f1,hlastmove,hax});
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

%-------------------------------------------------------------------------
%                   If AI's Turn
%-------------------------------------------------------------------------
else
    %Generate AI's move
   [~,chessboard,piece_colour,num_moves]=...
    AI_GenerateAllMoves(B,chessboard,piece_colour,num_moves,depth,maxormin,alpha,beta)
    %Read the AI's chessboard
    [B] = readchessboard(B,chessboard,piece_colour);
    B.info.turn = B.info.turn + 1;
%------------------------Draws Board & Embeds Click Piece ----------------
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
                parameters,handles,uih.f1,hlastmove,hax});
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

%-------------------------------------------------------------------------

end %Colour If Condition

end %Function End

