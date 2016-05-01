function DaltonValue = unit_to_dalton(value,unit)

if(strcmp(unit,'mmu'))
    DaltonValue = value / 1000;
elseif(strcmp(unit,'ppm'))
    DaltonValue = value / 1000000;
elseif(strcmp(unit,'%'))
    DaltonValue = value / 100;
else
    DaltonValue = value;
end

end