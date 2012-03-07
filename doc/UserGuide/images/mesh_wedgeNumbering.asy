import three;

settings.render = 0;
settings.prc = false;
settings.gsOptions="-r144x144";
size(11cm);
currentprojection=obliqueZ();

Z /= 2;

triple[] corners = {
  Z,   X+Z,   X,
  Y+Z, X+Y+Z, X+Y, Y
};
pair[] corner_pos = {
  SW, SE, SE,
  NW, SE, NE, NW
};

triple[] face_centers = {
  (corners[0]+corners[2]+corners[1])/3,
  (corners[3]+corners[4]+corners[5]+corners[6])/4,
  (corners[0]+corners[3]+corners[6])/3,
  (corners[1]+corners[2]+corners[5]+corners[4])/4,
  (corners[0]+corners[1]+corners[4]+corners[3])/4,
  (corners[0]+corners[6]+corners[5]+corners[2])/4,
};

int[][] edges = {
  {0, 1},
  {1, 2},
  {0, 2},
  {0, 3},
  {0, 6},
  {2, 5},
  {1, 4},
  {3, 4},
  {3, 6},
  {4, 5},
  {5, 6},
};

pen[] edge_styles = {
  black,
  black,
  dashed,
  black,
  dashed,
  black,
  black,
  black,
  black,
  black,
  black
};

pair[] edge_pos = {
  S, S, N,
  W, NW, E, E,
  S, N, S, N
};

picture wedge()
{
  picture pic = new picture;
  for(int i=0; i<edges.length; ++i)
  {
    draw(pic, corners[edges[i][0]]--corners[edges[i][1]], edge_styles[i]);
  }
  return pic;
}

picture pic1 = wedge();
picture pic3 = wedge();
picture pic2 = wedge();

for(int i=0; i<corners.length; ++i)
{
  label(pic1, format("$%d$", i), corners[i], corner_pos[i]);
}
for(int i=0; i<face_centers.length; ++i)
{
  label(pic2, format("$%d$", i), face_centers[i]);
}
for(int i=0; i<edges.length; ++i)
{
  triple c = (corners[edges[i][0]]+corners[edges[i][1]])/2;
  label(pic3, format("$%d$", i), c, edge_pos[i]);
}

add(pic1);
add(shift(1.5X)*pic2);
add(shift(3X)*pic3);
