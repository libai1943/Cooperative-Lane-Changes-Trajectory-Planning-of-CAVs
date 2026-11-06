# Cooperative lane changes through stepwise optimization

[Download ZIP](https://github.com/libai1943/Cooperative-Lane-Changes-Trajectory-Planning-of-CAVs/archive/refs/heads/master.zip) · [Getting started](#run-the-published-example) · [Guide](#follow-the-computation) · [Citation](#citation-and-license)

When several connected vehicles change lanes together, each vehicle's feasible path depends on where the others will be. The IV 2018 method starts from a relaxed trajectory optimization problem and reintroduces collision constraints in stages. This MATLAB research release lets you follow that sequence and inspect how the elapsed solve time grows as constraints return. [Paper](https://doi.org/10.1109/IVS.2018.8500384) · [Conference presentation (PDF)](IV%20Oral.pdf)

## Run the published example

1. Download the complete repository into a writable folder on Windows. The archive includes MATLAB P-code, text data, AMPL model files and Windows solver binaries. Use a compatible MATLAB installation and an AMPL/solver license suitable for the model size.
2. Make that folder the current MATLAB directory. The example uses relative paths and updates intermediate files in place, including the stage-selection file named `libai`. Use a separate working copy for each concurrent run.
3. Launch the driver from the command window:

```matlab
Run_Me
```

The driver fixes `Nfe = 20` to match the discretization. It runs `step_1` once, then selects stages using the sequence `[1 5 9 13 17 20]`. Leave this schedule intact for the supplied experiment. The author's original timing note estimates about 3,000 seconds for Algorithm 1; elapsed time depends on the solver and machine.

## Follow the computation

| File or variable | What to look for |
| --- | --- |
| [Run_Me.m](Run_Me.m) | The order of the subproblems, stage selector, timer and three figure windows. Start here to follow the paper's Algorithm 1. |
| `step_1.p`, `step_2_to_21.p` | Protected MATLAB entry points for the initial solve and the subsequent stages. Keep these files in the working folder. |
| [case00.mod](case00.mod), [case01.mod](case01.mod), [case02.mod](case02.mod) | AMPL model variants. Inspect them alongside the paper to see how the optimization is expressed. |
| [lagrange.m](lagrange.m) | Polynomial interpolation helper using the Lagrange basis. |
| `video_generation.p`, `figure_generation.p` | Render the motion and the result plots after optimization. |
| `CPU_time_recorder` | Cumulative wall-clock seconds since the first `tic`; only the stages visited by the driver have nonzero entries. |

The third figure plots the cumulative timer against the subproblem index. To compare the time added by each stage, run the following after the example:

```matlab
idx = find(CPU_time_recorder > 0);
elapsed = CPU_time_recorder(idx);
table(idx(:), elapsed(:), diff([0; elapsed(:)]), ...
    'VariableNames', {'Subproblem','Elapsed_s','Step_s'})
```

## Citation and license

The original source requests citation of **Bai Li, Yue Zhang, Youmin Zhang and Ning Jia**, “Cooperative Lane Change Motion Planning of Connected and Automated Vehicles: A Stepwise Computational Framework,” *2018 IEEE Intelligent Vehicles Symposium (IV)*, pp. 334–338. [DOI](https://doi.org/10.1109/IVS.2018.8500384)

```bibtex
@inproceedings{Li2018Stepwise,
  author = {Bai Li and Yue Zhang and Youmin Zhang and Ning Jia},
  title = {Cooperative Lane Change Motion Planning of Connected and Automated Vehicles: A Stepwise Computational Framework},
  booktitle = {2018 IEEE Intelligent Vehicles Symposium (IV)},
  year = {2018}, pages = {334--338}, doi = {10.1109/IVS.2018.8500384}
}
```

Copyright © 2018 Bai Li. The repository includes the [GNU GPL v3](LICENSE). Third-party solver components retain their own terms. The contact listed with the original release is libai@zju.edu.cn.
