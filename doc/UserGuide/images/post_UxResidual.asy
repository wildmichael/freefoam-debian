import graph;

settings.render = -2;
size(15cm,10cm,IgnoreAspect);

// read and plot numerical solution
file in = input("post_Ux_0").line();
real[][] xy = in.dimension(0,0);
xy = transpose(xy);

scale(Linear, Log);

draw(graph(xy[0],xy[1]), invisible,
   marker(scale(2)*unitcircle, black));

xlimits(0, 0.18, Crop);
ylimits(1e-5, 1, Crop);

// draw axes
yaxis("Ux\_0", LeftRight, RightTicks);
xaxis("Time [s]", BottomTop, LeftTicks(N=10));
