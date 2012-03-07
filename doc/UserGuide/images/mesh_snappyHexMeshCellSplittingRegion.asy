import mesh_snappyHexMeshCommon;

add(domain);
filldraw(box((2,1), (nx,5)), mediumgray);
draw(basegrid);
draw(splitgrid);
draw(castel);
filldraw(interior, white, black);
draw(car, thick);
