settings.render=-2;
unitsize(0.75cm);

defaultpen(font("OT1","cmss","m","it"));

void folder(Label l, pair pos=(0,0))
{
  draw(shift(pos)*((0,1)--(0,0)--(-1.5,0)--(-1.5,1)--cycle
                   --(-0.1,1.1)--(-0.3,1.1)--(-0.4,1)));
  label(l, pos+(0,0.5), E);
}

void connector(pair start, real h)
{
  pair p1 = (start.x,start.y-h);
  pair p2 = p1 + (0.4, 0);
  draw(shift(-0.75,0)*(start--p1--p2));
}

void file(Label l, pair pos)
{
  label(l, pos+(-0.75+0.4,0), E);
}

folder("$<$case$>$");

connector((0,0),1);
folder("system", (1.5,-1.5));
connector((1.5,-1.5),0.75);
file("controlDict", (1.5, -2.25));
connector((1.5,-2.25),0.75);
file("fvSchemes", (1.5, -3));
connector((1.5,-3),0.75);
file("fvSolution", (1.5, -3.75));

connector((0,0),4.75);
folder("constant", (1.5,-5.25));
connector((1.5,-5.25),0.75);
file("...Properties", (1.5, -6));

connector((1.5,-6),1);
folder("polyMesh", (3,-7.5));
connector((3,-7.5),0.75);
file("points", (3, -8.25));
connector((3,-8.25),0.75);
file("cells", (3, -9));
connector((3,-9),0.75);
file("faces", (3, -9.75));
connector((3,-9.75),0.75);
file("boundary", (3, -10.5));

connector((0,0),11.5);
folder("\emph{$<$time directories$>$}", (1.5,-12));
