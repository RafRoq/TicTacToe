import 'dart:io';

class Piece {
  //DONE
  String repr;
  int value;

  Piece(this.repr, this.value);

  @override
  String toString() => '${this.repr} : ${this.value}';
}

class Player {
  List<Piece> pieces = [];
  String repr;
  int num_pieces;

  Player({required String this.repr, int this.num_pieces = 5}) {
    for (var i = 0; i < this.num_pieces; i++) {
      this.pieces.add(Piece(this.repr, i));
    }
  }
  void put_piece(Board board, int pvalue, int tx, int ty) {
    Tile tile = board.board[tx][ty];
    if (tile.isempty() || tile.dominant!.value < pvalue) {
      for (var i = 0; i < pieces.length; i++) {
        if (pieces[i].value == pvalue) {
          board.board[tx][ty].dominant = pieces.removeAt(i);
        }
      }
    }
  }

  @override
  String toString() {
    return 'Player_$repr';
  }
}

class Tile {
  //DONE
  Piece? dominant;

  Tile({this.dominant = null});

  bool isempty() => this.dominant == null ? true : false;

  @override
  String toString() => '${this.dominant ?? 'Empty'}';
}

class Board {
  //DONE
  int dimensions;
  List board = [];

  Board({this.dimensions = 3}) {
    for (var i = 0; i < this.dimensions; i++) {
      this.board.add(List.generate(this.dimensions, (_) => Tile()));
    }
  }

  void drawn() {
    for (var line in this.board) {
      for (var tile in line) {
        stdout.write(' | $tile | ');
      }
      print('');
    }
    print('');
  }
}

class TICTACTOE {
  Board board = Board();
  final Player p1;
  final Player p2;
  final List players;

  final List checks = const [
    [
      [1, 1],
      [0, 1],
      [2, 1]
    ],
    [
      [1, 1],
      [1, 0],
      [1, 2]
    ],
    [
      [1, 1],
      [0, 0],
      [2, 2]
    ],
    [
      [1, 1],
      [2, 0],
      [0, 2]
    ],
    [
      [1, 0],
      [0, 0],
      [2, 0]
    ],
    [
      [1, 2],
      [0, 2],
      [2, 2]
    ],
    [
      [2, 1],
      [2, 0],
      [2, 2]
    ],
    [
      [0, 1],
      [0, 0],
      [0, 2]
    ]
  ];

  TICTACTOE({Player? p1, Player? p2})
      : p1 = p1 ?? Player(repr: ''),
        p2 = p2 ?? Player(repr: ''),
        players = [p1, p2];

  bool check_win_cond() {
    var a;
    var b;
    var c;
    var s = this.board.board;
    for (var x in checks) {
      a = x[0];
      b = x[1];
      c = x[2];
      var acord = s[a[0]][a[1]];
      var bcord = s[b[0]][b[1]];
      var ccord = s[c[0]][c[1]];
      if (!(acord.isempty()) && !(bcord.isempty()) && !(ccord.isempty())) {
        if ((acord.dominant.repr == bcord.dominant.repr) && (bcord.dominant.repr == ccord.dominant.repr)) {
          return true;
        }
      }
    }
    return false;
  }

  void run() {
    bool win_cond = false;
    while (!win_cond) {
      for (Player player in this.players) {
        stdout.write('Player_${player.repr}=>${player.pieces}\n\n');
        this.board.drawn();
        stdout.write('Player_${player.repr}=>Put a piece using the format (value,x,y): ');
        var choice = stdin.readLineSync()?.split(',');
        player.put_piece(this.board, int.parse(choice![0]), int.parse(choice[1]), int.parse(choice[2]));
        win_cond = this.check_win_cond();
        if (win_cond) {
          break;
        }
      }
    }
  }
}

void main() {
  var x = TICTACTOE(p1: Player(repr: 'R'), p2: Player(repr: 'Y'));
  x.run();
}
