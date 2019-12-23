function perc = perc_dist(eps, n, m)

% Evaluating the distortion by computing the euclidean distance between pixels
perc = ( eps / (n*m*sqrt(100^2 + 255^2 + 255^2)) )*100;

end