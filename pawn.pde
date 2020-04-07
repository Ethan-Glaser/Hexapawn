class pawn
{
  private int xCord;
  private int yCord;
  private int team;
  private PImage p;
  public pawn(int a, int b, int c)
  {
    xCord = a;
    yCord = b;
    team = c;
    p= loadImage("pawn" + team + ".png");
  }
  
  public void display()
  {
    imageMode(CENTER);
    p.resize(200,200);
    image(p, 100 + 200*xCord, 100 + 200 * yCord);
  }
  public int getTeam()
  {
    return team;
  }
  public int getX()
  {
    return xCord;
  }
  public int getY()
  {
    return yCord;
  }
  public void setX(int a)
  {
    xCord =a;
  }
  public void setY(int a)
  {
    yCord = a;
  }
  public String toString()
  {
    return(xCord + " " + yCord);
  }
}