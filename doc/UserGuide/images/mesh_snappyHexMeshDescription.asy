import mesh_snappyHexMeshCommon;

filldraw(box((0,0), (nx,ny)), lightgray);
filldraw(car, white, thick);
draw((4,2.2)--point(car, 12.5), Arrow);
label("STL surface", (4,2.2), E);
