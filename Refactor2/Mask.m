classdef Mask < handle
    %MASK Summary of this class goes here
    %   Detailed explanation goes here
    
    properties(GetAccess=public, SetAccess=private) %%read only access
        %% file properties
        file = '';
        header = [];
        
        %% mask properties
        is_registered = false;
        niiSingle = 0;
        vol = [];
        ind = [];
        x = 0;
        y = 0;
        image = [];
        tal_index = [];
        MNI = [];
        
    end
    
    methods
        %% constructor
        function mask = Mask(new_mask)
            mask.file = new_mask.file;
            mask.header = new_mask.header;
            mask.image = new_mask.image;
            mask.vol = new_mask.vol;
            mask.niiSingle = new_mask.niiSingle;
            mask.ind = new_mask.ind;
            mask.x = new_mask.x;
            mask.y = new_mask.y;
            mask.tal_index = new_mask.tal_index;
        end
        
        %% setters
        function set_x(obj, x)
            obj.x = x;
        end
        function set_dimensions(obj)
            sz = size(obj.ind);
            obj.x = sz(1);
            obj.y = sz(2);
        end
        function set_y(obj, y)
            obj.y = y;
        end
        function set_is_registered(obj)
            obj.is_registered = numel(unique( obj.image(obj.ind) )') > 1 && ...
                numel(unique( obj.image(obj.ind) )') < 6;
        end
        
        %% getters
        function x = get_x(obj)
            x = obj.x;
        end
        function y = get_y(obj)
            y = obj.y;
        end
        function ind = get_ind(obj)
            ind = obj.ind;
        end
        function output = get_is_registered(obj)
            output = obj.is_registered;
        end
        
        %% main methods
        function calculate_MNI(obj)
            if size(obj.image, 2) < 3
                D = reshape(obj.image, obj.vol.dim);
            else
                D = obj.image;
            end
            indices = 1:prod(obj.vol.dim);
            [I, J, K] = ind2sub(size(D), indices);
            IJK = [I; J; K];
            obj.MNI = obj.vol.mat(1:3,:)*[IJK; ones(1,size(IJK,2))];
            
        end
        
        function [reg_data,ind] = enc_mask_registrations( msk, reg )
            
            ind = [];
            
            if nargin < 2,  reg = 0;  end
            
            reg_data.count = [ 0 0 0 0 0 ];
            reg_data.ind = [];
            
            reg_data.ind(1).zref = find( msk.image( msk.ind) == 1 );
            reg_data.count(1)    = numel(  reg_data.ind(1).zref );
            
            reg_data.ind(2).zref = find( msk.image( msk.ind) == 2 );
            reg_data.count(2)    = numel(  reg_data.ind(2).zref );
            
            reg_data.ind(3).zref = find( msk.image( msk.ind) == 3 );
            reg_data.count(3)    = numel(  reg_data.ind(3).zref );
            
            reg_data.ind(4).zref = find( msk.image( msk.ind) == 4 );
            reg_data.count(4)    = numel(  reg_data.ind(4).zref );
            
            reg_data.ind(5).zref = find( msk.image( msk.ind) == 5 );
            reg_data.count(5)    = numel(  reg_data.ind(5).zref );
            
            switch reg
                case 1,           % Gray Matter includes Brain Stem and Cerebellum
                    ind = unique( [ reg_data.ind(1).zref; reg_data.ind(4).zref; reg_data.ind(5).zref ] );
                case 2,           % White Matter only
                    ind = reg_data.ind(2).zref;
            end
            
        end
        function SSQ = mask_normalization(msk, Z, SSQ)
            if msk.is_registered
                sd = zeros( size(msk.ind));
                for ii=1:numel(sd)
                    sd(ii) = sum(diag( Z(:,ii) * Z(:,ii)' ));
                end
                for ii = 1:5
                    if reg_data.count(ii) > 0
                        SSQ.Rsd(ii) = SSQ.Rsd(ii) + sum(sd(reg_data.ind(ii).zref) );
                    end
                end
            end
        end
        
        
    end
    
end

