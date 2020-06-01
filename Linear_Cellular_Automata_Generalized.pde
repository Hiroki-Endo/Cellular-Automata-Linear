import java.lang.*;
import java.util.*;
import java.math.*;

final BigInteger BASETWO = new BigInteger("2");
final int H = 400;
final int W = 1001;
final int P = 7;
final int C = (int)pow(2, P);
final BigInteger E = BASETWO.pow(C);

boolean[][] data = new boolean[H][W];
String[] ref = new String[C];
boolean[] curr = new boolean[C];
BigInteger now;
String temp = "";

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
  now = nextRandomBigInteger(E);
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

public void startCurr(BigInteger in) {
  curr = new boolean[C];
  temp="";
  print2Binaryform(in);
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

public BigInteger nextRandomBigInteger(BigInteger n) {
  Random rand = new Random();
  BigInteger result = new BigInteger(n.bitLength(), rand);
  while ( result.compareTo(n) >= 0 ) {
    result = new BigInteger(n.bitLength(), rand);
  }
  return result;
}

public void print2Binaryform(BigInteger in) {
  BigInteger result;
  if (in.compareTo(BigInteger.ONE)<=0) {
    temp+=in;
    return;
  }
  result = in.mod(new BigInteger(""+2));
  print2Binaryform(new BigInteger(""+in.divide(new BigInteger("2"))));
  temp+=result;
}
