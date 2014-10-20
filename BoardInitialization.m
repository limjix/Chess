function B = BoardInitialization(format)
% Sets up the board object, B, based on the specified format
%
% Calls NewPiece for specific piece object generation
%
% Board is an array containing all piece structures in B.top and a list of
% other relevant rule memory in B.info
%
% Note: white's pieces start at the "bottom" of the baord
%
%
%
% %%% code for ChessPiece, v1.1 2012, ZCD %%%
%


B.info.turn = 1;        % whose turn is it?
B.info.draw50 = 0;      % draw by 50 move non-captures
B.info.pad = 8;         % padding around board edge (must be even number)
B.info.ep = cell(2,1);	% list of possible en pessant captures and actual piece location


switch format
    case 'Contemporary'
        % standard contemporary chess setup
        tmp = {...
            'rook:-1','knight:-1','bishop:-1','queen:-1','king:-1','bishop:-1','knight:-1','rook:-1';...
            'pawn:-1','pawn:-1',  'pawn:-1',  'pawn:-1', 'pawn:-1','pawn:-1',  'pawn:-1',  'pawn:-1';...
            'none:0','none:0','none:0','none:0','none:0','none:0','none:0','none:0';...
            'none:0','none:0','none:0','none:0','none:0','none:0','none:0','none:0';...
            'none:0','none:0','none:0','none:0','none:0','none:0','none:0','none:0';...
            'none:0','none:0','none:0','none:0','none:0','none:0','none:0','none:0';...
            'pawn:1','pawn:1',  'pawn:1',  'pawn:1', 'pawn:1','pawn:1',  'pawn:1',  'pawn:1';...
            'rook:1','knight:1','bishop:1','queen:1','king:1','bishop:1','knight:1','rook:1' };
        % ranks on which guads promote [white black]
        promRanks = [8 1];
        
        % Now do the rest of the under the hood stuff
        B = RestOfStuff(B,tmp,format,promRanks);
        
    case 'FischerRandom'
        
        % guided randomization algorithm
        order = cell(1,8);
        x1 = 2:2:8; t1 = x1(randi(4));
        order{t1} = 'bishop:';
        x2 = 1:2:7; t2 = x2(randi(4));
        order{t2} = 'bishop:';
        x3 = setdiff(1:8,[t1 t2]); t3 = x3(randi(6));
        order{t3} = 'queen:';
        x4 = setdiff(1:8,[t1 t2 t3]); t4 = x4(randi(5));
        order{t4} = 'knight:';
        x5 = setdiff(1:8,[t1 t2 t3 t4]); t5 = x5(randi(4));
        order{t5} = 'knight:';
        x6 = setdiff(1:8,[t1 t2 t3 t4 t5]);
        order{x6(1)}='rook:'; order{x6(2)}='king:'; order{x6(3)}='rook:';
        
        
        tmp = {...
            'rook:-1','knight:-1','bishop:-1','queen:-1','king:-1','bishop:-1','knight:-1','rook:-1';...
            'pawn:-1','pawn:-1',  'pawn:-1',  'pawn:-1', 'pawn:-1','pawn:-1',  'pawn:-1',  'pawn:-1';...
            'none:0','none:0','none:0','none:0','none:0','none:0','none:0','none:0';...
            'none:0','none:0','none:0','none:0','none:0','none:0','none:0','none:0';...
            'none:0','none:0','none:0','none:0','none:0','none:0','none:0','none:0';...
            'none:0','none:0','none:0','none:0','none:0','none:0','none:0','none:0';...
            'pawn:1','pawn:1',  'pawn:1',  'pawn:1', 'pawn:1','pawn:1',  'pawn:1',  'pawn:1';...
            'rook:1','knight:1','bishop:1','queen:1','king:1','bishop:1','knight:1','rook:1' };
        
        for i=1:8
            tmp{1,i}=[order{i} '-1'];
            tmp{8,i}=[order{i} '1'];
        end
        
        % ranks on which guads promote [white black]
        promRanks = [8 1];
        
        % Now do the rest of the under the hood stuff
        B = RestOfStuff(B,tmp,format,promRanks);
        
    case 'DebugPositions'
        
        load('DebugPositions')
        ix = randi(length(X));
        tmp = X{ix};
        
%         tmp = {...
% 'none:0','none:0','none:0','none:0','none:0','none:0','none:0','none:0';...
% 'rook:-1','none:0','none:0','none:0','none:0','none:0','none:0','none:0';...
% 'none:0','none:0','none:0','none:0','none:0','none:0','none:0','none:0';...
% 'none:0','none:0','none:0','none:0','pawn:1','none:0','none:0','none:0';...
% 'none:0','none:0','none:0','pawn:1','none:0','pawn:-1','none:0','none:0';...
% 'none:0','none:0','none:0','king:1','none:0','none:0','none:0','rook:1';...
% 'none:0','none:0','none:0','none:0','none:0','king:-1','none:0','none:0';...
% 'none:0','none:0','none:0','none:0','none:0','none:0','none:0','none:0' };
        
        % ranks on which guads promote [white black]
        promRanks = [size(tmp,1) 1];
        
        % Now do the rest of the under the hood stuff
        B = RestOfStuff(B,tmp,format,promRanks);
        
    case 'MinorSwap'
        minorList =  {
            'knight'
            'bishop'
            'storm'
            'elephant'
            'lion'
            'waffle'
            'cleric'
            'wizard'
            'champion'
            'steward'
            'beholder'
            'minotaur'	 };
        % choose two minor pieces to insert into the game
        ix = randperm(length(minorList));
        m1 = minorList{ix(1)};
        m2 = minorList{ix(2)}; %m2 = 'minotaur';
        
        tmp = {...
            'rook:-1',[m1 ':-1'],[m2 ':-1'],'queen:-1','king:-1',[m2 ':-1'],[m1 ':-1'],'rook:-1';...
            'pawn:-1','pawn:-1',  'pawn:-1',  'pawn:-1', 'pawn:-1','pawn:-1',  'pawn:-1',  'pawn:-1';...
            'none:0','none:0','none:0','none:0','none:0','none:0','none:0','none:0';...
            'none:0','none:0','none:0','none:0','none:0','none:0','none:0','none:0';...
            'none:0','none:0','none:0','none:0','none:0','none:0','none:0','none:0';...
            'none:0','none:0','none:0','none:0','none:0','none:0','none:0','none:0';...
            'pawn:1','pawn:1',  'pawn:1',  'pawn:1', 'pawn:1','pawn:1',  'pawn:1',  'pawn:1';...
            'rook:1',[m1 ':1'],[m2 ':1'],'queen:1','king:1',[m2 ':1'],[m1 ':1'],'rook:1' };
        
        % ranks on which guads promote [white black]
        promRanks = [8 1];
        % Now do the rest of the under the hood stuff
        B = RestOfStuff(B,tmp,format,promRanks);
        
        
    case 'Omega'
        
        tmp = {...
            'wizard:-1',[],[],[],[],[],[],[],[],[],[],'wizard:-1';...
            [],'champion:-1','rook:-1','knight:-1','bishop:-1','queen:-1','king:-1','bishop:-1','knight:-1','rook:-1','champion:-1',[];...
            [],'longpawn:-1','longpawn:-1','longpawn:-1','longpawn:-1','longpawn:-1','longpawn:-1','longpawn:-1','longpawn:-1','longpawn:-1','longpawn:-1',[];...
            [],'none:0','none:0','none:0','none:0','none:0','none:0','none:0','none:0','none:0','none:0',[];...
            [],'none:0','none:0','none:0','none:0','none:0','none:0','none:0','none:0','none:0','none:0',[];...
            [],'none:0','none:0','none:0','none:0','none:0','none:0','none:0','none:0','none:0','none:0',[];...
            [],'none:0','none:0','none:0','none:0','none:0','none:0','none:0','none:0','none:0','none:0',[];...
            [],'none:0','none:0','none:0','none:0','none:0','none:0','none:0','none:0','none:0','none:0',[];...
            [],'none:0','none:0','none:0','none:0','none:0','none:0','none:0','none:0','none:0','none:0',[];...
            [],'longpawn:1','longpawn:1','longpawn:1','longpawn:1','longpawn:1','longpawn:1','longpawn:1','longpawn:1','longpawn:1','longpawn:1',[];...
            [],'champion:1','rook:1','knight:1','bishop:1','queen:1','king:1','bishop:1','knight:1','rook:1','champion:1',[];...
            'wizard:1',[],[],[],[],[],[],[],[],[],[],'wizard:1'};
        
        % ranks on which guads promote [white black]
        promRanks = [11 2];
        % Now do the rest of the under the hood stuff
        B = RestOfStuff(B,tmp,format,promRanks);
        
        
    case 'ChessPeace'
        
        minorList =  {'knight','bishop','storm','elephant','lion','waffle',...
            'cleric','wizard','champion','steward','beholder','minotaur'};
        % choose two minor pieces to insert into the game
        ix = randperm(length(minorList));
        m1 = minorList{ix(1)};
        m2 = minorList{ix(2)}; %m2='cleric';
        
        superiorList = {'queen','basilisk','arcangel','incarnation','sophist',...
            'jack','archbishop','marshal','dabash','gaea','knightrider','colonel'};
        % choose two minor pieces to insert into the game
        ix = randperm(length(superiorList));
        s1 = superiorList{ix(1)};
        s2 = superiorList{ix(2)}; %s2='gaea';
        
        majorList = {'rook','sentinel','paladin','blinky','ire','obdure'};
        % choose two minor pieces to insert into the game
        ix = randperm(length(majorList));
        mj = majorList{ix(1)}; %mj='sentinel';
        
        royalList = {'king','sultan','caliphate','blight'};
        ix = randperm(length(royalList));
        ry = royalList{ix(1)};
        % extra chance for normal King
        if rand>0.5 ry='king'; end
        
        tmp = {...
            [mj ':-1'],[m1 ':-1'],[m2 ':-1'],[s1 ':-1'],[ry ':-1'],[s2 ':-1'],[m1 ':-1'],[m2 ':-1'],[mj ':-1'];...
            'pawn:-1','pawn:-1',  'pawn:-1',  'pawn:-1', 'pawn:-1', 'pawn:-1','pawn:-1',  'pawn:-1',  'pawn:-1';...
            'none:0','none:0','none:0','none:0','none:0','none:0','none:0','none:0','none:0';...
            'none:0','none:0','none:0','none:0','none:0','none:0','none:0','none:0','none:0';...
            'none:0','none:0','none:0','none:0','none:0','none:0','none:0','none:0','none:0';...
            'none:0','none:0','none:0','none:0','none:0','none:0','none:0','none:0','none:0';...
            'pawn:1','pawn:1',  'pawn:1',  'pawn:1', 'pawn:1', 'pawn:1','pawn:1',  'pawn:1',  'pawn:1';...
            [mj ':1'],[m1 ':1'],[m2 ':1'],[s1 ':1'],[ry ':1'],[s2 ':1'],[m1 ':1'],[m2 ':1'],[mj ':1'] };
        
        % ranks on which guads promote [white black]
        promRanks = [8 1];
        % Now do the rest of the under the hood stuff
        B = RestOfStuff(B,tmp,format,promRanks);
        
        
    case 'ChessPeaceMadness'
        
        minorList =  {'knight','bishop','storm','elephant','lion','waffle',...
            'cleric','wizard','champion','steward','beholder','minotaur'};
        % choose two minor pieces to insert into the game
        ix = randperm(length(minorList));
        m1 = minorList{ix(1)};
        m2 = minorList{ix(2)};
        
        superiorList = {'queen','basilisk','arcangel','incarnation','sophist',...
            'jack','archbishop','marshal','dabash','gaea','knightrider','colonel'};
        ix = randperm(length(superiorList));
        s1 = superiorList{ix(1)};
        s2 = superiorList{ix(2)};
        
        majorList = {'rook','sentinel','paladin','blinky','ire','obdure'};
        ix = randperm(length(majorList));
        mj = majorList{ix(1)};
        
        royalList = {'king','sultan','caliphate','blight'};
        ix = randperm(length(royalList));
        ry = royalList{ix(1)};
        
        gaurdList = {'pawn','berolina','surf','longpawn'};
        if rand>0.35    % use pawns more often
            ixr = randperm(length(gaurdList));
            gd = gaurdList{ixr(1)};
        else
            gd = 'pawn';
        end
        
        
        tmp = {...
            [mj ':-1'],[m1 ':-1'],[m2 ':-1'],[s1 ':-1'],[ry ':-1'],[s2 ':-1'],[m1 ':-1'],[m2 ':-1'],[mj ':-1'];...
            [gd ':-1'],[gd ':-1'],[gd ':-1'],[gd ':-1'],[gd ':-1'],[gd ':-1'],[gd ':-1'],[gd ':-1'],[gd ':-1'];...
            'none:0','none:0','none:0','none:0','none:0','none:0','none:0','none:0','none:0';...
            'none:0','none:0','none:0','none:0','none:0','none:0','none:0','none:0','none:0';...
            'none:0','none:0','none:0','none:0','none:0','none:0','none:0','none:0','none:0';...
            'none:0','none:0','none:0','none:0','none:0','none:0','none:0','none:0','none:0';...
            [gd ':1'],[gd ':1'],[gd ':1'],[gd ':1'],[gd ':1'],[gd ':1'],[gd ':1'],[gd ':1'],[gd ':1'];...
            [mj ':1'],[m1 ':1'],[m2 ':1'],[s1 ':1'],[ry ':1'],[s2 ':1'],[m1 ':1'],[m2 ':1'],[mj ':1'] };
        
        
        % introduce a second royal piece, sometimes
        if rand>0.85
            override = randi(9);
            ixr = randi(length(royalList));
            tmp{1,override} = [royalList{ixr} ':-1'];
            tmp{8,override} = [royalList{ixr} ':1'];
        end
        
        % we randomize the back ranks sometimes
        if rand>0.65
            order = randperm(9);
            tmp(1,:) = tmp(1,order);
            tmp(8,:) = tmp(8,order);
        end
        
        % occasionally change the amount of playing area
        if rand>0.75
            adj = randi(3);
            if adj==1
                tmp = [tmp(1:4,:); {'none:0','none:0','none:0','none:0','none:0','none:0','none:0','none:0','none:0'}; tmp(5:8,:)];
            elseif adj==2
                tmp = [tmp(1:4,:); {'none:0','none:0','none:0','none:0','none:0','none:0','none:0','none:0','none:0'};...
                    {'none:0','none:0','none:0','none:0','none:0','none:0','none:0','none:0','none:0'}; tmp(5:8,:)];
            else
                tmp = [tmp(1:2,:); tmp(4:8,:)];
            end
        end
            
        % occasionally remove squares from the playing surface
        if rand>0.75
            empties = find(strcmp(tmp,'none:0'));
            ix = randperm(length(empties));
            ns = randi(5);
            for i=1:ns
                tmp{empties(ix(i))} = [];
            end
        end
            
            
        % ranks on which guads promote [white black]
        promRanks = [size(tmp,1) 1];
        % Now do the rest of the under the hood stuff
        B = RestOfStuff(B,tmp,format,promRanks);
        
    case 'Capablanca'
        
        tmp = {...
            'rook:-1','knight:-1','archbishop:-1','bishop:-1','queen:-1','king:-1','bishop:-1','marshal:-1','knight:-1','rook:-1';...
            'pawn:-1','pawn:-1',  'pawn:-1',  'pawn:-1', 'pawn:-1','pawn:-1',  'pawn:-1',  'pawn:-1',  'pawn:-1',  'pawn:-1';...
            'none:0','none:0','none:0','none:0','none:0','none:0','none:0','none:0','none:0','none:0';...
            'none:0','none:0','none:0','none:0','none:0','none:0','none:0','none:0','none:0','none:0';...
            'none:0','none:0','none:0','none:0','none:0','none:0','none:0','none:0','none:0','none:0';...
            'none:0','none:0','none:0','none:0','none:0','none:0','none:0','none:0','none:0','none:0';...
            'pawn:1','pawn:1',  'pawn:1',  'pawn:1', 'pawn:1','pawn:1',  'pawn:1',  'pawn:1',  'pawn:1',  'pawn:1';...
            'rook:1','knight:1','archbishop:1','bishop:1','queen:1','king:1','bishop:1','marshal:1','knight:1','rook:1' };
        % ranks on which guads promote [white black]
        promRanks = [8 1];
        
        % Now do the rest of the under the hood stuff
        B = RestOfStuff(B,tmp,format,promRanks);
        
        
    case 'Elena'
        
        tmp = {...
            'rook:-1','bishop:-1','king:-1','queen:-1','knight:-1';...
            'pawn:-1','pawn:-1',  'pawn:-1',  'pawn:-1', 'pawn:-1';...
            'none:0','none:0','none:0','none:0','none:0',;...
            'none:0','none:0','none:0','none:0','none:0',;...
            'pawn:1','pawn:1',  'pawn:1',  'pawn:1', 'pawn:1';...
            'knight:1','queen:1','king:1','bishop:1','rook:1' };
        % ranks on which guads promote [white black]
        promRanks = [6 1];
        
        % Now do the rest of the under the hood stuff
        B = RestOfStuff(B,tmp,format,promRanks);
        
    case 'ChessPeaceMini'
        
        minorList =  {'knight','bishop','storm','elephant','lion','waffle',...
            'cleric','wizard','champion','steward','beholder','minotaur'};
        % choose two minor pieces to insert into the game
        ix = randperm(length(minorList));
        m1 = minorList{ix(1)};
        m2 = minorList{ix(2)}; %m2='cleric';
        
        superiorList = {'queen','basilisk','arcangel','incarnation','sophist',...
            'jack','archbishop','marshal','dabash','gaea','knightrider','colonel'};
        % choose two minor pieces to insert into the game
        ix = randperm(length(superiorList));
        s1 = superiorList{ix(1)};
        
        majorList = {'rook','sentinel','paladin','blinky','ire','obdure'};
        % choose two minor pieces to insert into the game
        ix = randperm(length(majorList));
        mj = majorList{ix(1)}; %mj='sentinel';
        
        royalList = {'king','sultan','caliphate','blight'};
        ix = randperm(length(royalList));
        ry = royalList{ix(1)};
        % extra chance for normal King
        if rand>0.5, ry='king'; end
        
        tmp = {...
            [mj ':-1'],[m2 ':-1'],[ry ':-1'],[s1 ':-1'],[m1 ':-1'];...
            'pawn:-1','pawn:-1','pawn:-1',  'pawn:-1', 'pawn:-1', ;...
            'none:0','none:0','none:0','none:0','none:0';...
            'none:0','none:0','none:0','none:0','none:0';...
            'pawn:1','pawn:1',  'pawn:1',  'pawn:1', 'pawn:1';...
            [m1 ':1'],[s1 ':1'],[ry ':1'],[m2 ':1'],[mj ':1'] };
        
        % ranks on which guads promote [white black]
        promRanks = [6 1];
        % Now do the rest of the under the hood stuff
        B = RestOfStuff(B,tmp,format,promRanks);
        
        
    case 'AshPash'
        
        tmp = {...
            'rook:-1','knight:-1','bishop:-1','queen:-1', 'king:-1', 'queen:-1', 'knight:-1','bishop:-1', 'rook:-1';...
            'pawn:-1','pawn:-1',  'pawn:-1',  'pawn:-1',  'pawn:-1', 'pawn:-1',  'pawn:-1',  'pawn:-1',   'pawn:-1';...
            'none:0', 'none:0',   'none:0',   'none:0',   'none:0',  'none:0',   'none:0',   'none:0',    'none:0';...
            'none:0', 'none:0',   'none:0',   'none:0',   'none:0',  'none:0',   'none:0',   'none:0',    'none:0';...
            'none:0', 'none:0',   'none:0',   'none:0',   'none:0',  'none:0',   'none:0',   'none:0',    'none:0';...
            'none:0', 'none:0',   'none:0',   'none:0',   'none:0',  'none:0',   'none:0',   'none:0',    'none:0';...
            'pawn:1', 'pawn:1',   'pawn:1',   'pawn:1',   'pawn:1',  'pawn:1',   'pawn:1',   'pawn:1',    'pawn:1';...
            'rook:1', 'bishop:1', 'knight:1', 'queen:1',  'king:1',  'queen:1',  'bishop:1', 'knight:1',  'rook:1' };
        
        % ranks on which guads promote [white black]
        promRanks = [8 1];
        % Now do the rest of the under the hood stuff
        B = RestOfStuff(B,tmp,format,promRanks);
        
    case 'Custom'
        
        % prompt user
        [FileName,PathName,FilterIndex] = uigetfile(['CustomGames' filesep '*.mat'],'Choose Your Game');
        
        if FilterIndex==1
            % load chosen game object
            load([PathName FileName])
            % check that all needed variables exist
            if exist('tmp','var') 
                if ~exist('promRanks','var')
                    warning('Variable ''promRanks'' not found in custom game file, see GamePlay help.')
                    promRanks = [size(tmp,1) 1];
                end
                % Now do the rest of the under the hood stuff
                B = RestOfStuff(B,tmp,format,promRanks);
            else
                error('Needed User Variables Do Not Exist: ''tmp'' and ''promRanks''')
            end
        else
            B = [];
            return;
        end
        
        
    otherwise
        error('Board initialziation format unrecognized')
end

% check for board size
if any(size(tmp))>15 || any(size(tmp)<5)
    error('No board dimension shall exceed 15 or be less than 5 squares.')
end

end % end function



% --- extra functions ---

function B = RestOfStuff(B,tmp,format,promRanks)
% build the rest of the board

% place pieces on the baord
B.top = PlacePieces(tmp,B.info.pad);
% the game type that has been selected
B.info.format = format;
% list of unique non-royal pieces
B.info.pieces = UniquePieces(B);
% note the promotion ranks in the board object
B.info.promRanks = promRanks+B.info.pad/2;
% now that we have a list of the pieces, update possible promotion fcns
B = UpdatePromLists(B);
% note the boxed playable limits for the game
B.info.boxLim = BoxLim(B);
% finally, track this game history
B.info.hist = cellfun(@(x,y) [x num2str(y)],{B.top.name},{B.top.colour},'unifo',false);

end


function X = PlacePieces(input,pad)
X = struct(NewPiece([]));
% build the initial board with everything non-playable at first
% add paddings to the non-playable areas of 4 squares and place pieces
for i=1:size(input,1)+pad
    for j=1:size(input,2)+pad
        X(i,j) = NewPiece([]);
    end
end


% now place pieces and playable areas
for i=1:size(input,1)
    for j=1:size(input,2)
        % locate the delimiter
        ix = strfind(input{i,j},':');
        if isempty(ix)
            pName = []; pColour = 0;
        else
            pName = input{i,j}(1:ix-1);
            pColour = str2num(input{i,j}(ix+1:end));
        end
        X(i+pad/2,j+pad/2) = NewPiece(pName,pColour);
    end
end
end



function pList = UniquePieces(B)
    % get unique non-royal non-gaurd pieces (used for promotion
    tmp = {B.top.name};
    ix = (~cellfun(@isempty,tmp) & ~[B.top.royal]==1 & ~strcmp('guard',{B.top.type}));
    pList = unique(tmp(ix));
end
    


function B = UpdatePromLists(B)
% update all pieces that promote to "any" to the list of possible pieces
for k=1:numel(B.top)
    % go through each cell and search
    if iscell(B.top(k).promotion) && strcmp(B.top(k).promotion,'any')
        B.top(k).promotion = B.info.pieces;
    end
end

end


function bl = BoxLim(B)
pad = B.info.pad/2;
bSize = size(B.top)-pad;
rowEdge = [pad+1 bSize(1)];
colEdge = [pad+1 bSize(2)];
bl = [rowEdge; colEdge];
end
    