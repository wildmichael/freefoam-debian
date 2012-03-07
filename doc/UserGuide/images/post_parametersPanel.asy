// fiddling-parameter
real s = 0.8;
size(s*18.2cm,s*15cm);

label(graphic("post_parametersPanel-snapshot.png", format("height=%fcm", s*14.8)));
layer();

draw((11,7)--(17,7));
label(minipage("The user can select {\tt internalMesh}\\
                region and/or individual patches", 175), (17,7), E);

draw((11,-1)--(17,-1));
label(minipage("The user can select the fields\\
                read into the case module", 175), (17,-1), E);
