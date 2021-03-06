# MultiDIC: a MATLAB Toolbox for Multi-View 3D Digital Image Correlation   

MultiDIC is a work in progress. Not all the functions are fully implemented yet. The first complete package is expected to be published in April-May 2018.

- [Summary](#Summary)  
- [Installation](#Installation)  
- [Getting started](#Start)
- [Application Highlights](#Applications)
- [License](#License)  
- [Citing](#Cite)
- [Contributing](#Contributing)  

## Summary <a name="Summary"></a>
MultiDIC (Multi Digital Image Correlation) is an open-source MATLAB toolbox by [Dana Solav](https://www.media.mit.edu/people/danask/). Three-dimensional (stereo) Digital Image Correlation (3D-DIC) is an important technique for measuring the mechanical behavior of materials. MultiDIC was developed to allow fast calibration even for a large number of cameras, and be easily adaptable to different experimental requirements. It integrates the 2D-DIC subset-based software [Ncorr](https://www.github.com/justinblaber/ncorr_2D_matlab) with several camera calibration algorithms to reconstruct 3D surfaces from multiple stereo image pairs. Moreover, it contains algorithms for merging multiple surfaces, and for computing and plotting displacement, deformation and strain measures. High-level scripts allow users to perform 3D-DIC analyses with minimal interaction with MATLAB syntax, while proficient MATLAB users can use stand-alone functions and data-structures to write custom scripts for specific experimental requirements. Comprehensive documentation, user guide, and sample data are included.

## Installation <a name="Installation"></a>  
#### Installation Requirements
###### Operating system requirements
MultiDIC was developed on 64-bit Windows 10 and has not yet been tested on other operating systems.      
###### MATLAB requirements
MultiDIC was developed on MATLAB versions R2017a and R2017b, and has not yet been tested on prior versions.  

MATLAB toolbox dependencies:
* Bioinformatics Toolbox
* Image Processing Toolbox
* Statistics and Machine Learning Toolbox
* Computer Vision System Toolbox

#### Installation Instructions
To install Multi DIC simply follow these two steps:
###### 1. Get a copy of MultiDIC
Use one of these two options:      
**a.** Download and unzip the latest [zip file](https://github.com/MultiDIC/MultiDIC/archive/master.zip).   
**b.** Clone MultiDIC using: `git clone https://github.com/MultiDIC/MultiDIC/.git`.

###### 2. Install (or add to path)    
Use one of these two options:          
**a.** In Matlab, navigate to the unzipped MultiDIC folder, type installMultiDIC in the command window, and hit Enter.   
**b.** In Matlab, Add the MultiDIC folder (with subfolders) to the path and save the path definitions.



## Getting started <a name="Start"></a>
Check out the [instruction manual](https://github.com/MultiDIC/MultiDIC/blob/master/docs/pdf/MultiDIC_InstructionManual.pdf). It should have all the information you need to get started.

## Application Highlights <a name="Applications"></a>
#### These are some examples of figures obtained using MultiDIC:
###### Shape change and skin deformation induced by joint movement and muscle contraction
<img src="docs/img/Shank2D_corr_204_205.gif">
<img src="docs/img/ShankFull_L1_L2.gif">   
###### Shape change and skin deformation induced by indentation
<img src="docs/img/indentation_204_205_DispMgn_onImages.gif">
<img src="docs/img/indentation_3D_Lamda1_Lamda2_reducedLight.gif">

## License <a name="License"></a>
MultiDIC is provided under the [Apache-2.0 license](https://www.apache.org/licenses/). The [license file](https://www.github.com/MultiDIC/MultiDIC/blob/master/LICENSE) is found on the GitHub repository.

## Citing <a name="Cite"></a>   
This is the official repository for:
```
MultiDIC: a MATLAB Toolbox for Multi-View 3D Digital Image Correlation
Dana Solav, Kevin M. Moerman, Aaron M. Jaeger, Katia Genovese, Hugh M. Herr
DOI: TBD
```
Please cite this paper if you use the toolbox.


## Contributing <a name="Contributing"></a>   
If you wish to contribute code/algorithms to this project, please send an email to danask (at) mit (dot) edu.
