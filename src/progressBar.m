function progressBar(val, max)
n=50;
Progress = '      |';
for i = 1:n
    if  i <= n * val / max
        Progress= strcat(Progress, 'X');
    else
        Progress= strcat(Progress, '-');
    end;
end;
Progress = strcat(Progress,'|:[');

Progress = strcat(Progress, num2str(val));
Progress = strcat(Progress,'/');
Progress = strcat(Progress, num2str(max));
Progress = strcat(Progress,']=');
p = round(100*val/max);
Progress = strcat(Progress, num2str(p));
Progress = strcat(Progress,'%');

clc;
Progress
