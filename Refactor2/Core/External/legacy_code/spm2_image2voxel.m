function voxellist=image2voxel(imageFileName,imageIndices)

[DIM,VOX,SCALE,TYPE,OFFSET,ORIGIN,DESCRIP] = spm_hread(imageFileName);
fid=fopen(imageFileName);
im=fread(fid,DIM(1)*DIM(2)*DIM(3),spm_type(TYPE));
fclose(fid);

if size(imageIndices,1)==1
	imageIndices=imageIndices';
end

% convert to voxels;
sl=DIM(1)*DIM(2);
zvox=floor((imageIndices-1)/sl)+1;
temp2=rem(imageIndices-1,sl);
xvox=rem(temp2,DIM(1))+1;
yvox=floor(temp2/DIM(1))+1;

voxelsizex=VOX(1);
voxelsizey=VOX(2);
voxelsizez=VOX(3);

xvoxp=(xvox-ORIGIN(1))*VOX(1);
yvoxp=(yvox-ORIGIN(2))*VOX(2);
zvoxp=(zvox-ORIGIN(3))*VOX(3);

voxellist=[xvoxp yvoxp zvoxp];