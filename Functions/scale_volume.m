function [vol_scaled,minmax] = scale_volume(vol, target_range)
%NORMALIZE_VOLUME Change scaling of the focus volume to be in the
%target_range.
%   INPUTS:
%   vol - 3D volume
%   target_range - array of two numbers, for example [0 1], or [0 255]
%   OUTPUTS: 
%   vol_scaled - the scaled volume
%   minmax - values of the original values that can be used to restore the
%   original scaling

minmax=[min(vol(:)) max(vol(:))];
vol_scaled = (target_range(2)-target_range(1)) * ((vol - minmax(1)) / (minmax(2) - minmax(1))) + target_range(1);

end