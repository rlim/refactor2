function [mask, cancelled] = select_mask_image( filespec, title )
% show a select file dialog box
%
% select_image will also check for the existance of an
% associated .hdr file.  Without an .hdr file in the same directory
% SPM functions will abort with errors.
%
% return filename as full path
cancelled = 0;
image = 0;
[fn, path] = uigetfile(filespec, title );
if isequal(fn,0) || isequal(path,0)
    cancelled = 1;
    mask = 0;
    return;
else
    msk = cpca_read_vol([path fn]);
    if ( isempty( image ) )
        show_message( 'Image Read Error', hdr.error );
        mask = 0;
        cancelled = 1;
        return;
    end;
    msk.file = [path fn];
    
    mask = Mask(msk);
    calculate_MNI(mask);
end



