# Overview:
- This repository contains the 'Visual Search of An Image In A Dataset' project.
- The project is coded in MATLAB and employs the use of descriptors as opposed to more modern techniques like neural networks to calculate image similarity. This project aids in the understanding of early methods of computer vision.

## Contents:
1. Project Brief and Report: This folder contains 2 PDFs:
   - The project brief, which describes the project, provides instructions on how to begin coding using the starter-code, and the link to download the dataset.
   - The report contains the solution for the project. It describes the techniques used, the flow in the approach, the results and inference from the project.

2. starter-code: This folder contains the skeleton code, using which this project can be started from the beginning, without using the provided solutions. The guidelines on how to use this are in the project brief pdf.

3. Distance Measures: This folder contains the different similarity measures / distances used in experimentation to calculate the similarities between the descriptors of the query image and the descriptors of the rest of the dataset.

## How to use:
- Run the 'cvpr_computedescriptors' code to compute your descriptors and store them in a subfolder in the Descriptors folder. Different descriptors can be computed by selecting your choice inside the 'cvpr_computedescriptors' code.
- Then, run the 'cvpr_visualsearch' code to perform visual search of the database. The different descriptors and distance measures can be utilised inside the 'cvpr_visualsearch' code by editing the specific lines.
