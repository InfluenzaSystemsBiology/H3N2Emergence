# H3N2Emergence

On the basis of these preliminarily identified emerging variants, we developed a Bayesian model to infer the temporal and spatial origins of H3N2 antigenic variants. For a specific drift event, the Bayesian model was constructed upon the conditional dependency that T\~ZN(T_0,σ^2 )+(1-Z)(αN_+ (T_1,σ^2 )+(1-α) N_- (T_2,σ^2 )), D\~ZN(D_1,δ^2 )+(1-Z)N(D_2,δ^2 ) and Z\~Bern(p_0 ), where each virus within this drift contains a location L, time T (ranging in [T_1,T_2 ]), and an antigenic difference D (with hyper-parameters D_1 and D_2) between its distances to the two antigenic cluster centers in the drift; N, N_+, and N_- denote the normal distribution and two truncated normal distributions; Bern denotes the Bernoulli distribution; α, σ, and δ are hyper-parameters; and, for each virus, Z is a potential binary variable indicating whether the virus is a beginning point of an emergence event. The results for the temporal and spatial origins of an influenza A(H3N2) virus antigenic variant was further validated by using phylogenetic analyses to ensure the temporal and spatial information of the precursor viruses inferred for a testing H3N2 antigenic variant were consistent with those detected by the Bayesian model.
# Useage
Raw HA sequence data used in this model is located in Data folder. Total 44592 HA1 seuqences of human H3N2 IAVs in "1968-2018.fasta" and 22 HA1 sequences of vaccines in "histroy_vaccine.fasta". Process_Data.m can load data into matlab for further analysis. 
"Bayesian model' folder contains source code of the emergence Bayesian model. User can run Main_XX_XX.m for 7 antigenic drifts:
```  
  Main_BR07_PE09.m
  Main_CA04_BR07.m
  Main_FU02_CA04.m
  Main_PE09_TX12.m
  Main_SY97_FU02.m
  Main_TX12_HK14.m
  Main_TX12_SWZ13.m
```  
data for those scripts is located in Bayesian model/Data (SpatialUse_1994_2009.mat and SpatialUse_2009_2016.mat). 
Sequence-based antigenic distances and cartographies are caculated by GG-MTSL (https://doi.org/10.1093/bioinformatics/bty457). Data and codes are available at http://sysbio.cvm.msstate.edu/files/GG-MTSL/. 
# Feedback
Let me know if you have any questions or comments at  wan@cvm.msstate.edu
