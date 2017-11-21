function r = cellmap(func, c)
r = cell(size(c));
for i = 1:numel(c)
    r{i} = func(c{i});
end 