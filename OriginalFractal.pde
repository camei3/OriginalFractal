final int ITERATIONS = 5;
Triangle mainTriangle, flagTriangle;
public void setup() {
  size(800, 800);

  frameRate(8);
}

public void draw() {
  mainTriangle = new Triangle(
    new Vertx(75+(float)(Math.random()-0.5)*25, 200+(float)(Math.random()-0.5)*25), 
    new Vertx(150+(float)(Math.random()-0.5)*50, 600+(float)(Math.random()-0.5)*50), 
    new Vertx(700+(float)(Math.random()-0.5)*100, 250+(float)(Math.random()-0.5)*100));
  createSierpinskiDual(mainTriangle);
  mainTriangle.getVertx()[0].addTriangle(mainTriangle);
  mainTriangle.getVertx()[1].addTriangle(mainTriangle);
  mainTriangle.getVertx()[2].addTriangle(mainTriangle);  
  fill(0);
  rect(0, 0, width, height);  
  strokeWeight(25);
  stroke(125, 65, 0);
  Vertx point0 = mainTriangle.getVertx()[0];
  Vertx point1 = mainTriangle.getVertx()[1];  
  line(
    point0.getX(), point0.getY(), 
    point0.getX() + (point1.getX()-point0.getX())/(point1.getY()-point0.getY())*700 , point0.getY() + 700
    );

  splitTriangle(ITERATIONS, mainTriangle);
}

public void mouseClicked() {
  System.out.println(mouseX + "\n" + mouseY);
}

public void splitTriangle(int n, Triangle triangle) {
  if (n > 1) {

    Triangle newU, newDL, newDR, newC;
    Vertx u = triangle.getVertx()[0];
    Vertx dl = triangle.getVertx()[1];
    Vertx dr = triangle.getVertx()[2];
    Vertx d = triangle.getDualVertx()[0];
    Vertx ur = triangle.getDualVertx()[1];
    Vertx ul = triangle.getDualVertx()[2];

    if (triangle instanceof InvTriangle) {
      newC = new Triangle(d, ur, ul);
      createSierpinskiDual(newC);

      ul.addTriangle(newC);
      ur.addTriangle(newC);
      d.addTriangle(newC);

      splitTriangle(n-1, newC);

      newU = new InvTriangle(u, ul, ur);
      newU.storeDual(newC.getDualVertx()[0], searchTriVertx(ur, u).getDualVertx()[1], searchTriVertx(ul, u).getDualVertx()[2]);
      newDL = new InvTriangle(ul, dl, d);
      newDL.storeDual(searchTriVertx(d, dl).getDualVertx()[0], newC.getDualVertx()[1], searchTriVertx(ul, dl).getDualVertx()[2]);
      newDR = new InvTriangle(ur, d, dr);
      newDR.storeDual(searchTriVertx(d, dr).getDualVertx()[0], searchTriVertx(ur, dr).getDualVertx()[1], newC.getDualVertx()[2]);  

      splitTriangle(n-1, newU);
      splitTriangle(n-1, newDL);
      splitTriangle(n-1, newDR);
    } else {
      newU = new Triangle(u, ul, ur);
      createSierpinskiDual(newU);
      newDL = new Triangle(ul, dl, d);
      createSierpinskiDual(newDL);
      newDR = new Triangle(ur, d, dr);
      createSierpinskiDual(newDR);
      newC = new InvTriangle(d, ur, ul);
      newC.storeDual(newU.getDualVertx()[0], newDL.getDualVertx()[1], newDR.getDualVertx()[2]);
      ul.addTriangle(newU);
      ul.addTriangle(newDL);
      ul.addTriangle(newC);
      ur.addTriangle(newU);
      ur.addTriangle(newDR);
      ur.addTriangle(newC);
      d.addTriangle(newDL);
      d.addTriangle(newDR);
      d.addTriangle(newC);    

      splitTriangle(n-1, newU);
      splitTriangle(n-1, newDL);
      splitTriangle(n-1, newDR);    
      splitTriangle(n-1, newC);
    }
  } else {
    triangle.drawTriangle();
  }
}

public void createSierpinskiDual(Triangle triangle) {
  Vertx u = triangle.getVertx()[0];
  Vertx dl = triangle.getVertx()[1];
  Vertx dr = triangle.getVertx()[2];
  Vertx d = new Vertx((dl.getX()+dr.getX())/2, (dl.getY()+dr.getY())/2, u.getGen()+1);
  Vertx ur = new Vertx((u.getX()+dr.getX())/2, (u.getY()+dr.getY())/2, dl.getGen()+1);
  Vertx ul = new Vertx((dl.getX()+u.getX())/2, (dl.getY()+u.getY())/2, dr.getGen()+1);
  triangle.storeDual(d, ur, ul);
}

public Triangle searchTriVertx(Vertx child, Vertx matchee) {
  for (int i = 0; i < child.getTriangles().size(); i++) {
    for (Vertx j : child.getTriangles().get(i).getVertx()) {
      if (matchee == j) {
        return child.getTriangles().get(i);
      }
    }
  }
  return mainTriangle;
};
