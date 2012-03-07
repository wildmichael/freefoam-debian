import three;

settings.render = 0;
settings.prc = false;
settings.gsOptions="-r144x144";
size(11cm);
currentprojection=obliqueZ();

Z /= 2;

triple[] corners = {
  Z,   X+Z,   X,   O,
  Y+Z, X+Y+Z, X+Y, Y
};
pair[] corner_pos = {
  SW, SE, SE, NW,
  NW, SE, NE, NW
};

triple[] faces = {
  (corners[0]+corners[4]+corners[7]+corners[3])/4,
  (corners[1]+corners[2]+corners[6]+corners[5])/4,
  (corners[0]+corners[1]+corners[5]+corners[4])/4,
  (corners[2]+corners[3]+corners[7]+corners[6])/4,
  (corners[0]+corners[3]+corners[2]+corners[1])/4,
  (corners[4]+corners[5]+corners[6]+corners[7])/4,
};

triple[] edges = {
  (corners[0]+corners[1])/2,
  (corners[2]+corners[3])/2,
  (corners[6]+corners[7])/2,
  (corners[4]+corners[5])/2,
  (corners[0]+corners[3])/2,
  (corners[1]+corners[2])/2,
  (corners[5]+corners[6])/2,
  (corners[4]+corners[7])/2,
  (corners[0]+corners[4])/2,
  (corners[1]+corners[5])/2,
  (corners[2]+corners[6])/2,
  (corners[3]+corners[7])/2,
};

pair[] edge_pos = {
  S, N, N, S,
  N, S, S, N,
  W, E, E, E
};

picture cube()
{
  picture pic = new picture;
  draw(pic, Z--O--X^^O--Y, dashed);
  draw(pic, Z--X+Z--X+Z+Y--Z+Y--cycle^^
       X+Z--X--X+Y--X+Y+Z^^
       Y+Z--Y--X+Y);
  return pic;
}

picture pic1 = cube();
picture pic3 = cube();
picture pic2 = cube();

for(int i=0; i<corners.length; ++i)
{
  label(pic1, format("$%d$", i), corners[i], corner_pos[i]);
}
for(int i=0; i<faces.length; ++i)
{
  label(pic2, format("$%d$", i), faces[i]);
}
for(int i=0; i<edges.length; ++i)
{
  label(pic3, format("$%d$", i), edges[i], edge_pos[i]);
}

add(pic1);
add(shift(1.5X)*pic2);
add(shift(3X)*pic3);
