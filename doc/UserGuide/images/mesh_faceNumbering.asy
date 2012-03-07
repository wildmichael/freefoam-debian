import three;

settings.render = 0;
settings.prc = false;
settings.gsOptions="-r144x144";
size(5cm);
currentprojection=orthographic(5,3,2,center=true);

pair[] label_pos = {SE, NE, N, NW, SW};

path3 face = rotate(90,(1,0,0))*rotate(90,(0,1,0))*path3(polygon(5));

draw((-1.5,0,0)--O, dashed);
draw(surface(face), mediumgray, mediumgray, nolight);
draw(face, black);
for(int i=0; i<5; ++i)
{
  dot(point(face,i));
  label(format("$%d$", i), point(face,i), label_pos[i]);
}
dot(O);
draw(O--(1.5,0,0), Arrow3);
label("$S_f$", (1.5,0,0), NW);
