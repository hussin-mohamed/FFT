
function t = types(str)
    f=fimath('RoundingMethod', 'floor');
    switch str
        case 'single'
            t.x_imag=single([]);
            t.x_real=single([]);
            t.x =single([]);
            t.c =single([]);
            t.s =single([]);
            t.line1 = single([]);
            t.line2 = single([]);
            t.line1_0 = single([]);
            t.line2_0 = single([]);
            t.line1_1 = single([]);
            t.line2_1 = single([]);
            t.line1_2 = single([]);
            t.line2_2 = single([]);
            t.line1_3 = single([]);
            t.line2_3 = single([]);
            t.line1_4 = single([]);
            t.line2_4 = single([]);
            t.line1temp = single([]);
            t.line2temp = single([]);
            t.line1_temp = single([]);
            t.line2_temp = single([]);
            t.line1fly = single([]);
            t.line2fly = single([]);
            t.X= single([]);
            t.temp= single([]);
            
        case 'double'
            t.x_imag=double([]);
            t.x_real=double([]);
            t.x =double([]);
            t.c =double([]);
            t.s =double([]);
            t.line1 = double([]);
            t.line2 = double([]);
            t.line1_0 = double([]);
            t.line2_0 = double([]);
            t.line1_1 = double([]);
            t.line2_1 = double([]);
            t.line1_2 = double([]);
            t.line2_2 = double([]);
            t.line1_3 = double([]);
            t.line2_3 = double([]);
            t.line1_4 = double([]);
            t.line2_4 = double([]);
            t.line1temp = double([]);
            t.line2temp = double([]);
            t.line1_temp = double([]);
            t.line2_temp = double([]);
            t.line1fly = double([]);
            t.line2fly = double([]);
            t.X= double([]);
            t.temp= double([]);
            
        case 'fixed'
            t.x_imag=fi([],1,3+9,9,'fimath',f);
            t.x_real=fi([],1,3+9,9,'fimath',f);
            t.x =fi([],1,3+9,9,'fimath',f);
            t.c =fi([],1,2+10,10,'fimath',f);
            t.s =fi([],1,2+10,10,'fimath',f);
            t.line1 = fi([],1,3+9,9,'fimath',f);
            t.line2 = fi([],1,3+9,9,'fimath',f);
            t.line1_0 = fi([],1,3+9,9,'fimath',f);
            t.line2_0 = fi([],1,3+9,9,'fimath',f);
            t.line1_1 = fi([],1,4+8,8,'fimath',f);
            t.line2_1 = fi([],1,4+8,8,'fimath',f);
            t.line1_2 = fi([],1,4+8,8,'fimath',f);
            t.line2_2 = fi([],1,4+8,8,'fimath',f);
            t.line1_3 = fi([],1,5+7,7,'fimath',f);
            t.line2_3 = fi([],1,5+7,7,'fimath',f);
            t.line1_4 = fi([],1,5+7,7,'fimath',f);
            t.line2_4 = fi([],1,5+7,7,'fimath',f);
            t.line1temp_1 = fi([],1,4+8,8,'fimath',f);
            t.line1temp_2 = fi([],1,4+8,8,'fimath',f);
            t.line1temp_3 = fi([],1,5+7,7,'fimath',f);
            t.line2temp_1 = fi([],1,4+8,8,'fimath',f);
            t.line2temp_2 = fi([],1,4+8,8,'fimath',f);
            t.line2temp_3 = fi([],1,5+7,7,'fimath',f);
            t.line2temp = fi([],1,5+7,7,'fimath',f);
            t.line1_temp = fi([],1,5+7,7,'fimath',f);
            t.line2_temp = fi([],1,5+7,7,'fimath',f);
            t.line1fly_1 = fi([],1,4+8,8,'fimath',f);
            t.line2fly_1 = fi([],1,4+8,8,'fimath',f);
            t.line1fly_2 = fi([],1,4+8,8,'fimath',f);
            t.line2fly_2 = fi([],1,4+8,8,'fimath',f);
            t.line1fly_3 = fi([],1,5+7,7,'fimath',f);
            t.line2fly_3 = fi([],1,5+7,7,'fimath',f);
            t.X= fi([],1,5+7,7,'fimath',f);
            t.temp= fi([],1,5+7,7,'fimath',f);
    end
end