function [real_space,N] = real_space_generator(row,col)

N=0;
n = row*col;
rand_num = randi([5,fix(nthroot(row*col,2))],1);
atom = zeros(rand_num, 2);
dx = [1,1,1,0,0,-1,-1,-1];
dy = [1,0,-1,1,-1,1,0,-1];

for i=1:rand_num
    atom(i,1) = randi([1,row],1);
    atom(i,2) = randi([1,col],1);
end

real_space = zeros(row,col);

for i=1:rand_num
    real_space(atom(i,1),atom(i,2))=1;
end

for x=1:row
    real_space(x,1)=0;
    real_space(x,col)=0;
end

for y=1:col
    real_space(1,y)=0;
    real_space(row,y)=0;
end

for x=1:row
    for y=1:col
        if real_space(x,y)==1
            for n = 1:8
                nx = x+dx(n);
                ny = y+dy(n);
                if nx > 0 && nx <= row && ny > 0 && ny <= col
                    real_space(nx,ny) = 0;
                end
            end
        end
    end
end

for x=1:row
    for y=1:col
        if real_space(x,y)==1
            N = N+1;
        end
    end
end


end
