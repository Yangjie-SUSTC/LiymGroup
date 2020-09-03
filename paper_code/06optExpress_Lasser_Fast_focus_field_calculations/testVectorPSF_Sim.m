%% hyper parameters for PSF model used for fit
paraSim.NA = 1.43;                                                % numerical aperture of obj             
paraSim.refmed = 1.35;                                            % refractive index of sample medium
paraSim.refcov = 1.518;                                           % refractive index of converslip
paraSim.refimm = 1.518;                                           % refractive index of immersion oil
paraSim.lambda = 668;                                             % wavelength of emission
paraSim.objStage0 = -4500;                                        % nm, initial objStage0 position,relative to focus at coverslip
paraSim.zemit0 = -1*paraSim.refmed/paraSim.refimm*(paraSim.objStage0);  % reference emitter z position, nm, distance of molecule to coverslip
paraSim. pixelSizeX = 117;                                        % nm, pixel size of the image
paraSim. pixelSizeY = 127;                                        % nm, pixel size of the image
paraSim.Npupil = 64;                                             % sampling at the pupil plane

paraSim.aberrations = [2,-2,0.0; 2,2,0.0; 3,-1,0.0; 3,1,0.0; 4,0,0.0; 3,-3,0.0; 3,3,0.0; 4,-2,0.0; 4,2,0.00; 5,-1,0.0; 5,1,0.0; 6,0,0.0; 4,-4,0.0; 4,4,0.0;  5,-3,0.0; 5,3,0.0;  6,-2,0.0; 6,2,0.0; 7,1,0.0; 7,-1,0.00; 8,0,0.0];
paraSim.aberrations(:,3) =  paraSim.aberrations(:,3)*paraSim.lambda;




%% parameters for molecules for simulation
Nmol = 100;
Npixels = 17;
Nphotons = 5000 +10000*rand(1,Nmol);
bg = 10 + 10*rand(1,Nmol);
paraSim.Nmol = Nmol;
paraSim.sizeX = Npixels;
paraSim.sizeY = Npixels;

paraSim.xemit = (-200+400*rand(1,Nmol))*0;                             %nm
paraSim.yemit = (-200+400*rand(1,Nmol))*0;                             %nm
paraSim.zemit = linspace(-1000,1000,Nmol)*1;                                      %nm
paraSim.objStage = linspace(-1000,1000,Nmol)*0;                                  %nm

[PSFs,Waberration] = vectorPSF_Final(paraSim);


data = PSFs;
for i = 1:Nmol
    data(:,:,i) = Nphotons(i)*PSFs(:,:,i)+bg(i);% 每一个荧光分子产生的图像
end
data = poissrnd(data,size(data));% 每个生成泊松分布