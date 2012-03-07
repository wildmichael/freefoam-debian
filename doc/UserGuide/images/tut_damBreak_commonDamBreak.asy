private import graph;

void drawDamBreak(string field, string bar)
{
  settings.render = -3;
  // fiddling-parameter
  real s = 0.8;
  size(s*15cm);

  // draw invisible box around image in order to provide a frame-of-reference
  draw(box((0,0),(15,12.2)), invisible);

  // place the plot and the color bar
  label(graphic(field, format("height=%fcm", 12*s)),(6.1,6.1));
  label(graphic(bar, format("height=%fcm", 11*s)),(14.5,6.1));

  // add a label to the color bar
  draw(rotate(90)*Label("Phase fraction, $\alpha_1$"), (12.8,6.1));

  // fiddling parameters for the colorbar tick labels
  real yf = 1/2.69;
  real yo = 1.4;
  real yscale(real v){return (v+yo)*yf;}
  // create the tick labels for the colorbar
  for(int i=0; i<=30; i+=6) {
    label(format("$%#.1f$",i/30.), (14, yscale(i)), W);
  }
}
