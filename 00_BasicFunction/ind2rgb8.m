function rgb = ind2rgb8(varargin)

rgb = ind2rgb(varargin{:});
rgb = uint8(rgb*255);