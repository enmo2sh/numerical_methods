function[A,counter] =ReadFromFile()
 [file,path] = uigetfile('*.txt');
  if isequal(file,0)
      disp('User selected Cancel');
      return;
  else
A=[''];
counter=0;
i=1;
ffile =fopen(file);
tline=fgetl(ffile);
%counter=counter+1;
A{i}=tline;
while ischar(tline)
     i=i+1;
    tline=fgetl(ffile);
    counter=counter+1;
    A{i}=tline;
end
fclose(ffile);
  end
end