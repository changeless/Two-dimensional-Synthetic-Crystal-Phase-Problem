function P1=atomicity(test_density, atom_number)

[row,col] = size(test_density);

dx = [1,1,1,0,0,-1,-1,-1];
dy = [1,0,-1,1,-1,1,0,-1];
local_maximum_density = [];
local_maximum_density_id = [];

i = 1;

for x = 1:row
    for y = 1:col
        flag = 1;
        for n = 1:8
           nx = x+dx(n);
           ny = y+dy(n);
           if nx > 0 && nx <= row && ny > 0 && ny <= col
               if test_density(x,y) <= test_density(nx,ny)
                   flag = 0;
                   break;
               end
           end
        end
        if flag
           local_maximum_density = [local_maximum_density, test_density(x,y)];
           local_maximum_density_id = [local_maximum_density_id, [x,y]];
           i = i+1;
        end
            
    end
end

if i <= atom_number
    error('No enough local maximum');
end
    
[Sort, perm] = sort(local_maximum_density(:),'descend');

t = zeros(atom_number,2);
for x = 1:atom_number
    t(x,:) = [local_maximum_density_id(perm(x)*2-1), local_maximum_density_id(perm(x)*2)];
end

P1 = zeros(row,col);
for x = 1:atom_number
    for r = 1:row
        for c = 1:col
            if (r == t(x,1)) && (c ==t(x,2))
                if test_density(t(x,1),t(x,2))>0
                % fprintf('x=%d r=%d c=%d v=%f\n', x, r, c, P1(r, c));
                    P1(r,c) = test_density(t(x,1),t(x,2));
                end
                for n = 1:8
                    nx = t(x,1)+dx(n);
                    ny = t(x,2)+dy(n);
                    if nx > 0 && nx <= row && ny > 0 && ny <= col
                        if test_density(nx,ny)>0
                            P1(r+dx(n),c+dy(n)) = test_density(nx,ny);
                        else
                            P1(r+dx(n),c+dy(n)) = 0;
                        end
                    end
                end        
            end
        end
    end  
end



