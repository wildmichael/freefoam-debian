settings.render = -2;
size(10cm);

int nx = 10;
int ny = 6;

pen thick = black + 2*linewidth();

picture domain = new picture;
filldraw(domain, box((0,0), (nx,ny)), lightgray);

path[] basegrid;
for(int i=0; i<nx; ++i)
{
  basegrid = basegrid^^(i+1,0)--(i+1,ny);
}
for(int j=0; j<ny; ++j)
{
  basegrid = basegrid^^(0,j+1)--(nx,j+1);
}

path car = (2.45,1.9)--(3.2,1.9)..(3.6,1.6)..(4,1.9)--
           (6.2,1.9)..(6.6,1.6)..(7,1.9)--(7.4,1.9)--
           (7.4,2.9)--(6.7,2.9)--(6,4.1)--(4.7,4.1)--
           (4,3.2)--(2.45,2.8)--cycle;

path[] cross1 = (0,0.5)--(1,0.5)^^(0.5,0)--(0.5,1);
path[] cross2 = scale(0.5)*cross1;
path[] cross3 = scale(0.25)*cross1;

path[] castel1 = shift(6,2)*cross1^^
                 shift(6.5,2.5)*cross2^^
                 shift(6.5,2.75)*cross3;

path[] castel = castel1 ^^
                shift(7,2)*cross1^^
                shift(7,2)*cross2^^
                shift(7,2.5)*cross2^^
                shift(7,3)*cross1^^
                shift(6,3)*cross1^^
                shift(6.5,3)*cross2^^
                shift(6,3)*cross2^^
                shift(6,3.5)*cross2^^
                shift(6,4)*cross1^^
                shift(6,4)*cross2^^
                shift(5,4)*cross1^^
                shift(5.5,4)*cross2^^
                shift(5,4)*cross2^^
                shift(4,4)*cross1^^
                shift(4.5,4)*cross2^^
                shift(4,3)*cross1^^
                shift(4.5,3.5)*cross2^^
                shift(4,3.5)*cross2^^
                shift(4,3)*cross2^^
                shift(3,3)*cross1^^
                shift(3.5,3)*cross2^^
                shift(3,3)*cross2^^
                shift(2,3)*cross1^^
                shift(3,2)*cross1^^
                shift(3,2.5)*cross2^^
                shift(2,2)*cross1^^
                shift(2.5,2.5)*cross2^^
                shift(2,2.5)*cross2^^
                shift(2,2)*cross2^^
                shift(2,1)*cross1^^
                shift(2,1.5)*cross2^^
                shift(2.5,1.5)*cross2^^
                shift(3,1)*cross1^^
                shift(3,1.5)*cross2^^
                shift(3.5,1.5)*cross2^^
                shift(4,1)*cross1^^
                shift(4,1.5)*cross2^^
                shift(4.5,1.5)*cross2^^
                shift(5,1)*cross1^^
                shift(5,1.5)*cross2^^
                shift(5.5,1.5)*cross2^^
                shift(6,1)*cross1^^
                shift(6,1.5)*cross2^^
                shift(6.5,1.5)*cross2^^
                shift(7,1)*cross1^^
                shift(7,1.5)*cross2;

path interior = (2.5,2)--(3.25,2)--(3.25,1.75)--(3.5,1.75)--(3.5,1.5)--
                (3.75,1.5)--(3.75,1.75)--(4,1.75)--(4,2)--(6.25,2)--
                (6.25,1.75)--(6.5,1.75)--(6.5,1.5)--(6.75,1.5)--(6.75,1.75)--
                (7,1.75)--(7,2)--(7.5,2)--(7.5,3)--(6.75,3)--(6.75,2.875)--
                (6.625,2.875)--(6.625,3)--(6.5,3)--(6.5,3.5)--(6.25,3.5)--
                (6.25,4)--(4.5,4)--(4.5,3.5)--(4.25,3.5)--(4.25,3.25)--
                (3.75,3.25)--(3.75,3)--(2.75,3)--(2.75,2.75)--(2.5,2.75)--
                cycle;

path[] splitgrid;
for(int i=0; i<nx-2; ++i)
{
  splitgrid = splitgrid^^(i+2.5,1)--(i+2.5,ny-1);
}
for(int j=0; j<ny-2; ++j)
{
  splitgrid = splitgrid^^(2,j+1.5)--(nx,j+1.5);
}

path snappedcar = (2.4,2)--(2.5,1.9)--(3.2,1.9)--(3.3,1.72)--(3.52,1.6)--
                  (3.68,1.6)--(3.9,1.72)--(4,1.9)--(6.2,1.9)--(6.3,1.72)--
                  (6.52,1.6)--(6.68,1.6)--(6.9,1.72)--(7,1.9)--(7.25,1.9)--
                  (7.4,2)--(7.4,2.75)--(7.25,2.9)--(6.75,2.9)--(6.7,2.92)--
                  (6.25,3.75)--(6,4)--(5.75,4.05)--(5,4.05)--(4.75,4)--
                  (4.25,3.5)--(3.75,3.1)--(3,3)--(2.5,2.83)--(2.4,2.75)--cycle;

// Create overlay with warped cells (tedious at best)
picture warpedcells = new picture;
filldraw(warpedcells, box((3,1.5), (4,2)), lightgray, black);
draw(warpedcells, (3,1.75)--point(snappedcar,3)--point(snappedcar,6)--(4,1.75)^^
                  (3.25,1.5)--point(snappedcar,3)^^
                  (3.5,1.5)--point(snappedcar,4)^^
                  (3.75,1.5)--point(snappedcar,5));
filldraw(warpedcells, box((6,1.5), (7,2)), lightgray, black);
draw(warpedcells, (6,1.75)--point(snappedcar,9)--point(snappedcar,12)--(7,1.75)^^
                  (6.25,1.5)--point(snappedcar,9)^^
                  (6.5,1.5)--point(snappedcar,10)^^
                  (6.75,1.5)--point(snappedcar,11)
                  );
path l1 = (6.5,3)--(6.82,3.1)--(7.5,3);
filldraw(warpedcells, box((6.5,2.75), (7.5,3.5)), lightgray, black);
draw(warpedcells, (7,2.75)--(7,3.5)^^
                  l1^^
                  (6.85,2.9)--(6.82,3.1)--(6.75,3.5)^^
                  (6.5,3.25)--(7,3.25)^^
                  point(snappedcar,17)--point(l1,1.65)
                  );

// Create overlay for added layers
picture addedlayers = new picture;
filldraw(addedlayers, box((2,3), (4,4)), lightgray, black);
path l2 = point(snappedcar, 29)--point(snappedcar, 28)--point(snappedcar, 27)--
          point(snappedcar, 26)--(3.5,3.2)--
          (3,3.15)--(2.5,3)--
          cycle;
filldraw(addedlayers, l2, gray, black);
path l3 = point(l2,0)--(0.6point(l2,1)+0.4point(l2,6))--
          (point(l2,2)+point(l2,5))/2--
          point(l2,4)-(0.05,0.06)--
          point(l2,3);
path l4 = (2,3.5)--(2.5,3.6)--(3,3.6)--(3.5,3.6)--(3.75,3.6)--(4,3.5);
draw(addedlayers, l3^^l4^^
                  (3,3.4)--(4,3.3)^^
                  point(snappedcar,28)--point(l2,6)--(2.5,4)^^
                  point(snappedcar,27)--point(l2,5)--(3,4)^^
                  point(snappedcar,26.6)--point(l2,4.5)--(point(l4,2.5))^^
                  point(snappedcar,26.3)--point(l2,4)--(3.5,4)
                  );
