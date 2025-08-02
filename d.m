function similarity = d()

    filenames = ["Abl127_128_pts.png","Abl127_256_pts.png","Abl127_1024_pts.png","Abl127_mask.png","Abl135_128_pts.png","Abl135_256_pts.png","Abl135_1024_pts.png","Abl135_mask.png","Abl141_128_pts.png","Abl141_256_pts.png","Abl141_1024_pts.png","Abl141_mask.png","Abl157_128_pts.png","Abl157_256_pts.png","Abl157_1024_pts.png","Abl157_mask.png","Acl233_128_pts.png","Acl233_256_pts.png","Acl233_1024_pts.png","Acl223_mask.png","Acl261_128_pts.png","Acl261_256_pts.png","Acl261_1024_pts.png","Acl261_mask.png","Adl319_128_pts.png","Adl319_256_pts.png","Adl319_1024_pts.png","Adl319_mask.png","Adl344_128_pts.png","Adl344_256_pts.png","Adl344_1024_pts.png","Adl344_mask.png","Adl375_128_pts.png","Adl375_256_pts.png","Adl375_1024_pts.png","Adl375_mask.png","Adl395_128_pts.png","Adl395_256_pts.png","Adl395_1024_pts.png","Adl395_mask.png","Ael407_128_pts.png","Ael407_256_pts.png","Ael407_1024_pts.png","Ael407_mask.png","Ael442_128_pts.png","Ael442_256_pts.png","Ael442_1024_pts.png","Ael442_mask.png","Ael446_128_pts.png","Ael446_256_pts.png","Ael446_1024_pts.png","Ael446_mask.png","Ael508_128_pts.png","Ael508_256_pts.png","Ael508_1024_pts.png","Ael508_mask.png","Fal012_128_pts.png","Fal012_256_pts.png","Fal012_1024_pts.png","Fal012_mask.png","Fal070_128_pts.png","Fal070_256_pts.png","Fal070_1024_pts.png","FAL070_mask.png","Fal100_128_pts.png","Fal100_256_pts.png","Fal100_1024_pts.png","Fal100_mask.png","FBL012_128_pts.png","FBL012_256_pts.png","FBL012_1024_pts.png","FBL012_mask.png","Fbl024_128_pts.png","Fbl024_256_pts.png","Fbl024_1024_pts.png","Fbl024_mask.png","Fbl064_128_pts.png","Fbl064_256_pts.png","Fbl064_1024_pts.png","Fbl064_mask.png","Fbl088_128_pts.png","Fbl088_256_pts.png","Fbl088_1024_pts.png","Fbl088_mask.png","Fcl010_128_pts.png","Fcl010_256_pts.png","Fcl010_1024_pts.png","Fcl010_mask.png","FCL066_128_pts.png","FCL066_256_pts.png","FCL066_1024_pts.png","FCL066_mask.png","FCL068_128_pts.png","FCL068_256_pts.png","FCL068_1024_pts.png","FCL068_mask.png","FCL084_128_pts.png","FCL084_256_pts.png","FCL084_1024_pts.png","FCL084_mask.png","Fdl002_128_pts.png","Fdl002_256_pts.png","Fdl002_1024_pts.png","Fdl002_mask.png","Fdl020_128_pts.png","Fdl020_256_pts.png","Fdl020_1024_pts.png","Fdl020_mask.png","Ffl078_128_pts.png","Ffl078_256_pts.png","Ffl078_1024_pts.png","Ffl078_mask.png","Ffl080_128_pts.png","Ffl080_256_pts.png","Ffl080_1024_pts.png","Ffl080_mask.png","Ffl084_128_pts.png","Ffl084_256_pts.png","Ffl084_1024_pts.png","Ffl084_mask.png","Fgl023_128_pts.png","Fgl023_256_pts.png","Fgl023_1024_pts.png","Fgl023_mask.png","Fgl037_128_pts.png","Fgl037_256_pts.png","Fgl037_1024_pts.png","Fgl037_mask.png","Fgl074_128_pts.png","Fgl074_256_pts.png","Fgl074_1024_pts.png","Fgl074_mask.png","Fhl074_128_pts.png","Fhl074_256_pts.png","Fhl074_1024_pts.png","Fhl074_mask.png","Fhl078_128_pts.png","Fhl078_256_pts.png","Fhl078_1024_pts.png","Fhl078_mask.png","Fil062_128_pts.png","Fil062_256_pts.png","Fil062_1024_pts.png","Fil062_mask.png","Fll065_128_pts.png","Fll065_256_pts.png","Fll065_1024_pts.png","Fll065_mask.png","Fll077_128_pts.png","Fll077_256_pts.png","Fll077_1024_pts.png","Fll077_mask.png","Fll091_128_pts.png","Fll091_256_pts.png","Fll091_1024_pts.png","Fll091_mask.png","Fll132_128_pts.png","Fll132_256_pts.png","Fll132_1024_pts.png","Fll132_mask.png","Gal045_128_pts.png","Gal045_256_pts.png","Gal045_1024_pts.png","Gal045_mask.png","Gal134_128_pts.png","Gal134_256_pts.png","Gal134_1024_pts.png","Gal134_mask.png","Ggl006_128_pts.png","Ggl006_256_pts.png","Ggl006_1024_pts.png","Ggl006_mask.png","Ggl010_128_pts.png","Ggl010_256_Pts.png","Ggl010_1024_pts.png","Ggl010_mask.png","Ggl012_128_pts.png","Ggl012_256_pts.png","Ggl012_1024_pts.png","Ggl012_mask.png","Ggl090_128_pts.png","Ggl090_256_pts.png","Ggl090_1024_pts.png","Ggl090_mask.png","gzl16_128_pts.png","gzl16_256_pts.png","gzl16_1024_pts.png","gzl16_mask.png","gzl32_128_pts.png","gzl32_256_pts.png","gzl32_1024_pts.png","gzl32_mask.png","gzl70_128_pts.png","gzl70_256_pts.png","gzl70_1024_pts.png","gzl70_mask.png","gzl84_128_pts.png","gzl84_256_pts.png","gzl84_1024_pts.png","gzl84_mask.png"];

    [~,length] = size(filenames);      
    
    sims128 = 0;
    sims256 = 0;
    sims1024 = 0;
    
    max = 0;
    min = 1;
    
    for i = 1:4:length-3
        filenames(i+3)
        I1 = imread(char(filenames(i+3)));
        I1 = imbinarize(I1);                 
        
        %filenames(i)
        I2 = imread(char(filenames(i)));
        I2 = imbinarize(I2);        
        
        %filenames(i+1)
        I3 = imread(char(filenames(i+1)));
        I3 = imbinarize(I3);
        
        %filenames(i+2)
        I4 = imread(char(filenames(i+2)));
        I4 = imbinarize(I4);
        
        sim128 = dice(I1,I2)           
        sims128 = sims128 + sim128;
        
        sim256 = dice(I1,I3)
        sims256 = sims256 + sim256;  
        
        sim1024 = dice(I1,I4)
        sims1024 = sims1024 + sim1024;
        
        if sim256 > max
            max = sim256;
        end
        if sim256 < min
            min = sim256;
        end
    end       
    
    avg128 = sims128/(length/4)
    avg256 = sims256/(length/4)
    avg1024 = sims1024/(length/4)
    max
    min
    similarity = "Complete";
end