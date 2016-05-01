function value = dalton_to_unit(DaltonValue,unit)

if(strcmp(unit,'mmu'))
    value = DaltonValue / 1000;
elseif(strcmp(unit,'ppm'))
    value = DaltonValue / 1000000;
elseif(strcmp(unit,'%'))
    value = DaltonValue / 100;
else
    value = DaltonValue;
end

end