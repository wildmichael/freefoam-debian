size(18cm);

settings.render = -3;

defaultpen(font("OT1","cmss","m","n"));

transform[] shifts = {
    shift( 0,   0),
    shift( 0, -36.5),
    shift(40,   0),
    shift(40, -20.5),
    shift(40, -36.5),
  };

pair[][] boxes   = {
    {shifts[0]*(0 ,0),shifts[0]*(21, -21  )},  // newApp.C
    {shifts[1]*(0 ,0),shifts[1]*(21,  -5.5)},  // newApp
    {shifts[2]*(0 ,0),shifts[2]*(37, -18.5)},  // nc.H
    {shifts[3]*(0 ,0),shifts[3]*(37, -14  )},  // nc.C
    {shifts[4]*(0 ,0),shifts[4]*(37,  -5.5)},  // libnc.so
  };

string[] labels = {
  minipage(
      "\emph{newApp.C}\\
      \tt\#include <nc/nc.H>\\
      int main()\\
      \{\\
      ...\\
      ...\\
      return(0);\\
      \}", 200),
  minipage(
      "\emph{newApp}\\
      Executable", 200),
  minipage(
      "\emph{nc/nc.H}\\
      \tt// Declaration of class nc\\
      class nc\\
      \{\\
      ...\\
      ...\\
      \};", 200),
  minipage(
      "\emph{nc/nc.C}\\
      \tt\#include \"nc.H\"\\
      // Definition of class nc members\\
      ...\\
      ...", 250),
  minipage(
      "\emph{libnc.so}\\
      Library", 200),
};

for(int i=0; i<boxes.length; ++i)
{
  draw(box(boxes[i][0],boxes[i][1]));
  label(labels[i], boxes[i][0], SE);
}

pair p1 = (boxes[2][0].x, (boxes[2][0]+boxes[2][1]).y/2);
pair p2 = (boxes[0][1].x, p1.y);
path a1 = p1--p2;
pair p3 = point(a1,0.15);
pair p4 = (p3.x, (boxes[3][0]+boxes[3][1]).y/2);
pair p5 = (boxes[3][0].x,p4.y);
real off = abs(boxes[2][0].x - p3.x);
pair p6 = (boxes[0][0].x, (boxes[0][0]+boxes[0][1]).y/2);
pair p7 = p6-(off,0);
pair p9 = (boxes[1][0].x, (boxes[1][0]+boxes[1][1]).y/2);
pair p8 = p9-(off,0);
pair p10 = (boxes[3][1].x, (boxes[3][0]+boxes[3][1]).y/2);
pair p11 = p10+(off,0);
pair p13 = (boxes[4][1].x, (boxes[4][0]+boxes[4][1]).y/2);
pair p12 = p13+(off,0);
pair p14 = (boxes[1][1].x, (boxes[1][0]+boxes[1][1]).y/2);
pair p15 = (boxes[4][0].x, (boxes[4][0]+boxes[4][1]).y/2);

draw(a1,Arrow);
label("Inclusion", point(a1, 0.5), N);
draw(p3--p4--p5,Arrow);
draw(p6--p7--p8--p9,Arrow);
label(rotate(90)*"Compilation", (p7+p8)/2, W);
draw(p10--p11--p12--p13,Arrow);
label(rotate(-90)*"Compilation", (p11+p12)/2, E);
draw(p14--p15,Arrow);
label("Linking", (p14+p15)/2, N);
