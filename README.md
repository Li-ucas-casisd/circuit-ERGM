# ERGM Model Analysis Project in evolution dynamics of innovation networks in China’s integrated circuit industry

## 1. Project Overview
This project uses Exponential Random Graph Models (ERGM) to analyze network structures across three periods, investigating how geographic, spatial, and organizational proximity influence network tie formation. The code includes data loading, model fitting, goodness-of-fit testing, and result output.

## 2. Directory Structure
ergm_project/
├── code/ # Code directory
│ └── Circuit-ERGM.R # Main analysis script
├── ERGM_Data/ # Data directory
│ ├── Node_Attributes.xlsx # Node time and patent attributes
│ ├── Network_Data.xlsx # Network matrices for three periods
│ ├── T1/ # 2011-2014 period data
│ │ ├── Geographic_Proximity.xlsx
│ │ ├── Spatial_Proximity.xlsx
│ │ └── Organizational_Proximity.xlsx
│ ├── T2/ # 2015-2017 period data
│ │ ├── Geographic_Proximity.xlsx
│ │ ├── Spatial_Proximity.xlsx
│ │ └── Organizational_Proximity.xlsx
│ └── T3/ # 2018-2020 period data
│ ├── Geographic_Proximity.xlsx
│ ├── Spatial_Proximity.xlsx
│ └── Organizational_Proximity.xlsx
└── results/ # Output directory

## 3. Runtime Environment
- **R Version**: 4.4.1 or higher
- **Dependencies**: statnet, network, ergm, tergm, openxlsx, btergm, texreg, coda

## 4. Code Description
- **Data Loading**: Uses relative paths to read node attributes and network matrices, ensuring portability.
- **Model Setup**: Fits three model types for each period (2011-2014, 2015-2017, 2018-2020):
  - Basic model (node covariates only)
  - Model with edge covariates (proximity effects)
  - Model with high-order network terms (gwdegree, gwesp, gwdsp)
- **Output**: Generates goodness-of-fit plots, model comparison tables, and saves model objects.

## 5. Execution Steps
1. Place `ergm_analysis.R` in the `code/` directory.
2. Ensure the `ERGM_Data/` directory is parallel to the code directory.
3. Run the script in R; outputs will be saved to the `results/` directory.

## 6. Notes
- High-order term models (gwdegree, gwesp, gwdsp) may require adjusting MCMLE.density.guard for convergence.
- For large networks, a computer with at least 16GB RAM is recommended.
- Goodness-of-fit plots need manual saving or additional code for automation.

## 7. Dataset Availability
All raw data in the ERGM_Data/ directory can be downloaded from FigShare at: https://doi.org/10.6084/m9.figshare.29329997

## 8. Citation
Chao Liu, Keyi Lu, Longfei Li*. Adapting under pressure: Resilience characteristics and evolution dynamics of innovation networks in China’s integrated circuit industry. undergoing review in technology analysis & strategic management
