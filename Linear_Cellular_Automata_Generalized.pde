import java.lang.*;
import java.util.*;

final int H = 400;
final int W = 1001;
final int P = 5;
final int C = (int)pow(2, P);

boolean[][] data = new boolean[H][W];
String[] ref = new String[C];
boolean[] curr = new boolean[C];
long now = 0;
float r = random(2147483647);

void setup() {
  size(1001, 400);
  background(0);
  startRef();
  data[0][W/2]=true;
}

void draw() {
  clear();
  stroke(255);
  rect(W/2, 0, 1, 1);
  stroke(255);
  r = random(2147483647);
  now=(long)(map(r, 0, 2147483647, 0, pow(2, C)));
  startCurr(now);

  for (int i=1; i<H; i++) {
    String selected = "";
    for (int j=0; j<W; j++) {
      if (j<=0+P/2 || j>=W-P/2) { 
        for (int k=0; k<0+P/2; k++) {
          if (k==j) {
            for (int l=0; l<P/2-k; l++)selected += "0";
            for (int l=0-k; l<P/2; l++)selected += bToS(data[i-1][j+l]);
          }
        }
        for (int k=W-P/2; k<W; k++) {
          if (k==j) {
            for (int l=-(P/2); l<W-k; l++)selected += bToS(data[i-1][j+l]);
            for (int l=0; l<P/2-W+k+1; l++)selected += "0";
          }
        }
      } else {
        selected = "";
        for (int k=-(P/2); k<=P/2; k++)selected += bToS(data[i-1][j+k]);
      }
      for (int k=0; k<C; k++) {
        if (selected.equals(ref[k]))data[i][j]=curr[k];
      }
      if (data[i][j])rect(j, i, 1, 1);
    }
  }
  //now++;
  fill(0, 255, 0);
  text("#" + String.valueOf(now), 0, 10);
  //saveFrame(""+"5_"+String.valueOf(now)+".png");
}


public void startRef() {
  for (int i=0; i<C; i++) {
    String temp = "";
    temp=Integer.toBinaryString(i);
    while (temp.length()<P)temp="0"+temp;
    ref[i]=temp;
  }
}

public void startCurr(long in) {
  String temp = "";
  curr = new boolean[C];
  temp=Long.toBinaryString(in);
  while (temp.length()<C)temp="0"+temp;
  for (int i=0; i<C; i++) {
    if (temp.substring(i, i+1).equals("1"))curr[i]=true;
  }
}

public String bToS(boolean in) {
  if (in) {
    return("1");
  } else {
    return("0");
  }
}
