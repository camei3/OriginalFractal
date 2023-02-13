public class Triangle {
  private Vertx u, dl, dr;
  private Vertx d, ur, ul;
  public Triangle(Vertx a, Vertx b, Vertx c) {
    u = a;
    dl = b;
    dr = c;
  }
  
  public void drawTriangle() {
    strokeWeight(3);
    triangle(u.getX(), u.getY(), dl.getX(), dl.getY(), dr.getX(), dr.getY());
  }
  public Vertx[] getVertx() {
    return new Vertx[] {u,dl,dr};
  }
  public Vertx[] getDualVertx() {
    return new Vertx[] {d, ur, ul};
  }
  public void storeDual(Vertx a, Vertx b, Vertx c) {
    d = a;
    ur = b;
    ul = c;
  }
}
