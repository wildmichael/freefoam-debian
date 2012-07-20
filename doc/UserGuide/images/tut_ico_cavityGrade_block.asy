import three;
import graph3;

settings.render = 0;
settings.prc = false;
settings.gsOptions="-r144x144";

// define the view
triple normal = (-1,3,6);
currentprojection=orthographic(normal,up=(0,1,0));

// size of the thing
size(5cm);

// scaling
real d=0.8;
transform3 s = scale3(d);

// define corner points and mark them with dots
triple[] corners = {
  (0,0,0),
  (1,0,0),
  (2,0,0),
  (0,1,0),
  (1,1,0),
  (2,1,0),
  (0,2,0),
  (1,2,0),
  (2,2,0),
  (0,0,0.4),
  (1,0,0.4),
  (2,0,0.4),
  (0,1,0.4),
  (1,1,0.4),
  (2,1,0.4),
  (0,2,0.4),
  (1,2,0.4),
  (2,2,0.4),
};
dot(corners);

// label corners
for(int i=0; i < corners.length; ++i) {
  string str = format("$%d$",i);
  pair pos = NW;
  if(i==0) pos = W;
  if(i>=corners.length/2) pos = SE;
  label(str,corners[i],pos);
}

// draw edges
int[] ind1_list = {0, 1, 3, 4, 6, 7,           // horizontals (z=0)
                   0, 1, 2, 3, 4, 5,           // verticals   (z=0)
                   9, 10, 12, 13, 15, 16,      // horizontals (z=0.4)
                   9, 10, 11, 12, 13, 14,      // verticals   (z=0.4)
                   0, 1, 2, 3, 4, 5, 6, 7, 8}; // perpenticulars

int[] ind2_list = {1, 2, 4, 5, 7, 8,                   // horizontals (z=0)
                   3, 4, 5, 6, 7, 8,                   // verticals   (z=0)
                   10, 11, 13, 14, 16, 17,             // horizontals (z=0.4)
                   12, 13, 14, 15, 16, 17,             // verticals   (z=0.4)
                   9, 10, 11, 12, 13, 14, 15, 16, 17}; // perpenticulars

bool[] hidden = {true, true,  true, true, false, false,     // horizontals (z=0)
                 false, true, true, false, true, true,      // verticals   (z=0)
                 false, false, false, false, false, false,  // horizontals (z=0.4)
                 false, false, false, false, false, false,  // verticals   (z=0.4)
                 false, true, true, false, true, true, false, false, false}; // perpenticulars

for(int i=0; i < ind1_list.length; ++i) {
  triple pt1 = corners[ind1_list[i]];
  triple pt2 = corners[ind2_list[i]];
  path3 line = (pt1--pt2);
  pen p = black;
  if(hidden[i]) p = linetype("8 16");
  draw(line,p);
}

// label blocks
int[] owners = {0,1,3,4};
int[] offsets = {0,1,3,4,9,10,12,13};
for(int i=0; i < owners.length; ++i) {
  int j = owners[i];
  triple pos = (0,0,0);
  for(int k=0; k < offsets.length; ++k)
    pos += corners[j+offsets[k]];
  pos /= offsets.length;
  label(format("$%d$", i), pos);
  draw(circle(pos, 0.09, normal), black);
}

// the coordinate axis
xaxis3(Label("$x$",1),0,0.4*d,black+2*linewidth(),Arrow3);
yaxis3(Label("$y$",1),0,0.4*d,black+2*linewidth(),Arrow3);
zaxis3(Label("$z$",1),0,0.4*d,black+2*linewidth(),Arrow3);
