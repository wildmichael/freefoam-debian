import three;

settings.render = 0;
settings.prc = false;
settings.gsOptions="-r144x144";
size(9.1cm);
currentprojection=obliqueZ();

Z /= 2;

triple[] corners = {
  Z,   X+Z,   X,   O,
  Y+Z, 1.2X+Y+Z, 1.3X+Y, Y
};
pair[] corner_pos = {
  SW, SE, SE, NW,
  NW, SE, NE, NW
};

// control point for the curved edge to go through
triple ctrl = (corners[1]+(corners[1].x,corners[5].y,corners[1].z))/2;

path3[] edges = {
  corners[0]--corners[1],
  corners[3]--corners[2],
  corners[7]--corners[6],
  corners[4]--corners[5],
  corners[0]--corners[3],
  corners[1]--corners[2],
  corners[5]--corners[6],
  corners[4]--corners[7],
  corners[0]--corners[4],
  corners[1]..ctrl..corners[5],
  corners[2]--corners[6],
  corners[3]--corners[7],
};

triple[] edge_points = {
  (corners[0]+corners[1])/2,
  (corners[2]+corners[3])/2,
  (corners[6]+corners[7])/2,
  (corners[4]+corners[5])/2,
  (corners[0]+corners[3])/2,
  (corners[1]+corners[2])/2,
  (corners[5]+corners[6])/2,
  (corners[4]+corners[7])/2,
  (corners[0]+corners[4])/2,
  ctrl,
  (corners[2]+corners[6])/2,
  (corners[3]+corners[7])/2,
};

pair[] edge_pos = {
  S, N, N, S,
  N, S, S, N,
  W, E, E, E
};

triple[] arr_off = {
  (edge_pos[0].x+0.7, edge_pos[0].y,      0  )/20,
  (edge_pos[1].x+0.7, edge_pos[1].y,      0  )/20,
  (edge_pos[2].x+0.7, edge_pos[2].y,      0  )/20,
  (edge_pos[3].x+0.7, edge_pos[3].y,      0  )/20,
  (edge_pos[4].x,     edge_pos[4].y,     -0.9)/20,
  (edge_pos[5].x,     edge_pos[5].y,     -0.9)/20,
  (edge_pos[6].x,     edge_pos[6].y,     -0.9)/20,
  (edge_pos[7].x,     edge_pos[7].y,     -0.9)/20,
  (edge_pos[8].x,     edge_pos[8].y+0.7,  0  )/20,
  (edge_pos[9].x,     edge_pos[9].y+0.7,  0  )/20,
  (edge_pos[10].x,    edge_pos[10].y+0.7, 0  )/20,
  (edge_pos[11].x,    edge_pos[11].y+0.7, 0  )/20,
};

draw(edges[1]^^edges[4]^^edges[11], dashed);
draw(edges[0]^^edges[2]^^edges[3]^^edges[5]^^edges[6]^^edges[7]^^edges[8]^^
     edges[9]^^edges[10]);

for(int i=0; i<corners.length; ++i)
{
  label(format("$%d$", i), corners[i], corner_pos[i]);
}
for(int i=0; i<edge_points.length; ++i)
{
  label(format("$%d$", i), edge_points[i], edge_pos[i]);
  transform3 off = shift(arr_off[i]);
  draw(off*(edge_points[i]--edge_points[i]+dir(edges[i],1.0)/15), Arrow3);
}

draw(Z--Z+X/3, Arrow3);
label("$i_1$", Z+X/3, S);
draw(Z--Z+Y/3, Arrow3);
label("$i_3$", Z+Y/3, E);
draw(Z--Z-Z/3, Arrow3);
label("$i_2$", Z-Z/3, E);
