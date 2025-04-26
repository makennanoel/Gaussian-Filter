**Gaussian Filter Design**

---

## Introduction

Gaussian filtering is a technique widely used in fields such as Computer Vision, Medical Imaging, and Remote Sensing. It serves as a method for color balance, sharpening, and reducing image noise.  
Gaussian filtering applies a **weighted moving average** where the **central pixel** receives the most weight, with a gradual decrease for neighboring pixels. This produces a **smoothing effect** and **slight blur** across the image.

Gaussian filters are especially effective at reducing **high-frequency noise** by attenuating pixel-level intensity variations. While a **single filter application** has minimal computational cost, **multiple Gaussian filtering stages** introduce significant processing requirements due to the heavy use of **multiplications and additions**. These operations happen through convolution with a **kernel**. As **kernel size** increases or **image resolution** grows, the computational demands and processing time also increase【1】.

---

## Gaussian Kernel Formula

The design of a Gaussian kernel follows the 2D Gaussian function:

$$
G(x, y) = \frac{1}{2\pi\sigma^2} \exp\left( -\frac{x^2 + y^2}{2\sigma^2} \right)
$$

where:

- x, y are the spatial coordinates (row and column offsets),
- standard deviation determines the width of the Gaussian "bell curve."

**Interpretation of σ (standard deviation):**  
- A **low σ** results in a **sharp, local smoothing** (less blur).
- A **high σ** results in **broad, strong smoothing** (more blur).

The standard deviation controls how much area within the filter experiences higher smoothing with greater weighting【2】【3】.

---

## 2D Direct Gaussian Implementation

The project implements a **Direct 2D Gaussian filter**:
- A full **3x3 convolution** is performed per output pixel.
- **Nine pixels** are multiplied by precomputed weights and summed together in a **single operation**.
- The result is normalized via a right shift (`>> 4`), dividing by 16.

A **finite impulse response (FIR)** Gaussian blur approximation architecture.

---

## RTL Viewer

![image](https://github.com/user-attachments/assets/a8ca36f3-924e-4c88-8c7b-a077be058dc2)

---

## Silicon Usage, Maximum Frequency and Power Analyzer of Direct Gaussian Implementation

![image](https://github.com/user-attachments/assets/fffe57c5-4c53-464f-8833-ed7aab84f45f)

- Direct 2D convolution achieves real-time speeds for small image windows.
- Power estimates were obtained using real toggle data (.vcd file) from post-simulation activity analysis.

---

## References

[1] L. Mazumder and V. Shah, "Fast Gaussian Filter Approximations Comparison on SIMD Computing Platforms," *Applied Sciences*, vol. 14, no. 11, 2024. [Online]. Available: https://www.mdpi.com/2076-3417/14/11/4664

[2] K. He, X. Zhang, S. Ren, and J. Sun, "Delving Deep into Rectifiers: Surpassing Human-Level Performance on ImageNet Classification," *Advances in Neural Information Processing Systems (NeurIPS)*, vol. 28, 2015. [Online]. Available: https://proceedings.neurips.cc/paper/2020/file/f6a673f09493afcd8b129a0bcf1cd5bc-Paper.pdf

[3] H. Gulati, "Understanding the Gaussian Filter," *Medium*, 2021. [Online]. Available: https://himani-gulati.medium.com/understanding-the-gaussian-filter-c2cb4fb4f16b

[4] StackOverflow, "What is meant by 1D Gaussian kernel vs 2D Gaussian kernel?", *Stack Overflow*, 2021. [Online]. Available: https://stackoverflow.com/questions/66489348/what-is-meant-by-1d-gaussian-kernel-vs-2d-gaussian-kernel

---
