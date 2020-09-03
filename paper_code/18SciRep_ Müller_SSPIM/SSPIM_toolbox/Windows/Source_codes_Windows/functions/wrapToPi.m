function lambda = wrapToPi(lambda)

q = (lambda < -pi) | (pi < lambda);
lambda(q) = wrapTo2Pi(lambda(q) + pi) - pi;
