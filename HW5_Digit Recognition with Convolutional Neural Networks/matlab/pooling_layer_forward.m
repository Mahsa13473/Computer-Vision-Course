function [output] = pooling_layer_forward(input, layer)

    h_in = input.height;
    w_in = input.width;
    c = input.channel;
    batch_size = input.batch_size;
    k = layer.k;
    pad = layer.pad;
    stride = layer.stride;
    
    h_out = (h_in + 2*pad - k) / stride + 1;
    w_out = (w_in + 2*pad - k) / stride + 1;
    
    
    output.height = h_out;
    output.width = w_out;
    output.channel = c;
    output.batch_size = batch_size;

    output.data = zeros([h_out, w_out, c, batch_size]);  
    input.data = reshape(input.data,[h_in,w_in,c,batch_size]);
    padded_input = padarray(input.data,[pad, pad], 'both');
    
    for batch = 1:batch_size
        for channel=1:c
            a = padded_input(:,:,channel,batch);
            b = im2col(a, [k,k], 'distinct');
            [maxx,~] = max(b);
            output.data (:,:,channel,batch) = reshape(maxx, h_out, w_out);
        end
    end
output.data = reshape(output.data, [h_out * w_out * c, batch_size]);

end

