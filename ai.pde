import java.util.*;
import java.io.*;
class ai
{
  private ArrayList<boardState> boards = new ArrayList<boardState>();
  private ArrayList<boardState> boardTrack = new ArrayList<boardState>();
  private ArrayList<Integer> playTrack = new ArrayList<Integer>();

  void loadBoardStates() 
  {
  }

  void saveBoardStates()
  {
    if (turn == 0)
    {
      for (int i = 0; i < boardTrack.size(); i++)
        boardTrack.get(i).addProbability(playTrack.get(i));
    }
  }


  void makeMove(pawn[] a)
  {
    boolean bol = false;
    for (boardState b : boards)
    {
      if (b.compare(a))
      {
        boardTrack.add(b);
        playTrack.add(b.chooseMove());
        bol = true;
      }
    }
    if (!bol)
    { 
      boards.add(new boardState(createArray(a), createProbability()));
      makeMove(a);
    }
  }


  pawn[] createArray(pawn[] a)
  {
    pawn[] temp = new pawn[a.length];
    for (int i = 0; i < temp.length; i++)
    {
      temp[i] = a[i];
    }
    return temp;
  }

  ArrayList<Integer> createProbability()
  {
    int c = 0;
    for (int i = 0; i <= 8; i++)
    {
      for (int j = 0; j <= 8; j++)
      {
        if (validMove(i, j))
          c++;
      }
    }
    ArrayList<Integer> temp = new ArrayList<Integer>();
    for (int i = 0; i < c; i ++)
      temp.add(i);
    return temp;
  }
}
