import three;
import graph3;

settings.render = 0;
settings.prc = false;
settings.gsOptions="-r144x144";

// define the view
currentprojection=orthographic(-1,3,6,up=(0,1,0));

// size of the thing
size(5cm);

// scaling
real d=0.8;
transform3 s = scale3(d);

// define corner points and mark them with dots
triple[] corners = {
  (0,0,0),
  (1,0,0),
  (1,1,0),
  (0,1,0),
  (0,0,0.4),
  (1,0,0.4),
  (1,1,0.4),
  (0,1,0.4),
};
dot(corners);

// label corners
for(int i=0; i < 8; ++i) {
  string str = format("$%d$",i);
  label(str,corners[i],NE);
}

// draw edges
int[] ind1_list = { 0, 1, 2, 3, 4, 5, 6, 7, 0, 1, 2, 3 };
int[] ind2_list = { 1, 2, 3, 0, 5, 6, 7, 4, 4, 5, 6, 7 };
bool[] hidden = { true,  true,  false, false,
                  false, false, false, false,
                  false, true, false, false };
for(int i=0; i < 12; ++i) {
  triple pt1 = corners[ind1_list[i]];
  triple pt2 = corners[ind2_list[i]];
  path3 line = (pt1--pt2);
  pen p = black;
  if(hidden[i]) p = linetype(new real[] {8,16});
  draw(line,p);
}


// the coordinate axis
xaxis3(Label("$x$",1),0,0.3*d,black+2*linewidth(),Arrow3);
yaxis3(Label("$y$",1),0,0.3*d,black+2*linewidth(),Arrow3);
zaxis3(Label("$z$",1),0,0.3*d,black+2*linewidth(),Arrow3);
