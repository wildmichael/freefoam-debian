settings.render = -2;
size(9cm);

pen thin = linewidth(0.4);
currentpen += linewidth(1.2);

draw((0,0)--(1,0));

label("Expansion ratio = $\frac{\delta_e}{\delta_s}$", E/2, 3N);
label("Expansion direction", E/2, S);
draw(shift(S/35)*(0.7E--0.75E), thin, Arrow);

path m = (0,0)--(0,0.03);
draw(m, thin);
draw(shift(0.1E)*m, thin);
draw(shift(0.8E)*m, thin);
draw(shift(E)*m, thin);

transform off = shift(point(m,0.5));
draw(off*(W/10--(0,0)), thin, Arrow);
draw(shift(E/10)*off*(E/10--(0,0)), thin, Arrow);
label("$\delta_s$", off*(E/20), N);

draw(off*(0.8E--E), thin, Arrows);
label("$\delta_e$", off*(0.9E), N);
