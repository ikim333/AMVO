%AUTHORS: Miquel Badia, Daniel Longaron, Aranu Reyes
%TEAM 06

%% MAXIMUM ERROR
%this function calculates the maximum difference between values of the
%numerical and analitic results

function [error_conv, error_diff] = max_error (analitic_conv_u, convective_term_u, analitic_diff_u, diffusive_term_u, N)

error_conv = abs(analitic_conv_u - convective_term_u(2:N+1,2:N+1));
error_conv = max(max(error_conv));

error_diff = abs(analitic_diff_u - diffusive_term_u(2:N+1,2:N+1));
error_diff = max(max(error_diff));