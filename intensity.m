function P_2_real = intensity(test_density,measured_density)

test_density_reciprocal = fft2(test_density);

P_2_reci = measured_density./abs(test_density_reciprocal).*test_density_reciprocal;
P_2_real = ifft2(P_2_reci);

end