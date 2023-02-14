public class Vertx {
  private int generation;
  private float xPos, yPos;
  private ArrayList <Triangle> associatedTriangles = new ArrayList <Triangle>();
  public Vertx(float x, float y) {
    xPos = x;
    yPos = y;
    generation = 0;
  }
  public Vertx(float x, float y, int gen) {
    xPos = x;
    yPos = y;
    generation = gen;
  }
  public void show() {
    stroke(255);
    strokeWeight(25);
    point(xPos,yPos);
  }
  public void setX(float x) {
    xPos = x;
  }
  public void setY(float y) {
    yPos = y;
  }
  public float getX() {
    return xPos;
  }
  public float getY() {
    return yPos;
  }
  public int getGen() {
    return generation;
  }
  public void addTriangle(Triangle triangle) {
    associatedTriangles.add(triangle);
  }
  public void removeTriangle(Triangle triangle) {
    associatedTriangles.remove(associatedTriangles.indexOf(triangle));
  }
  public ArrayList <Triangle> getTriangles() {
    return associatedTriangles;
  }
  
}
