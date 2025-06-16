# -----------------------------------------------------
# ERGM Model Analysis: Network Structure and Proximity Effects
# -----------------------------------------------------

# 1. Load Required Packages
library(statnet)
library(network)
library(ergm)
library(tergm)
library(openxlsx)
library(btergm)
library(texreg)
library(coda)  # For MCMC diagnostics

# 2. Set Working Directory (Relative Path)
setwd(file.path("..", "ERGM_Data_circuit"))  # Assume code is in parent directory of data

# 3. Read Node Attribute Data
time <- read.xlsx("Node_Attributes.xlsx", sheet = "Year", rowNames = TRUE)
patent <- read.xlsx("Node_Attributes.xlsx", sheet = "Patent", rowNames = TRUE)

# 4. Construct Networks and Proximity Matrices for Three Periods
# 4.1 First Period (2011-2014)
T1 <- read.xlsx("Network_Data.xlsx", sheet = "T1", rowNames = TRUE)
N1 <- as.network(as.matrix(T1), directed = FALSE)
N1 %v% "time" <- time[, 1]
N1 %v% "patent" <- patent[, 1]

DL1 <- read.xlsx(file.path("T1", "Geographic_Proximity.xlsx"), sheet = "Sheet2", rowNames = TRUE)
DL1_M <- as.matrix(DL1)

KJ1 <- read.xlsx(file.path("T1", "Spatial_Proximity.xlsx"), sheet = "Sheet2", rowNames = TRUE)
KJ1_M <- as.matrix(KJ1)

ZZ1 <- read.xlsx(file.path("T1", "Organizational_Proximity.xlsx"), sheet = "Sheet2", rowNames = TRUE)
ZZ1_M <- as.matrix(ZZ1)

# 4.2 Second Period (2015-2017)
T2 <- read.xlsx("Network_Data.xlsx", sheet = "T2", rowNames = TRUE)
N2 <- as.network(as.matrix(T2), directed = FALSE)
N2 %v% "time" <- time[, 2]
N2 %v% "patent" <- patent[, 2]

DL2 <- read.xlsx(file.path("T2", "Geographic_Proximity.xlsx"), sheet = "Sheet2", rowNames = TRUE)
DL2_M <- as.matrix(DL2)

KJ2 <- read.xlsx(file.path("T2", "Spatial_Proximity.xlsx"), sheet = "Sheet2", rowNames = TRUE)
KJ2_M <- as.matrix(KJ2)

ZZ2 <- read.xlsx(file.path("T2", "Organizational_Proximity.xlsx"), sheet = "Sheet2", rowNames = TRUE)
ZZ2_M <- as.matrix(ZZ2)

# 4.3 Third Period (2018-2020)
T3 <- read.xlsx("Network_Data.xlsx", sheet = "T3", rowNames = TRUE)
N3 <- as.network(as.matrix(T3), directed = FALSE)
N3 %v% "time" <- time[, 3]
N3 %v% "patent" <- patent[, 3]

DL3 <- read.xlsx(file.path("T3", "Geographic_Proximity.xlsx"), sheet = "Sheet2", rowNames = TRUE)
DL3_M <- as.matrix(DL3)

KJ3 <- read.xlsx(file.path("T3", "Spatial_Proximity.xlsx"), sheet = "Sheet2", rowNames = TRUE)
KJ3_M <- as.matrix(KJ3)

ZZ3 <- read.xlsx(file.path("T3", "Organizational_Proximity.xlsx"), sheet = "Sheet2", rowNames = TRUE)
ZZ3_M <- as.matrix(ZZ3)

# 5. Define General Control Parameters
control_params <- control.ergm(
  MCMC.samplesize = 20000,      # MCMC sample size
  MCMC.burnin = 20000,          # Burn-in period
  MCMC.interval = 1000,         # Sampling interval
  parallel = 16,                # Number of parallel cores
  seed = 666,                   # Random seed
  MCMLE.density.guard = 20      # Density guard parameter
)

# 6. Model Fitting - First Period (2011-2014)
# 6.1 Basic Model (node covariates only)
model_2011_2014_1 <- ergm(N1 ~ edges + nodecov("time") + nodecov("patent"),
                          control = control_params)
summary(model_2011_2014_1)

# 6.2 Model with edge covariates
model_2011_2014_2 <- ergm(N1 ~ edges + nodecov("time") + nodecov("patent") +
                            edgecov(DL1_M) + edgecov(KJ1_M) + edgecov(ZZ1_M),
                          control = control_params)
summary(model_2011_2014_2)

# 6.3 Model with high-order terms
model_2011_2014_3 <- ergm(N1 ~ edges + gwdegree(0.25, fixed = TRUE) + gwesp(0.25, fixed = TRUE) + 
                            gwdsp(0.25, fixed = TRUE) + nodecov("time") + nodecov("patent") +
                            edgecov(DL1_M) + edgecov(KJ1_M) + edgecov(ZZ1_M),
                          control = control_params)
summary(model_2011_2014_3)

# 7. Model Fitting - Second Period (2015-2017)
# 7.1 Basic Model (node covariates only)
model_2015_2017_1 <- ergm(N2 ~ edges + nodecov("time") + nodecov("patent"),
                          control = control_params)
summary(model_2015_2017_1)

# 7.2 Model with edge covariates
model_2015_2017_2 <- ergm(N2 ~ edges + nodecov("time") + nodecov("patent") +
                            edgecov(DL2_M) + edgecov(KJ2_M) + edgecov(ZZ2_M),
                          control = control_params)
summary(model_2015_2017_2)

# 7.3 Model with high-order terms
model_2015_2017_3 <- ergm(N2 ~ edges + gwdegree(0.25, fixed = TRUE) + gwesp(0.25, fixed = TRUE) + 
                            gwdsp(0.25, fixed = TRUE) + nodecov("time") + nodecov("patent") +
                            edgecov(DL2_M) + edgecov(KJ2_M) + edgecov(ZZ2_M),
                          control = control_params)
summary(model_2015_2017_3)

# 8. Model Fitting - Third Period (2018-2020)
# 8.1 Basic Model (node covariates only)
model_2018_2020_1 <- ergm(N3 ~ edges + nodecov("time") + nodecov("patent"),
                          control = control_params)
summary(model_2018_2020_1)

# 8.2 Model with edge covariates
model_2018_2020_2 <- ergm(N3 ~ edges + nodecov("time") + nodecov("patent") +
                            edgecov(DL3_M) + edgecov(KJ3_M) + edgecov(ZZ3_M),
                          control = control_params)
summary(model_2018_2020_2)

# 8.3 Model with high-order terms
model_2018_2020_3 <- ergm(N3 ~ edges + gwdegree(0.25, fixed = TRUE) + gwesp(0.25, fixed = TRUE) + 
                            gwdsp(0.25, fixed = TRUE) + nodecov("time") + nodecov("patent") +
                            edgecov(DL3_M) + edgecov(KJ3_M) + edgecov(ZZ3_M),
                          control = control_params)
summary(model_2018_2020_3)

# 9. Goodness-of-Fit Testing
# 9.1 GoF for 2011-2014 model
gof_2011_2014 <- gof(model_2011_2014_3, control = control_params)
plot(gof_2011_2014)

# 9.2 GoF for 2015-2017 model
gof_2015_2017 <- gof(model_2015_2017_3, control = control_params)
plot(gof_2015_2017)

# 9.3 GoF for 2018-2020 model
gof_2018_2020 <- gof(model_2018_2020_3, control = control_params)
plot(gof_2018_2020)

# 10. Output and Save Results
# 10.1 Print key model summaries to console
cat("2011-2014 Model 3 Summary:\n")
summary(model_2011_2014_3)
cat("\n2015-2017 Model 3 Summary:\n")
summary(model_2015_2017_3)
cat("\n2018-2020 Model 3 Summary:\n")
summary(model_2018_2020_3)

# 10.2 Save all 9 ERGM models to file
save(model_2011_2014_1, model_2011_2014_2, model_2011_2014_3,
     model_2015_2017_1, model_2015_2017_2, model_2015_2017_3,
     model_2018_2020_1, model_2018_2020_2, model_2018_2020_3,
     file = "ergm_models_all.RData")
