[![License](https://img.shields.io/badge/License-GPL--3.0-brightgreen)](https://github.com/PTRRupprecht/Quantal-analysis-for-spike-inference/blob/main/LICENSE)
[![Size](https://img.shields.io/github/repo-size/PTRRupprecht/Quantal-analysis-for-spike-inference?style=plastic)](https://img.shields.io/github/repo-size/PTRRupprecht/Quantal-analysis-for-spike-inference?style=plastic)
[![Language](https://img.shields.io/github/languages/top/PTRRupprecht/Quantal-analysis-for-spike-inference?style=plastic)](https://github.com/PTRRupprecht/Quantal-analysis-for-spike-inference)

## Quantal analysis for spike inference

A proof-of-concept algorithm for quantal analysis to perform autocalibration of inferred spike rates from calcium imaging data

### Description

Calcium transients from calcium imaging can have variable amplitudes. In one neuron, the transient corresponding to a single action potential (AP) might be 30% ΔF/F, in another one it might be 45%. This variability introduces an error into the absolute inferred spike rate. To correct for this error, we apply here "quantal analysis" of the inferred spike rates. We assume that the inferred spike rates will fall into more or less discrete bins. Using a constrained Gaussian mixture model variant to fit this distribution, we extract the unitary amplitude (that is, the ΔF/F response towards the minimal, single AP) and use it to normalize the overall extracted spike rates.

Check out our preprint for more details: **preprint**.

This analysis is an based on spike inference with CASCADE, which is described in this **[paper](https://www.nature.com/articles/s41593-021-00895-5)** and is documented on [this GitHub repository](https://github.com/HelmchenLabSoftware/Cascade). The analysis was worked out within a Master's thesis by [Xusheng "Felix" Fang](https://github.com/Felix-bangbang).

### Codebase

The folder `example data` contains a single example recording (taken from the [GCaMP8s ground truth](https://github.com/HelmchenLabSoftware/Cascade/tree/master/Ground_truth/DS32-GCaMP8s-m-V1) dataset). It includes both the raw ΔF/F trace ("calcium") and the spike rates inferred with CASCADE ("spike_rates").

The folder `helper scripts` contains all functions to perform quantal analysis. The main function, which contains all other functions as helpers, is `Quantal_analysis_spike_rate.m`.

In the main folder, the `Demo_script.m` applies the quantal analysis to the example data, resulting in a value (`unitary_amplitude`) and the autocalibrated spike rates (`spike_rates_rescaled`) as output. Depending on the visualization parameters, the quantal analysis histogram will be displayed:

<p align="center"><img src="https://github.com/PTRRupprecht/Quantal-analysis-for-spike-inference/blob/main/etc/Example_histogram.png "  width="75%"></p>

### Application to new data

This is a proof-of-concept analysis that has not yet been thoroughly tested across many recordings and data types. If you try it out, we are looking forward to hearing from you how it worked and where you see room for improvement.

### References

If you are using this work, please consider citing this paper as original reference for Cascade:

> Rupprecht P, Carta S, Hoffmann A, Echizen M, Blot A, Kwan AC, Dan Y, Hofer SB, Kitamura K, Helmchen F\*, Friedrich RW\*, *[A database and deep learning toolbox for noise-optimized, generalized spike inference from calcium imaging](https://www.nature.com/articles/s41593-021-00895-5)*, Nature Neuroscience (2021).

Please cite this as a reference for GCaMP8:

> Zhang Y, Rózsa M, Liang Y et al. *[Fast and sensitive GCaMP calcium indicators for imaging neural populations](https://www.nature.com/articles/s41586-023-05828-9)*, Nature (2023).

And please cite this preprint as a reference for spike inference with GCaMP8 and the quantal analysis:

> Rupprecht P, Rózsa M, Fang X, Svoboda K, Helmchen F. *Spike inference from calcium imaging data acquired with GCaMP8 indicators*, bioRxiv (2025).

### Questions?

If you have questions, find bugs or want to discuss, please open an issue on GitHub, or get in touch via [e-Mail](mailto:p.t.r.rupprecht+cascade@gmail.com).
