function similarity = d2()

    filenames = ["AC-556 edited_ELPAC.png","AC-556 edited_mask.png","AC-556_edited_sigma20_ELPAC.png","AC-556_edited_sigma50_ELPAC.png","Accuracy_International_AW50_321_87_ELPAC.png","Accuracy_International_AW50_321_87_mask.png","Accuracy_International_AW50_321_87_sigma20_ELPAC.png","Accuracy_International_AW50_321_87_sigma50_ELPAC.png","Ak 5 edited_ELPAC.png","Ak 5 edited_mask.png","Ak 5 edited_sigma20_ELPAC.png","Ak 5 edited_sigma50_ELPAC.png","AK-47_319_103_ELPAC.png","AK-47_319_103_mask.png","AK-47_319_103_sigma20_ELPAC.png","AK-47_319_103_sigma50_ELPAC.png","AMP_Technical_Services_DSR_1 edited_ELPAC.png","AMP_Technical_Services_DSR_1 edited_mask.png","AMP_Technical_Services_DSR_1 edited_sigma20_ELPAC.png","AMP_Technical_Services_DSR_1 edited_sigma50_ELPAC.png","AMT_Automag V edited_ELPAC.png","AMT_Automag V edited_mask.png","AMT_Automag V edited_sigma20_ELPAC.png","AMT_Automag V edited_sigma50_ELPAC.png","MG1-ORIGINAL_ELPAC.png","MG1-ORIGINAL_mask.png","MG1-ORIGINAL_sigma20_ELPAC.png","MG1-ORIGINAL_sigma50_ELPAC.png","MG2-ORIGINAL-IMAGE_ELPAC.png","MG2-ORIGINAL-IMAGE_mask.png","MG2-ORIGINAL-IMAGE_sigma20_ELPAC.png","MG2-ORIGINAL-IMAGE_sigma50_ELPAC.png","MG4-ORIGINAL-IMAGE_ELPAC.png","MG4-ORIGINAL-IMAGE_mask.png","MG4-ORIGINAL-IMAGE_sigma20_ELPAC.png","MG4-ORIGINAL-IMAGE_sigma50_ELPAC.png","MG5-ORIGINAL-IMAGE_ELPAC.png","MG5-ORIGINAL-IMAGE_mask.png","MG5-ORIGINAL-IMAGE_sigma20_ELPAC.png","MG5-ORIGINAL-IMAGE_sigma50_ELPAC.png"];

    [~,length] = size(filenames);      
    
    sims = 0;
    sims20 = 0;
    sims50 = 0;
    
    max = 0;
    min = 1;
    max20 = 0;
    min20 = 1;
    max50 = 0;
    min50 = 1;
    
    for i = 1:4:length-3
        filenames(i+1)
        I1 = imread(char(filenames(i+1)));
        I1 = imbinarize(I1);                 
        
        %filenames(i)
        I2 = imread(char(filenames(i)));
        I2 = imbinarize(I2);        
        
        %filenames(i+1)
        I3 = imread(char(filenames(i+2)));
        I3 = imbinarize(I3);
        
        %filenames(i+2)
        I4 = imread(char(filenames(i+3)));
        I4 = imbinarize(I4);
        
        sim = dice(I1,I2)           
        sims = sims + sim;
        
        sim20 = dice(I1,I3)
        sims20 = sims20 + sim20;  
        
        sim50 = dice(I1,I4)
        sims50 = sims50 + sim50;
        
        if sim > max
            max = sim;
        end
        if sim < min
            min = sim;
        end
        if sim20 > max20
            max20 = sim20;
        end
        if sim20 < min20
            min20 = sim20;
        end
        if sim50 > max50
            max50 = sim;
        end
        if sim50 < min50
            min50 = sim50;
        end
    end       
    
    avg = sims/(length/4)
    avg20 = sims20/(length/4)
    avg50 = sims50/(length/4)
    max
    min
    max20
    min20
    max50
    min50
    similarity = "Complete";
end
