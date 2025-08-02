function norm = normalize(img,newMin,newMax)
% inputs, 
%  img : Gray level image data
%  newMin : New gray level minimum value
%  newMax : New gray level maximum value
%  
% outputs,
%  norm : Normalized gray level image
%
% Function was written Spring 2014 by Adam Bowden, GA at TAMU-C

    if max(img(:)) ~= min(img(:))
        norm = (img - min(img(:)))*(newMax - newMin)/(max(img(:)) - min(img(:))) + newMin;
    else
        norm = img;
    end
    
end