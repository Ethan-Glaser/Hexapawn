pawn Board[] = new pawn[9];
int score[]= {0,0};
int turn = 1;
int delay = 0;
int startBox =-1; 
int finishBox = -1;
String screen = "startScreen";
ai Ethan = new ai();
void setup()
{
  size(600, 600);
  rectMode(CENTER);
  textAlign(CENTER);
  resetBoard();
}


void resetBoard()
{
  int c= 0;
  for (int i = 0; i < 3; i++)
  {
    for (int j = 0; j < 3; j++)
    {
      if (i ==0)
        Board[c] = new pawn(j, i, 0);
      else if (i ==2)
        Board[c] = new pawn(j, i, 1);
      else
        Board[c] = null;

      c++;
    }
  }
}

//----------------------------------------------------------------------------------------------------------------------------------------------------------------------

void draw()
{
  if (screen.equals("startScreen"))
    startScreenDisplay();
  else if (screen.equals("gameScreen"))
    gameScreenDisplay();
  else if (screen.equals("resetScreen"))
    resetScreenDisplay();
}

void startScreenDisplay()
{
  clear();
  background(255);
  fill(0);
  textSize(60);
  text("HexaPawn", 300, 100);
  textSize(40);
  text("Rules", 300, 200);
  textSize(14);
  text("HexaPawn is like regular chess, but on a 3x3 grid and only with pawns. \nThe pawns move like in the normal game of chess, foward if the space is free\n or "+
  "diaginal if there is an enemy pawn. The game is over when either a player\n has no moves to make, or a player gets their pawn to the other side of the board"
  , 300, 300);
  rect(300, 500, 300, 100);
  fill(255);
  textSize(32);
  text("Play Game", 300, 500);
}


void gameScreenDisplay()
{
  clear();
  for (int i = 0; i < 3; i++)
  {
    for (int j = 0; j < 3; j++)
    {
      if ((i% 2 ==0 && j % 2 ==0) || (i% 2 ==1 && j%2 ==1))
        fill(0);
      else
        fill(255);
      rect(100 +200*i, 100 +200*j, 200, 200);
    }
  }
  for (pawn p : Board)
  {
    if (p != null)
      p.display();
  }
  if(turn == 0 && !gameOver())
     Ethan.makeMove(Board);
  if(delay>0)
  {
    if(delay == 2 && turn ==1)
    {
      delay(250);
      delay =0;
      screen = "resetScreen";
    }
    else if(delay == 3)
    {
      delay(500);
      delay =0;
      screen = "resetScreen";
    }
    else
      delay++;
  }
   
}




void resetScreenDisplay()
{
  clear();
  textSize(32);
  background(255);
  fill(0);
  text("Game over", 300, 200);
  if (turn ==0)
    text("Black won", 300, 250);
  else
    text("White won", 300, 250);
  text("Score", 300, 300);
  text("Black: "+score[0]+" to White: "+score[1], 300, 350);
  rect(300, 500, 300, 100);
  fill(255);
  text("Play Again", 300, 500);
}

//---------------------------------------------------------------------------------------------------------------------------------------------------------------------
void mouseClicked()
{
  if (screen.equals("startScreen"))
    startScreenAction();
  else if (screen.equals("gameScreen"))
    gameScreenAction();
  else if (screen.equals("resetScreen"))
    resetScreenAction();
}

void startScreenAction()
{
  if (mouseX > 150 && mouseX < 450 && mouseY > 400 && mouseY < 600)
    screen = "gameScreen";
}

void gameScreenAction()
{
  if (startBox == -1)
    startBox = calcBox();
  else
  {
    finishBox = calcBox();
    if (validMove(startBox, finishBox)) 
    
      movePiece(startBox, finishBox);
     else
      System.out.println("Enter in a Valid Move");
    startBox = -1;
  }
}

void resetScreenAction()
{
  Ethan.saveBoardStates();
  if (mouseX > 150 && mouseX < 450 && mouseY > 400 && mouseY < 600)
  { 
    turn = 1;
    startBox =-1; 
    finishBox = -1;
    resetBoard();
    screen = "gameScreen";
  }
}


//-------------------------------------------------------------------------------------------------------------------------------------------------------------------------

boolean gameOver()
{
  if (turn == 1 && (Board[0] != null && Board[0].getTeam() == 1 ||Board[1] != null && Board[1].getTeam() == 1 ||Board[2] != null && Board[2].getTeam()==1 ))
    return true;
  else if (turn == 0 && (Board[6] != null &&Board[6].getTeam() == 0 ||Board[7] != null && Board[7].getTeam() == 0 || Board[8] != null &&Board[8].getTeam()==0 ))
    return true;
  if (!checkForValid())
    return true;
  boolean t1 = true;
  boolean t2 = true;
  for (pawn i : Board)
  {
    if (i != null)
    {
      if (i.getTeam() == 1)
        t1 = false;
      if (i.getTeam() == 1)
        t2 = false;
    }
  }
  return( t1 && t2);
}

void movePiece(int a, int b)
{
  Board[b] = Board[a];
  Board[a] = null;
  Board[b].setX(b % 3);
  Board[b].setY(b / 3);
  if (gameOver())
  { 
    delay = 1;
    score[turn]++;
  }
  else
    turn = (turn +1) %2;
}


boolean checkForValid()
{
  for (int i = 0; i <= 8; i++)
  {
    for (int j = 0; j <= 8; j++)
    {
      if (validMove(i, j))
        return true;
    }
  }
  return false;
}


boolean validMove(int s, int e)
{
  if (turn == 1 && (Board[s] == null || Board[s].getTeam() != turn || s < e))
   return false;
  if (turn == 0 && (Board[s] == null || Board[s].getTeam() != turn || s > e))
    return false;
  if (Math.abs(s-e)==3 && Board[e] == null)
    return true;
  if (Math.abs(s % 3 - e % 3) ==1 && (Math.abs(s-e)==4 || Math.abs(s-e)==2)  &&  Board[e] != null && Board[e].getTeam() != turn)
    return true;
  return false;
}

int calcBox()
{
  int xBox, yBox;
  xBox = (mouseX/200 % 3);
  yBox = (mouseY/200 % 3);
  return( 3 * yBox +xBox);
}
