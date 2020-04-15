function [output] = inner_product_forward(input, layer, param)

d = size(input.data, 1);
k = size(input.data, 2); % batch size
m = size(param.w, 1); % m == d
n = size(param.w, 2);

b_mat = repmat(param.b, [k, 1]).';
output.data = param.w.' * input.data + b_mat;
output.height = size(param.w, 2);
output.width = 1;
output.channel = 1;
output.batch_size = k;

end
