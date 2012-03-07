import three;

settings.render = 0;
settings.prc = false;
settings.gsOptions="-r144x144";
size(5.5cm);
currentprojection=obliqueZ();

Z /= 2;

triple[] corners = {
  Z,   X+Z,   X,   O,
  Y+Z, X+Y+Z, X+Y, Y
};
pair[] corner_pos = {
  S, S, E, W,
  W, E, N, N
};

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
  corners[1]--corners[5],
  corners[2]--corners[6],
  corners[3]--corners[7],
  corners[2]--corners[5],
  corners[3]--corners[4],
};

draw(edges[1]^^edges[4]^^edges[13], dashed);
draw(edges[2]^^edges[6]^^edges[7]^^edges[10]^^edges[11], dotted);
draw(edges[0]^^edges[3]^^edges[5]^^edges[8]^^
     edges[9]^^edges[12]);

for(int i=0; i<corners.length; ++i)
{
  label(format("$%d$", i), corners[i], corner_pos[i]);
}

real s = 0.9;
draw(shift(0.05X)*scale(1,1,s)*edges[6], BeginArrow3);
draw(shift(-0.05X)*scale(1,1,s)*edges[7], BeginArrow3);
