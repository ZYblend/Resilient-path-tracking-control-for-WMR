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
   
