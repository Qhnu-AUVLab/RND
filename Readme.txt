RND Algorithm Introduction:
Underwater localization is a fundamental technology for autonomous underwater vehicles 
(AUVs) to conduct underwater operations successfully. However, due to the complexity of 
the underwater environment, acoustic propagation is constrained by limited bandwidth, 
significant propagation delays, stratification, multipath, and Doppler effects, as well as 
a constantly changing environment. In practice, acoustic propagation delay introduces 
common biases in the measurement data, while other factors introduce random biases. 
Ignoring these biases will significantly degrade the localization accuracy. To address this 
problem, this work adopts acoustic two-way travel-time measurements, which effectively 
alleviate common biases. Then, a localization model is established to account for acoustic 
time-propagation bias and AUV speed bias. Based on this localization model, a robust 
neurodynamics (RND) algorithm is designed that incorporates a weight derived from
the covariance matrix of the two biases and introduces a saturated activation function to
mitigate the effects of outliers. In this way, the RND algorithm guarantees bias perception
and robust performance on abnormal measurement values. Theoretical analysis and 
simulations verify that the RND algorithm exhibits distinct advantages in adaptiveness 
and robustness compared with state-of-the-art algorithms.

Simulation code:
Initial.m: Sets the initial parameters for the simulation.
AF.m: Implements the <AF 的实际名称>.
RND.m: Implements the RND algorithm.
CFS.m: Implements the CFS algorithm.
SCFS.m: Implements the SCFS algorithm.
MWLS.m: Implements the MWLS algorithm.    
JSPCTL.m: Implements the JSPCTL algorithm.
Fig2.m: Generates the results for the first group of simulations (Fig. 2).
Fig3.m: Generates the results for the second group of simulations (Fig. 3).
Fig4.m: Generates the results for the third group of simulations (Fig. 4).
Fig5.m: Generates the results for the fourth group of simulations (Fig. 5).