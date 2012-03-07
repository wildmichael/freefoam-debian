import graph;

usepackage("units");

settings.render = -2;
size(15cm,10cm,IgnoreAspect);

// read and plot numerical solution
file in = input("tut_plateHole_leftPatch_sigmaxx.xy").line();
real[][] xy = in.dimension(0,0);
xy = transpose(xy);

draw(graph(xy[0],xy[1]/1e3), invisible, "Numerical prediction",
   marker(scale(2)*unitcircle, black));

// plot analytical solution
draw(graph(new real(real x){return 10*(1+(0.125/(x**2))+(0.09375/(x**4)));},
   min(xy[0]), max(xy[0])), "Analytical solution");

// draw axes
yaxis("Stress $\left(\sigma_{xx}\right)_{x=0}\,\left[\unit{kPa}\right]$",
    ymin=0, ymax=35, LeftRight, RightTicks(N=8));
xaxis("Distance, $y\,\left[\unit{m}\right]$",
    xmin=0.5, BottomTop, LeftTicks(N=10));

// create legend
add(legend(2, invisible), point(S), 35S);
