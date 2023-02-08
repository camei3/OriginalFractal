int definition = 4;
public class layer {
  private float x1, x2, x3;
  private float y1, y2, y3;

  public layer(float xx1, float yy1, float xx2, float yy2, float xx3, float yy3) {
  }

  public void show() {
  }
}

public void setup() {
  size(800, 800);

  frameRate(12);
}

public void draw() {
  //strokeWeight(10);
  //fill(255);
  //line(0,800,30,0);
  background(0);  
  stroke(255);
  strokeWeight(3/definition);    //^x, ^y, <x, <y, >x, >y  
  rough(definition, new float[] {200, 300, 100, 700, 700+(float)(Math.random()-0.5)*75, 700+(float)(Math.random()-0.5)*75});
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
    fill(255-ordPairs[1]*255/width);
    triangle(
      ordPairs[0], ordPairs[1], 
      ordPairs[2], ordPairs[3], 
      ordPairs[4], ordPairs[5]
      );
  }
}
