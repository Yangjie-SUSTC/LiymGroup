function lambda = wrapTo2Pi(lambda)

positiveInput = (lambda > 0);
lambda = mod(lambda, 2*pi);
lambda((lambda == 0) & positiveInput) = 2*pi;
