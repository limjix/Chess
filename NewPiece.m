function piece = NewPiece(pieceName,colour)
% generates a new piece
%
% piece = NewPiece(pieceName,colour)
% where piece is the object (structure) containing the piece information to
% (presumably) be placed into the board object and colour is -1 or 1 to
% denote black or white respectively
%
% Special Commands:
% - if pieceName is "none" the piece object is initialized to an empty
% piece
% - if the pieceName is empty, [], this will be an impermissable
% playing square (as called by BoardInitialization).
% - if pieceName is "list", returned in piece will be a list of possible
% pieces to choose from.
%
%
% %%% code for ChessPiece, v1.1 2012, ZCD %%%
%

% image folder:
fs = filesep;
imDir = ['ImageSet' fs];

if isempty(pieceName)
    piece.name      = [];
    piece.colour     = nan;
    piece.move      = [];
    piece.capture   = [];
    piece.royal     = 0;
    piece.init      = nan;
    piece.promotion = nan;
    piece.castle    = nan;
    piece.immobile   = nan;
    piece.protect   = nan;
    piece.type      = 'OOB';
    piece.image     = [];
    piece.himg      = [];
    piece.rules     = [];
    return;
end


switch pieceName
    case 'none'
        piece.name      = [];
        piece.colour     = 0;
        piece.move      = [];
        piece.capture   = [];
        piece.royal     = 0;
        piece.init      = nan;
        piece.promotion = nan;
        piece.castle    = nan;
        piece.immobile   = nan;
        piece.protect   = nan;
        piece.type      = 'empty';
        piece.image     = [];
        piece.himg      = [];
        piece.rules     = [imDir 'pieceRules-01.png'];
    case 'knight'
        piece.name      = 'knight';
        piece.colour     = colour;    % white 1, black -1 (useful to invert board)
        piece.move      = {@(p,B) leap(1,2,'m',p,1,B)};
        piece.capture   = {@(p,B) leap(1,2,'c',p,1,B)};
        piece.royal     = 0;
        piece.init      = nan;
        piece.promotion = nan;
        piece.castle    = nan;
        piece.immobile   = nan;
        piece.protect   = nan;
        piece.type      = 'minor';
        piece.image     = [imDir piece.name num2str(piece.colour) '.png'];
        piece.himg      = [];
        piece.rules     = [imDir piece.name 'Rules-01.png'];
    case 'king'
        piece.name      = 'king';
        piece.colour     = colour;
        piece.move      = {@(p,B) leap(1,1,'m',p,1,B); @(p,B) leap(1,0,'m',p,1,B)};
        piece.capture   = {@(p,B) leap(1,1,'c',p,1,B); @(p,B) leap(1,0,'c',p,1,B)};
        piece.royal     = 1;
        piece.init      = nan;
        piece.promotion = nan;
        piece.castle    = 1;
        piece.immobile   = nan;
        piece.protect   = nan;
        piece.type      = 'royal';
        piece.image     = [imDir piece.name num2str(piece.colour) '.png'];
        piece.himg      = [];
        piece.rules     = [imDir piece.name 'Rules-01.png'];
    case 'pawn'
        piece.name      = 'pawn';
        piece.colour    = colour;
        piece.move      = {@(p,B) leap(1,0,'m',p,1,B,1)};
        piece.capture   = {@(p,B) leap(1,1,'c',p,1,B,[1 2])};
        piece.royal     = 0;
        piece.init      = {@(p,B) leap(1,0,'m',p,2,B,[1 1])};
        piece.promotion = {'any'}; % the "any" allows any starting piece
        piece.castle    = nan;
        piece.immobile   = nan;
        piece.protect   = nan;
        piece.type      = 'guard';
        piece.image     = [imDir piece.name num2str(piece.colour) '.png'];
        piece.himg      = [];
        piece.rules     = [imDir piece.name 'Rules-01.png'];
    case 'rook'
        piece.name      = 'rook';
        piece.colour     = colour;
        piece.move      = {@(p,B) leap(1,0,'m',p,100,B)};
        piece.capture   = {@(p,B) leap(1,0,'c',p,100,B)};
        piece.royal     = 0;
        piece.init      = nan;
        piece.promotion = nan;
        piece.castle    = 1;    % turns to nan once used?
        piece.immobile   = nan;
        piece.protect   = nan;
        piece.type      = 'major';
        piece.image     = [imDir piece.name num2str(piece.colour) '.png'];
        piece.himg      = [];
        piece.rules     = [imDir piece.name 'Rules-01.png'];
    case 'bishop'
        piece.name      = 'bishop';
        piece.colour     = colour;
        piece.move      = {@(p,B) leap(1,1,'m',p,100,B)};
        piece.capture   = {@(p,B) leap(1,1,'c',p,100,B)};
        piece.royal     = 0;
        piece.init      = nan;
        piece.promotion = nan;
        piece.castle    = nan;
        piece.immobile   = nan;
        piece.protect   = nan;
        piece.type      = 'minor';
        piece.image     = [imDir piece.name num2str(piece.colour) '.png'];
        piece.himg      = [];
        piece.rules     = [imDir piece.name 'Rules-01.png'];
    case 'queen'
        piece.name      = 'queen';
        piece.colour     = colour;
        piece.move      = {@(p,B) leap(1,1,'m',p,100,B); @(p,B) leap(1,0,'m',p,100,B)};
        piece.capture   = {@(p,B) leap(1,1,'c',p,100,B); @(p,B) leap(1,0,'c',p,100,B)};
        piece.royal     = 0;
        piece.init      = nan;
        piece.promotion = nan;
        piece.castle    = nan;
        piece.immobile   = nan;
        piece.protect   = nan;
        piece.type      = 'superior';
        piece.image     = [imDir piece.name num2str(piece.colour) '.png'];
        piece.himg      = [];
        piece.rules     = [imDir piece.name 'Rules-01.png'];
    case 'beholder'
        piece.name      = 'beholder';
        piece.colour     = colour;
        piece.move      = {@(p,B) leap(1,1,'m',p,3,B)};
        piece.capture   = nan;
        piece.royal     = 0;
        piece.init      = nan;
        piece.promotion = {'knightrider'};
        piece.castle    = nan;
        piece.immobile   = {@(p,B) leap(1,1,'c',p,1,B); @(p,B) leap(1,0,'c',p,1,B)};
        piece.protect   = nan;
        piece.type      = 'minor';
        piece.image     = [imDir piece.name num2str(piece.colour) '.png'];
        piece.himg      = [];
        piece.rules     = [imDir piece.name 'Rules-01.png'];
    case 'knightrider'
        piece.name      = 'knightrider';
        piece.colour     = colour;
        piece.move      = {@(p,B) leap(1,2,'m',p,100,B)};
        piece.capture   = {@(p,B) leap(1,2,'c',p,100,B)};
        piece.royal     = 0;
        piece.init      = nan;
        piece.promotion = nan;
        piece.castle    = nan;
        piece.immobile   = nan;
        piece.protect   = nan;
        piece.type      = 'superior';
        piece.image     = [imDir piece.name num2str(piece.colour) '.png'];
        piece.himg      = [];
        piece.rules     = [imDir piece.name 'Rules-01.png'];
    case 'storm'
        piece.name      = 'storm';
        piece.colour     = colour;
        piece.move      = {@(p,B) leap(1,1,'m',p,2,B); @(p,B) leap(1,0,'m',p,2,B)};
        piece.capture   = {@(p,B) leap(1,0,'c',p,2,B,1)};
        piece.royal     = 0;
        piece.init      = nan;
        piece.promotion = {'any'};
        piece.castle    = nan;
        piece.immobile   = nan;
        piece.protect   = nan;
        piece.type      = 'minor';
        piece.image     = [imDir piece.name num2str(piece.colour) '.png'];
        piece.himg      = [];
        piece.rules     = [imDir piece.name 'Rules-01.png'];
    case 'cleric'
        piece.name      = 'cleric';
        piece.colour     = colour;
        piece.move      = {@(p,B) leap(1,1,'m',p,4,B)};
        piece.capture   = {@(p,B) leap(1,1,'c',p,4,B)};
        piece.royal     = 0;
        piece.init      = nan;
        piece.promotion = nan;
        piece.castle    = nan;
        piece.immobile   = nan;
        piece.protect   = {@(p,B) leap(1,1,'p',p,1,B)};
        piece.type      = 'minor';
        piece.image     = [imDir piece.name num2str(piece.colour) '.png'];
        piece.himg      = [];
        piece.rules     = [imDir piece.name 'Rules-01.png'];
    case 'elephant'
        piece.name      = 'elephant';
        piece.colour     = colour;
        piece.move      = {@(p,B) leap(2,2,'m',p,1,B)};
        piece.capture   = {@(p,B) leap(2,2,'c',p,1,B); @(p,B) leap(1,0,'c',p,3,B)};
        piece.royal     = 0;
        piece.init      = nan;
        piece.promotion = nan;
        piece.castle    = nan;
        piece.immobile   = nan;
        piece.protect   = nan;
        piece.type      = 'minor';
        piece.image     = [imDir piece.name num2str(piece.colour) '.png'];
        piece.himg      = [];
        piece.rules     = [imDir piece.name 'Rules-01.png'];
    case 'lion'
        piece.name      = 'lion';
        piece.colour     = colour;
        piece.move      = {@(p,B) leap(2,2,'m',p,1,B); @(p,B) leap(2,0,'m',p,1,B)};
        piece.capture   = {@(p,B) leap(2,2,'c',p,1,B); @(p,B) leap(2,0,'c',p,1,B); @(p,B) leap(0,1,'c',p,1,B); @(p,B) leap(1,1,'c',p,1,B)};
        piece.royal     = 0;
        piece.init      = {@(p,B) leap(1,2,'m',p,1,B,[5 7])};
        piece.promotion = nan;
        piece.castle    = nan;
        piece.immobile   = nan;
        piece.protect   = nan;
        piece.type      = 'minor';
        piece.image     = [imDir piece.name num2str(piece.colour) '.png'];
        piece.himg      = [];
        piece.rules     = [imDir piece.name 'Rules-01.png'];
    case 'waffle'
        piece.name      = 'waffle';
        piece.colour     = colour;
        piece.move      = {@(p,B) leap(2,2,'m',p,1,B); @(p,B) leap(1,0,'m',p,1,B)};
        piece.capture   = {@(p,B) leap(2,2,'c',p,1,B); @(p,B) leap(1,0,'c',p,1,B); @(p,B) leap(1,1,'c',p,1,B)};
        piece.royal     = 0;
        piece.init      = nan;
        piece.promotion = nan;
        piece.castle    = nan;
        piece.immobile   = nan;
        piece.protect   = nan;
        piece.type      = 'minor';
        piece.image     = [imDir piece.name num2str(piece.colour) '.png'];
        piece.himg      = [];
        piece.rules     = [imDir piece.name 'Rules-01.png'];
    case 'wizard'
        piece.name      = 'wizard';
        piece.colour     = colour;
        piece.move      = {@(p,B) leap(1,3,'m',p,1,B); @(p,B) leap(1,1,'m',p,1,B)};
        piece.capture   = {@(p,B) leap(1,3,'c',p,1,B); @(p,B) leap(1,1,'c',p,1,B)};
        piece.royal     = 0;
        piece.init      = nan;
        piece.promotion = nan;
        piece.castle    = nan;
        piece.immobile   = nan;
        piece.protect   = nan;
        piece.type      = 'minor';
        piece.image     = [imDir piece.name num2str(piece.colour) '.png'];
        piece.himg      = [];
        piece.rules     = [imDir piece.name 'Rules-01.png'];
    case 'champion'
        piece.name      = 'champion';
        piece.colour     = colour;
        piece.move      = {@(p,B) leap(2,2,'m',p,1,B); @(p,B) leap(1,0,'m',p,1,B); @(p,B) leap(2,0,'m',p,1,B)};
        piece.capture   = {@(p,B) leap(2,2,'c',p,1,B); @(p,B) leap(1,0,'c',p,1,B); @(p,B) leap(2,0,'c',p,1,B)};
        piece.royal     = 0;
        piece.init      = nan;
        piece.promotion = nan;
        piece.castle    = nan;
        piece.immobile   = nan;
        piece.protect   = nan;
        piece.type      = 'minor';
        piece.image     = [imDir piece.name num2str(piece.colour) '.png'];
        piece.himg      = [];
        piece.rules     = [imDir piece.name 'Rules-01.png'];
    case 'steward'
        piece.name      = 'steward';
        piece.colour     = colour;
        piece.move      = {@(p,B) leap(1,0,'m',p,1,B)};
        piece.capture   = {@(p,B) leap(1,1,'c',p,1,B)};
        piece.royal     = 0;
        piece.init      = {@(p,B) leap(1,0,'m',p,2,B,[1 1])};
        piece.promotion = {'any'};
        piece.castle    = nan;
        piece.immobile   = nan;
        piece.protect   = nan;
        piece.type      = 'minor';
        piece.image     = [imDir piece.name num2str(piece.colour) '.png'];
        piece.himg      = [];
        piece.rules     = [imDir piece.name 'Rules-01.png'];
    case 'minotaur'
        piece.name      = 'minotaur';
        piece.colour     = colour;
        piece.move      = {@(p,B) leap(1,1,'m',p,1,B,[3 4]); @(p,B) leap(1,0,'m',p,1,B,[3 5 7]); @(p,B) leap(1,2,'m',p,1,B,[1 5 7 2])};
        piece.capture   = {@(p,B) leap(1,1,'c',p,1,B,[3 4]); @(p,B) leap(1,0,'c',p,1,B,[3 5 7]); @(p,B) leap(1,2,'c',p,1,B,[1 5 7 2])};
        piece.royal     = 0;
        piece.init      = nan;
        piece.promotion = nan;
        piece.castle    = nan;
        piece.immobile   = nan;
        piece.protect   = nan;
        piece.type      = 'minor';
        piece.image     = [imDir piece.name num2str(piece.colour) '.png'];
        piece.himg      = [];
        piece.rules     = [imDir piece.name 'Rules-01.png'];
    case 'longpawn'
        piece.name      = 'longpawn';
        piece.colour    = colour;
        piece.move      = {@(p,B) leap(1,0,'m',p,1,B,1)};
        piece.capture   = {@(p,B) leap(1,1,'c',p,1,B,[1 2])};
        piece.royal     = 0;
        piece.init      = {@(p,B) leap(1,0,'m',p,3,B,1)};
        piece.promotion = {'any'}; % the "any" allows any starting piece
        piece.castle    = nan;
        piece.immobile   = nan;
        piece.protect   = nan;
        piece.type      = 'guard';
        piece.image     = [imDir piece.name num2str(piece.colour) '.png'];
        piece.himg      = [];
        piece.rules     = [imDir piece.name 'Rules-01.png'];
    case 'berolina'
        piece.name      = pieceName;
        piece.colour    = colour;
        piece.move      = {@(p,B) leap(1,1,'m',p,1,B,[1 2])};
        piece.capture   = {@(p,B) leap(1,0,'c',p,1,B,1)};
        piece.royal     = 0;
        piece.init      = {@(p,B) leap(1,1,'m',p,2,B,[1 2])};
        piece.promotion = {'any'};
        piece.castle    = nan;
        piece.immobile   = nan;
        piece.protect   = nan;
        piece.type      = 'guard';
        piece.image     = [imDir piece.name num2str(piece.colour) '.png'];
        piece.himg      = [];
        piece.rules     = [imDir piece.name 'Rules-01.png'];
    case 'surf'
        piece.name      = pieceName;
        piece.colour    = colour;
        piece.move      = {@(p,B) leap(1,0,'m',p,1,B,[1 2])};
        piece.capture   = {@(p,B) leap(1,0,'c',p,1,B,[3 6 7])};
        piece.royal     = 0;
        piece.init      = {@(p,B) leap(1,0,'m',p,2,B,1)};
        piece.promotion = {'any'};
        piece.castle    = nan;
        piece.immobile   = nan;
        piece.protect   = nan;
        piece.type      = 'guard';
        piece.image     = [imDir piece.name num2str(piece.colour) '.png'];
        piece.himg      = [];
        piece.rules     = [imDir piece.name 'Rules-01.png'];
    case 'basilisk'
        piece.name      = pieceName;
        piece.colour    = colour;
        piece.move      = {@(p,B) leap(1,0,'m',p,3,B)};
        piece.capture   = {@(p,B) leap(1,1,'c',p,3,B)};
        piece.royal     = 0;
        piece.init      = nan;
        piece.promotion = nan;
        piece.castle    = nan;
        piece.immobile   = {@(p,B) leap(1,2,'c',p,1,B)};
        piece.protect   = nan;
        piece.type      = 'superior';
        piece.image     = [imDir piece.name num2str(piece.colour) '.png'];
        piece.himg      = [];
        piece.rules     = [imDir piece.name 'Rules-01.png'];
    case 'arcangel'
        piece.name      = pieceName;
        piece.colour    = colour;
        piece.move      = {@(p,B) leap(1,0,'m',p,100,B)};
        piece.capture   = {@(p,B) leap(1,0,'c',p,100,B)};
        piece.royal     = 0;
        piece.init      = nan;
        piece.promotion = nan;
        piece.castle    = nan;
        piece.immobile   = nan;
        piece.protect   = {@(p,B) leap(1,1,'p',p,100,B)};
        piece.type      = 'superior';
        piece.image     = [imDir piece.name num2str(piece.colour) '.png'];
        piece.himg      = [];
        piece.rules     = [imDir piece.name 'Rules-01.png'];
    case 'incarnation'
        piece.name      = pieceName;
        piece.colour    = colour;
        piece.move      = {@(p,B) leap(1,0,'m',p,1,B); @(p,B) leap(1,1,'m',p,1,B)};
        piece.capture   = {@(p,B) leap(1,0,'c',p,100,B); @(p,B) leap(1,1,'c',p,100,B); @(p,B) leap(1,2,'c',p,1,B)};
        piece.royal     = 0;
        piece.init      = nan;
        piece.promotion = nan;
        piece.castle    = nan;
        piece.immobile   = nan;
        piece.protect   = nan;
        piece.type      = 'superior';
        piece.image     = [imDir piece.name num2str(piece.colour) '.png'];
        piece.himg      = [];
        piece.rules     = [imDir piece.name 'Rules-01.png'];
    case 'sophist'
        piece.name      = pieceName;
        piece.colour    = colour;
        piece.move      = {@(p,B) leap(2,2,'m',p,1,B); @(p,B) leap(1,2,'m',p,1,B)};
        piece.capture   = {@(p,B) leap(2,2,'c',p,1,B); @(p,B) leap(1,2,'c',p,1,B)};
        piece.royal     = 0;
        piece.init      = nan;
        piece.promotion = nan;
        piece.castle    = nan;
        piece.immobile   = {@(p,B) leap(2,2,'c',p,1,B)};
        piece.protect   = {@(p,B) leap(1,0,'p',p,1,B,1)};
        piece.type      = 'superior';
        piece.image     = [imDir piece.name num2str(piece.colour) '.png'];
        piece.himg      = [];
        piece.rules     = [imDir piece.name 'Rules-01.png'];
    case 'jack'
        piece.name      = pieceName;
        piece.colour    = colour;
        piece.move      = {@(p,B) leap(2,2,'m',p,100,B); @(p,B) leap(2,0,'m',p,100,B); @(p,B) leap(1,2,'m',p,1,B)};
        piece.capture   = {@(p,B) leap(2,2,'c',p,100,B); @(p,B) leap(2,0,'c',p,100,B)};
        piece.royal     = 0;
        piece.init      = nan;
        piece.promotion = nan;
        piece.castle    = nan;
        piece.immobile   = nan;
        piece.protect   = nan;
        piece.type      = 'superior';
        piece.image     = [imDir piece.name num2str(piece.colour) '.png'];
        piece.himg      = [];
        piece.rules     = [imDir piece.name 'Rules-01.png'];
    case 'archbishop'
        piece.name      = pieceName;
        piece.colour    = colour;
        piece.move      = {@(p,B) leap(1,1,'m',p,100,B); @(p,B) leap(1,2,'m',p,1,B)};
        piece.capture   = {@(p,B) leap(1,1,'c',p,100,B); @(p,B) leap(1,2,'c',p,1,B)};
        piece.royal     = 0;
        piece.init      = nan;
        piece.promotion = nan;
        piece.castle    = nan;
        piece.immobile   = nan;
        piece.protect   = nan;
        piece.type      = 'superior';
        piece.image     = [imDir piece.name num2str(piece.colour) '.png'];
        piece.himg      = [];
        piece.rules     = [imDir piece.name 'Rules-01.png'];
    case 'marshal'
        piece.name      = pieceName;
        piece.colour    = colour;
        piece.move      = {@(p,B) leap(1,0,'m',p,100,B); @(p,B) leap(1,2,'m',p,1,B)};
        piece.capture   = {@(p,B) leap(1,0,'c',p,100,B); @(p,B) leap(1,2,'c',p,1,B)};
        piece.royal     = 0;
        piece.init      = nan;
        piece.promotion = nan;
        piece.castle    = nan;
        piece.immobile   = nan;
        piece.protect   = nan;
        piece.type      = 'superior';
        piece.image     = [imDir piece.name num2str(piece.colour) '.png'];
        piece.himg      = [];
        piece.rules     = [imDir piece.name 'Rules-01.png'];
    case 'dabash'
        piece.name      = pieceName;
        piece.colour    = colour;
        piece.move      = {@(p,B) leap(1,1,'m',p,100,B); @(p,B) leap(0,2,'m',p,1,B)};
        piece.capture   = {@(p,B) leap(1,1,'c',p,100,B); @(p,B) leap(0,2,'c',p,1,B)};
        piece.royal     = 0;
        piece.init      = nan;
        piece.promotion = nan;
        piece.castle    = nan;
        piece.immobile   = {@(p,B) leap(0,1,'c',p,1,B)};
        piece.protect   = nan;
        piece.type      = 'superior';
        piece.image     = [imDir piece.name num2str(piece.colour) '.png'];
        piece.himg      = [];
        piece.rules     = [imDir piece.name 'Rules-01.png'];
    case 'gaea'
        piece.name      = pieceName;
        piece.colour    = colour;
        piece.move      = {@(p,B) leap(1,0,'m',p,3,B); @(p,B) leap(1,1,'m',p,3,B)};
        piece.capture   = {@(p,B) leap(1,0,'c',p,3,B); @(p,B) leap(1,1,'c',p,3,B)};
        piece.royal     = 0;
        piece.init      = {@(p,B) teleport('m',p,B,'radial',3); @(p,B) teleport('c',p,B,'radial',3);...
            @(p,B) leap(1,0,'m',p,100,B); @(p,B) leap(1,1,'m',p,100,B); @(p,B) leap(1,0,'c',p,100,B); @(p,B) leap(1,1,'c',p,100,B)};
        piece.promotion = {'gaea'};
        piece.castle    = nan;
        piece.immobile   = nan;
        piece.protect   = nan;
        piece.type      = 'superior';
        piece.image     = [imDir piece.name num2str(piece.colour) '.png'];
        piece.himg      = [];
        piece.rules     = [imDir piece.name 'Rules-01.png'];
    case 'colonel'
        piece.name      = pieceName;
        piece.colour    = colour;
        piece.move      = {@(p,B) leap(1,0,'m',p,100,B,[1 5 7]); @(p,B) leap(1,2,'m',p,1,B,[1 5 7 2]); @(p,B) leap(1,1,'m',p,1,B); @(p,B) leap(1,0,'m',p,1,B)};
        piece.capture   = {@(p,B) leap(1,0,'c',p,100,B,[1 5 7]); @(p,B) leap(1,2,'c',p,1,B,[1 5 7 2]); @(p,B) leap(1,1,'c',p,1,B); @(p,B) leap(1,0,'c',p,1,B)};
        piece.royal     = 0;
        piece.init      = nan;
        piece.promotion = nan;
        piece.castle    = nan;
        piece.immobile   = nan;
        piece.protect   = nan;
        piece.type      = 'superior';
        piece.image     = [imDir piece.name num2str(piece.colour) '.png'];
        piece.himg      = [];
        piece.rules     = [imDir piece.name 'Rules-01.png'];
    case 'sentinel'
        piece.name      = pieceName;
        piece.colour     = colour;
        piece.move      = {@(p,B) leap(1,0,'m',p,4,B,[5 7]); @(p,B) leap(1,0,'m',p,1,B,[1 3])};
        piece.capture   = {@(p,B) leap(1,0,'c',p,4,B,[5 7]); @(p,B) leap(1,0,'c',p,1,B,[1 3])};
        piece.royal     = 0;
        piece.init      = nan;
        piece.promotion = {'queen'};
        piece.castle    = 1;
        piece.immobile   = nan;
        piece.protect   = {@(p,B) leap(1,0,'p',p,2,B,[5 7])};
        piece.type      = 'major';
        piece.image     = [imDir piece.name num2str(piece.colour) '.png'];
        piece.himg      = [];
        piece.rules     = [imDir piece.name 'Rules-01.png'];
    case 'paladin'
        piece.name      = pieceName;
        piece.colour     = colour;
        piece.move      = {@(p,B) leap(1,1,'m',p,2,B,[5 7]); @(p,B) leap(1,0,'m',p,100,B,[1 3])};
        piece.capture   = {@(p,B) leap(1,1,'c',p,2,B,[5 7]); @(p,B) leap(1,0,'c',p,100,B,[1 3])};
        piece.royal     = 0;
        piece.init      = nan;
        piece.promotion = nan;
        piece.castle    = 1;
        piece.immobile   = nan;
        piece.protect   = nan;
        piece.type      = 'major';
        piece.image     = [imDir piece.name num2str(piece.colour) '.png'];
        piece.himg      = [];
        piece.rules     = [imDir piece.name 'Rules-01.png'];
    case 'blinky'
        piece.name      = pieceName;
        piece.colour     = colour;
        piece.move      = {@(p,B) teleport('m',p,B,'forward',4); @(p,B) leap(1,1,'m',p,1,B,[4 3]); @(p,B) leap(1,2,'m',p,1,B,[3 6 8 4])};
        piece.capture   = {@(p,B) teleport('c',p,B,'forward',4); @(p,B) leap(1,1,'c',p,1,B,[4 3]); @(p,B) leap(1,2,'c',p,1,B,[3 6 8 4])};
        piece.royal     = 0;
        piece.init      = nan;
        piece.promotion = nan;
        piece.castle    = 1;
        piece.immobile   = nan;
        piece.protect   = nan;
        piece.type      = 'major';
        piece.image     = [imDir piece.name num2str(piece.colour) '.png'];
        piece.himg      = [];
        piece.rules     = [imDir piece.name 'Rules-01.png'];
    case 'ire'
        piece.name      = pieceName;
        piece.colour     = colour;
        piece.move      = {@(p,B) leap(1,0,'m',p,1,B,[1 3]); @(p,B) teleport('m',p,B,'row')};
        piece.capture   = {@(p,B) leap(1,0,'c',p,1,B,[1 3]); @(p,B) teleport('c',p,B,'row')};
        piece.royal     = 0;
        piece.init      = nan;
        piece.promotion = nan;
        piece.castle    = 1;
        piece.immobile   = nan;
        piece.protect   = nan;
        piece.type      = 'major';
        piece.image     = [imDir piece.name num2str(piece.colour) '.png'];
        piece.himg      = [];
        piece.rules     = [imDir piece.name 'Rules-01.png'];
    case 'obdure'
        piece.name      = pieceName;
        piece.colour     = colour;
        piece.move      = nan;
        piece.capture   = {@(p,B) leap(1,1,'c',p,1,B)};
        piece.royal     = 0;
        piece.init      = {@(p,B) leap(1,0,'m',p,100,B); @(p,B) leap(1,0,'c',p,100,B)};
        piece.promotion = nan;
        piece.castle    = 1;
        piece.immobile   = nan;
        piece.protect   = {@(p,B) leap(0,0,'p',p,1,B,1)};
        piece.type      = 'major';
        piece.image     = [imDir piece.name num2str(piece.colour) '.png'];
        piece.himg      = [];
        piece.rules     = [imDir piece.name 'Rules-01.png'];
    case 'sultan'
        piece.name      = pieceName;
        piece.colour     = colour;    
        piece.move      = {@(p,B) leap(1,2,'m',p,1,B)};
        piece.capture   = {@(p,B) leap(1,2,'c',p,1,B)};
        piece.royal     = 1;
        piece.init      = nan;
        piece.promotion = nan;
        piece.castle    = 1;
        piece.immobile   = nan;
        piece.protect   = nan;
        piece.type      = 'royal';
        piece.image     = [imDir piece.name num2str(piece.colour) '.png'];
        piece.himg      = [];
        piece.rules     = [imDir piece.name 'Rules-01.png'];
    case 'caliphate'
        piece.name      = pieceName;
        piece.colour     = colour;
        piece.move      = nan;
        piece.capture   = {@(p,B) teleport('c',p,B,'radial',2)};
        piece.royal     = 1;
        piece.init      = {@(p,B) teleport('m',p,B,'radial',2)};
        piece.promotion = nan;
        piece.castle    = 1;
        piece.immobile   = nan;
        piece.protect   = nan;
        piece.type      = 'royal';
        piece.image     = [imDir piece.name num2str(piece.colour) '.png'];
        piece.himg      = [];
        piece.rules     = [imDir piece.name 'Rules-01.png'];
    case 'blight'
        piece.name      = pieceName;
        piece.colour     = colour;
        piece.move      = {@(p,B) teleport('m',p,B,'radial',1)};
        piece.capture   = {@(p,B) teleport('c',p,B,'radial',1)};
        piece.royal     = 1;
        piece.init      = nan;
        piece.promotion = nan;
        piece.castle    = 1;
        piece.immobile   = {@(p,B) leap(1,1,'c',p,1,B)};
        piece.protect   = nan;
        piece.type      = 'royal';
        piece.image     = [imDir piece.name num2str(piece.colour) '.png'];
        piece.himg      = [];
        piece.rules     = [imDir piece.name 'Rules-01.png'];
    otherwise
        error(['Unrecognized pieceName, ' pieceName])
end