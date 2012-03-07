import flowchart;
import math;

block ellipse(object body, pair center=(0,0), pen fillpen=invisible,
              pen drawpen=currentpen, real dr=3)
{
  frame f=body.f;
  pair m=min(f);
  pair M=max(f);
  pair d = M - m;
  real a = 1./sqrt(2.)*d.x + dr;
  real b = 1./sqrt(2.)*d.y + dr;

  path shape=shift(a,b)*scale(a,b)*unitcircle;

  block block;
  block.draw=new frame(pen p) {
    frame block;
    filldraw(block,shape,fillpen,drawpen);
    add(block,shift(-0.5*(M+m))*f,(a,b));
    return block;
  };
  block.f_position=new pair(real x) {
    return point(shape,x);
  };
  block.f_center=(a,b);
  block.center=center;
  block.size=(2a,2b);
  block.f_right=point(shape,0);
  block.f_topright=point(shape,0.5);
  block.f_top=point(shape,1);
  block.f_topleft=point(shape,1.5);
  block.f_left=point(shape,2);
  block.f_bottomleft=point(shape,2.5);
  block.f_bottom=point(shape,3);
  block.f_bottomright=point(shape,3.5);
  return block;
}

settings.render = -2;
unitsize(1cm);

block block1=rectangle(
    "Open Source Field Operation and Manipulation (OpenFOAM) C++ Library",
      (0,2));
block block2=ellipse("Pre-Processing", (-4.5,0));
block block3=ellipse("Solving", (0,0));
block block4=ellipse("Post-Processing", (4.5,0));
block block5=rectangle("Utilities", (-6.8,-2));
block block6=rectangle(pack("Meshing","Tools"), (-4.5,-2));
block block7=rectangle(pack("User","Applications"), (-1.5,-2));
block block8=rectangle(pack("Standard","Applications"), (1.5,-2));
block block9=rectangle("ParaView", (4.5,-2));
block block10=rectangle(pack("Others", "e.g.\ Ensight"), (7.5,-2));

draw(block1);
draw(block2);
draw(block3);
draw(block4);
draw(block5);
draw(block6);
draw(block7);
draw(block8);
draw(block9);
draw(block10);

add(new void(picture pic, transform t) {
    real botoff = 0.2;
    pair b1p1 = botoff*block1.bottomleft(t) + (1-botoff)*block1.bottom(t);
    pair b1p2 = botoff*block1.bottomright(t) + (1-botoff)*block1.bottom(t);
    draw(pic, b1p1--block2.top(t), Arrow);
    draw(pic, block1.bottom(t)--block3.top(t), Arrow);
    draw(pic, b1p2--block4.top(t), Arrow);

    pair b2p1 = botoff*block2.bottomleft(t) + (1-botoff)*block2.bottom(t);
    draw(pic, block5.top(t)--b2p1, Arrow);
    draw(pic, block6.top(t)--block2.bottom(t), Arrow);

    pair b3p1 = botoff*block3.bottomleft(t) + (1-botoff)*block3.bottom(t);
    pair b3p2 = botoff*block3.bottomright(t) + (1-botoff)*block3.bottom(t);
    draw(pic, block7.top(t)--b3p1, Arrow);
    draw(pic, block8.top(t)--b3p2, Arrow);

    pair b4p1 = botoff*block4.bottomright(t) + (1-botoff)*block4.bottom(t);
    draw(pic, block9.top(t)--block4.bottom(t), Arrow);
    draw(pic, block10.top(t)--b4p1, Arrow);
  }
);
