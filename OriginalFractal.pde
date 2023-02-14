int iterations = 6;
Triangle mainTriangle;
public void setup() {
  size(800, 800);
  mainTriangle = new Triangle(new Vertx(400, 50), new Vertx(50, 750), new Vertx(750, 750));
  createSierpinskiDual(mainTriangle);
  mainTriangle.getVertx()[0].addTriangle(mainTriangle);
  mainTriangle.getVertx()[1].addTriangle(mainTriangle);
  mainTriangle.getVertx()[2].addTriangle(mainTriangle);
  frameRate(12);
}

public void draw() {
  fill(0);
  rect(0, 0, width, height);
  splitTriangle(iterations, mainTriangle);
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
  Vertx ur = new Vertx((u.getX()+dr.getX())/2, (u.getY()+dr.getY())/2, u.getGen()+1);
  Vertx ul = new Vertx((dl.getX()+u.getX())/2, (dl.getY()+u.getY())/2, u.getGen()+1);
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
