class Piece:

    def __init__(self, repr: str, value: int) -> None:
        self.repr = repr
        self.value = value

    def __repr__(self) -> str:
        return f'{self.repr} : {self.value}'

class Player:

    def __init__(self, repr: str, number_pieces: int) -> None:
        self.repr = repr
        self.pieces = []
        for i in range(number_pieces):
            self.pieces.append(Piece(self.repr, i))

    def put_piece(self, board, pvalue: int, tx: int, ty: int):
        try:
            if not board.board[tx][ty].dominant or board.board[tx][ty].dominant.value < pvalue:
                for i in range(len(self.pieces)):
                    if self.pieces[i].value == pvalue:
                        board.board[tx][ty].dominant = self.pieces.pop(i)
                        return print(f'piece {board.board[tx][ty].dominant} put in ({tx}, {ty})\n')
                    else:
                        continue
            else:
                return print('Invalid choice')
        except:
            return print('Invalid choice error')

class Tile:

    def __init__(self) -> None:
        self.dominant = None

    def __repr__(self) -> str:
        if self.dominant:
            return f'{self.dominant}'
        else:
            return 'Empty'

class Board:
    """creates a 3x3 grid with tile objects in each of it's points"""

    def __init__(self) -> None:
        self.board = [[],[],[]]
        for i in self.board:
            for ii in range(3):
                i.append(Tile())
        
    def drawn(self):
        for i in self.board:
            for ii in i:
                print(' | ',ii,' | ', end='')
            print()
        print()

class TIKTAKTOE:
    checks = (
    ((1,1),(0,1),(2,1)),
    ((1,1),(1,0),(1,2)),
    ((1,1),(0,0),(2,2)),
    ((1,1),(2,0),(0,2)),
    ((1,0),(0,0),(2,0)),
    ((1,2),(0,2),(2,2)),
    ((2,1),(2,0),(2,2)),
    ((0,1),(0,0),(0,2))
    )
    
    def __init__(self) -> None:
        self.board = Board()
        p1 = Player(input('Player_?=>Choose your char: ').upper(), 5)
        p2 = Player(input('Player_?=>Choose your char: ').upper(), 5)
        self.players = [p1, p2]
    
    def check_win_cond(self) -> bool:
        for (a_x, a_y), (b_x, b_y), (c_x, c_y) in self.checks:
            if (a := self.board.board[a_x][a_y].dominant) and (b := self.board.board[b_x][b_y].dominant) and (c := self.board.board[c_x][c_y].dominant):
                if a.repr == b.repr == c.repr:
                    return True
        return False

    def run(self):
        win_cond = None
        while not win_cond:
            for i in self.players:
                print(f'Player_{i.repr}=>{i.pieces}\n')
                self.board.drawn()
                choice = input(f'Player_{i.repr}=>Put a piece using the format (value,x,y): ').split(',')
                i.put_piece(self.board, int(choice[0]), int(choice[1]), int(choice[2]))
                win_cond = self.check_win_cond()
                if win_cond:
                    print(f'Player_{i.repr} WON!')
                    break

tik = TIKTAKTOE()
tik.run()
