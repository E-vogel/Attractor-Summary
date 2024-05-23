# Attractor-Summary

This repository contains MATLAB code to simulate various attractors, including the Lorenz, Rössler, Langford, and Gumowski-Mira attractors. Each simulation generates a video visualizing the trajectories of particles in the attractor's phase space.

## Attractors

### 1. Lorenz Attractor
The Lorenz attractor is a system of ordinary differential equations originally developed to model atmospheric convection. It is notable for having chaotic solutions for certain parameter values.

The equations are:
$$\frac{dx}{dt} = \sigma (y - x)$$
$$\frac{dy}{dt} = x (\rho - z) - y$$
$$\frac{dz}{dt} = x y - \beta z$$

where:
- $\sigma$ is the Prandtl number,
- $\rho$ is the Rayleigh number.

### 2. Rössler Attractor
The Rössler attractor is another system of differential equations that exhibits chaotic behavior. It was introduced as a simpler model of chaos compared to the Lorenz system.

The equations are:
$$\frac{dx}{dt} = -y - z$$
$$\frac{dy}{dt} = x + a y$$
$$\frac{dz}{dt} = b + x z - c z$$

where $a$, $b$, and $c$ are system parameters.

### 3. Langford Attractor
The Langford attractor is a less common chaotic system. It exhibits complex behavior and is used to study chaos theory in dynamical systems.

The equations are:
$$\frac{dx}{dt} = y$$
$$\frac{dy}{dt} = z$$
$$\frac{dz}{dt} = -a z - y + \mu y (1 - c y^2) + x (1 - c x^2)$$

where $a$, $\mu$, and $c$ are system parameters.

### 4. Gumowski-Mira Attractor
The Gumowski-Mira attractor is a two-dimensional discrete-time dynamical system that exhibits complex and chaotic behavior. It is used to study nonlinear dynamics.

The iterative equations are:
$$x_{n+1} = y_n + a y_n (1 - b y_n^2) + c x_n + 2 (1 - c) \frac{x_n^2}{1 + x_n^2}$$
$$y_{n+1} = -x_n + c x_{n+1} + 2 (1 - c) \frac{x_{n+1}^2}{1 + x_{n+1}^2}$$

where $a$, $b$, and $c$ are system parameters.

## Codes

### `Lorenz_attractor.m`
This script simulates the Lorenz attractor. 
[![Open in MATLAB Online](https://www.mathworks.com/images/responsive/global/open-in-matlab-online.svg)](https://matlab.mathworks.com/open/github/v1?repo=E-vogel/Attractor-Summary&file=Lorenz_attractor.m)

### `Roessler_attractor.m`
This script simulates the Rössler attractor. 
[![Open in MATLAB Online](https://www.mathworks.com/images/responsive/global/open-in-matlab-online.svg)](https://matlab.mathworks.com/open/github/v1?repo=E-vogel/Attractor-Summary&file=Roessler_attractor.m)

### `Langford.m`
This script simulates the Langford attractor. 
[![Open in MATLAB Online](https://www.mathworks.com/images/responsive/global/open-in-matlab-online.svg)](https://matlab.mathworks.com/open/github/v1?repo=E-vogel/Attractor-Summary&file=Langford.m)

### `Gumowski_Mira.m`
This script simulates the Gumowski-Mira attractor. 
[![Open in MATLAB Online](https://www.mathworks.com/images/responsive/global/open-in-matlab-online.svg)](https://matlab.mathworks.com/open/github/v1?repo=E-vogel/Attractor-Summary&file=Gumowski_Mira.m)
