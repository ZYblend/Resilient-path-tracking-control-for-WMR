# Introduction
These files are the simulation based on Matlab/Simulink for the paper: **ATTACK-RESILIENT OBSERVER PRUNING FOR PATH-TRACKING CONTROL OFWHEELED MOBILE ROBOT**.

If you use the whole codes or part of them, please cite the paper:
```
@proceeding{Yu2020false,
  author={Zheng, Yu and Anubi, Olugbenga Moses},
  title= "{Attack-Resilent Observer Pruning for Path-tracking Control of
Wheeled Mobile Robot}",
  series = {Dynamic Systems and Control Conference},
  volume={},
  number={},
  pages={},
  year={2020},
  publisher={ASME}
}
```

# How to use the codes
## simulation of machine learning oracle
   (Refer to: ***Localization_oracle.m***) <br />
   We use the Bernoulli uncertainty model to simulate the result of any machine learning localization algorithm's results.
## codes of pruning algorithm
   (Refer to: ***robustneess_support***) <br />
**Note: the way to use the upper two set of codes** <br />
Refer to ***Pruning_observer_inexact.slx/Attack_localization_and_Removing/Attack_localization*** block.

## codes of FDIA construction
  ***getAttackIndices.m***: obatin the support of the optimal attacked locations<br />
  ***gen_attack_channel.m***: generate the successful FDIA based on the selected locations<br />
  **Notice**: the way to use these two set of codes, please follow the mathmatical process in the paper, and refer to the function in ***Pruning_observer_inexact.slx/FDIA***.
   
## codes of dynamic and kinematic model of WMR
   ***Pruning_observer_inexact.slx/dynamic model***<br />
   ***Pruning_observer_inexact.slx/Forward kinematic model***
   
## codes of path-tracking controller
   ***Pruning_observer_inexact.slx/path_tracking controller***
   
## Simulation of path-tracking under FDIA
Please run ***Run_this_file_for_DDWMR_model*** firstly to set all parameters; <br />
***Pruning_observer_inexact.slx***: the simulation for pruning observer based on inexact oracle<br />
***UKF_under_FDIA.slx***: the simulation for only UKF<br />
***only_oracle_and_UKF.slx***: the simulation for UKF based on oracle 
***DDWMR.slx***: the path-tracking simulation without attacks
