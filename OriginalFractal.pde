int definition = 4;
public class Vertx {
  private float xPos, yPos;
  private int iteration, placement;
  private Vertx[] parents;
  public Vertx(float x, float y) {
    xPos = x;
    yPos = y;
  }
  public Vertx(Vertx parent1,Vertx parent2) {
    xPos = (parent1.getX() + parent2.getX())/2;
    yPos = (parent1.getY() + parent2.getY())/2;
    iteration = parent1.getIteration()+1;
    parents = new Vertx[] {parent1,parent2};
  };

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
  public int getIteration() {
    return iteration;
  }
  public int getPlacement() {
    return iteration;
  }
  public void setIteration(int itn) {
    iteration = itn;
  }
  public void setPlacement(int pmt) {
    placement = pmt;
  }  
}
public class Triangle {
  private Vertx vC,vB,vA;
  private Vertx[] dual;
  public void Triangle(Vertx c, Vertx b, Vertx a) {
    vC = c;
    vB = b; // c@12'00; b@8'00; a@4'00
    vA = a;
    dual[0] = new Vertx(vC,vB);
    dual[1] = new Vertx(vC,vA);
    dual[2] = new Vertx(vB,vA);
  }
  
}


ArrayList <Vertx> vertexes = new ArrayList <Vertx>();
public void setup() {
  size(800, 800);
  frameRate(12);
}

public void draw() {
  fill(0,200);
  rect(0,0,width,height);
  //strokeWeight(25);
  //fill(255);
  //stroke(255);
  //line(0,800,30,0);
  stroke(255);
  strokeWeight(3/definition);    //^x, ^y, <x, <y, >x, >y  
  rough(definition, new float[] {200, 100, 100, 500, 700+(float)(Math.random()-0.5)*75, 450+(float)(Math.random()-0.5)*150});
}

public void rough(int n, float[] ordPairs) {
  float[] compPairs = {
    (ordPairs[0]+ordPairs[2])/2, (ordPairs[1]+ordPairs[3])/2, // Fx, Fy
    (ordPairs[4]+ordPairs[0])/2, (ordPairs[5]+ordPairs[1])/2, // 7x, 7y
    (ordPairs[2]+ordPairs[4])/2, (ordPairs[3]+ordPairs[5])/2, // vx, vy  
  };
  if (n > 0) {

    for (int i = 0; i < compPairs.length; i++) {
      compPairs[i] += (Math.random()-0.5)*pow(2,n+2);
    }

    rough(n-1, compPairs);
    rough(n-1, new float[] {ordPairs[0], ordPairs[1], compPairs[0], compPairs[1], compPairs[2], compPairs[3]});
    rough(n-1, new float[] {compPairs[0], compPairs[1], ordPairs[2], ordPairs[3], compPairs[4], compPairs[5]});
    rough(n-1, new float[] {compPairs[2], compPairs[3], compPairs[4], compPairs[5], ordPairs[4], ordPairs[5]});
  } else {
    fill(255-ordPairs[1]*255/width,200);
    line(
      ordPairs[0], ordPairs[1], 
      ordPairs[2], ordPairs[3]
      );
    line(
      ordPairs[2], ordPairs[3], 
      ordPairs[4], ordPairs[5]
      );
    line(
      ordPairs[0], ordPairs[1], 
      ordPairs[4], ordPairs[5]
      );      
    triangle(
      ordPairs[0], ordPairs[1], 
      ordPairs[2], ordPairs[3], 
      ordPairs[4], ordPairs[5]    
    );
  }
}
