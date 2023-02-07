
public class layer {
  private float x1, x2, x3;
  private float y1, y2, y3;
  
  public layer(float xx1, float yy1, float xx2, float yy2, float xx3, float yy3) {
  }
  
  public void show() {
  }
  
}

public void setup() {
  size(800,800);
  background(0);
  stroke(255);
  fill(0,0);
  strokeWeight(3);
  rough(1,new float[] {200,300,100,700,750,750});
}

public void rough(int n, float[] ordPairs) {
  if (n > 0) {
    float[] compPairs = new float[] {
    (ordPairs[0]+ordPairs[2])/2,(ordPairs[1]+ordPairs[3])/2,
    (ordPairs[2]+ordPairs[4])/2,(ordPairs[3]+ordPairs[5])/2,
    (ordPairs[4]+ordPairs[0])/2,(ordPairs[5]+ordPairs[1])/2,    
  };
    triangle(
      ordPairs[0],ordPairs[1],
      ordPairs[2],ordPairs[3],
      ordPairs[4],ordPairs[5]
    );
    triangle(
      compPairs[0],compPairs[1],
      compPairs[2],compPairs[3],
      compPairs[4],compPairs[5]
    );
    rough(n-1, new float[] {ordPairs[0],ordPairs[1]});
    rough(n-1, new float[] {ordPairs[2],ordPairs[3]});
    rough(n-1, new float[] {ordPairs[4],ordPairs[5]});
  }
}
