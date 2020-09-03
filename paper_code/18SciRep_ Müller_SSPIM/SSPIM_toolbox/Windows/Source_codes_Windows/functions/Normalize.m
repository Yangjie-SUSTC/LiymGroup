function [out] = Normalize(in)
if max(in(:)) == min(in(:))
    out = in;
else
    out = in-min(in(:));
    out = out./(max(out(:))+eps);
end

