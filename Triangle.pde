public class Triangle {
  protected Vertx u, dl, dr;
  protected Vertx d, ur, ul;
  public Triangle(Vertx a, Vertx b, Vertx c) {
    u = a;
    dl = b;
    dr = c;
  }
  
  public void drawTriangle() {
    noStroke();    
    fill(255-10*u.getGen(),125-10*u.getGen(),165-10*u.getGen(),200);
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
