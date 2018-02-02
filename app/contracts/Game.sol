pragma solidity ^ 0.4 .17;
contract Game {
struct Player {
address PlayerIdentifier;
string Name;
uint NoOfWins;
mapping(address => Player) PreviousOponents;
uint[] Winnings;
bool Registerd;
}
struct Position {
uint pos;
bool Played;
int WhoPlayed;
}
uint[] one;
uint[] two;
uint[] three;
uint[] four;
uint[] five;
uint[] six;
uint[] seven;
uint[] eight;
mapping(address => Player) PlayersWhoPlayed;
mapping(address => Player) Winners;
mapping(address => Player) RegisterdPlayers;
uint Player1Count;
uint Player2Count;
uint BoardCount;
mapping(uint => Position) Player1Positions1;
mapping(uint => Position) Player2Positions1;
mapping(uint => Position) Board1;
uint RegisteredPlayerCount;
bool HasGameBeenSetUp = false;
Player P1;
Player P2;
function RegisterPlayer(string name, address playerAddress) public  returns(string) {

if (RegisterdPlayers[playerAddress].Registerd) {
return "Player Already Registered";
}
if(RegisteredPlayerCount == 2){
return "Only Two players can play at a time";
}
uint[] memory arr1 = new uint[](50);
uint[] memory arr = new uint[](50);
var player = Player(playerAddress,name, 0, arr1, true);
RegisterdPlayers[playerAddress] = player; // address of plyaer is the address of the contracts instance
if(RegisteredPlayerCount==0){
P1=player;
PlayersWhoPlayed[playerAddress]=P1;
}
else if(RegisteredPlayerCount ==1){
P2=player;
PlayersWhoPlayed[playerAddress]=P2;
}
RegisteredPlayerCount = RegisteredPlayerCount+1;
return "Registerd Player Successfully";
}

function SetUpGame() public returns(string) {

if (HasGameBeenSetUp) return "Game Already SetUp";
Player1Count = 0;
Player2Count = 0;
BoardCount = 0;
one = new uint[](3);
two = new uint[](3);
three = new uint[](3);
four = new uint[](3);
five = new uint[](3);
six = new uint[](3);
seven = new uint[](3);
eight = new uint[](3);
one[0] = 1;
one[1] = 2;
one[2] = 3;
two[0] = 4;
two[1] = 5;
two[2] = 6;
three[0] = 7;
three[1] = 8;
three[2] = 9;
four[0] = 1;
four[1] = 4;
four[2] = 7;
five[0] = 2;
five[1] = 5;
five[2] = 8;
six[0] = 3;
six[1] = 6;
six[2] = 9;
seven[0] = 1;
seven[1] = 5;
seven[2] = 9;
eight[0] = 3;
eight[1] = 5;
eight[2] = 7;
HasGameBeenSetUp = true;
return "Successfully Setup board";
}

function GetPlayerStats(address ID) public  returns(string, uint, uint[] a2) {
if (!RegisterdPlayers[ID].Registerd) {
return ("User does not exist", 0, a2);
}
return (RegisterdPlayers[ID].Name, RegisterdPlayers[ID].NoOfWins, RegisterdPlayers[ID].Winnings);
}

function MakeMove(uint Pos, uint WhichPlayer) public  returns(string) {
if (!HasGameBeenSetUp|| RegisteredPlayerCount ==0) {
return "Game hasnt been initialsied";
}
    if (WhichPlayer == 1) {
        if(BoardCount == 0){
        var p = Position(Pos, true, 1);
        Player1Positions1[Player1Count] = p;
        Board1[BoardCount] = p;
        BoardCount = BoardCount + 1;
        Player1Count = Player1Count + 1;
        return "Player 2's turn";    
        }
    for (uint i = 0; i < BoardCount; i++) {
                if (!Board1[i].Played) {
                    var p2 = Position(Pos, true, 1);
                    Player1Positions1[Player1Count] = p2;
                    Board1[BoardCount] = p2;
                    BoardCount = BoardCount + 1;
                    Player1Count = Player1Count + 1;
                    return "Player 2's turn";
                }
            }
            if (Player1Count > 2 || Player1Count > 2) {
                if(CheckForDrawOrWinner() == 1){
                P1.NoOfWins = P1.NoOfWins +1;    
                P1.PreviousOponents[P2.PlayerIdentifier]=P2;    
                RegisterdPlayers[P1.PlayerIdentifier]=P1;
                Winners[P1.PlayerIdentifier]=P1;
                return "Player 1 Wins";                    
                }
                if(CheckForDrawOrWinner() == 3)//Indicating a draw
                {
                    return "The Game has been drawn";
                }
            }
        }
    if (WhichPlayer == 2) {
        if(BoardCount == 0){
        var p1 = Position(Pos, true, 1);
        Player1Positions1[Player1Count] = p1;
        Board1[BoardCount] = p1;
        BoardCount = BoardCount + 1;
        Player1Count = Player1Count + 1;
        return "Player 2's turn";    
        }
            for (uint i2 = 0; i2 < BoardCount; i2++) {
                if (!Board1[i2].Played) {
                    var p3 = Position(Pos, true, 2);
                    Player2Positions1[Player2Count] = p3;
                    Board1[BoardCount] = p3;
                    Player2Count = Player2Count + 1;
                    BoardCount = BoardCount + 1;
                    return "Player 1's turn";
                }
            }
            if (Player1Count > 2 || Player2Count > 2) {
                if(CheckForDrawOrWinner() == 1){
                P2.NoOfWins = P2.NoOfWins +1;    
                P2.PreviousOponents[P1.PlayerIdentifier]=P1;    
                RegisterdPlayers[P2.PlayerIdentifier]=P2;
                Winners[P1.PlayerIdentifier]=P1;
                return "Player 2 Wins";                    
                }
                if(CheckForDrawOrWinner() == 3)//Indicating a draw
                {
                    ResetGame();
                    return "The Game has been drawn";
                }            
            }
        }
    }

    function CheckForDrawOrWinner() public  returns(uint)
    {
        if (Player1Positions1[0].pos == one[0] || Player1Positions1[1].pos == one[1] || Player1Positions1[2].pos == one[2]) {
            return 1;
        }
        if (Player1Positions1[0].pos == two[0] || Player1Positions1[1].pos == two[1] || Player1Positions1[2].pos == two[2]) {
            return 1;
        }
        if (Player1Positions1[0].pos == three[0] || Player1Positions1[1].pos == three[1] || Player1Positions1[2].pos == three[2]) {
            return 1;
        }
        if (Player1Positions1[0].pos == four[0] || Player1Positions1[1].pos == four[1] || Player1Positions1[2].pos == four[2]) {
            return 1;
        }
        if (Player1Positions1[0].pos == five[0] || Player1Positions1[1].pos == five[1] || Player1Positions1[2].pos == five[2]) {
            return 1;
        }
        if (Player1Positions1[0].pos == six[0] || Player1Positions1[1].pos == six[1] || Player1Positions1[2].pos == six[2]) {
            return 1;
        }
        if (Player1Positions1[0].pos == seven[0] || Player1Positions1[1].pos == seven[1] || Player1Positions1[2].pos == seven[2]) {
            return 1;
        }
        if (Player1Positions1[0].pos == eight[0] || Player1Positions1[1].pos == eight[1] || Player1Positions1[2].pos == eight[2]) {
            return 1;
        }
        if (Player2Positions1[0].pos == one[0] || Player2Positions1[1].pos == one[1] || Player2Positions1[2].pos == one[2]) {
            return 2;
        }
        if (Player2Positions1[0].pos == two[0] || Player2Positions1[1].pos == two[1] || Player2Positions1[2].pos == two[2]) {
            return 2;
        }
        if (Player2Positions1[0].pos == three[0] || Player2Positions1[1].pos == three[1] || Player2Positions1[2].pos == three[2]) {
            return 2;
        }
        if (Player2Positions1[0].pos == four[0] || Player2Positions1[1].pos == four[1] || Player2Positions1[2].pos == four[2]) {
            return 2;
        }
        if (Player2Positions1[0].pos == five[0] || Player2Positions1[1].pos == five[1] || Player2Positions1[2].pos == five[2]) {
            return 2;
        }
        if (Player2Positions1[0].pos == six[0] || Player2Positions1[1].pos == six[1] || Player2Positions1[2].pos == six[2]) {
            return 2;
        }
        if (Player2Positions1[0].pos == seven[0] || Player2Positions1[1].pos == seven[1] || Player2Positions1[2].pos == seven[2]) {
            return 2;
        }
        if (Player2Positions1[0].pos == eight[0] || Player2Positions1[1].pos == eight[1] || Player2Positions1[2].pos == eight[2]) {
            return 2;
        }
        uint Occupied = 0;
        for (uint i = 0; i < BoardCount; i++) {
            if (!Board1[i].Played) {
                Occupied = Occupied + 1;
            }
        }
        if (Occupied == 9) {
            return 3;
        }
        return 4; //Nothing
    }
    function ResetGame() public {
    RegisteredPlayerCount =0;
    delete P1;
    delete P2;
    HasGameBeenSetUp=false;
    BoardCount=0;
    for(uint i = 0;i< Player1Count;i++){
        delete Player1Positions1[i];
    }
    for(i = 0;i< Player2Count;i++){
        delete Player2Positions1[i];
    }
    Player1Count=0;
    Player2Count=0;
    }
}