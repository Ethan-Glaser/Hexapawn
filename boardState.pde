import java.util.*;
class boardState 
{
  pawn[] board = new pawn[9];
  private ArrayList<Integer> probability = new ArrayList<Integer>();
  public boardState(pawn[] p, ArrayList<Integer> i)
  {
    board = p;
    probability = i;
  }

  boolean compare(pawn[] arr)
  {
    boolean b = true;
    for (int i = 0; i < arr.length; i++)
    {

      if ((board[i] == null && arr[i] != null) || (board[i] != null && arr[i] == null)) //<>//
        b = false;
      else if (board[i] == null && arr[i] == null)
      {
      }
      else if (board[i].getTeam() != arr[i].getTeam())
        b = false;
    }
    return b;
  }
  

  int chooseMove()
  {
    int r = probability.remove((int)(Math.random() * probability.size()));
    int c =0;
    for (int i = 0; i <= 8; i++)
    {
      for (int j = 0; j <= 8; j++)
      {
        if (validMove(i, j))
        {
          if (r == c)
            movePiece(i, j);
          c++;
        }
      }
    }
    return r;
  }
  
  void addProbability(int x)
  {
    probability.add(x);
    probability.add(x);
  }
  
  
  
  
}
