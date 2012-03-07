settings.render=-2;
unitsize(0.75cm);

defaultpen(font("OT1","cmss","m","it"));

path folder = (0,1)--(0,0)--(-1.5,0)--(-1.5,1)--cycle
              --(-0.1,1.1)--(-0.3,1.1)--(-0.4,1);

draw(folder);
label("TFoam", (0,0.5), E);

path treePart = shift(-0.75,0)*((0,0)--(0,-1)--(0.4,-1));
path[] tree = treePart
              ^^shift(0,-1)*treePart
              ^^shift(0,-2)*treePart
              ^^shift(0,-3)*treePart;

draw(tree);

label("TFoam.C", (-0.35,-1), E);
label("createFields.H", (-0.35,-2), E);
label("CMakeLists.txt", (-0.35,-3), E);
label("files.cmake", (-0.35,-4), E);
