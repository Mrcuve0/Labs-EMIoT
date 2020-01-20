function send_image(file_pointer, img_R, img_G, img_B)
    n = size(img_R);
    
    fwrite(file_pointer,['0','1',img_B(1, :)],'char');
    fwrite(file_pointer,['0','1',img_G(1, :)],'char');
    fwrite(file_pointer,['0','1',img_R(1, :)],'char');
%     flush(file_pointer)
%     write(file_pointer, ['0','1',img_B(1, :)], 'char')   
%     write(file_pointer, ['0','1',img_G(1, :)], 'char')
%     write(file_pointer, ['0','1',img_R(1, :)], 'char')
    
    for i = 2:n(1)
        fwrite(file_pointer,['0','0',img_B(i, :)],'char');
        fwrite(file_pointer,['0','0',img_G(i, :)],'char');
        fwrite(file_pointer,['0','0',img_R(i, :)],'char');
%         write(file_pointer, ['0','0',img_B(i, :)], 'char')
%         write(file_pointer, ['0','0',img_G(i, :)], 'char')
%         write(file_pointer, ['0','0',img_R(i, :)], 'char')
    end
end