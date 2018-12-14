function [num] = first_num(str_fam)

if (isequal(str_fam,'AAAAAA') == 1)
    num = 0;
elseif (isequal(str_fam,'AABABB') == 1)
    num = 1;
elseif (isequal(str_fam,'AABBAB') == 1)
    num = 2;
elseif (isequal(str_fam,'AABBBA') == 1)
    num = 3;
elseif (isequal(str_fam,'ABAABB') == 1)
    num = 4;
elseif (isequal(str_fam,'ABBAAB') == 1)
    num = 5;
elseif (isequal(str_fam,'ABBBAA') == 1)
    num = 6;
elseif (isequal(str_fam,'ABABAB') == 1)
    num = 7;
elseif (isequal(str_fam,'ABABBA') == 1)
    num = 8;
elseif (isequal(str_fam,'ABBABA') == 1)
    num = 9;
else 
    num = -1;
end




    
end 
