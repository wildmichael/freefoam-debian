// process with:
//   asy -f <fmt> -tex <pdflatex|xelatex> sigmaxx
// DO NOT SPECIFY AN OUTPUT NAME (this confuses asy...)
import graph;

usepackage("units");

settings.render = -2;

// fiddling-parameter
real s = 0.8;
size(s*15cm);

// draw invisible box around image in order to provide a frame-of-reference
draw(box((0,0),(15,12.2)), invisible);

// place the plot and the color bar
label(graphic("tut_plateHole_field.png", format("height=%fcm", 12*s)),(6.1,6.1));
label(graphic("tut_plateHole_bar.png", format("height=%fcm", 11*s)),(14.5,6.1));

// add a label to the color bar
draw(rotate(90)*Label("$\sigma_{xx}\,\left[\unit{kPa}\right]$"), (12.8,6.1));

// fiddling parameters for the colorbar tick labels
real yf = 1/2.94;
real yo = 2.4;
real yscale(real v){return (v+yo)*yf;}
// create the tick labels for the colorbar
for(int i=0; i<=30; i+=5) {
  label(format("$%d$",i), (14, yscale(i)), W);
}
