import three;

settings.render = 0;
settings.prc = false;
settings.gsOptions="-r144x144";
size(11cm);
currentprojection=orthographic((-5,2,8), Y) ;

triple[] pts = {
  (1, 0, 0),
  (3, 0, 0),
  (3, 1, 0),
  (1, 1, 0),
};

real angle = 20;

pen fat = black+linewidth(1);

transform3 rotBack = rotate(-angle/2, X);
transform3 rotFront = rotate(angle/2, X);

draw(rotBack*(pts[2]--pts[3]--pts[0]), fat);
draw(rotBack*(pts[1]--pts[2]), dashed+fat);
draw(rotFront*(pts[0]--pts[1]--pts[2]--pts[3]--cycle), fat);
draw(rotBack*pts[2]--rotFront*pts[2], fat);
draw(rotBack*pts[3]--rotFront*pts[3], fat);

draw(shift((1,0,0))*rotate(90,Y)*unitcircle3);

draw(shift((1,0,0))*arc(O, rotBack*(0,0.3,0), rotFront*(0,0.3,0)));
draw((1,0.2,0)--(0,1,0));
label("$<5^\circ$", (0,1,0), N);

draw(O--0.6X, Arrow3);
draw(O--0.6Y, Arrow3);
draw(O--0.6Z, Arrow3);

draw(O--scale3(1.2)*pts[1], dashdotted);
label("Axis of symmetry", scale3(1.2)*pts[1], N+0.5E);

triple center = (pts[0]+pts[1]+pts[2]+pts[3])/4;
path3 patch = shift(center-(0.1,0.1,0)/2)*scale3(0.1)*unitsquare3;
draw(rotBack*patch);
draw(rotFront*patch);

draw(rotBack*center--(center.x,1.2,-0.5));
label("{\tt wedge} patch 2", (center.x,1.2,-0.5), N);
draw(rotFront*center--(center.x,-0.2,0.5));
label("{\tt wedge} patch 1", (center.x,-0.2,0.5), S);

triple p = 0.4Z-0.1X-0.9Y;
draw(0.3Z--p);
label(minipage("wedge aligned along\\ coordinate plane"), p, S+0.7E);
