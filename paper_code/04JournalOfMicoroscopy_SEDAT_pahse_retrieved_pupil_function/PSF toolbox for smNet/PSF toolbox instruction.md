### Content of PSF toolbox

**Matlab classes:**

- OptimPR_Ast -- for phase retrieval
- PRPSF -- for phase retrieval
- PSF_zernike -- simulation of PSFs with optical aberration
- PSF_interp -- simulation of PSFs from interpolation
- PSF_DH -- simulation of double-helix PSFs
- DipoleField -- simulation of dipole PSFs
- CalCRLB -- calculation of CRLB for non-dipole PSF model
- CalCRLB_dipole -- calculation of CRLB for dipole PSF model
- Zernike_Polynomials -- generation of Zernike polynomials
- OTFrescale -- OTF rescaling of the simulated PSFs

**Example codes:**

- PR_example.m
- PSF_astigmatism_example.m
- PSF_complex_simulate_example.m
- PSF_complex_interp_example.m
- PSF_doublehelix_example.m
- PSF_dipole_example.m

**Test data:**

- complexPSF_recorded.mat
- astigmatimPSF_PR_result_optimAst.mat
- complexPSF_samplepsf.mat







## Instruction on Using PSF toolbox

**The code has been tested in following system and packages:**
Windows7, Windows10, MatlabR2015a, DIPimage(http://www.diplib.org/)

1. Change current folder in Matlab to PSF toolbox.
2. Run each example code in PSF toolbox/examples/.
   **Note: ** for PR_example.m, it requires user to select the center of the PSF in the pop up window.
3. Type ‘help classname’ in Matlab command window for detailed help on each Matlab class.

