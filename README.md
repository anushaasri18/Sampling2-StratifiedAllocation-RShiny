# Sampling2-StratifiedAllocation-RShiny
An interactive R Shiny application to estimate population mean using stratified sampling, incorporating sampling bias, cost, and time constraints, and comparing proportional, Neyman, and optimized allocation strategies in real time.

Overview

This project presents an interactive R Shiny application developed as part of an asynchronous academic assignment based on Sampling-2.
The application demonstrates how sample size determination for population mean estimation changes under different stratified allocation methods, while accounting for sampling bias, survey cost, and survey time.

Users can experiment with different strata characteristics and instantly observe their impact on allocation efficiency and experimental design.

Key Features
1. Stratified Population Design

Multiple Strata Support: Define population sizes across strata.

Statistical Characteristics: Specify stratum-wise variance and sampling bias.

Weight Computation: Automatically computes stratum weights 
𝑊
ℎ
W
h
	​

.

2. Interactive Allocation Methods

The app compares three standard allocation techniques:

Proportional Allocation

Sample sizes allocated proportional to stratum sizes.

Neyman Allocation

Minimizes variance by allocating samples based on stratum variability.

Optimized Allocation

Incorporates cost and time constraints for practical survey planning.

Users can switch between allocation methods in real time.

3. Real-Time Sample Size & Survey Metrics

The application dynamically computes and displays:

Stratum-wise sample sizes (
𝑛
ℎ
n
h
	​

)

Total sample size

Total survey cost

Total survey time

Bias-adjusted variance considerations

4. Experimental Design Visualization

Cost–Time Trade-off Plot: Visualizes survey efficiency across strata.

Allocation Tables: Clearly displays stratum-wise allocation results.

Helps users understand design efficiency vs resource constraints.

5. Academic & Practical Relevance

Demonstrates Sampling-2 concepts interactively.

Bridges theoretical sampling methods with real-world survey constraints.

Suitable for teaching, learning, and experimentation.

Use Cases

Academic assignments and demonstrations

Understanding stratified sampling strategies

Survey planning under cost and time constraints

Visual learning of allocation efficiency

Prerequisites

To run the application, ensure R is installed along with the following packages:

install.packages(c("shiny", "dplyr"))
