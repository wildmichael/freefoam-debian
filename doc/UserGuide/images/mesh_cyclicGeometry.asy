settings.render = -2;
unitsize(1.5cm);

picture pic1 = new picture;
draw(pic1, unitsquare);
label(pic1, minipage("1\\ 2\\ 3"), N, SE);
add(shift(N/2)*pic1);

picture pic2 = new picture;
draw(pic2, unitsquare);
label(pic2, minipage("4\\ 5\\ 6"), N, SE);
add(shift(S/2)*pic2);

label(minipage("\centering \tt cyclic\\ faceList"), 1.5N+0.5E, N);

for (int i=0; i<3; ++i)
{
  for (int j=0; j<3; ++j)
  {
    draw(shift(2E+(i,j-0.5))*scale(0.2)*unitcircle);
  }
}

draw((1.5,1)--(4.5,1)^^(1.5,0)--(4.5,0), dashed);
draw((1.5,1)--(1.5,0)^^(4.5,1)--(4.5,0));

label("Repeated geometry", (3, 1.7), N);

draw(N+0.5E..1.3N+E..N+2E, Arrow);
draw(0.5E..-0.3N+E..2E, Arrow);

add(shift(2S+W)*pic1);
add(shift(2S+E)*pic2);
for (int i=0; i<3; ++i)
{
  real y = 1/6.+i/3.;
  draw(shift(2S)*((0,y)--(1,y)), Arrows);
}

label("Computational links", 2S+0.5E, S);
