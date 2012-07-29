import three;

settings.render = 0;
settings.prc = false;
settings.gsOptions="-r144x144";
size(11cm);
currentprojection=obliqueZ();

Z /= 2;

triple[] corners = {
  Z,
  X+Z,
  X,
  (X+Z)/2+Y,
};
pair[] corner_pos = {
  SW, SE, E, N,
};

triple[] face_centers = {
    (corners[1]+corners[2]+corners[3])/3,
    (corners[0]+corners[3]+corners[2])/3,
    (corners[0]+corners[1]+corners[3])/3,
    (corners[0]+corners[2]+corners[1])/3,
};

int[][] edges = {
    {0, 1},
    {0, 2},
    {0, 3},
    {3, 1},
    {1, 2},
    {3, 2},
};

pen[] edge_styles = {
  black,
  dashed,
  black,
  black,
  black,
  black,
};

pair[] edge_pos = {
  S, N, W, E, E, E,
};

picture tet()
{
  picture pic = new picture;
  for(int i=0; i<edges.length; ++i)
  {
    draw(pic, corners[edges[i][0]]--corners[edges[i][1]], edge_styles[i]);
  }
  return pic;
}

picture pic1 = tet();
picture pic3 = tet();
picture pic2 = tet();

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